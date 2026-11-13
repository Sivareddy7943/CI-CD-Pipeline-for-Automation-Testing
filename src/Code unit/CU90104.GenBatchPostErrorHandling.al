//SRBC-280 - SY - 30012025 - Created Codeunit for fail safe batch process
//SRBC-297 - SY - 10032025 - Did changes for resolve error of - Out of balance in Debit or Credit entry
//         - SY - 17032025 - Did changes for Manual No. series boolean for "Document No." of General Journal
//         - SY - 21032025 - Created procedure - GenJnlPostProcess for use in Codeunit - 50012 in procedure - ApplyEntryForNewPayment
//SRBC-298 - SY - 05052025 - Did changes in procedure - PostGenJnlBatch for create log
//SRBC-477 - SY - 20012025 - Did changes in procedure - UpdateGenJnlLine for update Renumbered doc no on Applies to doc no.
//SRBC-412 - SY - 16062026 - Commented code on procedure-PostGenJnlBatch for not to create API log when Journal failed to post
codeunit 90104 "Gen Batch Post Error Handling"
{
    Permissions = tabledata "No. Series Line" = rimd, tabledata "Gen. Journal Line" = rimd, tabledata "Salon Republic Setup" = rimd;
    trigger OnRun()
    begin

    end;

    var
        // APILogManagement: Codeunit "API Log Management";//SRBC-298 //PS_16102026
        myInt: Integer;
        IsPreview: Boolean;
        SICU: Codeunit "Single Instance Mgt.";
        Temp_GenJnlLine: Record "Gen. Journal Line" temporary;
        Temp_NoSeriesLine_gRec: Record "No. Series Line" temporary;
        GeneralJournalBatch: Record "Gen. Journal Batch";
        NoSeriesLine: Record "No. Series Line";
        GenJnlLine_gRec: Record "Gen. Journal Line";
        Renumber_IsHandled: Boolean;
        SingleIstanceCU: Codeunit "Single Instance Mgt.";//SRBC-297
        GenJnlBatch: Record "Gen. Journal Batch";//SRBC-297

    //SRBC-280 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", OnBeforeGenJnlPostBatchRun, '', false, false)]
    local procedure CU231_OnBeforeGenJnlPostBatchRun(var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean; var GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch")
    var
        Srsetup: Record "Salon Republic Setup";
    begin
        Srsetup.Get();
        if Srsetup."Handle Batch Posting Errors" then begin
            Clear(GenJnlBatch);//SRBC-297
            GenJnlBatch.Reset();//SRBC-297
            GenJnlBatch.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");//SRBC-297
            GenJnlBatch.SetRange(Name, GenJnlLine."Journal Batch Name");//SRBC-297
            if GenJnlBatch.FindFirst() then begin//SRBC-297
                if GenJnlBatch."Skip Error lines" then begin//SRBC-297
                    if not SICU.IsPreviewCheck() then begin
                        IsHandled := true;
                        PostGenJnlBatch(GenJnlLine, IsHandled, GenJnlPostBatch);
                        SICU.IsPreview(false);
                    end;
                end;
            end;
        end;
    end;
    //SRBC-280 - Start

    //SRBC-297 - Start
    procedure GenJnlPostProcess(GenJnlLine_: Record "Gen. Journal Line"; Bool: Boolean; GenBatchPost: Codeunit "Gen. Jnl.-Post Batch") _ReturnTxt: Dictionary of [Integer, Text]
    begin
        Clear(_ReturnTxt);
        IsPreview := SICU.IsPreview(false);
        _ReturnTxt := PostGenJnlBatch(GenJnlLine_, Bool, GenBatchPost);
    end;
    //SRBC-297 - End

    procedure PostGenJnlBatch(var GenJnl_Line: Record "Gen. Journal Line"; var IsHandled: Boolean; var GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch") _returnValue: Dictionary of [Integer, Text]
    var
        GJLINE: Record "Gen. Journal Line";
        GenJnlPostBatch2: Codeunit "Gen. Jnl.-Post Batch";
        NextDocNo: Code[20];
        FilterTempGJLINEDocNo: Record "Gen. Journal Line" temporary;
        GJLINErenumber: Record "Gen. Journal Line";
        OldDocumentNo: Code[20];//SRBC-297
        GenJnlLine: Record "Gen. Journal Line";//SRBC-297
    begin
        NextDocNo := '';
        if not SICU.IsPreviewCheck() then begin
            IsHandled := true;
            CleareTempGenJnlLine();
            GenJnlLine.Reset();//SRBC-297
            GenJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");//SRBC-297
            GenJnlLine.SetRange("Journal Template Name", GenJnl_Line."Journal Template Name");//SRBC-297
            GenJnlLine.SetRange("Journal Batch Name", GenJnl_Line."Journal Batch Name");//SRBC-297
            if GenJnlLine.findset then begin
                repeat
                    OldDocumentNo := GenJnlLine."Document No.";//SRBC-297
                    GetLastDocumentNo(GenJnlLine);//SRBC-297
                    Clear(GenJnlPostBatch2);
                    GJLINE.Reset();
                    GJLINE.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    GJLINE.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                    GJLINE.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                    if GenJnlLine."Account Type" <> GenJnlLine."Account Type"::"G/L Account" then//SRBC-297
                        GJLINE.SetRange("Line No.", GenJnlLine."Line No.")//SRBC-297
                    else//SRBC-297
                        GJLINE.SetRange("Document No.", GenJnlLine."Document No.");//SRBC-297
                    if GJLINE.FindFirst() then begin
                        if GJLINE."Line No." < GenJnlLine."Line No." then//SRBC-297
                            GJLINE.copy(GenJnlLine);//SRBC-297
                        FilterTempGJLINEDocNo.Reset();
                        FilterTempGJLINEDocNo.DeleteAll();
                        FilterTempGJLINEDocNo.Init();
                        FilterTempGJLINEDocNo.TransferFields(GJLINE);
                        FilterTempGJLINEDocNo.Insert();
                        if not GenJnlPostBatch2.RUN(GJLINE) then begin
                            GJLINE.Validate("Error Message", CopyStr(GetLastErrorText(), 1, MaxStrLen(GJLINE."Error Message")));
                            // APILogManagement.LogErrorDetails(GJLINE);//SRBC-298 //SRBC-412 16062026
                            Clear(_returnValue);//SRBC-297
                            _returnValue.Add(1, 'true');//SRBC-297
                            _returnValue.Add(2, GetLastErrorText());//SRBC-297
                            if GJLINE."Account Type" <> GJLINE."Account Type"::"G/L Account" then//SRBC-297
                                UpdateGeneralJournalDocNo(GJLINE, '');//SRBC-297
                            if not Temp_GenJnlLine.get(GJLINE."Journal Template Name", GJLINE."Journal Batch Name", GJLINE."Line No.") then begin//SRBC-297
                                Temp_GenJnlLine.Init();
                                Temp_GenJnlLine.TransferFields(GJLINE);
                                Temp_GenJnlLine.Insert();
                            end;//SRBC-297
                            Renumber_IsHandled := true;
                            GenJnlLine_gRec.copy(GenJnlLine);
                        end else begin
                            if FilterTempGJLINEDocNo.FindLast() then
                                NextDocNo := FilterTempGJLINEDocNo."Document No.";
                        end;
                    end;
                until GenJnlLine.Next() = 0;
                if NextDocNo <> '' then begin
                    GeneralJournalBatch.Reset();
                    GeneralJournalBatch.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                    GeneralJournalBatch.SetRange(Name, GenJnlLine."Journal Batch Name");
                    if GeneralJournalBatch.FindFirst() then begin
                        NoSeriesLine.Reset();
                        NoSeriesLine.SetRange("Series Code", GeneralJournalBatch."No. Series");
                        if NoSeriesLine.FindFirst() then begin
                            if NoSeriesLine."Last No. Used" <> NextDocNo then begin
                                NoSeriesLine.Validate("Last No. Used", NextDocNo);
                                NoSeriesLine.Modify();
                            end;
                        end;
                    end;
                end;
                if Temp_GenJnlLine.FindSet() then begin
                    GJLINErenumber.copy(Temp_GenJnlLine);
                    GJLINErenumber.RenumberDocumentNo();
                end;
                if not Temp_GenJnlLine.IsEmpty then
                    UpdateErroredGenJnlLine
                else begin
                    Clear(_returnValue);//SRBC-297
                    _returnValue.Add(1, 'false');//SRBC-297
                    _returnValue.Add(2, '');//SRBC-297
                end;
            end;
        end;
        SICU.IsPreview(false);
    end;

    procedure UpdateErroredGenJnlLine()
    var
        GenJnlLine: Record "Gen. Journal Line";
        EmailMgmt: Codeunit "Automation Management";
        SRSETUP: Record "Salon Republic Setup";
    begin
        if Temp_GenJnlLine.FindSet() then begin
            repeat
                GenJnlLine.Reset();
                GenJnlLine.SetRange("Journal Template Name", Temp_GenJnlLine."Journal Template Name");
                GenJnlLine.SetRange("Journal Batch Name", Temp_GenJnlLine."Journal Batch Name");
                GenJnlLine.SetRange("Line No.", Temp_GenJnlLine."Line No.");
                if GenJnlLine.FindFirst() then begin
                    GenJnlLine.Validate("Error Message", Temp_GenJnlLine."Error Message");
                    GenJnlLine.Modify();
                end;
            until Temp_GenJnlLine.Next() = 0;
            SRSETUP.Get();
            if SRSETUP."Send Batch Error Alert Email" then
                if not GenJnlLine.IsEmpty then//SRBC-297
                    EmailMgmt.SendBactchErrorInTabularFormat(GenJnlLine);
            CleareTempGenJnlLine();
        end;
    end;

    procedure CleareTempGenJnlLine()
    begin
        Temp_GenJnlLine.Reset();
        Temp_GenJnlLine.DeleteAll();
    end;

    procedure ClearTempNoSeriesLine()
    begin
        Temp_NoSeriesLine_gRec.Reset();
        Temp_NoSeriesLine_gRec.DeleteAll();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnBeforeSkipRenumberDocumentNo, '', false, false)]
    local procedure "Gen. Journal Line_OnBeforeSkipRenumberDocumentNo"(var Sender: Record "Gen. Journal Line"; GenJournalLine: Record "Gen. Journal Line"; var Result: Boolean; var IsHandled: Boolean)
    begin
        if not SICU.IsPreviewCheck() then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Preview", OnBeforeRunPreview, '', false, false)]
    local procedure "Gen. Jnl.-Post Preview_OnBeforeRunPreview"(Subscriber: Variant; RecVar: Variant)
    begin
        IsPreview := SICU.IsPreview(true);
    end;
    //SRBC-280 End

    //SRBC-297 Start
    procedure GetLastDocumentNo(var Rec: Record "Gen. Journal Line")
    var
        GetNextNo_lTxt: Text;
    begin
        Clear(GeneralJournalBatch);
        clear(NoSeriesLine);
        GetNextNo_lTxt := '';
        GeneralJournalBatch.Reset();
        GeneralJournalBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
        GeneralJournalBatch.SetRange(Name, Rec."Journal Batch Name");
        if GeneralJournalBatch.FindFirst() then begin
            NoSeriesLine.Reset();
            NoSeriesLine.SetRange("Series Code", GeneralJournalBatch."No. Series");
            if NoSeriesLine.FindFirst() then begin
                if NoSeriesLine."Last No. Used" <> '' then
                    GetNextNo_lTxt := IncStr(NoSeriesLine."Last No. Used")
                else
                    GetNextNo_lTxt := NoSeriesLine."Starting No.";
                UpdateGenJnlLine(Rec, GetNextNo_lTxt);
            end;
        end;
    end;

    procedure UpdateGenJnlLine(var Rec: Record "Gen. Journal Line"; DocNumber: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        _UpdateDocNoGenJnlLine: Record "Gen. Journal Line";//SRBC-477
        _CopyGenJnlLine: Record "Gen. Journal Line";
        _IsCopy: Boolean;
        _LastDocNo: Code[20];//SRBC-477
    begin
        _IsCopy := false;
        if DocNumber <> Rec."Document No." then begin
            GenJnlLine.Reset();
            GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
            GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
            if Rec."Account Type" = Rec."Account Type"::"G/L Account" then
                GenJnlLine.SetRange("Document No.", Rec."Document No.")
            else
                GenJnlLine.SetRange("Line No.", Rec."Line No.");
            if GenJnlLine.FindSet() then begin
                repeat
                    _LastDocNo := '';//SRBC-477
                    if GenJnlLine."Line No." >= Rec."Line No." then begin
                        _LastDocNo := GenJnlLine."Document No.";//SRBC-477
                        GenJnlLine.Validate("Document No.", DocNumber);
                        GenJnlLine.Modify();
                        //SRBC-477 Start
                        _UpdateDocNoGenJnlLine.Reset();
                        _UpdateDocNoGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                        _UpdateDocNoGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                        _UpdateDocNoGenJnlLine.SetFilter("Document Type", '<>%1', GenJnlLine."Document Type");
                        _UpdateDocNoGenJnlLine.SetRange("Applies-to Doc. Type", GenJnlLine."Document Type");
                        _UpdateDocNoGenJnlLine.SetRange("Applies-to Doc. No.", _LastDocNo);
                        if _UpdateDocNoGenJnlLine.FindSet() then
                            repeat
                                if _UpdateDocNoGenJnlLine."Applies-to Doc. No." <> DocNumber then begin
                                    _UpdateDocNoGenJnlLine.Validate("Applies-to Doc. No.", DocNumber);
                                    _UpdateDocNoGenJnlLine.Modify();
                                end;
                            until _UpdateDocNoGenJnlLine.Next() = 0;
                        //SRBC-477 End
                        if not _IsCopy then begin
                            _IsCopy := true;
                            _CopyGenJnlLine.copy(GenJnlLine);
                        end;
                    end;
                until GenJnlLine.Next() = 0;
            end;
            Rec.Validate("Document No.", _CopyGenJnlLine."Document No.");
            Commit();
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"General Journal", 'OnBeforeActionEvent', Post, false, false)]
    local procedure MyProcedure_GeneralJournal(var Rec: Record "Gen. Journal Line")
    begin
        Clear(SingleIstanceCU);
        IsPreview := SingleIstanceCU.IsPreview(false);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Journal", 'OnBeforeActionEvent', Post, false, false)]
    local procedure MyProcedure_SalesJournal(var Rec: Record "Gen. Journal Line")
    begin
        Clear(SingleIstanceCU);
        IsPreview := SingleIstanceCU.IsPreview(false);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Cash Receipt Journal", 'OnBeforeActionEvent', Post, false, false)]
    local procedure MyProcedure_CashReceiptJournal(var Rec: Record "Gen. Journal Line")
    begin
        Clear(SingleIstanceCU);
        IsPreview := SingleIstanceCU.IsPreview(false);
    end;

    procedure UpdateGeneralJournalDocNo(Rec_: Record "Gen. Journal Line"; DocNumber: Code[20])
    var
        GJLine_lRec: Record "Gen. Journal Line";
    begin
        if GJLine_lRec.Get(Rec_."Journal Template Name", Rec_."Journal Batch Name", Rec_."Line No.") then begin
            GJLine_lRec.Validate("Document No.", '');
            GJLine_lRec.Modify();
            Commit();
        end;
    end;
    //SRBC-297 End
}