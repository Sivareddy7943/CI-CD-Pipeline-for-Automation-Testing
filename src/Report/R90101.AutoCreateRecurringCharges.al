/// <summary>
/// Report Auto Create Recurring Charges (ID 50000).
/// </summary>
//SRBC-280 - SY - 30012025 - Changes for fail safe batch Batch Process functionality
//SRBC-306 - SY - 12032025 - Did changes if "Next Charge Date" not equal to blank and "Next Charge Date" of "Recurring Charges" not equal to "Execution Date" then it should skip
//SRBC-309 - SY - 12032025 - In Sales Journal amount should be same as Recurring Charges Amount
//SRBC-349 - NU - 20250627 - Commented IsBC Validation in function - AutoCreateRecurringChargeLine and commented code for auto run report for AS.
//SRBC-380 - SY - 15072025 - Did changes on trigger OnAfterGerRecord for Construction Agreement
//SRBC-388 - SY - 31072025 - Did changes on trigger - OnAfterGetRecord for posting Jnl
//SRBC-395 - SY - 21082025 - Did changes on trigger -  OnAfterGetRecord() commented code
//SRBC-442 - SY - 24102025 - Did changes on trigger - OnOpenPage added one more filter - ConstrucAgreeSTUDMODIDIPOSIT
//SRBC-445 - SY - 05112025 - Did changes on trigger - OnAfterGetRecord() for skip posting date functonality for Security Deposit case only.
//SRBC-456 - AM - 04122025 - Did changes in updating next charge date from charge anticipated end date.
//SRBC-465 - NT - 17122025 - Did changes in OnPreDataItem trigger (added filter for Frequency and Next Charge Date).
//SRBC-352 - AM - 28042026 - Did changes in the procedure CreateSalesJournalLines,CreateSalesJournalPaymentLines,CreateConstructionPaymentJournal,CreateAdditionalSecurityInvoiceJournal and created one procedure FlowFrequencyInJnl
//SRBC-499 - AM - 01072026 - Did changes in the OnAfterGetRecord trigger to check the end date is less or equal to today
//SRBC-529 - NU - 24092026 - Did changes in the Procedure CreateSalesJournalPaymentLines to update the payment method type while creating sales journal from Recurring charges
report 90101 "Auto Create Recurring Charges"
{
    ApplicationArea = All;
    Caption = 'Auto Create Recurring Charges';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(RecurringCharges; "Recurring Charges")
        {
            DataItemTableView = where(sr_IsCRM = filter(false));
            RequestFilterFields = "Customer No.", "Entry No.";
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                TotalCount := 0;
                IF NOT AutoTriggerRecurringCharges then begin
                    SetRange(Cancelled, false);
                    SetRange(Inactive, false);
                    SetRange(IsBC, true); //SRBC-349 - NU - 20250627
                    SetFilter("Start Date", '<=%1', ExecutionDate);
                end;
                SetCurrentKey("Customer No.", "Agreement ID");
                GlobalCount := RecurringCharges.Count;
            end;

            trigger OnAfterGetRecord()
            var
                GenJnlLine: Record "Gen. Journal Line";
                ModRecurringCharges: Record "Recurring Charges";
                MidDayAgreement: Boolean;
                CurrDayNo: Integer;
                DiffNoofDays: Integer;
                LastCycleDays: Integer;
                MultiHoldDepositReccCharges: Record "Recurring Charges";
                ReccCount: Integer;
                CheckReccChargesDate: Record "Recurring Charges";
                NoSeriesBatch: Codeunit "No. Series - Batch";//BC26_LB_12092025- Added variable because of Method 'IncrementDocumentNo' is marked for removal.
            begin
                BottomLine := false;
                MidDayAgreement := false;
                CurrDayNo := 0;
                DiffNoofDays := 0;
                NextChargeDate := 0D;
                LastChargeDate := 0D;
                LastCycleDays := 0;

                // if RecurringCharges."End Date" <> 0D then begin
                //     RecurringCharges.SetFilter("End Date", '>=%1', ExecutionDate);
                //     if RecurringCharges."End Date" < ExecutionDate then
                //         exit;
                // end else begin
                //     RecurringCharges.SetFilter("Charge Anticipated End Date", '>=%1', ExecutionDate);
                //     if RecurringCharges."Charge Anticipated End Date" < ExecutionDate then
                //         exit;
                // end;
                CheckReccChargesDate.Reset();
                CheckReccChargesDate.Get(RecurringCharges."Entry No.");
                if CheckReccChargesDate."End Date" <> 0D then begin
                    CheckReccChargesDate.SetFilter("End Date", '>=%1', ExecutionDate);
                    if CheckReccChargesDate."End Date" < ExecutionDate then
                        exit;
                    //SRBC-395 Start AM 21112025
                    // end else begin
                    //     CheckReccChargesDate.SetFilter("Charge Anticipated End Date", '>=%1', ExecutionDate);
                    //     if CheckReccChargesDate."Charge Anticipated End Date" < ExecutionDate then
                    //         exit;
                    //SRBC-395 End
                end;
                TotalCount += 1;
                InvAmt := RecurringCharges.Amount;

                IF GuiAllowed then begin
                    WinDlg.Update(1, RecurringCharges."Customer No.");
                    WinDlg.Update(2, TotalCount);
                end;

                // IF RecurringCharges."Last Charged Date" = ExecutionDate then
                //     CurrReport.Skip();
                LastChargeDate := ExecutionDate;
                NextChargeDate := CalculateNextChargeDate(ExecutionDate);

                // If RecurringCharges."Last Charged Date" = 0D then begin
                //     If RecurringCharges.Frequency <> RecurringCharges.Frequency::Once then begin
                //         MidDayAgreement := RecurringCharges."Agreement Start Day" <> RecurringCharges."Due Day";
                //         If MidDayAgreement then begin
                //             CalcDates;
                //             DiffNoofDays := NextChargeDate - RecurringCharges."Agreement Start Date" + 1;
                //             InvAmt := (InvAmt * DiffNoofDays) / 7;
                //         end;
                //         // end else begin
                //         // IF RecurringCharges."Start Date" <> ExecutionDate then
                //         // CurrReport.Skip();
                //         // NextChargeDate := 0D;
                //     end;
                // end else begin
                //     If RecurringCharges."Next Charge Date" <> ExecutionDate then
                //         CurrReport.Skip();
                // end;

                If RecurringCharges."Last Charged Date" <> 0D then
                    If RecurringCharges."Next Charge Date" <> ExecutionDate then
                        CurrReport.Skip();
                //SRBC-306 Start
                if RecurringCharges."Next Charge Date" <> 0D then
                    if ExecutionDate <> RecurringCharges."Next Charge Date" then
                        CurrReport.Skip();
                //SRBC-306 End


                // case of last cycle amount charge
                //SRBC-395 Start
                // If ((RecurringCharges.Frequency <> RecurringCharges.Frequency::Once) AND (NOT RecurringCharges."Skip Calculation")) then begin
                //     if RecurringCharges."Next Charge Date" = 0D then begin
                //         if RecurringCharges."End Date" <> 0D then
                //             LastCycleDays := RecurringCharges."End Date" - ExecutionDate
                //         else
                //             LastCycleDays := RecurringCharges."Charge Anticipated End Date" - ExecutionDate;
                //         case LastCycleDays of
                //             1 .. 7:
                //                 InvAmt := CalculateLastCycleAmount(LastCycleDays);
                //         end;
                //     end else begin
                //         if RecurringCharges."End Date" <> 0D then
                //             LastCycleDays := RecurringCharges."End Date" - RecurringCharges."Next Charge Date"
                //         else
                //             LastCycleDays := RecurringCharges."Charge Anticipated End Date" - RecurringCharges."Next Charge Date";
                //         //LastCycleDays := RecurringCharges."End Date" - RecurringCharges."Next Charge Date";
                //         case LastCycleDays of
                //             1 .. 7:
                //                 // InvAmt := CalculateLastCycleAmount(LastCycleDays);//SRBC-309
                //                 InvAmt := InvAmt;//SRBC-309
                //         end;
                //         // if LastCycleDays < 7 then
                //         //     InvAmt := CalculateLastCycleAmount(LastCycleDays);
                //     end;
                // end;
                //SRBC-395 End

                LineNo := 0;
                ReccCount := 0;
                GenJnlLine.Reset();
                GenJnlLine.SetRange("Journal Template Name", SalonRepublicSetup."Rent Charge Template");
                GenJnlLine.SetRange("Journal Batch Name", SalonRepublicSetup."Rent Charge Batch");
                IF GenJnlLine.FindLast() then begin
                    LineNo := GenJnlLine."Line No." + 10000;
                    NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, GenJnlLine."Document No.");
                    BottomLine := true;
                    //GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);
                end else
                    LineNo := 10000;

                //SRBC-445 Start
                if RecurringCharges."Auto Charge Type" in ['ADDITIONAL SECURITY DEPOSIT', 'LICENSE FEE SECURITY DEPOSIT', 'STUDIO MODIFICATION DEPOSIT'] then
                    SkipPostingDate_gVar := true
                else
                    SkipPostingDate_gVar := false;
                //SRBC-445 End

                //Multi Signer Hold Deposit Start
                if (RecurringCharges.IsLastRow) AND (RecurringCharges."MultiSigner Hold Deposit") then begin
                    InvoiceLineInserted := false;
                    AmountShare := CalculateMultiSignerAmount(RecurringCharges);
                    MultiHoldDepositReccCharges.Reset();
                    MultiHoldDepositReccCharges.SetCurrentKey("Entry No.");
                    MultiHoldDepositReccCharges.SetRange("Agreement ID", RecurringCharges."Agreement ID");
                    MultiHoldDepositReccCharges.SetRange("MultiSigner Hold Deposit", true);
                    //MultiHoldDepositReccCharges.SetFilter(sr_AmountShare, '<>%1', 0);

                    if MultiHoldDepositReccCharges.FindSet() then begin
                        repeat
                            ReccCount += 1;
                            if ReccCount = 1 then begin

                                if CreateSalesJournalLines(GenJnlLine) then begin  //Invoice
                                    if AmountShare <> 0 then begin
                                        GenJnlLine.insert(true);
                                        TempGJLine.Init();
                                        TempGJLine.TransferFields(GenJnlLine);
                                        TempGJLine.Insert();
                                        LineNo += 10000;
                                        InvoiceLineInserted := true;
                                    end;

                                    //GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);//BC26_LB_12092025 - Method 'IncrementDocumentNo' is marked for removal.
                                    NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, NextDocNo);//BC26_LB_12092025- Added to overcome Method 'IncrementDocumentNo' is marked for removal.

                                    if ((not MultiHoldDepositReccCharges."Additional Security Charge") AND (MultiHoldDepositReccCharges.Amount <> 0)) then
                                        //if MultiHoldDepositReccCharges.sr_AmountShare <> 0 then
                                        CreateSalesJournalPaymentLines(GenJnlLine, MultiHoldDepositReccCharges);
                                end;
                            end else begin
                                if ((not MultiHoldDepositReccCharges."Additional Security Charge") AND (MultiHoldDepositReccCharges.Amount <> 0)) then begin
                                    //if MultiHoldDepositReccCharges.sr_AmountShare <> 0 then
                                    CreateSalesJournalPaymentLines(GenJnlLine, MultiHoldDepositReccCharges);
                                end else begin
                                    //GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);//BC26_LB_12092025 - Method 'IncrementDocumentNo' is marked for removal.
                                    NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, NextDocNo);//BC26_LB_12092025- Added to overcome Method 'IncrementDocumentNo' is marked for removal.

                                    if ((MultiHoldDepositReccCharges."Additional Security Charge") AND (MultiHoldDepositReccCharges.Amount <> 0)) then begin
                                        if MultiHoldDepositReccCharges.sr_AmountShare <> 0 then
                                            if CreateAdditionalSecurityInvoiceJournal(GenJnlLine, MultiHoldDepositReccCharges) then begin
                                                GenJnlLine.insert(true);
                                                TempGJLine.Init();
                                                TempGJLine.TransferFields(GenJnlLine);
                                                TempGJLine.Insert();
                                            end;
                                    end;
                                end;
                            end;

                            ModRecurringCharges.Get(MultiHoldDepositReccCharges."Entry No.");


                            if ModRecurringCharges."End Date" <> 0D then begin
                                if (NextChargeDate <= ModRecurringCharges."End Date") then begin
                                    ModRecurringCharges."Next Charge Date" := NextChargeDate;
                                end else begin
                                    ModRecurringCharges."Next Charge Date" := 0D;
                                    ModRecurringCharges.Inactive := true;
                                end;
                                //SRBC-456 Start
                                // end else begin
                                //     if (NextChargeDate <= ModRecurringCharges."Charge Anticipated End Date") then begin
                                //         ModRecurringCharges."Next Charge Date" := NextChargeDate;
                                //     end else begin
                                //         ModRecurringCharges."Next Charge Date" := 0D;
                                //         ModRecurringCharges.Inactive := true;
                                //     end;
                                //SRBC-456 End
                            end;

                            if (not ModRecurringCharges.Inactive) AND (ModRecurringCharges."Next Charge Date" = 0D) then begin
                                if (ModRecurringCharges.Frequency = ModRecurringCharges.Frequency::Once) then
                                    ModRecurringCharges.Inactive := true;
                            end;

                            if not MultiHoldDepositReccCharges."Additional Security Charge" then
                                ModRecurringCharges."Last Charged Date" := ExecutionDate
                            else
                                ModRecurringCharges."Last Charged Date" := MultiHoldDepositReccCharges."Start Date";

                            ModRecurringCharges.Modify();

                        until MultiHoldDepositReccCharges.Next() = 0;

                        if SalonRepublicSetup."Auto Post Recurring Charge" then begin  //Post Multisigner
                            if TempGJLine.FindSet() then begin
                                Commit();
                                //SRBC-280 Start                 
                                if GlobalCount = TotalCount then begin
                                    //SRBC-388 Start 
                                    if SkipPostingDate_gVar then
                                        SICU.SkipCLEPostingDate(true);//SRBC-445 
                                    Clear(GenJnlBatch_gCU);
                                    if GenJnlBatch_gCU.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") then begin
                                        if GenJnlBatch_gCU."Skip Error lines" then
                                            GenJnlBatchPostErrorHandling_gCU.PostGenJnlBatch(GenJnlLine, IsHandled_gVar, GenJnlPostBatch)
                                        else
                                            if not GenJnlPostBatch.RUN(GenJnlLine) then
                                                IF GuiAllowed then
                                                    Message(GetLastErrorText());
                                    end;
                                    SICU.SkipCLEPostingDate(false);//SRBC-445
                                    //SRBC-388 End
                                    //SRBC-280 End
                                end;

                            end;
                        end;
                        //GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);
                    end;
                end;
                //Multi Signer Hold Deposit End

                //SRBC-380 Start
                //Construction Agreement Start
                if (not RecurringCharges."MultiSigner Hold Deposit") AND (RecurringCharges."Construction Agreement") AND (RecurringCharges.sr_AmountShare <> 0) AND (RecurringCharges.Amount = 0) then begin
                    IF CreateSalesJournalLines(GenJnlLine) then begin
                        GenJnlLine.Insert(true);
                        //InsertTmpCustRentRateDtls();//SRBC-465 JSG 21012026 - Commented
                        If not SalonRepublicSetup."Auto Post Recurring Charge" then begin
                            MarkGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                            MarkGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            MarkGenJnlLine.SetRange("Line No.", GenJnlLine."Line No.");
                            MarkGenJnlLine.FindFirst();
                            MarkGenJnlLine.Mark(true);
                        end else begin
                            Commit();
                            //SRBC-388 Start  
                            if GlobalCount = TotalCount then begin
                                if SkipPostingDate_gVar then
                                    SICU.SkipCLEPostingDate(true);//SRBC-445 RecurringCharges
                                Clear(GenJnlBatch_gCU);
                                if GenJnlBatch_gCU.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") then begin
                                    if GenJnlBatch_gCU."Skip Error lines" then
                                        GenJnlBatchPostErrorHandling_gCU.PostGenJnlBatch(GenJnlLine, IsHandled_gVar, GenJnlPostBatch)
                                    else
                                        if not GenJnlPostBatch.RUN(GenJnlLine) then
                                            IF GuiAllowed then
                                                Message(GetLastErrorText());
                                end;
                                SICU.SkipCLEPostingDate(false);//SRBC-445
                            end;
                            //SRBC-388 End
                        end;

                        //GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);//BC26_LB_12092025 - Method 'IncrementDocumentNo' is marked for removal.
                        NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, NextDocNo);//BC26_LB_12092025- Added to overcome Method 'IncrementDocumentNo' is marked for removal.

                        ModRecurringCharges.Get(RecurringCharges."Entry No.");
                        if ModRecurringCharges."End Date" <> 0D then begin
                            if (NextChargeDate <= ModRecurringCharges."End Date") then begin
                                ModRecurringCharges."Next Charge Date" := NextChargeDate;
                            end else begin
                                ModRecurringCharges."Next Charge Date" := 0D;
                                ModRecurringCharges.Inactive := true;
                            end;
                            //SRBC-456 Start
                            // end else begin
                            //     if (NextChargeDate <= ModRecurringCharges."Charge Anticipated End Date") then begin
                            //         ModRecurringCharges."Next Charge Date" := NextChargeDate;
                            //     end else begin
                            //         ModRecurringCharges."Next Charge Date" := 0D;
                            //         ModRecurringCharges.Inactive := true;
                            //     end;
                            //SRBC-456 End
                        end;
                        if (not ModRecurringCharges.Inactive) AND (ModRecurringCharges."Next Charge Date" = 0D) then begin
                            if (ModRecurringCharges.Frequency = ModRecurringCharges.Frequency::Once) then
                                ModRecurringCharges.Inactive := true;
                        end;
                        ModRecurringCharges."Last Charged Date" := ExecutionDate;
                        ModRecurringCharges.Modify();
                    end;
                end else begin
                    if (not RecurringCharges."MultiSigner Hold Deposit") AND (RecurringCharges."Construction Agreement") AND (RecurringCharges.Amount <> 0) AND (RecurringCharges.sr_AmountShare = 0) then begin
                        CreateConstructionPaymentJournal(GenJnlLine, RecurringCharges);
                        If not SalonRepublicSetup."Auto Post Recurring Charge" then begin
                            MarkGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                            MarkGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            MarkGenJnlLine.SetRange("Line No.", GenJnlLine."Line No.");
                            MarkGenJnlLine.FindFirst();
                            MarkGenJnlLine.Mark(true);
                        end else begin
                            Commit();
                            //SRBC-388 Start  
                            if GlobalCount = TotalCount then begin
                                if SkipPostingDate_gVar then
                                    SICU.SkipCLEPostingDate(true);//SRBC-445 RecurringCharges
                                //GenJnlBatchPostErrorHandling.PostGenJnlBatch(GenJnlLine, IsHandled, GenJnlPostBatch); 
                                Clear(GenJnlBatch_gCU);
                                if GenJnlBatch_gCU.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") then begin
                                    if GenJnlBatch_gCU."Skip Error lines" then
                                        GenJnlBatchPostErrorHandling_gCU.PostGenJnlBatch(GenJnlLine, IsHandled_gVar, GenJnlPostBatch)
                                    else
                                        if not GenJnlPostBatch.RUN(GenJnlLine) then
                                            IF GuiAllowed then
                                                Message(GetLastErrorText());
                                end;
                                SICU.SkipCLEPostingDate(false);//SRBC-445
                            end;
                            //SRBC-388 End
                        end;

                        //GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);//BC26_LB_12092025 - Method 'IncrementDocumentNo' is marked for removal.
                        NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, NextDocNo);//BC26_LB_12092025- Added to overcome Method 'IncrementDocumentNo' is marked for removal.
                        ModRecurringCharges.Get(RecurringCharges."Entry No.");

                        if ModRecurringCharges."End Date" <> 0D then begin
                            if (NextChargeDate <= ModRecurringCharges."End Date") then begin
                                ModRecurringCharges."Next Charge Date" := NextChargeDate;
                            end else begin
                                ModRecurringCharges."Next Charge Date" := 0D;
                                ModRecurringCharges.Inactive := true;
                            end;
                            //SRBC-456 Start
                            // end else begin
                            //     if (NextChargeDate <= ModRecurringCharges."Charge Anticipated End Date") then begin
                            //         ModRecurringCharges."Next Charge Date" := NextChargeDate;
                            //     end else begin
                            //         ModRecurringCharges."Next Charge Date" := 0D;
                            //         ModRecurringCharges.Inactive := true;
                            //     end;
                            //SRBC-456 End
                        end;
                        if (not ModRecurringCharges.Inactive) AND (ModRecurringCharges."Next Charge Date" = 0D) then begin
                            if (ModRecurringCharges.Frequency = ModRecurringCharges.Frequency::Once) then
                                ModRecurringCharges.Inactive := true;
                        end;
                        ModRecurringCharges."Last Charged Date" := ExecutionDate;
                        ModRecurringCharges.Modify();
                    end else begin
                        if (not RecurringCharges."MultiSigner Hold Deposit") AND (RecurringCharges."Construction Agreement") AND (RecurringCharges.Amount <> 0) AND (RecurringCharges.sr_AmountShare <> 0) then begin
                            IF CreateSalesJournalLines(GenJnlLine) then begin
                                GenJnlLine.Insert(true);
                                //InsertTmpCustRentRateDtls();//SRBC-465 JSG 21012026 - Commented
                                If not SalonRepublicSetup."Auto Post Recurring Charge" then begin
                                    MarkGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                                    MarkGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                                    MarkGenJnlLine.SetRange("Line No.", GenJnlLine."Line No.");
                                    MarkGenJnlLine.FindFirst();
                                    MarkGenJnlLine.Mark(true);
                                end else begin
                                    Commit();
                                    //SRBC-388 Start
                                    if GlobalCount = TotalCount then begin
                                        if SkipPostingDate_gVar then
                                            SICU.SkipCLEPostingDate(true);//SRBC-445 RecurringCharges
                                        //GenJnlBatchPostErrorHandling.PostGenJnlBatch(GenJnlLine, IsHandled, GenJnlPostBatch); 
                                        Clear(GenJnlBatch_gCU);
                                        if GenJnlBatch_gCU.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") then begin
                                            if GenJnlBatch_gCU."Skip Error lines" then
                                                GenJnlBatchPostErrorHandling_gCU.PostGenJnlBatch(GenJnlLine, IsHandled_gVar, GenJnlPostBatch)
                                            else
                                                if not GenJnlPostBatch.RUN(GenJnlLine) then
                                                    IF GuiAllowed then
                                                        Message(GetLastErrorText());
                                        end;
                                        SICU.SkipCLEPostingDate(false);//SRBC-445
                                    end;
                                    //SRBC-388 End
                                end;

                                //GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);//BC26_LB_12092025 - Method 'IncrementDocumentNo' is marked for removal.
                                NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, NextDocNo);//BC26_LB_12092025- Added to overcome Method 'IncrementDocumentNo' is marked for removal.
                            end;
                            Clear(GenJnlLine);
                            CreateConstructionPaymentJournal(GenJnlLine, RecurringCharges);
                            If not SalonRepublicSetup."Auto Post Recurring Charge" then begin
                                MarkGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                                MarkGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                                MarkGenJnlLine.SetRange("Line No.", GenJnlLine."Line No.");
                                MarkGenJnlLine.FindFirst();
                                MarkGenJnlLine.Mark(true);
                            end else begin
                                Commit();
                                //SRBC-388 Start  
                                if GlobalCount = TotalCount then begin
                                    if SkipPostingDate_gVar then
                                        SICU.SkipCLEPostingDate(true);//SRBC-445 RecurringCharges
                                    //GenJnlBatchPostErrorHandling.PostGenJnlBatch(GenJnlLine, IsHandled, GenJnlPostBatch); 
                                    Clear(GenJnlBatch_gCU);
                                    if GenJnlBatch_gCU.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") then begin
                                        if GenJnlBatch_gCU."Skip Error lines" then
                                            GenJnlBatchPostErrorHandling_gCU.PostGenJnlBatch(GenJnlLine, IsHandled_gVar, GenJnlPostBatch)
                                        else
                                            if not GenJnlPostBatch.RUN(GenJnlLine) then
                                                IF GuiAllowed then
                                                    Message(GetLastErrorText());
                                    end;
                                    SICU.SkipCLEPostingDate(false);//SRBC-445
                                end;
                                //SRBC-388 End
                            end;

                            // GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);//BC26_LB_12092025 - Method 'IncrementDocumentNo' is marked for removal.
                            NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, NextDocNo);//BC26_LB_12092025- Added to overcome Method 'IncrementDocumentNo' is marked for removal.
                            ModRecurringCharges.Get(RecurringCharges."Entry No.");

                            if ModRecurringCharges."End Date" <> 0D then begin
                                if (NextChargeDate <= ModRecurringCharges."End Date") then begin
                                    ModRecurringCharges."Next Charge Date" := NextChargeDate;
                                end else begin
                                    ModRecurringCharges."Next Charge Date" := 0D;
                                    ModRecurringCharges.Inactive := true;
                                end;
                                //SRBC-456 Start
                                // end else begin
                                //     if (NextChargeDate <= ModRecurringCharges."Charge Anticipated End Date") then begin
                                //         ModRecurringCharges."Next Charge Date" := NextChargeDate;
                                //     end else begin
                                //         ModRecurringCharges."Next Charge Date" := 0D;
                                //         ModRecurringCharges.Inactive := true;
                                //     end;
                                //SRBC-456 End
                            end;
                            if (not ModRecurringCharges.Inactive) AND (ModRecurringCharges."Next Charge Date" = 0D) then begin
                                if (ModRecurringCharges.Frequency = ModRecurringCharges.Frequency::Once) then
                                    ModRecurringCharges.Inactive := true;
                            end;
                            ModRecurringCharges."Last Charged Date" := ExecutionDate;
                            ModRecurringCharges.Modify();

                            //Construction Agreement Start
                            // if (not RecurringCharges."MultiSigner Hold Deposit") AND (RecurringCharges."Construction Agreement") AND (RecurringCharges.Amount <> 0) then begin
                            //     CreateConstructionPaymentJournal(GenJnlLine, RecurringCharges);

                            //     If not SalonRepublicSetup."Auto Post Recurring Charge" then begin
                            //         MarkGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                            //         MarkGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            //         MarkGenJnlLine.SetRange("Line No.", GenJnlLine."Line No.");
                            //         MarkGenJnlLine.FindFirst();
                            //         MarkGenJnlLine.Mark(true);
                            //     end else begin
                            //         Commit();
                            //         //SRBC-280 Start
                            //         if GlobalCount = TotalCount then
                            //             GenJnlBatchPostErrorHandling.PostGenJnlBatch(GenJnlLine, IsHandled, GenJnlPostBatch);
                            //         // if not GenJnlPostBatch.RUN(GenJnlLine) then
                            //         //     IF GuiAllowed then
                            //         //         Message(GetLastErrorText());
                            //         //SRBC-280 End

                            //     end;

                            //     GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);
                            //     ModRecurringCharges.Get(RecurringCharges."Entry No.");


                            //     if ModRecurringCharges."End Date" <> 0D then begin
                            //         if (NextChargeDate <= ModRecurringCharges."End Date") then begin
                            //             ModRecurringCharges."Next Charge Date" := NextChargeDate;
                            //         end else begin
                            //             ModRecurringCharges."Next Charge Date" := 0D;
                            //             ModRecurringCharges.Inactive := true;
                            //         end;
                            //     end else begin
                            //         if (NextChargeDate <= ModRecurringCharges."Charge Anticipated End Date") then begin
                            //             ModRecurringCharges."Next Charge Date" := NextChargeDate;
                            //         end else begin
                            //             ModRecurringCharges."Next Charge Date" := 0D;
                            //             ModRecurringCharges.Inactive := true;
                            //         end;
                            //     end;

                            //     if (not ModRecurringCharges.Inactive) AND (ModRecurringCharges."Next Charge Date" = 0D) then begin
                            //         if (ModRecurringCharges.Frequency = ModRecurringCharges.Frequency::Once) then
                            //             ModRecurringCharges.Inactive := true;
                            //     end;
                            //     ModRecurringCharges."Last Charged Date" := ExecutionDate;
                            //     ModRecurringCharges.Modify();

                        end else begin //Construction Agreement End

                            //Normal one to one mapping Start
                            if (not RecurringCharges."MultiSigner Hold Deposit") AND (NOT RecurringCharges."Construction Agreement") AND (RecurringCharges.Amount <> 0) then begin
                                IF CreateSalesJournalLines(GenJnlLine) then begin
                                    GenJnlLine.Insert(true);
                                    //InsertTmpCustRentRateDtls();//SRBC-465 JSG 21012026 - Commented
                                    If not SalonRepublicSetup."Auto Post Recurring Charge" then begin
                                        MarkGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                                        MarkGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                                        MarkGenJnlLine.SetRange("Line No.", GenJnlLine."Line No.");
                                        MarkGenJnlLine.FindFirst();
                                        MarkGenJnlLine.Mark(true);
                                    end else begin
                                        Commit();
                                        //SRBC-388 Start  
                                        // if GlobalCount = TotalCount then begin//SRBC-395 27112025
                                        //GenJnlBatchPostErrorHandling.PostGenJnlBatch(GenJnlLine, IsHandled, GenJnlPostBatch); 
                                        if SkipPostingDate_gVar then
                                            SICU.SkipCLEPostingDate(true);//SRBC-445
                                        Clear(GenJnlBatch_gCU);
                                        if GenJnlBatch_gCU.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") then begin
                                            if GenJnlBatch_gCU."Skip Error lines" then
                                                GenJnlBatchPostErrorHandling_gCU.PostGenJnlBatch(GenJnlLine, IsHandled_gVar, GenJnlPostBatch)
                                            else
                                                if not GenJnlPostBatch.RUN(GenJnlLine) then
                                                    IF GuiAllowed then
                                                        Message(GetLastErrorText());
                                        end;
                                        SICU.SkipCLEPostingDate(false);//SRBC-445
                                                                       // end;//SRBC-395 27112025
                                                                       //SRBC-388 End
                                    end;

                                    //GenJnlLine.IncrementDocumentNo(GenJnlBatch, NextDocNo);//BC26_LB_12092025 - Method 'IncrementDocumentNo' is marked for removal.
                                    NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", ExecutionDate, NextDocNo);//BC26_LB_12092025- Added to overcome Method 'IncrementDocumentNo' is marked for removal.
                                    ModRecurringCharges.Get(RecurringCharges."Entry No.");


                                    if ModRecurringCharges."End Date" <> 0D then begin
                                        if (NextChargeDate <= ModRecurringCharges."End Date") then begin
                                            ModRecurringCharges."Next Charge Date" := NextChargeDate;
                                        end else begin
                                            ModRecurringCharges."Next Charge Date" := 0D;
                                            if ModRecurringCharges."End Date" <= Today then //SRBC-499 01072026
                                                ModRecurringCharges.Inactive := true;
                                        end;
                                        //SRBC-395 Start AM 21112025
                                        // end else begin
                                        //     if (NextChargeDate <= ModRecurringCharges."Charge Anticipated End Date") then begin
                                        //         ModRecurringCharges."Next Charge Date" := NextChargeDate;
                                        //     end else begin
                                        //         ModRecurringCharges."Next Charge Date" := 0D;
                                        //         ModRecurringCharges.Inactive := true;
                                        //     end;
                                        //SRBC-395 End
                                    end;

                                    if (not ModRecurringCharges.Inactive) AND (ModRecurringCharges."Next Charge Date" = 0D) then begin
                                        if (ModRecurringCharges.Frequency = ModRecurringCharges.Frequency::Once) then
                                            ModRecurringCharges.Inactive := true;
                                    end;
                                    ModRecurringCharges."Last Charged Date" := ExecutionDate;
                                    //SRBC-395 Start 26112025
                                    if RecurringCharges."End Date" = 0D then
                                        ModRecurringCharges."Next Charge Date" := NextChargeDate;
                                    //SRBC-395 End 26112025
                                    ModRecurringCharges.Modify();
                                end;
                            end;
                            //Normal one to one mapping End
                        end;
                    end;
                end;
            end;
            //SRBC-380 End

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                IF GuiAllowed then
                    WinDlg.Close();

                //UpdateCustomerRent();//SRBC-465 JSG 21012026 - Commented
                if NOT HideDialog then begin
                    MarkGenJnlLine.SetRange("Journal Template Name");
                    MarkGenJnlLine.SetRange("Journal Batch Name");
                    MarkGenJnlLine.SetRange("Line No.");
                    MarkGenJnlLine.MarkedOnly(true);

                    if not MarkGenJnlLine.IsEmpty then
                        IF GuiAllowed then
                            Message(LinesCreatedLbl);
                end;
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
                    field("Execution Date"; ExecutionDate)
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
            area(processing) { }
        }
        trigger OnOpenPage()
        var
            CurrDay: Code[20];
        begin
            SalonRepublicSetup.Get();
            // If ExecutionDate = 0D then
            //     ExecutionDate := Today;
            // if (AutochargeCode = (SalonRepublicSetup."LICENSE FEE SECURITY")) OR (AutochargeCode = (SalonRepublicSetup."CONVENIENCE FEE TYPE")) OR (AutochargeCode = (SalonRepublicSetup.ConstrucAgreeSTUDMODICHARGE)) OR ((AutochargeCode = SalonRepublicSetup."ADDITIONAL SECURITY DEPOSIT")) then begin//SRBC-442 JSG 221025 Old
            if (AutochargeCode = (SalonRepublicSetup."LICENSE FEE SECURITY")) OR (AutochargeCode = (SalonRepublicSetup."CONVENIENCE FEE TYPE")) OR (AutochargeCode = (SalonRepublicSetup.ConstrucAgreeSTUDMODICHARGE)) OR ((AutochargeCode = SalonRepublicSetup."ADDITIONAL SECURITY DEPOSIT")) OR ((AutochargeCode = SalonRepublicSetup.ConstrucAgreeSTUDMODIDIPOSIT)) then begin//SRBC-442 JSG 221025 New
                ExecutionDate := StartDate;
            end else begin
                If ExecutionDate = 0D then
                    ExecutionDate := Today;
            end;
        end;
    }
    var
        AmtLbl: Label 'Amount';
        PostLbl: Label 'Journal Lines posted successfully.';
        LinesCreatedLbl: Label 'Journal Lines generated successfully.';
        SalonRepublicSetup: Record "Salon Republic Setup";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlBatch: Record "Gen. Journal Batch";
        MarkGenJnlLine: Record "Gen. Journal Line";
        TempGJLine: Record "Gen. Journal Line" temporary;
        DateForWeek: Record Date;
        // NoSeriesMgt: Codeunit NoSeriesManagement;//BC26_LB_12092025- Codeunit 'NoSeriesManagement' is marked for removal.
        NoSeriesMgt: Codeunit "No. Series";//BC26_LB_12092025- Added variable instead of Codeunit NoSeriesManagement  
        NoSeriesBatch: Codeunit "No. Series - Batch";
        BottomLine: Boolean;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        TmpCustomer: Record Customer temporary;
        ExecutionDate: Date;
        NextChargeDate: Date;
        LastChargeDate: Date;
        CurrDayOpt: Enum "Week Selection";
        NextDocNo: Code[20];
        WinDlg: Dialog;
        WeekDayDictionary: Dictionary of [Integer, Enum "Week Selection"];
        InvAmt: Decimal;
        AmountShare: Decimal;
        TotalCount: Integer;
        GlobalCount: Integer;
        LineNo: Integer;
        AutoTriggerRecurringCharges: Boolean;
        SkipCalculation: Boolean;
        AutochargeCode: Code[50];
        StartDate: Date;
        HideDialog: Boolean;
        InvoiceLineInserted: Boolean;
        GenJnlBatchPostErrorHandling_gCU: Codeunit "Gen Batch Post Error Handling";//SRBC-388
        IsHandled_gVar: Boolean;//SRBC-388
        GenJnlBatch_gCU: Record "Gen. Journal Batch";//SRBC-388 
        SkipPostingDate_gVar: Boolean;//SRBC-445

    trigger OnPreReport()
    var
        CurrDay: Code[20];

    begin
        SalonRepublicSetup.Get();
        NextDocNo := '';
        MarkGenJnlLine.Reset();

        //if (AutochargeCode = (SalonRepublicSetup."LICENSE FEE SECURITY")) OR (AutochargeCode = (SalonRepublicSetup."CONVENIENCE FEE TYPE")) OR (AutochargeCode = (SalonRepublicSetup.ConstrucAgreeSTUDMODICHARGE)) OR ((AutochargeCode = SalonRepublicSetup."ADDITIONAL SECURITY DEPOSIT")) then begin//SRBC-442 JSG 221025 Old
        if (AutochargeCode = (SalonRepublicSetup."LICENSE FEE SECURITY")) OR (AutochargeCode = (SalonRepublicSetup."CONVENIENCE FEE TYPE")) OR (AutochargeCode = (SalonRepublicSetup.ConstrucAgreeSTUDMODICHARGE)) OR ((AutochargeCode = SalonRepublicSetup."ADDITIONAL SECURITY DEPOSIT")) OR ((AutochargeCode = SalonRepublicSetup.ConstrucAgreeSTUDMODIDIPOSIT)) then begin//SRBC-442 JSG 221025 New
            ExecutionDate := StartDate;
        end else begin
            If ExecutionDate = 0D then
                ExecutionDate := Today;
        end;


        TmpCustomer.Reset();
        TmpCustomer.DeleteAll();
        SourceCodeSetup.Get();


        SalonRepublicSetup.TestField("Rent Charge Template");
        SalonRepublicSetup.TestField("Rent Charge Batch");
        SourceCodeSetup.TestField("Sales Journal");
        SetWeekDay();
        GenJnlBatch.Get(SalonRepublicSetup."Rent Charge Template", SalonRepublicSetup."Rent Charge Batch");
        //NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", ExecutionDate, FALSE);

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
    begin
        if not BottomLine then begin
            GenJnlBatch.Get(SalonRepublicSetup."Rent Charge Template", SalonRepublicSetup."Rent Charge Batch");
            NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", ExecutionDate, FALSE);
        end;

        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := SalonRepublicSetup."Rent Charge Template";
        GenJnlLine."Journal Batch Name" := SalonRepublicSetup."Rent Charge Batch";
        GenJnlLine."Line No." := LineNo;

        if RecurringCharges."Auto Charge Type" = SalonRepublicSetup."LICENSE FEE CONCESSION" then
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::"Credit Memo"
        else
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;

        GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
        GenJnlLine."Document No." := NextDocNo;
        GenJnlLine."Posting Date" := ExecutionDate;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine.VALIDATE("Account No.", RecurringCharges."Customer No.");
        Customer.GET(RecurringCharges."Customer No.");
        // if not RecurringCharges."MultiSigner Hold Deposit" then
        //     GenJnlLine.Description := RecurringCharges."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(InvAmt, 0.01, '='))
        // else
        //     GenJnlLine.Description := RecurringCharges."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(AmountShare, 0.01, '='));
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine.VALIDATE("Bal. Account No.", RecurringCharges."GL Account");
        GenJnlLine.Validate("Shortcut Dimension 1 Code", RecurringCharges."Shortcut Dimension 1 Code");
        GenJnlLine.Validate("Shortcut Dimension 2 Code", RecurringCharges."Shortcut Dimension 2 Code");
        if (RecurringCharges."Payment Method Code" <> '') AND NOT (RecurringCharges."MultiSigner Hold Deposit") then
            GenJnlLine.Validate("Payment Method Code", RecurringCharges."Payment Method Code");
        if RecurringCharges."Construction Agreement" then//SRBC-380 
            GenJnlLine.Validate("Construction Agreement", true);//SRBC-380 
        GenJnlLine."Source Code" := SourceCodeSetup."Sales Journal";
        GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
        //GenJnlLine.Validate(License, RecurringCharges.Licensee);
        if not RecurringCharges."MultiSigner Hold Deposit" then begin
            //SRBC-380 Start
            if GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" then
                GenJnlLine.VALIDATE(Amount, -RecurringCharges.Amount)
            else
                if RecurringCharges."Construction Agreement" then
                    GenJnlLine.Validate(Amount, RecurringCharges.sr_AmountShare)
                else
                    GenJnlLine.VALIDATE(Amount, InvAmt);
        end else begin
            if not RecurringCharges."Construction Agreement" then
                GenJnlLine.VALIDATE(Amount, AmountShare);
            //SRBC-380 End
        end;
        //SRBC-236 Start
        //GenJnlLine.Description := RecurringCharges."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(Abs(GenJnlLine.Amount), 0.01, '=')); //07/18/2024
        GenJnlLine.Validate(Sr_Description, RecurringCharges."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(Abs(GenJnlLine.Amount), 0.01, '='))); //07/18/2024
        //SRBC-236 End
        GenJnlLine.Validate("Charge Payment Type", RecurringCharges."Auto Charge Type"); //22 Jan
        //GenJnlLine.Validate(License, RecurringCharges.Licensee);
        GenJnlLine.Validate("Agreement ID", RecurringCharges."Agreement ID");
        GenJnlLine.Validate("AutoCharge ID", RecurringCharges."AutoCharge ID");
        FlowFrequencyInJnl(GenJnlLine, RecurringCharges);//SRBC-352 28042026

    end;

    [TryFunction]
    local procedure CreateSalesJournalPaymentLines(var GJLines: Record "Gen. Journal Line"; var MultiHolddeposit: Record "Recurring Charges")
    var
        GenJnlLine: Record "Gen. Journal Line";
        Customer: Record Customer;
        InvAmt: Decimal;
        PaymentMethod: Record "Payment Method";
    begin
        // GenJnlBatch.Get(SalonRepublicSetup."Rent Charge Template", SalonRepublicSetup."Rent Charge Batch");
        // NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", ExecutionDate, FALSE);
        GenJnlLine.INIT;
        if MultiHolddeposit."Construction Agreement" then begin
            GenJnlLine."Journal Template Name" := SalonRepublicSetup."Rent Charge Template";
            GenJnlLine."Journal Batch Name" := SalonRepublicSetup."Rent Charge Batch";
        end else begin
            GenJnlLine."Journal Template Name" := GJLines."Journal Template Name";
            GenJnlLine."Journal Batch Name" := GJLines."Journal Batch Name";
        end;

        GenJnlLine."Line No." := LineNo;

        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

        GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
        GenJnlLine."Document No." := GJLines."Document No.";
        GenJnlLine."Posting Date" := GJLines."Posting Date";
        GenJnlLine."Account Type" := GJLines."Account Type"::Customer;
        GenJnlLine.VALIDATE("Account No.", GJLines."Account No.");

        //PaymentMethod.Get('DEPSITORY');
        //if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::"Bank Account" then
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        //else
        //GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";

        GenJnlLine.VALIDATE("Bal. Account No.", 'DEPOSITORY');
        GenJnlLine.Validate("Shortcut Dimension 1 Code", GJLines."Shortcut Dimension 1 Code");
        GenJnlLine.Validate("Shortcut Dimension 2 Code", GJLines."Shortcut Dimension 2 Code");
        if InvoiceLineInserted then begin
            if RecurringCharges.sr_DocusignPaymentType <> RecurringCharges.sr_DocusignPaymentType::"ConstructionAgreement-Remote" then begin
                GenJnlLine.Validate("Applies-to Doc. Type", GJLines."Applies-to Doc. Type"::Invoice);
                GenJnlLine.Validate("Applies-to Doc. No.", GJLines."Document No.");
            end;
        end;
        GenJnlLine."Source Code" := GJLines."Source Code";
        GenJnlLine."Reason Code" := GJLines."Reason Code";

        GenJnlLine.VALIDATE(Amount, -MultiHolddeposit.Amount);
        //SRBC-529 Start
        if (RecurringCharges."Payment Method Code" <> '') then
            GenJnlLine.Validate("Payment Method Code", RecurringCharges."Payment Method Code");
        //SRBC-529 End
        GenJnlLine.Validate("Charge Payment Type", 'DOCUSIGN CREDIT/DEBIT'); //22 Jan
        GenJnlLine.Validate(License, MultiHolddeposit.Licensee);
        //GenJnlLine.Validate("Payment Method Code", GJLines."Payment Method Code");

        GenJnlLine.Validate("Agreement ID", GJLines."Agreement ID");
        GenJnlLine.Validate("AutoCharge ID", GJLines."AutoCharge ID");
        GenJnlLine.Validate("External Document No.", MultiHolddeposit.sr_chargeid); //SRBC-173 JIRA
        FlowFrequencyInJnl(GenJnlLine, MultiHolddeposit);//SRBC-352 28042026
        GenJnlLine.Insert(true);
        TempGJLine.Init();
        TempGJLine.TransferFields(GenJnlLine);
        TempGJLine.Insert();
        LineNo += 10000;
    end;

    [TryFunction]
    local procedure CreateConstructionPaymentJournal(var GenJnlLine: Record "Gen. Journal Line"; var RecurringCharges_iRec: Record "Recurring Charges")
    var
        Customer: Record Customer;
    begin
        // GenJnlBatch.Get(SalonRepublicSetup."Rent Charge Template", SalonRepublicSetup."Rent Charge Batch");
        //SRBC-202
        if NextDocNo = '' then
            NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", ExecutionDate, FALSE);
        //SRBC-202
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := SalonRepublicSetup."Rent Charge Template";
        GenJnlLine."Journal Batch Name" := SalonRepublicSetup."Rent Charge Batch";
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
        GenJnlLine."Document No." := NextDocNo;
        GenJnlLine."Posting Date" := RecurringCharges_iRec."Start Date";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine.VALIDATE("Account No.", RecurringCharges_iRec."Customer No.");
        Customer.GET(RecurringCharges_iRec."Customer No.");
        //SRBC-236 Start
        //GenJnlLine.Description := RecurringCharges_iRec."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(RecurringCharges_iRec.Amount, 0.01, '='));
        GenJnlLine.Validate(Sr_Description, RecurringCharges_iRec."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(RecurringCharges_iRec.Amount, 0.01, '=')));
        //SRBC-236 End
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine.VALIDATE("Bal. Account No.", 'DEPOSITORY');
        GenJnlLine.Validate("Shortcut Dimension 1 Code", RecurringCharges_iRec."Shortcut Dimension 1 Code");
        GenJnlLine.Validate("Shortcut Dimension 2 Code", RecurringCharges_iRec."Shortcut Dimension 2 Code");
        GenJnlLine."Source Code" := SourceCodeSetup."Sales Journal";
        GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
        GenJnlLine.VALIDATE(Amount, -RecurringCharges_iRec.Amount);
        GenJnlLine.Validate("Charge Payment Type", 'DOCUSIGN CREDIT/DEBIT'); //22 Jan
        //GenJnlLine.Validate(License, RecurringCharges.Licensee);
        GenJnlLine.Validate("Agreement ID", RecurringCharges_iRec."Agreement ID");
        GenJnlLine.Validate(License, RecurringCharges_iRec.Licensee);
        GenJnlLine.Validate("AutoCharge ID", RecurringCharges_iRec."AutoCharge ID");
        GenJnlLine.Validate("External Document No.", RecurringCharges_iRec.sr_chargeid); //SRBC-173 JIRA
        FlowFrequencyInJnl(GenJnlLine, RecurringCharges_iRec);//SRBC-352 28042026
        GenJnlLine.Insert(true);
        TempGJLine.Init();
        TempGJLine.TransferFields(GenJnlLine);
        TempGJLine.Insert();
        LineNo += 10000;
    end;

    [TryFunction]
    local procedure CreateAdditionalSecurityInvoiceJournal(var GenJnlLine: Record "Gen. Journal Line"; var RecurringCharges_iRec: Record "Recurring Charges")
    var
        Customer: Record Customer;
    begin
        // GenJnlBatch.Get(SalonRepublicSetup."Rent Charge Template", SalonRepublicSetup."Rent Charge Batch");
        // NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", ExecutionDate, FALSE);
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := SalonRepublicSetup."Rent Charge Template";
        GenJnlLine."Journal Batch Name" := SalonRepublicSetup."Rent Charge Batch";
        LineNo += 10000;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
        GenJnlLine."Document No." := NextDocNo;

        if not RecurringCharges_iRec."Additional Security Charge" then
            GenJnlLine."Posting Date" := ExecutionDate
        else
            GenJnlLine."Posting Date" := RecurringCharges_iRec."Start Date";

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine.VALIDATE("Account No.", RecurringCharges_iRec."Customer No.");
        Customer.GET(RecurringCharges_iRec."Customer No.");
        //SRBC-236 Start
        //GenJnlLine.Description := RecurringCharges_iRec."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(RecurringCharges_iRec.Amount, 0.01, '='));
        GenJnlLine.Validate(Sr_Description, RecurringCharges_iRec."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(RecurringCharges_iRec.Amount, 0.01, '=')));
        //SRBC-236
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine.VALIDATE("Bal. Account No.", RecurringCharges_iRec."GL Account");
        GenJnlLine.Validate("Shortcut Dimension 1 Code", RecurringCharges_iRec."Shortcut Dimension 1 Code");
        GenJnlLine.Validate("Shortcut Dimension 2 Code", RecurringCharges_iRec."Shortcut Dimension 2 Code");
        GenJnlLine."Source Code" := SourceCodeSetup."Sales Journal";
        GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
        GenJnlLine.VALIDATE(Amount, RecurringCharges_iRec.Amount);
        GenJnlLine.Validate("Charge Payment Type", RecurringCharges_iRec."Auto Charge Type"); //22 Jan
        //GenJnlLine.Validate(License, RecurringCharges.Licensee);
        GenJnlLine.Validate("Agreement ID", RecurringCharges_iRec."Agreement ID");
        //GenJnlLine.Validate(License, RecurringCharges_iRec.Licensee);
        GenJnlLine.Validate("AutoCharge ID", RecurringCharges_iRec."AutoCharge ID");
        FlowFrequencyInJnl(GenJnlLine, RecurringCharges_iRec);//SRBC-352 28042026
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

    local procedure CalcDates()
    var
        AgreementWeekStartDate: Date;
        AgreementWeekEndDate: Date;
        MindDate: Date;
        MaxDate: Date;
        DiffDays: Integer;
    begin
        AgreementWeekStartDate := CalcDate('-CW', RecurringCharges."Agreement Start Date");
        AgreementWeekEndDate := CalcDate('CW+1D', RecurringCharges."Agreement Start Date");
        MindDate := CalcDate('WD' + Format(WeekDayDictionary.Keys.IndexOf(RecurringCharges."Due Day".AsInteger())), AgreementWeekStartDate);
        MaxDate := CalcDate('WD' + Format(WeekDayDictionary.Keys.IndexOf(RecurringCharges."Due Day".AsInteger())), AgreementWeekEndDate);
        If MindDate < RecurringCharges."Agreement Start Date" then begin
            IF MaxDate < RecurringCharges."Agreement Start Date" then
                NextChargeDate := CalculateNextChargeDate(MaxDate)
            else
                NextChargeDate := MaxDate;
        end;
        // end else
        //     NextChargeDate := MindDate;
    end;

    local procedure CalculateNextChargeDate(CurrDate: Date): Date
    begin
        case RecurringCharges.Frequency of
            "Recurring Charge Frequency"::Daily:
                exit(CalcDate('1D', CurrDate));
            "Recurring Charge Frequency"::Weekly:
                exit(CalcDate('1W', CurrDate));
            "Recurring Charge Frequency"::Monthly:
                exit(CalcDate('1M', CurrDate));
            "Recurring Charge Frequency"::Yearly:
                exit(CalcDate('1Y', CurrDate));
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
    /// <summary>
    /// SetReportParameters.
    /// </summary>
    /// <param name="AutoTriggerRecurringCharges_iBln">Boolean.</param>
    procedure SetReportParameters(AutoTriggerRecurringCharges_iBln: Boolean; ExecutionDate_iDte: Date; AutochargeType_iCod: Code[50]; HideDialog_iBln: Boolean)
    var
        myInt: Integer;
    begin
        AutoTriggerRecurringCharges := AutoTriggerRecurringCharges_iBln;
        StartDate := ExecutionDate_iDte;
        AutochargeCode := AutochargeType_iCod;
        HideDialog := HideDialog_iBln;
    end;

    local procedure InsertTmpCustRentRateDtls()
    var
        AgreementScheduleRec: Record "Agreement Schedule";
    begin
        if RecurringCharges."Auto Charge Type" = SalonRepublicSetup."LICENSE FEE" then begin
            AgreementScheduleRec.Get(RecurringCharges."Agreement Schedule ID");
            IF TmpCustomer.Get(RecurringCharges."Customer No.") then begin
                TmpCustomer."Current Rent Rate" := AgreementScheduleRec.sr_weeklylicensefee;
                TmpCustomer.Modify();
            end else begin
                TmpCustomer.Init();
                TmpCustomer."No." := RecurringCharges."Customer No.";
                TmpCustomer."Current Rent Rate" := AgreementScheduleRec.sr_weeklylicensefee;
                TmpCustomer.Insert();
            end;
        end;

    end;

    local procedure UpdateCustomerRent()
    var
        CustomerRec: Record Customer;
        AgreementRec: Record Agreements;
    begin
        //Updating Rent on Customer
        TmpCustomer.Reset();
        IF TmpCustomer.FindSet() then
            repeat
                CustomerRec.get(TmpCustomer."No.");
                CustomerRec."Current Rent Rate" := TmpCustomer."Current Rent Rate";
                CustomerRec.Modify(true);
                AgreementRec.Get(CustomerRec."CRM Agreement ID");
                AgreementRec."Current Rent Rate" := TmpCustomer."Current Rent Rate";
                AgreementRec.Modify();
            until TmpCustomer.Next() = 0;
    end;

    local procedure CalculateMultiSignerAmount(var ReccuringCharges_iRec: Record "Recurring Charges"): Decimal
    var
        RecCharges: Record "Recurring Charges";
        Amount: Decimal;
    begin
        RecCharges.Reset();
        RecCharges.SetRange("Agreement ID", ReccuringCharges_iRec."Agreement ID");
        RecCharges.SetRange("MultiSigner Hold Deposit", true);
        if RecCharges.FindSet() then begin
            Amount := 0;
            repeat
                Amount += RecCharges.sr_AmountShare;
            until RecCharges.Next() = 0;
            exit(Amount);
        end;
    end;
    //SRBC-352 Start 28042026
    procedure FlowFrequencyInJnl(Var Rec: Record "Gen. Journal Line"; RecurringCharges: Record "Recurring Charges")
    begin
        case RecurringCharges.Frequency of
            RecurringCharges.Frequency::Once:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Once);
            RecurringCharges.Frequency::Daily:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Daily);
            RecurringCharges.Frequency::Weekly:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Weekly);
            RecurringCharges.Frequency::Monthly:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Monthly);
            RecurringCharges.Frequency::Quarterly:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Quarterly);
            RecurringCharges.Frequency::Yearly:
                Rec.Validate(Rec.Frequency, Rec.Frequency::Yearly);
        end;
    end;
    //SRBC-352 End 28042026

    var
        GenJnlBatchPostErrorHandling: Codeunit "Gen Batch Post Error Handling";
        IsHandled: Boolean;
        SICU: Codeunit "Single Instance Mgt.";//SRBC-445
}
