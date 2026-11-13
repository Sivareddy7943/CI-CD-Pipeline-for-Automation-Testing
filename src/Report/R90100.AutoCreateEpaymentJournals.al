//SRBC-214 - If the Execution Date is greater than the End Date (Not Null) then please skip that line while creating journal line.
//SRBC-256 - 20241219 -NU - Update Banking Account GUID when creating cash receipt journals from E-Payment Schedule and Flow value from the CLE
//SRBC-280 - SY - 30012025 - Changes for Fail safe batch process fuctionality
//SRBC-296 - SY - 24022025 - Before insert "General Journal" will check "Recipient Bank Account" of "Epayment Schedule" is attached or not on that customer.
//SRBC-227 - SY - 25022025 - Dis changes for update Next Payment Date of Epayment Schedule
//SRBC-297 - SY - 20032025 - In procedure CalculateNextPaymentDateofEpaymentSchedule did change for frequency-Once
//SRBC-349 - NU - 20260627 - Commented IsBC Validation in function - AutoCreateRecurringChargeLine and commented code for auto run report for AS.
//         - SY - 01072025 - Did changes in procedure - CreateRecurringCharges, added field IsBC to true recurring charge insertition time.
//SRBC-388 - SY - 31072025 - Did changes on trigger - OnAfterGetRecord for posting Jnl
//SRBC-404 - SY - 12082025 - Did changes on trigger - OnAfterGetRecord for skip report 
//SRBC-404 - AM - 20082025 - Did changes in procedure - CalculateNextChargeDate 
//SRBC-395 - AM - 21112025 - Did changes in OnAfterGetRecord Trigger
//SRBC-352 - AM - 28042026 - Did changes in the procedure CreateSalesJournalLines and created one procedure FlowFrequencyInJnl
report 90100 AutoCreateEpaymentJournals
{
    ApplicationArea = All;
    Caption = 'AutoCreateEpaymentJournals';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(EPaymentSchedule; "E Payment Schedule")
        {
            DataItemTableView = where(sr_IsCRM = filter(false));
            RequestFilterFields = "Customer No.", "Entry No.";
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                TotalCount := 0;
                if not AutoTriggerEpayment then begin
                    SetRange(Cancelled, false);
                    SetRange(Inactive, false);
                    SetRange(sr_IsBC, true);  //SRBC-349 - NU - 20250627
                    SetFilter("Start Date", '<=%1', ExecutionDate);
                    SetCurrentKey("Customer No.", "Agreement ID");
                end;
                GlobalCount := EPaymentSchedule.Count;
            end;

            trigger OnAfterGetRecord()
            var
                GenJnlLine: Record "Gen. Journal Line";
                ModEpayments: Record "E Payment Schedule";
                MidDayAgreement: Boolean;
                CurrDayNo: Integer;
                DiffNoofDays: Integer;
                LastCycleDays: Integer;
                Agreements: Record Agreements;
                FrequencyDays: Text; //SRBC-227
                NextPaymentDate: Date;//SRBC-227
                GenJnlBatch: Record "Gen. Journal Batch";//SRBC-388
                NoSeriesBatch: Codeunit "No. Series - Batch";//BC26_LB_12092025- Added variable because of Method 'IncrementDocumentNo' is marked for removal.
            begin
                FrequencyDays := '';
                MidDayAgreement := false;
                CurrDayNo := 0;
                DiffNoofDays := 0;
                NextChargeDate := 0D;
                LastChargeDate := 0D;
                LastCycleDays := 0;

                //SRBC-227 Start 25022025
                if EPaymentSchedule."Stripe Payment Method Status" <> 'active' then begin
                    if EPaymentSchedule."Start Date" < Today then begin
                        if EPaymentSchedule."Next Charge Date" = 0D then begin
                            if EPaymentSchedule."End Date" = 0D then begin
                                EPaymentSchedule.Validate("Next Charge Date", CalculateNextPaymentDateofEpaymentSchedule(EPaymentSchedule));
                                EPaymentSchedule.Modify();
                            end else begin
                                if EPaymentSchedule."End Date" < Today then begin
                                    EPaymentSchedule.Validate(Inactive, true);
                                    EPaymentSchedule.Modify();
                                end else begin
                                    NextPaymentDate := CalculateNextPaymentDateofEpaymentSchedule(EPaymentSchedule);
                                    if NextPaymentDate < EPaymentSchedule."End Date" then begin
                                        EPaymentSchedule.Validate("Next Charge Date", NextPaymentDate);
                                        EPaymentSchedule.Modify();
                                    end else begin
                                        EPaymentSchedule.Validate(Inactive, true);
                                        EPaymentSchedule.Modify();
                                    end;
                                end;
                            end;
                        end else begin
                            NextPaymentDate := 0D;
                            if EPaymentSchedule.Frequency = EPaymentSchedule.Frequency::Daily then
                                FrequencyDays := '1D';
                            if EPaymentSchedule.Frequency = EPaymentSchedule.Frequency::Weekly then
                                FrequencyDays := '1W';
                            if EPaymentSchedule.Frequency = EPaymentSchedule.Frequency::Monthly then
                                FrequencyDays := '1M';
                            if EPaymentSchedule.Frequency = EPaymentSchedule.Frequency::Quarterly then
                                FrequencyDays := '1Q';
                            if EPaymentSchedule.Frequency = EPaymentSchedule.Frequency::Yearly then
                                FrequencyDays := '1Y';
                            NextPaymentDate := CalcDate(FrequencyDays, EPaymentSchedule."Next Charge Date");
                            if EPaymentSchedule."End Date" <> 0D then begin
                                if EPaymentSchedule."End Date" < NextPaymentDate then begin
                                    EPaymentSchedule.Validate("Next Charge Date", 0D);
                                    EPaymentSchedule.Validate(Inactive, true);
                                    EPaymentSchedule.Modify();
                                end else begin
                                    EPaymentSchedule.Validate("Next Charge Date", NextPaymentDate);
                                    EPaymentSchedule.Modify();
                                end;
                            end else begin
                                EPaymentSchedule.Validate("Next Charge Date", NextPaymentDate);
                                EPaymentSchedule.Modify();
                            end;
                        end;
                    end;
                    exit;
                end;

                //SRBC-404 Start
                If EPaymentSchedule."Last Charged Date" <> 0D then
                    If EPaymentSchedule."Next Charge Date" <> ExecutionDate then
                        CurrReport.Skip();
                if EPaymentSchedule."Next Charge Date" <> 0D then
                    if ExecutionDate <> EPaymentSchedule."Next Charge Date" then
                        CurrReport.Skip();
                //SRBC-404 End

                //SRBC-227 End 25022025

                //SRBC-214 JIRA
                if ("End Date" <> 0D) then begin
                    if (ExecutionDate > "End Date") then begin
                        Validate(Inactive, true);
                        Modify();
                        //CurrReport.Skip();
                    end;
                end;

                //SRBC-214 JIRA		
                if not Inactive then begin  ////SRBC-214 JIRA
                    TotalCount += 1;
                    InvAmt := EPaymentSchedule.sr_TotalAmount;

                    IF GuiAllowed then begin
                        WinDlg.Update(1, EPaymentSchedule."Customer No.");
                        WinDlg.Update(2, TotalCount);
                    end;

                    LastChargeDate := ExecutionDate;
                    If EPaymentSchedule.Frequency <> EPaymentSchedule.Frequency::Once then
                        NextChargeDate := CalculateNextChargeDate(ExecutionDate);

                    EPaymentSchedule."Last Charged Date" := ExecutionDate;
                    EPaymentSchedule."Next Charge Date" := CalculateNextChargeDate(ExecutionDate);

                    if EPaymentSchedule."End Date" <> 0D then begin
                        if EPaymentSchedule."Next Charge Date" > EPaymentSchedule."End Date" then
                            EPaymentSchedule."Next Charge Date" := 0D;
                    end;

                    // If EPaymentSchedule."Last Charged Date" <> 0D then
                    //     If EPaymentSchedule."Next Charge Date" <> ExecutionDate then
                    //         CurrReport.Skip();

                    //SRBC-395 Start AM 21112025
                    // case of last cycle amount charge
                    // If EPaymentSchedule.Frequency <> EPaymentSchedule.Frequency::Once then begin
                    //     if EPaymentSchedule."Next Charge Date" = 0D then begin
                    //         if EPaymentSchedule."End Date" <> 0D then
                    //             LastCycleDays := EPaymentSchedule."End Date" - ExecutionDate
                    //         else
                    //             //LastCycleDays := EPaymentSchedule."Charge Anticipated End Date" - ExecutionDate;
                    //             case LastCycleDays of
                    //                 1 .. 7:
                    //                     InvAmt := CalculateLastCycleAmount(LastCycleDays);
                    //             end;
                    //     end else begin
                    //         if EPaymentSchedule."End Date" <> 0D then
                    //             LastCycleDays := EPaymentSchedule."End Date" - EPaymentSchedule."Next Charge Date"
                    //         else
                    //             //LastCycleDays := EPaymentSchedule."Charge Anticipated End Date" - EPaymentSchedule."Next Charge Date";
                    //             //LastCycleDays := RecurringCharges."End Date" - RecurringCharges."Next Charge Date";
                    //             case LastCycleDays of
                    //                 1 .. 7:
                    //                     InvAmt := CalculateLastCycleAmount(LastCycleDays);
                    //             end;
                    //         // if LastCycleDays < 7 then
                    //         //     InvAmt := CalculateLastCycleAmount(LastCycleDays);
                    //     end;
                    // end;
                    //SRBC-395 End

                    LineNo := 0;
                    GenJnlLine.Reset();
                    GenJnlLine.SetRange("Journal Template Name", SalonRepublicSetup."Epayment Template");
                    GenJnlLine.SetRange("Journal Batch Name", SalonRepublicSetup."Epayment Batch");
                    IF GenJnlLine.FindLast() then begin
                        LineNo := GenJnlLine."Line No." + 10000;
                        NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, GenJnlLine."Document No.");
                        BottomLine := true;
                    end else
                        LineNo := 10000;
                    IF CreateSalesJournalLines(GenJnlLine) then begin
                        GenJnlLine.Insert(true);
                        CreateRecurringCharges();
                        if not SalonRepublicSetup."Auto Post Epayment Jnl" then begin
                            MarkGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                            MarkGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            MarkGenJnlLine.SetRange("Line No.", GenJnlLine."Line No.");
                            MarkGenJnlLine.FindFirst();
                            MarkGenJnlLine.Mark(true);
                        end else begin
                            Commit();
                            //SRBC-388 Start
                            // if GlobalCount = TotalCount then begin //SRBC-395 27112025
                            if GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") then begin
                                if GenJnlBatch."Skip Error lines" then
                                    GenJnlBatchPostErrorHandling.PostGenJnlBatch(GenJnlLine, IsHandled, GenJnlPostBatch)
                                else
                                    if not GenJnlPostBatch.RUN(GenJnlLine) then
                                        IF GuiAllowed then
                                            Message(GetLastErrorText());
                            end;
                            // end; //SRBC-395 27112025
                            //SRBC-388 End
                        end;
                        // GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);//BC26_LB_12092025 - Method 'IncrementDocumentNo' is marked for removal.
                        NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, NextDocNo);//BC26_LB_12092025- Added to overcome Method 'IncrementDocumentNo' is marked for removal.
                        ModEpayments.Get(EPaymentSchedule."Entry No.");

                        if ModEpayments."End Date" <> 0D then begin
                            if (NextChargeDate <= ModEpayments."End Date") then begin
                                ModEpayments."Next Charge Date" := NextChargeDate;
                            end else begin
                                ModEpayments."Next Charge Date" := 0D;//SRBC-227 - 03032025
                                ModEpayments.Inactive := true;
                            end;
                        end else begin
                            // if (NextChargeDate <= ModEpayments."Charge Anticipated End Date") then begin
                            //     ModEpayments."Next Charge Date" := NextChargeDate;
                            // end else begin
                            //     ModEpayments."Next Charge Date" := 0D;
                            //     ModEpayments.Inactive := true;
                            // end;
                        end;

                        if (not ModEpayments.Inactive) AND (ModEpayments."Next Charge Date" = 0D) then begin
                            if (ModEpayments.Frequency = ModEpayments.Frequency::Once) then
                                ModEpayments.Inactive := true;
                        end;


                        ModEpayments."Last Charged Date" := ExecutionDate;

                        if EPaymentSchedule."End Date" = 0D then
                            ModEpayments."Next Charge Date" := NextChargeDate;

                        ModEpayments.Modify();

                        if ModEpayments."Payment Plan" then begin
                            Agreements.Reset();
                            Agreements.Get(ModEpayments."Agreement ID");
                            if not Agreements."Payment Plan" then begin
                                Agreements.Validate("Payment Plan", true);
                                Agreements.Modify();
                            end;
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                IF GuiAllowed then
                    WinDlg.Close();

                MarkGenJnlLine.SetRange("Journal Template Name");
                MarkGenJnlLine.SetRange("Journal Batch Name");
                MarkGenJnlLine.SetRange("Line No.");
                MarkGenJnlLine.MarkedOnly(true);


                if not MarkGenJnlLine.IsEmpty then
                    IF GuiAllowed then
                        Message(LinesCreatedLbl);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(ExecutionDate; ExecutionDate)
                    {
                        Caption = 'Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Date field.';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            If ExecutionDate = 0D then
                ExecutionDate := Today;
        end;
    }

    var
        AmtLbl: Label 'Amount';
        PostLbl: Label 'Journal Lines posted successfully.';
        LinesCreatedLbl: Label 'Journal Lines generated successfully.';
        AutoTriggerEpayment: Boolean;
        StartDate: Date;
        TotalCount: Integer;
        GlobalCount: Integer;
        ExecutionDate: Date;
        //NoSeriesMgt: Codeunit NoSeriesManagement;//BC26_LB_12092025- Codeunit 'NoSeriesManagement' is marked for removal.
        NoSeriesMgt: Codeunit "No. Series";//BC26_LB_12092025- Added variable instead of Codeunit NoSeriesManagement  
        NoSeriesBatch: Codeunit "No. Series - Batch";
        BottomLine: Boolean;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        SalonRepublicSetup: Record "Salon Republic Setup";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlBatch: Record "Gen. Journal Batch";
        MarkGenJnlLine: Record "Gen. Journal Line";
        MarkRecurrinChargesRec: Record "Recurring Charges";
        WeekDayDictionary: Dictionary of [Integer, Enum "Week Selection"];
        NextDocNo: Code[20];
        LineNo: Integer;
        WinDlg: Dialog;
        InvAmt: Decimal;
        CurrDayOpt: Enum "Week Selection";
        NextChargeDate: Date;
        LastChargeDate: Date;
        GenJnlBatchPostErrorHandling: Codeunit "Gen Batch Post Error Handling";//SRBC-280
        IsHandled: Boolean;//SRBC-280
    /// <summary>
    /// SetReportParameters.
    /// </summary>
    /// <param name="AutoTriggerRecurringCharges_iBln">Boolean.</param>

    trigger OnPreReport()
    var
        CurrDay: Code[20];
    begin
        NextDocNo := '';
        MarkGenJnlLine.Reset();
        If ExecutionDate = 0D then
            ExecutionDate := Today;

        SourceCodeSetup.Get();
        SalonRepublicSetup.Get();

        SalonRepublicSetup.TestField("Epayment Template");
        SalonRepublicSetup.TestField("Epayment Batch");
        SourceCodeSetup.TestField("Sales Journal");
        GenJnlBatch.Get(SalonRepublicSetup."Epayment Template", SalonRepublicSetup."Epayment Batch");
        NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", ExecutionDate, FALSE);
        IF GuiAllowed then
            WinDlg.Open('Generating Journal Lines...\Customer:#1#############\Total Lines: #2####################');
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        // MarkGenJnlLine.SetRange("Journal Template Name");
        // MarkGenJnlLine.SetRange("Journal Batch Name");
        // MarkGenJnlLine.SetRange("Line No.");
        // MarkGenJnlLine.MarkedOnly(true);


        // if not MarkGenJnlLine.IsEmpty then
        //     IF GuiAllowed then
        //         Message(LinesCreatedLbl);
    end;

    [TryFunction]
    local procedure CreateSalesJournalLines(var GenJnlLine: Record "Gen. Journal Line")
    var
        Customer: Record Customer;
        sr_Description: Code[2048];
        Customer_lRec: Record Customer;//SRBC-296
        CustomerBankAccount_lRec: Record "Customer Bank Account";//SRBC-296
    begin
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := SalonRepublicSetup."Epayment Template";
        GenJnlLine."Journal Batch Name" := SalonRepublicSetup."Epayment Batch";
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

        GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
        GenJnlLine."Document No." := NextDocNo;
        GenJnlLine."Posting Date" := ExecutionDate;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
        GenJnlLine.VALIDATE("Account No.", EPaymentSchedule."Customer No.");
        Customer.GET(EPaymentSchedule."Customer No.");

        GenJnlLine.Validate(Sr_Description, sr_Description);
        GenJnlLine.VALIDATE("Bal. Account Type", GenJnlBatch."Bal. Account Type");
        GenJnlLine.VALIDATE("Bal. Account No.", GenJnlBatch."Bal. Account No."); //need to map
        if EPaymentSchedule."Shortcut Dimension 1 Code" <> '' then
            GenJnlLine.Validate("Shortcut Dimension 1 Code", EPaymentSchedule."Shortcut Dimension 1 Code");
        if EPaymentSchedule."Shortcut Dimension 2 Code" <> '' then
            GenJnlLine.Validate("Shortcut Dimension 2 Code", EPaymentSchedule."Shortcut Dimension 2 Code");
        GenJnlLine."Source Code" := SourceCodeSetup."Sales Journal";
        GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";

        GenJnlLine.VALIDATE(Amount, -InvAmt);

        //GenJnlLine.Validate("Charge Payment Type", RecurringCharges."Auto Charge Type"); //22 Jan
        //GenJnlLine.Validate(License, RecurringCharges.Licensee);
        GenJnlLine.Validate("Agreement ID", EPaymentSchedule."Agreement ID");
        GenJnlLine.Validate("AutoCharge ID", EPaymentSchedule."AutoCharge ID");
        //SRBC-296 - Start
        CustomerBankAccount_lRec.Reset();
        CustomerBankAccount_lRec.SetRange("Customer No.", EPaymentSchedule."Customer No.");
        CustomerBankAccount_lRec.SetRange(Code, EPaymentSchedule."BC Cust. Bank Account");
        CustomerBankAccount_lRec.SetRange("License ID", EPaymentSchedule."License ID");
        CustomerBankAccount_lRec.SetRange("Bank Account Info", EPaymentSchedule."Banking Account Info");
        if CustomerBankAccount_lRec.FindFirst() then
            GenJnlLine.Validate("Recipient Bank Account", EPaymentSchedule."BC Cust. Bank Account");
        //SRBC-296 - End
        GenJnlLine.Validate("Banking Account Info", EPaymentSchedule."Banking Account Info"); //SRBC-256
                                                                                              //GenJnlLine.Validate("Payment Intent ID",EPaymentSchedule.pay);
        GenJnlLine.Validate(License, EPaymentSchedule."License ID");
        GenJnlLine.Validate("Charge Payment Type", 'E-PAYMENT');
        GenJnlLine.Validate("Payment Method Code", 'E-PAYMENT');
        GenJnlLine.Validate("Epayment Schedule", true);
        sr_Description := GenJnlLine."Charge Payment Type" + ' ' + AmtLbl + ' ' + Format(Round(InvAmt, 0.01, '='));
        GenJnlLine.Validate(Sr_Description, sr_Description);
        FlowFrequencyInJnl(GenJnlLine, EPaymentSchedule);//SRBC-352 28042026
    end;

    local procedure SetWeekDayOld(CurrDay: Code[20])
    begin
        Case CurrDay of
            'SUNDAY':
                CurrDayOpt := CurrDayOpt::Sunday;
            'MONDAY':
                CurrDayOpt := CurrDayOpt::Monday;
            'TUESDAY':
                CurrDayOpt := CurrDayOpt::Tuesday;
            'WEDNESDAY':
                CurrDayOpt := CurrDayOpt::Wednesday;
            'THURSDAY':
                CurrDayOpt := CurrDayOpt::Thursday;
            'FRIDAY':
                CurrDayOpt := CurrDayOpt::Friday;
            'SATURDAY':
                CurrDayOpt := CurrDayOpt::Saturday;
        End;
    end;

    local procedure SetWeekDay()
        WeekDayEnum: Enum "Week Selection";
    begin
        WeekDayDictionary.Add(1, WeekDayEnum::Monday);
        WeekDayDictionary.Add(2, WeekDayEnum::Tuesday);
        WeekDayDictionary.Add(3, WeekDayEnum::Wednesday);
        WeekDayDictionary.Add(4, WeekDayEnum::Thursday);
        WeekDayDictionary.Add(5, WeekDayEnum::Friday);
        WeekDayDictionary.Add(6, WeekDayEnum::Saturday);
        WeekDayDictionary.Add(7, WeekDayEnum::Sunday);
    End;

    local procedure CalculateNextChargeDate(CurrDate: Date): Date
    begin
        case EPaymentSchedule.Frequency of
            "Recurring Charge Frequency"::Daily:
                exit(CalcDate('1D', CurrDate));
            "Recurring Charge Frequency"::Weekly:
                exit(CalcDate('1W', CurrDate));
            "Recurring Charge Frequency"::Monthly:
                exit(CalcDate('1M', CurrDate));
            "Recurring Charge Frequency"::Yearly:
                exit(CalcDate('1Y', CurrDate));
            //SRBC-404  Start
            "Recurring Charge Frequency"::Quarterly:
                exit(CalcDate('1Q', CurrDate));
            //SRBC-404 End
            else
                exit(0D);
        end;
    end;

    local procedure CalculateLastCycleAmount(LastCycleDays: Integer): Decimal
    begin
        case LastCycleDays of
            1 .. 7:
                exit((InvAmt * LastCycleDays) / 7);
        end;
    end;

    procedure SetReportParameters(AutoTriggerEpayment_iBln: Boolean; ExecutionDate_iDte: Date)
    var
        myInt: Integer;
    begin
        AutoTriggerEpayment := AutoTriggerEpayment_iBln;
        StartDate := ExecutionDate_iDte;
        //AutochargeCode := AutochargeType_iCod;
    end;

    local procedure CreateRecurringCharges()
    var
        ReccurringCharges: Record "Recurring Charges";
        srsetup: record "Salon Republic Setup";
        EntryNo: Integer;
    begin
        srsetup.Get();
        MarkRecurrinChargesRec.Reset();
        ReccurringCharges.Reset();
        IF ReccurringCharges.FindLast() then
            EntryNo := ReccurringCharges."Entry No." + 1
        else
            EntryNo += 1;
        ReccurringCharges.Init();
        ReccurringCharges."Entry No." := EntryNo;
        ReccurringCharges.Validate("Customer No.", EPaymentSchedule."Customer No.");
        ReccurringCharges.Validate(Licensee, EPaymentSchedule."License ID");
        ReccurringCharges.Validate("Agreement ID", EPaymentSchedule."Agreement ID");
        ReccurringCharges.Validate("Auto Charge Type", srsetup."CONVENIENCE FEE TYPE");
        ReccurringCharges.Validate("Start Date", ExecutionDate);
        ReccurringCharges.Validate("End Date", ExecutionDate);
        ReccurringCharges.Validate("Due Day", EPaymentSchedule."Due Day");
        ReccurringCharges.Validate(Frequency, ReccurringCharges.Frequency::Once);
        //ReccurringCharges.Validate("Last Charged Date", EPaymentSchedule."Last Charged Date");
        ReccurringCharges.Validate(Amount, SalonRepublicSetup."Convenience Fee");
        ReccurringCharges.Validate(IsBC, true);//SRBC-349 SY 01072025
        //ReccurringCharges.Validate("Next Charge Date", EPaymentSchedule."Next Charge Date");
        ReccurringCharges.Insert(true);

        MarkRecurrinChargesRec.SetRange("Entry No.", ReccurringCharges."Entry No.");
        MarkRecurrinChargesRec.FindFirst();
        MarkRecurrinChargesRec.Mark(true);
        AutoCreateRecurringChargeLine();
    end;

    local procedure AutoCreateRecurringChargeLine()
    var
        AutoCreateRecurringCharges: Report "Auto Create Recurring Charges";
        SRSetup: Record "Salon Republic Setup";
    begin
        SRSetup.Get();
        If NOT SRSetup."Auto Create Recurring Charge" then
            exit;
        MarkRecurrinChargesRec.SetRange("Entry No.");
        MarkRecurrinChargesRec.MarkedOnly(true);
        IF MarkRecurrinChargesRec.IsEmpty then
            exit;

        Commit();

        MarkRecurrinChargesRec.FindSet();
        AutoCreateRecurringCharges.SetTableView(MarkRecurrinChargesRec);
        //AutoCreateRecurringCharges.SetReportParameters(true); //Need to check with Abhay
        AutoCreateRecurringCharges.SetReportParameters(false, MarkRecurrinChargesRec."Start Date", MarkRecurrinChargesRec."Auto Charge Type", true); //Need to check with Abhay
        AutoCreateRecurringCharges.UseRequestPage(false);
        AutoCreateRecurringCharges.RunModal();
    end;


    //SRBC-227 Start
    procedure CalculateNextPaymentDateofEpaymentSchedule(EpaymentSchedule: Record "E Payment Schedule") NextPaymentDate: Date
    begin
        NextPaymentDate := 0D;
        //repeat
        Case EpaymentSchedule.Frequency of
            //SRBC-297 Start
            EpaymentSchedule.Frequency::Once:
                begin
                    NextPaymentDate := 0D;
                end;
            //SRBC-297 End
            EpaymentSchedule.Frequency::Weekly:
                if NextPaymentDate = 0D then
                    NextPaymentDate := CalcDate('1W', EpaymentSchedule."Start Date")
                else
                    NextPaymentDate := CalcDate('1W', NextPaymentDate);
            EpaymentSchedule.Frequency::Monthly:
                if NextPaymentDate = 0D then
                    NextPaymentDate := CalcDate('1M', EPaymentSchedule."Start Date")
                else
                    NextPaymentDate := CalcDate('1M', NextPaymentDate);
            EpaymentSchedule.Frequency::Yearly:
                if NextPaymentDate = 0D then
                    NextPaymentDate := CalcDate('1Y', EPaymentSchedule."Start Date")
                else
                    NextPaymentDate := CalcDate('1Y', NextPaymentDate);
            EpaymentSchedule.Frequency::Quarterly:
                if NextPaymentDate = 0D then
                    NextPaymentDate := CalcDate('1Q', EPaymentSchedule."Start Date")
                else
                    NextPaymentDate := CalcDate('1Q', NextPaymentDate);
            EpaymentSchedule.Frequency::Daily:
                if NextPaymentDate = 0D then
                    NextPaymentDate := CalcDate('1D', EPaymentSchedule."Start Date")
                else
                    NextPaymentDate := CalcDate('1D', NextPaymentDate);
        End;
        //until NextPaymentDate > Today();
    end;
    //SRBC-227 End
    //SRBC-352 Start 28042026
    procedure FlowFrequencyInJnl(Var Rec: Record "Gen. Journal Line"; EpaySchedule: Record "E Payment Schedule")
    begin
        case EpaySchedule.Frequency of
            EpaySchedule.Frequency::Once:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Once);
            EpaySchedule.Frequency::Daily:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Daily);
            EpaySchedule.Frequency::Weekly:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Weekly);
            EpaySchedule.Frequency::Monthly:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Monthly);
            EpaySchedule.Frequency::Quarterly:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Quarterly);
            EpaySchedule.Frequency::Yearly:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Yearly);
        end;
    end;
    //SRBC-352 End 28042026
}
