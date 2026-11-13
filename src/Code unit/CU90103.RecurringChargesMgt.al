/// <summary>
/// Codeunit Recurring Charges Mgt. (ID 50002).
/// </summary>
//SRBC-306 Did changes on trigger - OnAfterInsert of "Recurring Charges" for upate "Next Charge Date" & Inactive
//         - SY - 26032025 - Did changes in procedure - InsertRecurringLicenseFeeCharges 
//SRBC-297 - SY - 20032025 - In procedure CalculateRecurringChargeFrequencyDate did change for frequency-Once
//SRBC-326 - SY - 22032025 - Did changes on event - OnAfterInsertEvent of Agreement Schedule for create Recurring charges
//                         - Updated fields "Recurring Charge Created", "Recurring Charge Created Date", "Recurring Charge Created Time".
//                         - Added condition on OnAfterModifyEvent of Agreement Schedule, if Current Agreement Start/End Date will not blank and
//                         - Recurring Charge Created boolean will be false then Recurring charge should create.
//                         - Did changes on event - OnAfterInsertEvent, OnAfterModifyEvent of Agreement Schedule for skip modify event on insert time.
//SRBC-354 - NU - 20250428 - Added Logic to bugfix CRM renewal Code for start date end date on agg. schedule.
//SRBC-349 - SY - 07052025 - Did changes on event - OnAfterInsertEvent of Recurring charges
//                         - Did changes on procedure - InsertTmpRecurrngChgFromAgreementSchedule for upate recurring charge - End date
//SRBC-349 - NU - 20260627 - Commented IsBC Validation in function - AutoCreateRecurringChargeLine and commented code for auto run report for AS.
//         - SY - 04082025 - Did changes OnAfterInsertEvent, OnBeforeModifyEvent of Recurring Charges
//SRBC-380 - SY - 10072025 - Did changes in procedure - InsertTmpRecurrngChgFromPaymentSr
//SRBC-387 - SY - 28072025 - Did changes on event - OnBeforeModifyEvent, OnAfterModifyEvent, OnAfterInsertEvent of "Agreement Schedule" 
//SRBC-406 - SY - 07082025 - Did changes in procedure - InsertRecurringLicenseFeeCharges for Paidon field
//SRBC-405 - SY - 19082025 - Did changes in procedure - AgreementSchedule_OnAfterInsertEvent, InsertTmpRecurrngChgFromAgreementSchedule
//         - SY - 21082025 - Did changes on event - AgreementSchedule_OnAfterInsertEvent for update Current Agreement Start/End date
//         - SY - 12092025 - Did changes in procedure - InsertTmpRecurrngChgFromAgreementSchedule
//SRBC-413 - SY - 28082025 - Did changes on event - OnAfterInsertEvent, OnBeforeModifyEvent of Agreement Schedule
//SRBC-421 - SY - 02092025 - Added event - OnBeforeInsertEvent of Recurring Charges & Created Procedure - UpdateEpaymentAndRecurringCharge
//SRBC-405 - JSG- 13092025 - Made changes in recurring charges while creating the Recc Charges from Agg. Schedule , Seq no should <> 0.
//                - //SRBC-405 JSG 13092025 
//SRBC-443 - SY - 24102025 - Did changes in procedure - InsertTmpRecurrngChgFromAgreementSchedule
//SRBC-447 - AM - 07112025 - Did changes in procedure - InsertRecurringLicenseFeeCharges to add condition while creating recurring charges
//SRBC-471 - SY - 12012025 - Did changes in procedure - OnAfterInsert or OnAfterModify Event of Agreement Schedule 
//SRBC-478 - SY - 05022026 - Did changes in procedure - CalculateDiscountRecurringChargeDtls for create discount lines for fridays case
//SRBC-498 - SY - 24062026 - Did changes on event-OnAfterInsertEvent of "Agreement Schedule" for calcuate Highest Amount & removed code of update sequenc feild value it will udpate from CRM now
codeunit 90103 "Recurring Charges Mgt."
{
    var
        SICU_Codeunit: Codeunit "Single Instance Mgt.";//SRBC-326 - 29032025
        TmpRecurringChargesRec: Record "Recurring Charges" temporary;
        TmpRecurringChargesRec1: Record "Recurring Charges" temporary;
        RecurrinChargesRec: Record "Recurring Charges";
        MarkRecurrinChargesRec: Record "Recurring Charges";
        MarkLASecurityCharges: Record "Recurring Charges";
        SRSetup: Record "Salon Republic Setup";
        CustomerRec: Record Customer;
        DateForWeek: Record Date;
        WeekDayDictionary: Dictionary of [Integer, Enum "Week Selection"];
        DayEnum: Enum "Week Selection";
        DefaultWeekSelectionEnum: Enum "Week Selection";
        ChargeStartDate: Date;
        ChargeEndDate: Date;
        AgreementStartDate: Date;
        AgreementEndDate: Date;
        EntryNo: Integer;
        Deposit: Decimal;
        IsMidWeekAgreement: Boolean;
        IsMidWeekThirdLine: Boolean;
        CheckChargesforLine3: Boolean;
        IsMidWeekDiscThirdLine: Boolean;
        CheckDiscforLine3: Boolean;
        NoOfDiscDays: Integer;
        IsInsertSecondLine: Boolean;
        IsInsertThirdLine: Boolean;

    // Start -->PS_16102026 not required for ACH payments
    // [EventSubscriber(ObjectType::Table, Database::"Payments SR BC", 'OnAfterInsertEvent', '', true, true)]
    // local procedure "Payments SR BC_OnAfterInsertEvent"(var Rec: Record "Payments SR BC"; RunTrigger: Boolean)
    // var
    //     Variant: Variant;
    // begin
    //     Variant := Rec;
    //     if Rec."Recurring Entry No." = 0 then
    //         InsertRecurringLicenseFeeCharges(Variant);
    //     UpdateBCLocationSalonCode(Rec); //Salon Code Update from Dimension Values
    // end;
    // <-- End

    //Start -->PS_16102026 not required for ACH payments
    // //Salon Code Update from Dimension Values
    // [EventSubscriber(ObjectType::Table, Database::"Payments SR BC", 'OnBeforeModifyEvent', '', true, true)]
    // local procedure "Payments SR BC_OnBeforeModifyEvent"(var Rec: Record "Payments SR BC"; RunTrigger: Boolean)
    // begin
    //     UpdateBCLocationSalonCode(Rec);
    // end;
    // <-- End 

    //SRBC-413 JSG 19092025 Start
    // [EventSubscriber(ObjectType::Table, Database::"Agreement Schedule", 'OnBeforeInsertEvent', '', true, true)]
    // local procedure "AgreementSchedule_OnBeforeInsertEvent"(var Rec: Record "Agreement Schedule"; RunTrigger: Boolean)
    // var
    //     AS_lRec: Record "Agreement Schedule";
    //     SequenceNo: Integer;
    //     MODAgreementSchedule: Record "Agreement Schedule";
    //     HighestAmount: Decimal;
    // begin
    //     if Rec.sr_IsLastRow then begin
    //         AS_lRec.Reset();
    //         AS_lRec.SetRange(sr_agreementid, Rec.sr_agreementid);
    //         AS_lRec.SetRange(sr_IsLastRow, true);
    //         AS_lRec.SetCurrentKey(sr_feeduedate);
    //         AS_lRec.SetFilter(Sequence, '<>%1', 0);
    //         IF AS_lRec.FindLast() then
    //             SequenceNo := AS_lRec.Sequence + 1
    //         else
    //             SequenceNo := 1;

    //         AS_lRec.Reset();
    //         AS_lRec.SetCurrentKey(sr_weeklylicensefee);
    //         AS_lRec.SetRange(sr_agreementid, Rec.sr_agreementid);
    //         AS_lRec.SetRange(Sequence, 0);
    //         IF AS_lRec.FindLast() then begin
    //             //HighestAmount := AS_lRec.sr_weeklylicensefee;//SRBC-413 JSG 21092025
    //             HighestAmount := Rec.sr_weeklylicensefee;//SRBC-413 JSG 21092025
    //         end;

    //         MODAgreementSchedule.Reset();
    //         MODAgreementSchedule.SetRange(sr_agreementid, Rec.sr_agreementid);
    //         MODAgreementSchedule.SetRange(Sequence, 0);
    //         if MODAgreementSchedule.FindSet() then begin
    //             repeat
    //                 MODAgreementSchedule.Validate("Highest Amount", HighestAmount);
    //                 MODAgreementSchedule.Validate(Sequence, SequenceNo);
    //                 MODAgreementSchedule.Modify();
    //             until MODAgreementSchedule.Next() = 0;
    //         end;
    //     end;
    // end;
    //SRBC-413 JSG 19092025 End
    [EventSubscriber(ObjectType::Table, Database::"Agreement Schedule", 'OnAfterInsertEvent', '', true, true)]
    local procedure "AgreementSchedule_OnAfterInsertEvent"(var Rec: Record "Agreement Schedule"; RunTrigger: Boolean)
    var
        Variant: Variant;
        Agreement_lRec: Record Agreements;
        AS_lRec: Record "Agreement Schedule";
        SequenceNo: Integer;
        MODAgreementSchedule: Record "Agreement Schedule";
        MODRecurringCharges: Record "Recurring Charges";
        HighestAmount: Decimal;
        WeeksInDecimal: Decimal;
        EpaymentScheduleMgnt: Codeunit "Epayment Management";
        AgreementSchedule: Record "Agreement Schedule";//SRBC-405
        NoOfAgreementSchedule: Integer;//SRBC-405
        CalcCurrAgreementStartDate: Date;//SRBC-413
    begin
        NoOfAgreementSchedule := 0;//SRBC-405
        //SRBC-326 - 29032025 Start
        SICU_Codeunit.OnAfterInsertOfAgreementSchedule(true);
        //SRBC-326 - 29032025 End
        //SRBC-175  - Convert current agreement Start/End date flow field to normal field & flow from Agreements.
        //SRBC-387 Start
        if (Rec.new_abatementfee <> 0) AND (Rec.sr_weeklylicensefee <> 0) then begin
            Rec."No. of Weeks for Disc" := Round((Rec.new_abatementfee / Rec.sr_weeklylicensefee), 1, '>');
            //NU-NS 20 Aug Fix for Disc Days less than 7
            WeeksInDecimal := Round((Rec.new_abatementfee / Rec.sr_weeklylicensefee), 0.001, '=');
            Rec."No. of Days for Disc" := ROUND(WeeksInDecimal * 7, 1, '=');
        end;
        Agreement_lRec.Reset();
        if Agreement_lRec.Get(Rec.sr_agreementid) then begin
            //SRBC-405 Start
            //SRBC-413 Start
            Rec.Validate("Agreement Status", Agreement_lRec."Agreement Status");
            Rec.Validate("Agreement Status Reason", Agreement_lRec."Agreement Status Reason");
            Rec.Validate(Inactive, Agreement_lRec.Inactive);
            AgreementSchedule.Reset();
            AgreementSchedule.SetCurrentKey(sr_feeduedate);
            AgreementSchedule.SetRange(sr_agreementid, Rec.sr_agreementid);
            AgreementSchedule.SetRange(Sequence, Rec.Sequence);
            if AgreementSchedule.FindFirst() then begin
                if (Rec."Current Agrement Start Date" = 0D) or (Rec."Current Agrement End Date" = 0D) then begin
                    if (Agreement_lRec."Current Agreement Start Date" >= Rec.sr_feeduedate) and (Agreement_lRec."Current Agreement End Date" >= Rec.sr_feeduedate) then begin
                        if Agreement_lRec."Current Agreement End Date" > Agreement_lRec."Current Agreement Start Date" then begin
                            Rec.Validate("Current Agrement Start Date", Agreement_lRec."Current Agreement Start Date");
                            Rec.Validate("Current Agrement End Date", Agreement_lRec."Current Agreement End Date");
                        end;
                    end else begin
                        if (Rec."No. of Days for Disc" <> 0) and (Rec.new_abatementfee <> 0) then begin
                            Clear(CalcCurrAgreementStartDate);
                            CalcCurrAgreementStartDate := (Rec.sr_feeduedate - Rec."No. of Days for Disc") + 1;
                            if (CalcCurrAgreementStartDate = Agreement_lRec."Current Agreement Start Date") and
                             (Agreement_lRec."Current Agreement End Date" > Agreement_lRec."Current Agreement Start Date") then begin
                                Rec.Validate("Current Agrement Start Date", Agreement_lRec."Current Agreement Start Date");
                                Rec.Validate("Current Agrement End Date", Agreement_lRec."Current Agreement End Date");
                            end;
                        end else begin
                            if (Rec."No. of Days for Disc" = 0) and (Rec.new_abatementfee = 0) then begin
                                Clear(CalcCurrAgreementStartDate);
                                CalcCurrAgreementStartDate := (rec.sr_feeduedate - ((rec.sr_from - 1) * 7)) + 1;
                                if (Agreement_lRec."Current Agreement Start Date" = CalcCurrAgreementStartDate) and (Agreement_lRec."Current Agreement End Date" >= Rec.sr_feeduedate) then
                                    if Agreement_lRec."Current Agreement End Date" > Agreement_lRec."Current Agreement Start Date" then begin
                                        Rec.Validate("Current Agrement Start Date", Agreement_lRec."Current Agreement Start Date");
                                        Rec.Validate("Current Agrement End Date", Agreement_lRec."Current Agreement End Date");
                                    end;
                            end;
                        end;
                    end;
                    if (Rec.new_abatementfee <> 0) AND (Rec.sr_weeklylicensefee <> 0) then begin
                        if Rec."Current Agrement Start Date" <> 0D then begin
                            Rec."Discount Start Date" := Rec."Current Agrement Start Date" - 1;
                            Rec."Discount End Date" := Rec."Discount Start Date" + Rec."No. of Days for Disc" - 1;
                        end;
                    end;
                end;
            end;//SRBC-413 End
            //SRBC-405 End
        end;
        //SRBC-175
        WeeksInDecimal := 0;
        HighestAmount := 0;
        SRSetup.Get();
        Rec."No. of Weeks" := (Rec.sr_to - Rec.sr_from) + 1;
        If not Rec.sr_IsLastRow then begin
            //SRBC-413 Start
            if (Rec.new_abatementfee <> 0) AND (Rec.sr_weeklylicensefee <> 0) then begin
                if Rec."Current Agrement Start Date" <> 0D then//SRBC-413
                    Rec."Staggered End Due Date" := CalcDate(Format(rec."No. of Weeks") + 'W', Rec."Current Agrement Start Date" - 1)//SRBC-413
            end else
                Rec."Staggered End Due Date" := CalcDate(Format(rec."No. of Weeks") + 'W', Rec.sr_feeduedate);
        end else begin
            if Rec."Current Agrement End Date" <> 0D then//SRBC-413
                Rec."Staggered End Due Date" := Rec."Current Agrement End Date";
        end;
        //SRBC-413 End
        Rec.Modify();
        //SRBC-306 Start

        Variant := Rec;
        //SRBC-326 Start
        if Rec."Recurring Entry No." = 0 then begin
            if (Rec."Current Agrement Start Date" <> 0D) and (Rec."Current Agrement End Date" <> 0D) then begin
                //Anjaneya reddy-Updated with below logic to handle Agreement schedule feedue date-24/04/25
                //SRBC-354
                if (Rec.sr_feeduedate < Rec."Current Agrement Start Date") and
                   (Rec.sr_feeduedate < Rec."Current Agrement End Date") then begin
                    if Rec.sr_weeklylicensefee <> 0 then begin
                        InsertRecurringLicenseFeeCharges(Variant);
                        Rec.Validate("Recurring Charge Created", true);
                        Rec.Validate("Recurring Charge Created Date", Today);
                        Rec.Validate("Recurring Charge Created Time", Time);
                    end;
                end;
                //SRBC-354
            end;
        end;
        //SRBC-326 End

        //SRBC-306 End

        //SRBC-498 Start
        // if Rec.sr_IsLastRow then begin
        //     //Renew Agreement
        //     AS_lRec.Reset();
        //     AS_lRec.SetRange(sr_agreementid, Rec.sr_agreementid);
        //     AS_lRec.SetRange(sr_IsLastRow, true);
        //     AS_lRec.SetCurrentKey(sr_feeduedate); //SRBC-413 JSG 09092025
        //     AS_lRec.SetFilter(Sequence, '<>%1', 0);
        //     IF AS_lRec.FindLast() then
        //         SequenceNo := AS_lRec.Sequence + 1
        //     else
        //         SequenceNo := 1;

        //     AS_lRec.Reset();
        //     AS_lRec.SetCurrentKey(sr_weeklylicensefee);
        //     AS_lRec.SetRange(sr_agreementid, Rec.sr_agreementid);
        //     //AS_lRec.SetRange(sr_IsLastRow, true);
        //     AS_lRec.SetRange(Sequence, 0);
        //     IF AS_lRec.FindLast() then begin
        //         //repeat
        //         HighestAmount := AS_lRec.sr_weeklylicensefee;
        //         //until AS_lRec.Next() = 0;
        //     end;

        //     MODAgreementSchedule.Reset();
        //     //MODAgreementSchedule.SetCurrentKey()
        //     MODAgreementSchedule.SetRange(sr_agreementid, Rec.sr_agreementid);
        //     MODAgreementSchedule.SetRange(Sequence, 0);
        //     if MODAgreementSchedule.FindSet() then begin
        //         repeat
        //             MODAgreementSchedule.Validate("Highest Amount", HighestAmount);
        //             MODAgreementSchedule.Validate(Sequence, SequenceNo);
        //             MODAgreementSchedule.Modify();

        //             MODRecurringCharges.Reset();
        //             MODRecurringCharges.SetRange("Agreement Schedule ID", MODAgreementSchedule.sr_agreementscheduleId);
        //             MODRecurringCharges.SetRange("Auto Charge Type", SRSetup."LICENSE FEE");
        //             MODRecurringCharges.SetRange(Sequence, 0);
        //             if MODRecurringCharges.FindSet() then begin
        //                 repeat
        //                     MODRecurringCharges.Validate(Sequence, SequenceNo);
        //                     MODRecurringCharges.Modify();
        //                 until MODRecurringCharges.Next() = 0;
        //             end;
        //             //SRBC-471 Start JSG 12012026
        //             if (not MODAgreementSchedule."Epayment Schedule Created") and (MODAgreementSchedule."Epayment Schedule Created Date" = 0D) and (MODAgreementSchedule."Epayment Schedule Created Time" = 0T) then
        //                 if (MODAgreementSchedule."CRM Renewal") or (MODAgreementSchedule.sr_renewalLADocuSign) then
        //                     if (MODAgreementSchedule."Highest Amount" <> 0) and (MODAgreementSchedule.Sequence <> 0) then
        //                         if (MODAgreementSchedule."Current Agrement Start Date" <> 0D) and (MODAgreementSchedule."Current Agrement End Date" <> 0D) then
        //                             EpaymentScheduleMgnt.InsertEpaymentScheduleFromCRMRenewal(MODAgreementSchedule, MODRecurringCharges);
        //         //SRBC-471 End JSG 12012026
        //         until MODAgreementSchedule.Next() = 0;
        //     end;
        // end;
        AS_lRec.Reset();
        AS_lRec.SetCurrentKey(sr_weeklylicensefee);
        AS_lRec.SetRange(sr_agreementid, Rec.sr_agreementid);
        AS_lRec.SetRange(Sequence, Rec.Sequence);
        IF AS_lRec.FindLast() and AS_lRec.sr_IsLastRow then begin
            HighestAmount := AS_lRec.sr_weeklylicensefee;
            MODAgreementSchedule.Reset();
            MODAgreementSchedule.SetRange(sr_agreementid, Rec.sr_agreementid);
            MODAgreementSchedule.SetRange(Sequence, Rec.Sequence);
            if MODAgreementSchedule.FindSet() then begin
                repeat
                    MODAgreementSchedule.Validate("Highest Amount", HighestAmount);
                    MODAgreementSchedule.Modify();
                    MODRecurringCharges.Reset();
                    MODRecurringCharges.SetRange("Agreement Schedule ID", MODAgreementSchedule.sr_agreementscheduleId);
                    MODRecurringCharges.SetRange("Auto Charge Type", SRSetup."LICENSE FEE");
                    MODRecurringCharges.SetRange(Sequence, Rec.Sequence);
                    if MODRecurringCharges.FindSet() then begin
                        repeat
                            MODRecurringCharges.Validate(Sequence, Rec.Sequence);
                            MODRecurringCharges.Modify();
                        until MODRecurringCharges.Next() = 0;
                    end;
                    if (not MODAgreementSchedule."Epayment Schedule Created") and (MODAgreementSchedule."Epayment Schedule Created Date" = 0D) and (MODAgreementSchedule."Epayment Schedule Created Time" = 0T) then
                        if (MODAgreementSchedule."CRM Renewal") or (MODAgreementSchedule.sr_renewalLADocuSign) then
                            if (MODAgreementSchedule."Highest Amount" <> 0) and (MODAgreementSchedule.Sequence <> 0) then
                                if (MODAgreementSchedule."Current Agrement Start Date" <> 0D) and (MODAgreementSchedule."Current Agrement End Date" <> 0D) then
                                    EpaymentScheduleMgnt.InsertEpaymentScheduleFromCRMRenewal(MODAgreementSchedule, MODRecurringCharges);
                until MODAgreementSchedule.Next() = 0;
            end;
        end;
        //SRBC-498 End
        //SRBC-175  Insert Epayment schedule for Renewal.
        //Renew Agreement
        // if MODAgreementSchedule."CRM Renewal" then//SRBC-405 20082025
        //SRBC-471 Start JSG 12012026
        // if (MODAgreementSchedule."CRM Renewal") or (MODAgreementSchedule.sr_renewalLADocuSign) then//SRBC-405 20082025
        //     //EpaymentScheduleMgnt.InsertEpaymentScheduleFromCRMRenewal(Variant, MODRecurringCharges);
        //     EpaymentScheduleMgnt.InsertEpaymentScheduleFromCRMRenewal(MODAgreementSchedule, MODRecurringCharges);
        //SRBC-471 End JSG 12012026
        //SRBC-326 - 29032025 Start 
        SICU_Codeunit.OnAfterInsertOfAgreementSchedule(false);
        //SRBC-326 - 29032025 End
    end;

    //SRBC-387 Start
    [EventSubscriber(ObjectType::Table, Database::"Agreement Schedule", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModifyEvent_AgreementSchedule(var Rec: Record "Agreement Schedule"; RunTrigger: Boolean)
    var
        Agreement_lRec: Record Agreements;
    begin
        Agreement_lRec.Reset();
        if Agreement_lRec.Get(Rec.sr_agreementid) then begin
            Rec.Validate("Agreement Status", Agreement_lRec."Agreement Status");
            Rec.Validate("Agreement Status Reason", Agreement_lRec."Agreement Status Reason");
            Rec.Validate(Inactive, Agreement_lRec.Inactive);
        end;
        //SRBC-413 Start
        Rec."No. of Weeks" := (Rec.sr_to - Rec.sr_from) + 1;
        If not Rec.sr_IsLastRow then begin
            if (Rec.new_abatementfee <> 0) AND (Rec.sr_weeklylicensefee <> 0) then begin
                if Rec."Current Agrement Start Date" <> 0D then//SRBC-413
                    Rec."Staggered End Due Date" := CalcDate(Format(rec."No. of Weeks") + 'W', Rec."Current Agrement Start Date" - 1)//SRBC-413
            end else
                Rec."Staggered End Due Date" := CalcDate(Format(rec."No. of Weeks") + 'W', Rec.sr_feeduedate);
        end else begin
            if Rec."Current Agrement End Date" <> 0D then//SRBC-413
                Rec."Staggered End Due Date" := Rec."Current Agrement End Date";
        end;
        //SRBC-413 End
    end;
    //SRBC-387 End

    [EventSubscriber(ObjectType::Table, Database::"Agreement Schedule", 'OnAfterModifyEvent', '', true, true)]
    local procedure "AgreementSchedule_OnAftermodifyEvent"(var Rec: Record "Agreement Schedule"; RunTrigger: Boolean)
    var
        Variant: Variant;
        MODAgreementSchedule: Record "Agreement Schedule";
    begin
        //SRBC-326 - 29032025 Start
        if not SICU_Codeunit.CheckIsInsertOfAgreementSchedule() then begin
            if not Rec."Recurring Charge Created" then begin//SRBC-387
                if (Rec."Current Agrement Start Date" <> 0D) and (Rec."Current Agrement End Date" <> 0D) then begin
                    if Rec.sr_weeklylicensefee <> 0 then begin
                        // if not Rec."Recurring Charge Created" then begin//SRBC-387
                        Variant := Rec;
                        if Rec."Recurring Entry No." = 0 then
                            if Rec."Recurring Charge Created Date" = 0D then begin
                                InsertRecurringLicenseFeeCharges(Variant);
                            end;
                        // end;//SRBC-387 
                    end;
                end;
            end;//SRBC-387
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"CDS sr_autocharge", 'OnAfterInsertEvent', '', true, true)]
    local procedure CdsAutoChargeOnAfterInsertEvent(var Rec: Record "CDS sr_autocharge"; RunTrigger: Boolean)
    begin
        ModifyAutoChargeIDRecurringPaymentEntries(Rec);
    end;

    //SRBC-349 Start 04082025
    [EventSubscriber(ObjectType::Table, Database::"Recurring Charges", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModify_RecurringCharge(var Rec: Record "Recurring Charges"; RunTrigger: Boolean)
    var
        Customer: Record Customer;
        CRMIntegrationMgmt: Codeunit "CRM Integration Management";//SY-06022026
        AutoCharge: Record "CDS sr_autocharge";//SY-06022026
    begin
        Customer.Reset();
        Customer.SetRange("CRM Agreement ID", Rec."Agreement ID");
        if Customer.FindFirst() then begin
            Rec.Validate("Customer No.", Customer."No.");
            Rec.Validate("Customer Name", Customer.Name);
        end;
        // //SY-06022026 Start
        // // Apply filter based on ISBC
        // if CRMIntegrationMgmt.IsCDSIntegrationEnabled() then begin
        //     AutoCharge.Reset();
        //     if Rec.ISBC then
        //         AutoCharge.SetRange(new_SrBCEntryNo, Rec."Entry No.")
        //     else
        //         AutoCharge.SetRange(sr_autochargeId, Rec."AutoCharge ID");
        //     // Check if record exists
        //     if AutoCharge.FindFirst() then begin
        //         if AutoCharge.ModifiedOn > Rec.SystemModifiedAt then begin
        //             if AutoCharge.sr_chargestartdate = 0D then
        //                 Rec.Validate("Start Date", AutoCharge.sr_chargestartdate);
        //             if AutoCharge.sr_chargeenddate = 0D then
        //                 Rec.Validate("End Date", AutoCharge.sr_chargeenddate);
        //             if AutoCharge.sr_lastposteddate = 0D then
        //                 Rec.Validate("Last Charged Date", AutoCharge.sr_lastposteddate);
        //             if AutoCharge.new_NextChargeDate = 0D then
        //                 Rec.Validate("Next Charge Date", AutoCharge.new_NextChargeDate);
        //         end;
        //     end;
        // end;
        // //SY-06022026 End
    end;

    //SRBC-421 Start
    procedure UpdateEpaymentAndRecurringCharge(Variant: Variant)
    var
        EpaymentSchedule: Record "E Payment Schedule";
        RecurringCharge: Record "Recurring Charges";
        RecRef: RecordRef;
        Month: Integer;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Recurring Charges":
                begin
                    RecurringCharge := Variant;
                    RecurringCharge.Reset();
                    RecurringCharge.SetFilter("End Date", '>%1', Today);
                    RecurringCharge.SetFilter(Inactive, '%1', false);
                    RecurringCharge.SetFilter(IsBC, '%1', true);
                    if RecurringCharge.FindSet() then
                        repeat
                            Month := 0;
                            if RecurringCharge.Frequency = RecurringCharge.Frequency::Weekly then begin
                                if RecurringCharge."Due Day" = RecurringCharge."Due Day"::" " then
                                    RecurringCharge.Validate("Week Day", RecurringCharge."Week Day"::" ");
                                if RecurringCharge."Due Day" = RecurringCharge."Due Day"::Monday then
                                    RecurringCharge.Validate("Week Day", RecurringCharge."Week Day"::Monday);
                                if RecurringCharge."Due Day" = RecurringCharge."Due Day"::Tuesday then
                                    RecurringCharge.Validate("Week Day", RecurringCharge."Week Day"::Tuesday);
                                if RecurringCharge."Due Day" = RecurringCharge."Due Day"::Wednesday then
                                    RecurringCharge.Validate("Week Day", RecurringCharge."Week Day"::Wednesday);
                                if RecurringCharge."Due Day" = RecurringCharge."Due Day"::Thursday then
                                    RecurringCharge.Validate("Week Day", RecurringCharge."Week Day"::Thursday);
                                if RecurringCharge."Due Day" = RecurringCharge."Due Day"::Friday then
                                    RecurringCharge.Validate("Week Day", RecurringCharge."Week Day"::Friday);
                                if RecurringCharge."Due Day" = RecurringCharge."Due Day"::Saturday then
                                    RecurringCharge.Validate("Week Day", RecurringCharge."Week Day"::Saturday);
                                if RecurringCharge."Due Day" = RecurringCharge."Due Day"::Sunday then
                                    RecurringCharge.Validate("Week Day", RecurringCharge."Week Day"::Sunday);
                            end else
                                if RecurringCharge.Frequency = RecurringCharge.Frequency::Monthly then
                                    RecurringCharge.Validate("Month Day", Date2DMY(RecurringCharge."Start Date", 1))
                                else begin
                                    if (RecurringCharge.Frequency = RecurringCharge.Frequency::Quarterly) or (RecurringCharge.Frequency = RecurringCharge.Frequency::Yearly) then begin
                                        RecurringCharge.Validate("Month Day", Date2DMY(RecurringCharge."Start Date", 1));
                                        Month := Date2DMY(RecurringCharge."Start Date", 2);
                                        if Month = 1 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::January);
                                        if Month = 2 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::February);
                                        if Month = 3 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::March);
                                        if Month = 4 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::April);
                                        if Month = 5 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::May);
                                        if Month = 6 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::June);
                                        if Month = 7 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::July);
                                        if Month = 8 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::August);
                                        if Month = 9 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::September);
                                        if Month = 10 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::October);
                                        if Month = 11 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::November);
                                        if Month = 12 then
                                            RecurringCharge.Validate("Month Name", RecurringCharge."Month Name"::December);
                                    end;
                                end;
                        until RecurringCharge.Next() = 0;
                end;
            Database::"E Payment Schedule":
                begin
                    EpaymentSchedule := Variant;
                    EpaymentSchedule.Reset();
                    EpaymentSchedule.SetFilter("End Date", '>%1', Today);
                    EpaymentSchedule.SetFilter(Inactive, '%1', true);
                    EpaymentSchedule.SetFilter(sr_IsBC, '%1', true);
                    if EpaymentSchedule.FindSet() then
                        repeat
                            Month := 0;
                            if EpaymentSchedule.Frequency = EpaymentSchedule.Frequency::Weekly then begin
                                if EpaymentSchedule."Due Day" = EpaymentSchedule."Due Day"::" " then
                                    EpaymentSchedule.Validate("Week Day", EpaymentSchedule."Week Day"::" ");
                                if EpaymentSchedule."Due Day" = EpaymentSchedule."Due Day"::Monday then
                                    EpaymentSchedule.Validate("Week Day", EpaymentSchedule."Week Day"::Monday);
                                if EpaymentSchedule."Due Day" = EpaymentSchedule."Due Day"::Tuesday then
                                    EpaymentSchedule.Validate("Week Day", EpaymentSchedule."Week Day"::Tuesday);
                                if EpaymentSchedule."Due Day" = EpaymentSchedule."Due Day"::Wednesday then
                                    EpaymentSchedule.Validate("Week Day", EpaymentSchedule."Week Day"::Wednesday);
                                if EpaymentSchedule."Due Day" = EpaymentSchedule."Due Day"::Thursday then
                                    EpaymentSchedule.Validate("Week Day", EpaymentSchedule."Week Day"::Thursday);
                                if EpaymentSchedule."Due Day" = EpaymentSchedule."Due Day"::Friday then
                                    EpaymentSchedule.Validate("Week Day", EpaymentSchedule."Week Day"::Friday);
                                if EpaymentSchedule."Due Day" = EpaymentSchedule."Due Day"::Saturday then
                                    EpaymentSchedule.Validate("Week Day", EpaymentSchedule."Week Day"::Saturday);
                                if EpaymentSchedule."Due Day" = EpaymentSchedule."Due Day"::Sunday then
                                    EpaymentSchedule.Validate("Week Day", EpaymentSchedule."Week Day"::Sunday);
                            end else
                                if EpaymentSchedule.Frequency = EpaymentSchedule.Frequency::Monthly then
                                    EpaymentSchedule.Validate("Month Day", Date2DMY(EpaymentSchedule."Start Date", 1))
                                else begin
                                    if (EpaymentSchedule.Frequency = EpaymentSchedule.Frequency::Quarterly) or (EpaymentSchedule.Frequency = EpaymentSchedule.Frequency::Yearly) then begin
                                        EpaymentSchedule.Validate("Month Day", Date2DMY(EpaymentSchedule."Start Date", 1));
                                        Month := Date2DMY(EpaymentSchedule."Start Date", 2);
                                        if Month = 1 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::January);
                                        if Month = 2 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::February);
                                        if Month = 3 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::March);
                                        if Month = 4 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::April);
                                        if Month = 5 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::May);
                                        if Month = 6 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::June);
                                        if Month = 7 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::July);
                                        if Month = 8 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::August);
                                        if Month = 9 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::September);
                                        if Month = 10 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::October);
                                        if Month = 11 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::November);
                                        if Month = 12 then
                                            EpaymentSchedule.Validate("Month Name", EpaymentSchedule."Month Name"::December);
                                    end;
                                end;
                        until EpaymentSchedule.Next() = 0;
                end;
        end;
    end;
    //SRBC-421 End

    //SRBC-349 Start 04082025
    [EventSubscriber(ObjectType::Table, Database::"Recurring Charges", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterRecurringCharge(var Rec: Record "Recurring Charges"; RunTrigger: Boolean)
    var
        NextChargeDate: Date;
        Customer: Record Customer;//SRBC-349
        AutoCharge: Record "Auto Charge";//SRBC-349
        Month: Integer;//SRBC-421
    begin
        //SRBC-349 Start
        // if Rec.sr_IsCRM then begin //SRBC-349 - 04082025
        Customer.Reset();
        Customer.SetRange("CRM Agreement ID", Rec."Agreement ID");
        if Customer.FindFirst() then begin//SRBC-349 - 04082025
            Rec.Validate("Customer No.", Customer."No.");
            Rec.Validate("Customer Name", Customer.Name);//SRBC-349 - 04082025
        end;//SRBC-349 - 04082025
        if Rec."Auto Charge Type" = '' then begin
            AutoCharge.Reset();
            AutoCharge.SetRange(sr_autochargetypeId, Rec.sr_autochargetypecode);
            if AutoCharge.FindFirst() then
                Rec."Auto Charge Type" := AutoCharge.Code;
        end;
        // end; //SRBC-349 - 04082025
        if (Rec."Source Table ID" <> 0) and (not IsNullGuid(Rec."Source Table RecordID")) then
            rec.Validate(IsBC, true);
        //SRBC-349 End
        //SRBC-306 Start
        if (Rec."Start Date" < Today) then begin
            if Rec."End Date" = 0D then
                Rec.Validate("Next Charge Date", CalculateRecurringChargeFrequencyDate(Rec))
            else begin
                NextChargeDate := CalculateRecurringChargeFrequencyDate(Rec);
                if NextChargeDate < Rec."End Date" then
                    Rec.Validate("Next Charge Date", NextChargeDate)
                else begin
                    Rec.Validate("Next Charge Date", 0D);
                    Rec.Validate(Inactive, true);
                end;
            end;
        end;
        //SRBC-421 Start
        Month := 0;
        if Rec.IsBC then begin
            if Rec.Frequency = Rec.Frequency::Weekly then begin
                if Rec."Due Day" = Rec."Due Day"::" " then
                    Rec.Validate("Week Day", Rec."Week Day"::" ");
                if Rec."Due Day" = Rec."Due Day"::Monday then
                    Rec.Validate("Week Day", Rec."Week Day"::Monday);
                if Rec."Due Day" = Rec."Due Day"::Tuesday then
                    Rec.Validate("Week Day", Rec."Week Day"::Tuesday);
                if Rec."Due Day" = Rec."Due Day"::Wednesday then
                    Rec.Validate("Week Day", Rec."Week Day"::Wednesday);
                if Rec."Due Day" = Rec."Due Day"::Thursday then
                    Rec.Validate("Week Day", Rec."Week Day"::Thursday);
                if Rec."Due Day" = Rec."Due Day"::Friday then
                    Rec.Validate("Week Day", Rec."Week Day"::Friday);
                if Rec."Due Day" = Rec."Due Day"::Saturday then
                    Rec.Validate("Week Day", Rec."Week Day"::Saturday);
                if Rec."Due Day" = Rec."Due Day"::Sunday then
                    Rec.Validate("Week Day", Rec."Week Day"::Sunday);
            end else
                if Rec.Frequency = Rec.Frequency::Monthly then
                    Rec.Validate("Month Day", Date2DMY(Rec."Start Date", 1))
                else begin
                    if (Rec.Frequency = Rec.Frequency::Quarterly) or (Rec.Frequency = Rec.Frequency::Yearly) then begin
                        Rec.Validate("Month Day", Date2DMY(Rec."Start Date", 1));
                        Month := Date2DMY(Rec."Start Date", 2);
                        if Month = 1 then
                            Rec.Validate("Month Name", Rec."Month Name"::January);
                        if Month = 2 then
                            Rec.Validate("Month Name", Rec."Month Name"::February);
                        if Month = 3 then
                            Rec.Validate("Month Name", Rec."Month Name"::March);
                        if Month = 4 then
                            Rec.Validate("Month Name", Rec."Month Name"::April);
                        if Month = 5 then
                            Rec.Validate("Month Name", Rec."Month Name"::May);
                        if Month = 6 then
                            Rec.Validate("Month Name", Rec."Month Name"::June);
                        if Month = 7 then
                            Rec.Validate("Month Name", Rec."Month Name"::July);
                        if Month = 8 then
                            Rec.Validate("Month Name", Rec."Month Name"::August);
                        if Month = 9 then
                            Rec.Validate("Month Name", Rec."Month Name"::September);
                        if Month = 10 then
                            Rec.Validate("Month Name", Rec."Month Name"::October);
                        if Month = 11 then
                            Rec.Validate("Month Name", Rec."Month Name"::November);
                        if Month = 12 then
                            Rec.Validate("Month Name", Rec."Month Name"::December);
                    end;
                end;
        end;
        //SRBC-421 End
        Rec.Modify();
        //SRBC-306 End
    end;
    //SRBC-306 Start
    procedure CalculateRecurringChargeFrequencyDate(RecurringCharge: Record "Recurring Charges") NextPaymentDate: Date
    var
    begin
        NextPaymentDate := 0D;
        repeat
            Case RecurringCharge.Frequency of
                //SRBC-297 Start
                RecurringCharge.Frequency::Once://SRBC-306 20032025
                    begin
                        NextPaymentDate := 0D;
                        exit;
                    end;
                //SRBC-297 End
                RecurringCharge.Frequency::Weekly:
                    if NextPaymentDate = 0D then
                        NextPaymentDate := CalcDate('1W', RecurringCharge."Start Date")
                    else
                        NextPaymentDate := CalcDate('1W', NextPaymentDate);
                RecurringCharge.Frequency::Monthly:
                    if NextPaymentDate = 0D then
                        NextPaymentDate := CalcDate('1M', RecurringCharge."Start Date")
                    else
                        NextPaymentDate := CalcDate('1M', NextPaymentDate);
                RecurringCharge.Frequency::Yearly:
                    if NextPaymentDate = 0D then
                        NextPaymentDate := CalcDate('1Y', RecurringCharge."Start Date")
                    else
                        NextPaymentDate := CalcDate('1Y', NextPaymentDate);
                RecurringCharge.Frequency::Quarterly:
                    if NextPaymentDate = 0D then
                        NextPaymentDate := CalcDate('1Q', RecurringCharge."Start Date")
                    else
                        NextPaymentDate := CalcDate('1Q', NextPaymentDate);
                RecurringCharge.Frequency::Daily:
                    if NextPaymentDate = 0D then
                        NextPaymentDate := CalcDate('1D', RecurringCharge."Start Date")
                    else
                        NextPaymentDate := CalcDate('1D', NextPaymentDate);
            End;
        until NextPaymentDate > Today();

    end;
    //SRBC-306 End

    procedure InsertRecurringLicenseFeeCharges(var Variant: Variant)
    var
        RecRef: RecordRef;
        PaymentSrBC: Record "Payments SR BC";
        AgreementSchedueRec: Record "Agreement Schedule";
        LicencseID: Guid;
        Frquency: Enum "Recurring Charge Frequency";
        _RecurringCharges: Record "Recurring Charges";//SRBC-306 
        _CustomerBankAccount: Record "Customer Bank Account";//SRBC-306 
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Payments SR BC":
                begin
                    PaymentSrBC := Variant;
                    If PaymentSrBC."Recurring Charge Created" then begin
                        RecurrinChargesRec.Reset();
                        RecurrinChargesRec.SetRange("Source Table ID", RecRef.Number);
                        RecurrinChargesRec.SetRange("Source Table RecordID", PaymentSrBC.sr_paymentId);
                        IF RecurrinChargesRec.FindSet() then
                            RecurrinChargesRec.DeleteAll();
                    end;

                    EntryNo := 0;
                    TmpRecurringChargesRec.Reset();
                    TmpRecurringChargesRec.DeleteAll();

                    CustomerRec.Reset();
                    CustomerRec.SetRange("CRM Agreement ID", Format(PaymentSrBC.sr_agreementid));
                    IF not CustomerRec.FindFirst() then
                        exit;

                    //SRBC-406 Start
                    if PaymentSrBC.sr_paidontext <> '' then begin
                        Evaluate(ChargeStartDate, PaymentSrBC.sr_paidontext);
                        Evaluate(ChargeEndDate, PaymentSrBC.sr_paidontext);
                    end else begin
                        ChargeStartDate := DT2Date(PaymentSrBC.sr_paidon);
                        ChargeEndDate := DT2Date(PaymentSrBC.sr_paidon);
                    end;
                    //SRBC-406 End
                    InsertTmpRecurrngChgFromPaymentSr(PaymentSrBC);
                    InsertRecurringCharges();
                    AutoCreateRecurringChargeLine();//SRBC-306 26032025
                end;
            DATABASE::"Agreement Schedule":
                begin
                    AgreementSchedueRec := Variant;
                    AgreementSchedueRec.CalcFields("Licensee ID", "Security Deposit Amount");
                    //IF (AgreementSchedueRec.sr_feeduedate = 0D) OR (AgreementSchedueRec."Current Agrement Start Date" = 0D) OR (AgreementSchedueRec."Current Agrement End Date" = 0D) then //SRBC-405 JSG 13092025 Old
                    //SRBC-447 Start
                    // IF (AgreementSchedueRec.sr_feeduedate = 0D) OR (AgreementSchedueRec."Current Agrement Start Date" = 0D) OR (AgreementSchedueRec."Current Agrement End Date" = 0D) OR (AgreementSchedueRec.Sequence = 0) then //SRBC-405 JSG 13092025 New                                                                                                                                                                                                      
                    IF (AgreementSchedueRec.sr_feeduedate = 0D) OR (AgreementSchedueRec."Current Agrement Start Date" = 0D) OR (AgreementSchedueRec."Current Agrement End Date" = 0D) OR (AgreementSchedueRec.Sequence = 0)
                    or (IsNullGuid(AgreementSchedueRec.sr_agreementid)) or (AgreementSchedueRec."Staggered End Due Date" = 0D) or (AgreementSchedueRec.sr_weeklylicensefee <= 0) or
                    (AgreementSchedueRec."Highest Amount" <= 0) then
                        exit;
                    if AgreementSchedueRec.new_abatementfee > 0 then begin
                        if (AgreementSchedueRec."Discount Start Date" = 0D) or (AgreementSchedueRec."Discount End Date" = 0D) then
                            exit;
                    end;
                    //SRBC-447 End                                                                                                                                                                                                     

                    If AgreementSchedueRec."Recurring Charge Created" then begin
                        RecurrinChargesRec.Reset();
                        RecurrinChargesRec.SetRange("Source Table ID", RecRef.Number);
                        RecurrinChargesRec.SetRange("Source Table RecordID", AgreementSchedueRec.sr_agreementscheduleId);
                        IF RecurrinChargesRec.FindSet() then
                            RecurrinChargesRec.DeleteAll();
                    end;

                    EntryNo := 0;
                    IsMidWeekAgreement := false;
                    TmpRecurringChargesRec.Reset();
                    TmpRecurringChargesRec.DeleteAll();
                    DefaultWeekSelectionEnum := DefaultWeekSelectionEnum::Saturday;

                    CustomerRec.Reset();

                    CustomerRec.SetRange("CRM Agreement ID", AgreementSchedueRec.sr_agreementid);
                    IF not CustomerRec.FindFirst() then
                        exit;

                    if (AgreementSchedueRec.new_abatementfee <> 0) AND (AgreementSchedueRec.sr_weeklylicensefee <> 0) then begin
                        IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Current Agrement Start Date" - 1) then
                            GetWeekDay(DayEnum, DateForWeek."Period Name");
                        //                         else
                        //                             Error(
                        //        'Missing DateForWeek record. Period Type = Date, Period Start = %1 (Agreement Start Date - 1)',
                        //        AgreementSchedueRec."Current Agrement Start Date" - 1
                        //     );
                        //                         IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec.sr_feeduedate) then
                        //                             GetWeekDay(DayEnum, DateForWeek."Period Name")
                        //                         else
                        //                             Error(
                        //        'Missing DateForWeek record. Period Type = Date, Period Start = %1 (FeedueDate)',
                        //        AgreementSchedueRec.sr_feeduedate
                        //    );
                    end else begin
                        IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec.sr_feeduedate) then
                            GetWeekDay(DayEnum, DateForWeek."Period Name");
                    end;

                    IsMidWeekAgreement := DayEnum <> DefaultWeekSelectionEnum;
                    //defaultweek := dependingupondate <> Saturday;

                    NoOfDiscDays := 0;//SRBC-478
                    NoOfDiscDays := AgreementSchedueRec."No. of Days for Disc";//SRBC-478

                    //If Full Week Agreement -Start
                    If Not IsMidWeekAgreement then begin
                        TmpRecurringChargesRec1.Reset();//SRBC-478
                        TmpRecurringChargesRec1.DeleteAll();//SRBC-478
                        CalculateRecurringChargeDtls(AgreementSchedueRec);
                        InsertTmpRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly, 0);
                        InsertRecurringCharges();

                        if (AgreementSchedueRec.new_abatementfee <> 0) then begin
                            CalculateDiscountRecurringChargeDtls(AgreementSchedueRec);  //SRBC-218 JIRA
                            InsertTmpDiscountRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly);
                            if not IsInsertSecondLine then//SRBC-478
                                InsertDiscountAbatmentCharges;
                        end;
                        //SRBC-478 Start
                        //IF Full week discount is greater then 7 days or A week create 2nd Disc line of remaining days
                        if IsInsertSecondLine then begin
                            if (AgreementSchedueRec.new_abatementfee <> 0) then begin
                                CalculateDiscountRecurringChargeDtls(AgreementSchedueRec);  //SRBC-218 JIRA
                                InsertTmpDiscountRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly);
                                InsertDiscountAbatmentCharges;
                            end;
                        end;
                        //SRBC-478 End
                        exit;
                    end;
                    //If Full Week Agreement -End
                    IsMidWeekThirdLine := false;
                    CheckChargesforLine3 := false;
                    IsMidWeekDiscThirdLine := false;
                    CheckDiscforLine3 := false;
                    IsInsertSecondLine := false;
                    IsInsertThirdLine := false;
                    //Mid Week Agreement - 1st Line
                    //NoOfDiscDays := 0;//SRBC-478 05022026
                    //NoOfDiscDays := AgreementSchedueRec."No. of Days for Disc";//SRBC-478 05022026
                    CalculateRecurringChargeDtls(AgreementSchedueRec);
                    InsertTmpRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly, 1);

                    //SY - Strat
                    //Mid Week Discount - 1st Line  
                    if (AgreementSchedueRec.new_abatementfee <> 0) then begin
                        TmpRecurringChargesRec1.Reset();
                        TmpRecurringChargesRec1.DeleteAll();
                        CalculateDiscountRecurringChargeDtls(AgreementSchedueRec);
                        InsertTmpDiscountRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly);
                    end;
                    //SY - End

                    //Mid Week Agreement - 2nd Line
                    CalculateRecurringChargeDtls(AgreementSchedueRec);
                    InsertTmpRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly, 2);
                    if not IsMidWeekThirdLine then
                        InsertRecurringCharges();

                    //Mid Week Discount - 2nd Line
                    if (AgreementSchedueRec.new_abatementfee <> 0) then begin
                        CalculateDiscountRecurringChargeDtls(AgreementSchedueRec);
                        if IsInsertSecondLine then
                            InsertTmpDiscountRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly);
                        if not IsMidWeekDiscThirdLine then
                            InsertDiscountAbatmentCharges;
                    end;
                    //SY - End
                    //Mid Week Agreement - 3rd Line
                    if IsMidWeekThirdLine then begin
                        CheckChargesforLine3 := true;
                        CalculateRecurringChargeDtls(AgreementSchedueRec);
                        InsertTmpRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly, 3);
                        InsertRecurringCharges();
                    end;

                    //Mid Week Discount - 3rd Line
                    if (AgreementSchedueRec.new_abatementfee <> 0) then begin
                        if IsMidWeekDiscThirdLine then begin
                            CheckDiscforLine3 := true;
                            CalculateDiscountRecurringChargeDtls(AgreementSchedueRec);
                            if IsInsertThirdLine then
                                InsertTmpDiscountRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly);
                            InsertDiscountAbatmentCharges;
                        end;
                    end;
                    //SRBC-306 Start
                    //SRBC-349 - NU - 20260627
                    // _RecurringCharges.Reset();
                    // _RecurringCharges.SetRange("Agreement ID", AgreementSchedueRec.sr_agreementid);
                    // if _RecurringCharges.FindFirst() then begin
                    //     if not (_RecurringCharges."Start Date" < Today) AND (_RecurringCharges.IsBC) then
                    //         AutoCreateRecurringChargeLine();
                    // end;
                    //SRBC-349 - NU - 20260627
                    //SRBC-306 End
                end;
        end;
    end;

    local procedure ModifyAutoChargeIDRecurringPaymentEntries(var CDSAutoCharge: Record "CDS sr_autocharge")
    var
        RecurrinCharges: Record "Recurring Charges";
    begin
        RecurrinCharges.Reset();
        if not RecurrinCharges.Get(CDSAutoCharge.new_SrBCEntryNo) then
            exit;
        RecurrinCharges.Validate("AutoCharge ID", CDSAutoCharge.sr_autochargeId);
        RecurrinCharges.Modify(true);
    end;

    //SY - Start
    local procedure InsertDiscountAbatmentCharges()
    var
        AgreementSchedueRec: Record "Agreement Schedule";
    begin
        MarkRecurrinChargesRec.Reset();
        TmpRecurringChargesRec1.Reset();
        IF TmpRecurringChargesRec1.FindSet() then
            repeat
                RecurrinChargesRec.Init();
                RecurrinChargesRec.TransferFields(TmpRecurringChargesRec1);
                RecurrinChargesRec."Entry No." := 0;
                RecurrinChargesRec.Insert(true);
                MarkRecurrinChargesRec.SetRange("Entry No.", RecurrinChargesRec."Entry No.");
                MarkRecurrinChargesRec.FindFirst();
                MarkRecurrinChargesRec.Mark(true);

                case TmpRecurringChargesRec1."Source Table ID" of

                    DATABASE::"Agreement Schedule":
                        begin
                            AgreementSchedueRec.Get(TmpRecurringChargesRec1."Source Table RecordID");
                            AgreementSchedueRec."Recurring Charge Created" := true;
                            AgreementSchedueRec."Recurring Charge Created Date" := Today;
                            AgreementSchedueRec."Recurring Charge Created Time" := Time;
                            AgreementSchedueRec.Modify();
                        end;
                end;
            until TmpRecurringChargesRec1.Next() = 0;
    end;
    //SY - End

    procedure InsertRecurringFromAS(var AgreementSchedule_iRec: Record "Agreement Schedule")
    var
        RecRef: RecordRef;
        AgreementSchedueRec: Record "Agreement Schedule";
        Frquency: Enum "Recurring Charge Frequency";
    begin
        AgreementSchedueRec.Reset();
        AgreementSchedueRec.Get(AgreementSchedule_iRec.sr_agreementscheduleId);
        AgreementSchedueRec.CalcFields("Licensee ID", "Security Deposit Amount");
        IF (AgreementSchedueRec.sr_feeduedate = 0D) OR (AgreementSchedueRec."Current Agrement Start Date" = 0D) OR (AgreementSchedueRec."Current Agrement End Date" = 0D) then
            exit;
        If AgreementSchedueRec."Recurring Charge Created" then begin
            RecurrinChargesRec.Reset();
            RecurrinChargesRec.SetRange("Source Table ID", RecRef.Number);
            RecurrinChargesRec.SetRange("Source Table RecordID", AgreementSchedueRec.sr_agreementscheduleId);
            IF RecurrinChargesRec.FindSet() then
                RecurrinChargesRec.DeleteAll();
        end;
        EntryNo := 0;
        IsMidWeekAgreement := false;
        TmpRecurringChargesRec.Reset();
        TmpRecurringChargesRec.DeleteAll();
        DefaultWeekSelectionEnum := DefaultWeekSelectionEnum::Saturday;

        CustomerRec.Reset();
        CustomerRec.SetRange("CRM Agreement ID", AgreementSchedueRec.sr_agreementid);
        IF not CustomerRec.FindFirst() then
            exit;

        if (AgreementSchedueRec.new_abatementfee <> 0) AND (AgreementSchedueRec.sr_weeklylicensefee <> 0) then begin
            IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Current Agrement Start Date" - 1) then
                GetWeekDay(DayEnum, DateForWeek."Period Name");
        end else begin
            IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec.sr_feeduedate) then
                GetWeekDay(DayEnum, DateForWeek."Period Name");
        end;


        IsMidWeekAgreement := DayEnum <> DefaultWeekSelectionEnum;

        //If Full Week Agreement
        If Not IsMidWeekAgreement then begin
            CalculateRecurringChargeDtls(AgreementSchedueRec);
            InsertTmpRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly, 0);
            InsertRecurringCharges();

            if (AgreementSchedueRec.new_abatementfee <> 0) then begin
                CalculateRecurringChargeDtls(AgreementSchedueRec);
                InsertTmpDiscountRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly);
                InsertDiscountAbatmentCharges;
            end;
            exit;
        end;

        //Mid Week Agreement - 1st Line
        CalculateRecurringChargeDtls(AgreementSchedueRec);
        InsertTmpRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly, 1);

        //SY - Strat  
        if (AgreementSchedueRec.new_abatementfee <> 0) then begin
            CalculateDiscountRecurringChargeDtls(AgreementSchedueRec);
            InsertTmpDiscountRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Once);
        end;
        //SY - End

        //Mid Week Agreement - 2nd Line
        CalculateRecurringChargeDtls(AgreementSchedueRec);
        InsertTmpRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly, 2);
        InsertRecurringCharges();
        if (AgreementSchedueRec.new_abatementfee <> 0) then begin
            CalculateDiscountRecurringChargeDtls(AgreementSchedueRec);
            InsertTmpDiscountRecurrngChgFromAgreementSchedule(AgreementSchedueRec, Frquency::Weekly);
            InsertDiscountAbatmentCharges;

        end;

        AutoCreateRecurringChargeLine();
    end;

    local procedure InsertRecurringCharges()
    var
        PaymentSrBC: Record "Payments SR BC";
        AgreementSchedueRec: Record "Agreement Schedule";
        Agreement_lRec: Record Agreements;
    begin
        MarkRecurrinChargesRec.Reset();
        TmpRecurringChargesRec.Reset();
        IF TmpRecurringChargesRec.FindSet() then
            repeat
                RecurrinChargesRec.Init();
                RecurrinChargesRec.TransferFields(TmpRecurringChargesRec);
                RecurrinChargesRec."Entry No." := 0;
                RecurrinChargesRec.Insert(true);
                MarkRecurrinChargesRec.SetRange("Entry No.", RecurrinChargesRec."Entry No.");
                MarkRecurrinChargesRec.FindFirst();
                MarkRecurrinChargesRec.Mark(true);

                case TmpRecurringChargesRec."Source Table ID" of
                    DATABASE::"Payments SR BC":
                        begin
                            PaymentSrBC.Get(TmpRecurringChargesRec."Source Table RecordID");
                            //UpdateBCLocationSalonCode(PaymentSrBC);
                            PaymentSrBC."Recurring Charge Created" := true;
                            PaymentSrBC."Recurring Charge Created Date" := Today;
                            PaymentSrBC."Recurring Charge Created Time" := Time;
                            PaymentSrBC.Validate("Recurring Entry No.", MarkRecurrinChargesRec."Entry No.");
                            PaymentSrBC.Modify();
                        end;
                    DATABASE::"Agreement Schedule":
                        begin
                            AgreementSchedueRec.Get(TmpRecurringChargesRec."Source Table RecordID");
                            AgreementSchedueRec."Recurring Charge Created" := true;
                            AgreementSchedueRec."Recurring Charge Created Date" := Today;
                            AgreementSchedueRec."Recurring Charge Created Time" := Time;
                            AgreementSchedueRec.Validate("Recurring Entry No.", MarkRecurrinChargesRec."Entry No.");
                            AgreementSchedueRec.Modify();
                        end;
                    Database::Agreements:
                        begin
                            Agreement_lRec.Get(TmpRecurringChargesRec."Source Table RecordID");
                            Agreement_lRec.Validate("Additional Security Charge", true);
                            Agreement_lRec.Validate("Security Charge Created Date", Today);
                            Agreement_lRec.Validate("Security Charge Created Time", Time);
                            Agreement_lRec.Validate("Additional Security Entry No.", MarkRecurrinChargesRec."Entry No.");
                            Agreement_lRec.Modify();
                        end;
                end;
            until TmpRecurringChargesRec.Next() = 0;
    end;

    local procedure InsertTmpRecurrngChgFromPaymentSr(var PaymentSrBC: Record "Payments SR BC")
    var
        Agreements: Record Agreements;
    begin
        SRSetup.Get();
        EntryNo += 1;
        TmpRecurringChargesRec.Init();
        TmpRecurringChargesRec."Entry No." := EntryNo;
        TmpRecurringChargesRec.Validate("Customer No.", CustomerRec."No.");
        TmpRecurringChargesRec.Validate(Frequency, TmpRecurringChargesRec.Frequency::Once);

        TmpRecurringChargesRec.Validate(Amount, PaymentSrBC.sr_amount);
        TmpRecurringChargesRec.Validate("Start Date", ChargeStartDate);
        TmpRecurringChargesRec.Validate("End Date", ChargeEndDate);

        if (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"ConstructionAgreement-Remote") and (not PaymentSrBC."Studio Modification Deposit") then//SRBC-380
            TmpRecurringChargesRec.Validate(Description, SRSetup.ConstrucAgreeSTUDMODICHARGE + '.')//SRBC-380
        else if (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"ConstructionAgreement-Remote") and (PaymentSrBC."Studio Modification Deposit") then//SRBC-380
            TmpRecurringChargesRec.Validate(Description, SRSetup.ConstrucAgreeSTUDMODIDIPOSIT + '.')//SRBC-380
        else if (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"AddStudioHDA-InPerson") OR
                 (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"AddStudioHDA-Remote") then
            TmpRecurringChargesRec.Validate(Description, 'Add Studio HD Amount' + Format(TmpRecurringChargesRec.Amount))
        else
            TmpRecurringChargesRec.Validate(Description, 'License Fee Security Deposit.');

        //STUDIO MODIFICATION CHARGE
        //SRBC-380 Start
        if (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"ConstructionAgreement-Remote") and (not PaymentSrBC."Studio Modification Deposit") then
            TmpRecurringChargesRec.Validate("Auto Charge Type", SRSetup.ConstrucAgreeSTUDMODICHARGE)
        else if (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"ConstructionAgreement-Remote") and (PaymentSrBC."Studio Modification Deposit") then
            TmpRecurringChargesRec.Validate("Auto Charge Type", SRSetup.ConstrucAgreeSTUDMODIDIPOSIT)
        else
            TmpRecurringChargesRec.Validate("Auto Charge Type", SRSetup."LICENSE FEE SECURITY");
        // if (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"ConstructionAgreement-Remote") then
        //     TmpRecurringChargesRec.Validate("Auto Charge Type", SRSetup.ConstrucAgreeSTUDMODICHARGE)
        // else
        //     TmpRecurringChargesRec.Validate("Auto Charge Type", SRSetup."LICENSE FEE SECURITY");
        //SRBC-380 End
        if PaymentSrBC."BC Location Code" <> '' then
            TmpRecurringChargesRec.Validate("Shortcut Dimension 1 Code", PaymentSrBC."BC Location Code");  //salon
        if PaymentSrBC."BC Salon Code" <> '' then
            TmpRecurringChargesRec.Validate("Shortcut Dimension 2 Code", PaymentSrBC."BC Salon Code");  // studio
        TmpRecurringChargesRec.Validate("Agreement Start Date");
        Evaluate(TmpRecurringChargesRec.Licensee, PaymentSrBC.sr_licenseID);

        TmpRecurringChargesRec.Validate("Payment Method Code", 'DOCUSIGN');
        TmpRecurringChargesRec.Validate("Agreement ID", PaymentSrBC.sr_agreementid);

        //Multisigner Hold deposit Start
        TmpRecurringChargesRec.Validate(sr_AmountShare, PaymentSrBC.sr_AmountShare);
        TmpRecurringChargesRec.Validate(sr_DocusignPaymentType, PaymentSrBC.sr_DocusignPaymentType);
        TmpRecurringChargesRec.Validate(IsLastRow, PaymentSrBC.IsLastRow);
        TmpRecurringChargesRec.Validate("Payment SR BC", PaymentSrBC.sr_paymentId);

        if (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"DocuSignHoldDeposit-InPerson") OR//SRBC-380 11072025
        (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"DocuSignHoldDeposit-Remote") OR
        (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"AddStudioHDA-InPerson") OR
        (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"AddStudioHDA-Remote") OR
        (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"MoveOutHDA-InPerson") OR
        (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"MoveOutHDA-Remote") then begin
            TmpRecurringChargesRec.Validate("MultiSigner Hold Deposit", true);
        end;
        //Multisigner Hold deposit End

        //Construction Agreement Start
        //JIRA SRBC-202
        //SRBC-380 Start
        if (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"ConstructionAgreement-Remote") OR//SRBC-380 16072025
        (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"DocusignHoldDepositTransfer-InPerson") OR
        (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"DocusignHoldDepositTransfer-Remote") then begin
            TmpRecurringChargesRec.Validate("Construction Agreement", true);
        end;
        //SRBC-380 End
        //Construction Agreement End
        //JIRA SRBC-202
        TmpRecurringChargesRec.Validate(sr_chargeid, PaymentSrBC.sr_chargeid); //SRBC-173 JIRA
        TmpRecurringChargesRec."Source Table ID" := Database::"Payments SR BC";
        TmpRecurringChargesRec."Source Table RecordID" := PaymentSrBC.sr_paymentId;
        TmpRecurringChargesRec.Insert;

        //Create additional reccuring charges in multi signer for additional security START
        if not TmpRecurringChargesRec."Additional Security Charge" then begin
            if TmpRecurringChargesRec.IsLastRow then begin
                if (TmpRecurringChargesRec.sr_DocusignPaymentType = TmpRecurringChargesRec.sr_DocusignPaymentType::"DocuSignHoldDeposit-InPreson") OR
                (TmpRecurringChargesRec.sr_DocusignPaymentType = TmpRecurringChargesRec.sr_DocusignPaymentType::"DocuSignHoldDeposit-Remote") OR
                (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"AddStudioHDA-InPerson") OR
                (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"AddStudioHDA-Remote") OR
                (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"MoveOutHDA-InPerson") OR
                (PaymentSrBC.sr_DocusignPaymentType = PaymentSrBC.sr_DocusignPaymentType::"MoveOutHDA-Remote") then begin
                    Agreements.Reset();
                    if Agreements.Get(TmpRecurringChargesRec."Agreement ID") then begin
                        if Agreements."Current Agreement Start Date" = 0D then
                            exit;
                        if Agreements."Current Agreement End Date" = 0D then
                            exit;
                        if Agreements."Additional Security Charge" then
                            exit;
                        if Agreements.sr_AdditionalSecurityDepAmt <> 0 then begin
                            EntryNo += 1;
                            TmpRecurringChargesRec.Init();
                            TmpRecurringChargesRec."Entry No." := EntryNo;
                            TmpRecurringChargesRec.Validate("Customer No.", CustomerRec."No.");
                            TmpRecurringChargesRec.Validate(Frequency, TmpRecurringChargesRec.Frequency::Once);
                            TmpRecurringChargesRec.Validate(Description, 'ADDITIONAL SECURITY DEPOSIT.');
                            TmpRecurringChargesRec.Validate(Amount, Agreements.sr_AdditionalSecurityDepAmt);
                            TmpRecurringChargesRec.Validate("Start Date", Agreements."Current Agreement Start Date");
                            TmpRecurringChargesRec.Validate("End Date", Agreements."Current Agreement Start Date");
                            TmpRecurringChargesRec.Validate("Auto Charge Type", SRSetup."ADDITIONAL SECURITY DEPOSIT");

                            Evaluate(TmpRecurringChargesRec.Licensee, Agreements."Licensee 1");
                            TmpRecurringChargesRec.Validate("Agreement ID", Agreements."Agreement ID");
                            //Multisigner Hold deposit
                            TmpRecurringChargesRec.Validate("Payment SR BC", PaymentSrBC.sr_paymentId);
                            TmpRecurringChargesRec.Validate("Additional Security Charge", true);
                            TmpRecurringChargesRec."Source Table ID" := Database::Agreements;
                            TmpRecurringChargesRec."Source Table RecordID" := Agreements."Agreement ID";
                            TmpRecurringChargesRec.Insert;
                        end;
                    end;
                end;
            end;
        end;
        //Create additional reccuring charges in multi signer for additional security END
    end;

    procedure CreateAdditionalSecurityDepositLines(var Agreement_iRec: Record Agreements)
    //Create Additional Security Charge Directly from agreement
    var
    begin
        SRSETUP.Get();
        CustomerRec.Reset();
        CustomerRec.SetRange("CRM Agreement ID", Format(Agreement_iRec."Agreement ID"));
        IF not CustomerRec.FindFirst() then
            exit;

        if Agreement_iRec."Current Agreement Start Date" = 0D then
            exit;
        if Agreement_iRec."Current Agreement End Date" = 0D then
            exit;
        if Agreement_iRec.sr_AdditionalSecurityDepAmt <> 0 then begin
            EntryNo += 1;
            TmpRecurringChargesRec.Init();
            TmpRecurringChargesRec."Entry No." := EntryNo;
            TmpRecurringChargesRec.Validate("Customer No.", CustomerRec."No.");
            TmpRecurringChargesRec.Validate(Frequency, TmpRecurringChargesRec.Frequency::Once);
            TmpRecurringChargesRec.Validate(Description, 'ADDITIONAL SECURITY DEPOSIT.');
            TmpRecurringChargesRec.Validate(Amount, Agreement_iRec.sr_AdditionalSecurityDepAmt);
            TmpRecurringChargesRec.Validate("Agreement Start Date", Agreement_iRec."Current Agreement Start Date");
            TmpRecurringChargesRec.Validate("Start Date", Agreement_iRec."Current Agreement Start Date");
            TmpRecurringChargesRec.Validate("End Date", Agreement_iRec."Current Agreement Start Date");
            TmpRecurringChargesRec.Validate("Auto Charge Type", SRSETUP."ADDITIONAL SECURITY DEPOSIT");
            Evaluate(TmpRecurringChargesRec.Licensee, Agreement_iRec."Licensee 1");

            TmpRecurringChargesRec.Validate("Agreement ID", Agreement_iRec."Agreement ID");
            //Multisigner Hold deposit
            TmpRecurringChargesRec.Validate("Additional Security Charge", true);
            TmpRecurringChargesRec."Source Table ID" := Database::Agreements;
            TmpRecurringChargesRec."Source Table RecordID" := Agreement_iRec."Agreement ID";
            TmpRecurringChargesRec.Insert;
            InsertRecurringCharges();
            AutoCreateRecurringChargeLine();
        end;
    end;

    local procedure InsertTmpRecurrngChgFromAgreementSchedule(var AgreementSchedueRec: Record "Agreement Schedule"; Frequency: Enum "Recurring Charge Frequency"; MidWeekLineNo: Integer)
    var
        RecurringCharge_lRec: Record "Recurring Charges";
        RecurringChargeCreatedDate: Date;//SRBC-349
    begin
        srsetup.Get();
        EntryNo += 1;
        TmpRecurringChargesRec.Init();
        TmpRecurringChargesRec."Entry No." := EntryNo;
        TmpRecurringChargesRec.Validate("Customer No.", CustomerRec."No.");
        TmpRecurringChargesRec.Validate(Frequency, Frequency);

        if MidWeekLineNo = 1 then
            TmpRecurringChargesRec.Validate("Skip Calculation", true)
        else
            TmpRecurringChargesRec.Validate("Skip Calculation", false);

        TmpRecurringChargesRec.Validate(Description, 'Recurring License Fee Charges');
        TmpRecurringChargesRec.Validate(Amount, Deposit);
        TmpRecurringChargesRec.Validate("Start Date", ChargeStartDate);
        TmpRecurringChargesRec.Validate("End Date", ChargeEndDate);
        TmpRecurringChargesRec.Validate("Agreement Start Date", AgreementStartDate);
        TmpRecurringChargesRec.Validate("Charge Anticipated End Date", AgreementEndDate);
        TmpRecurringChargesRec.Validate("Auto Charge Type", srsetup."LICENSE FEE");
        TmpRecurringChargesRec.Validate("Shortcut Dimension 1 Code", CustomerRec."Global Dimension 1 Code");  //salon 
        TmpRecurringChargesRec.Validate("Shortcut Dimension 2 Code", CustomerRec."Global Dimension 2 Code");  // studio
        TmpRecurringChargesRec.Validate(Licensee, AgreementSchedueRec."Licensee ID");
        TmpRecurringChargesRec.Validate("Agreement ID", AgreementSchedueRec.sr_agreementid);
        TmpRecurringChargesRec.Validate("Agreement Schedule ID", AgreementSchedueRec.sr_agreementscheduleId);
        TmpRecurringChargesRec.Validate(Sequence, AgreementSchedueRec.Sequence);
        TmpRecurringChargesRec."Source Table ID" := Database::"Agreement Schedule";
        TmpRecurringChargesRec."Source Table RecordID" := AgreementSchedueRec.sr_agreementscheduleId;
        TmpRecurringChargesRec.Inactive := AgreementSchedueRec.Inactive;
        TmpRecurringChargesRec.Validate(sr_from, AgreementSchedueRec.sr_from);
        TmpRecurringChargesRec.Validate(sr_to, AgreementSchedueRec.sr_to);

        TmpRecurringChargesRec."CRM Renewal" := AgreementSchedueRec."CRM Renewal";
        TmpRecurringChargesRec.sr_renewalLADocuSign := AgreementSchedueRec.sr_renewalLADocuSign;//SRBC-405 20082025
        //if (AgreementSchedueRec."CRM Renewal") or (AgreementSchedueRec.sr_renewalLADocuSign) then begin//SRBC-405 20082025 SRBC-405 JSG 10092025
        RecurringCharge_lRec.Reset();
        RecurringCharge_lRec.SetRange("Agreement ID", AgreementSchedueRec.sr_agreementid);
        //SRBC-349 Start
        // RecurringCharge_lRec.SetRange("CRM Renewal", false);
        // RecurringCharge_lRec.SetRange("End Date", 0D);
        RecurringCharge_lRec.SetRange(Frequency, RecurringCharge_lRec.Frequency::Weekly);//SRBC-405 20082025
        RecurringCharge_lRec.SetRange("Auto Charge Type", 'LICENSE FEE (''Rent'')');
        if RecurringCharge_lRec.FindSet() then
            //SRBC-405 Start JSG 12092025
            // repeat
            //     RecurringChargeCreatedDate := DT2Date(RecurringCharge_lRec.SystemCreatedAt);
            //     if RecurringChargeCreatedDate > AgreementSchedueRec.sr_feeduedate then begin
            //         if RecurringCharge_lRec."End Date" = 0D then
            //             RecurringCharge_lRec."End Date" := RecurringChargeCreatedDate
            //         else
            //             if RecurringCharge_lRec."End Date" >= RecurringChargeCreatedDate then
            //                 RecurringCharge_lRec."End Date" := RecurringChargeCreatedDate
            //     end else
            //         if RecurringCharge_lRec."End Date" = 0D then
            //             RecurringCharge_lRec."End Date" := AgreementSchedueRec.sr_feeduedate - 1
            //         else begin
            //             if RecurringCharge_lRec."End Date" >= AgreementSchedueRec.sr_feeduedate then
            //                 RecurringCharge_lRec."End Date" := AgreementSchedueRec.sr_feeduedate - 1;
            //         end;
            //     RecurringCharge_lRec.Modify();
            // until RecurringCharge_lRec.Next() = 0;
            repeat
                if RecurringCharge_lRec.Sequence < AgreementSchedueRec.Sequence then begin //SRBC-405 End JSG 13092025
                    //if RecurringCharge_lRec."Start Date" < (AgreementSchedueRec."Current Agrement Start Date" - 2) then begin //SRBC-405 End JSG 13092025 
                    if (RecurringCharge_lRec."End Date" >= (AgreementSchedueRec."Current Agrement Start Date" - 2)) or (RecurringCharge_lRec."End Date" = 0D) and ((AgreementSchedueRec."Current Agrement Start Date" - 2) >= Today) then begin
                        RecurringCharge_lRec."End Date" := (AgreementSchedueRec."Current Agrement Start Date" - 2)
                        //end else if (RecurringCharge_lRec."End Date" >= (AgreementSchedueRec."Current Agrement Start Date" - 2)) or (RecurringCharge_lRec."End Date" = 0D) and ((AgreementSchedueRec."Current Agrement Start Date" - 2) < Today) then begin//SRBC-443 JSG 15102025 Old
                    end else if (RecurringCharge_lRec."End Date" >= (AgreementSchedueRec."Current Agrement Start Date" - 2)) or (RecurringCharge_lRec."End Date" = 0D) and ((AgreementSchedueRec."Current Agrement Start Date" - 2) < Today) and (AgreementSchedueRec.sr_feeduedate <> Today) then begin//SRBC-443 JSG 15102025 New
                        RecurringCharge_lRec."End Date" := Today;
                        //SRBC-443 JSG 15102025 Start
                        //RecurringCharge_lRec.Inactive := true;
                    end else if (RecurringCharge_lRec."End Date" >= (AgreementSchedueRec."Current Agrement Start Date" - 2)) or (RecurringCharge_lRec."End Date" = 0D) and ((AgreementSchedueRec."Current Agrement Start Date" - 2) < Today) and (AgreementSchedueRec.sr_feeduedate = Today) then begin
                        RecurringCharge_lRec."End Date" := Today - 1;
                    end;
                    if RecurringCharge_lRec."End Date" <= Today then
                        RecurringCharge_lRec.Inactive := True;
                    //SRBC-443 JSG 15102025 End
                    RecurringCharge_lRec.Modify();
                end;
            until RecurringCharge_lRec.Next() = 0;
        //SRBC-405 End JSG 12092025    
        //SRBC-349 End
        //end; SRBC-405 JSG 10092025
        TmpRecurringChargesRec.Insert();
    end;

    //SY-Start
    local procedure InsertTmpDiscountRecurrngChgFromAgreementSchedule(var AgreementSchedueRec: Record "Agreement Schedule"; Frequency: Enum "Recurring Charge Frequency")
    var
        RecurringCharge_lRec: Record "Recurring Charges";
        EndDate_lDte: Date;
        OneDayDiscountAmount_lVar: Decimal;
    begin
        srsetup.Get();
        EndDate_lDte := 0D;

        RecurringCharge_lRec.Reset();

        EntryNo += 1;

        TmpRecurringChargesRec1.Init();
        TmpRecurringChargesRec1."Entry No." := EntryNo;
        TmpRecurringChargesRec1.Validate("Customer No.", CustomerRec."No.");
        TmpRecurringChargesRec1.Validate(Frequency, Frequency);
        TmpRecurringChargesRec1.Validate(Description, 'License Fee Concession');


        TmpRecurringChargesRec1.Validate("Start Date", ChargeStartDate);
        TmpRecurringChargesRec1.Validate("Agreement Start Date", AgreementStartDate);
        TmpRecurringChargesRec1.Validate("Auto Charge Type", srsetup."LICENSE FEE CONCESSION");
        TmpRecurringChargesRec1."No. of Weeks for Disc" := AgreementSchedueRec."No. of Weeks for Disc";
        if AgreementSchedueRec."No. of Days for Disc" <> 0 then begin
            if ChargeStartDate <> 0D then begin
                EndDate_lDte := ((ChargeStartDate + AgreementSchedueRec."No. of Days for Disc") - 1);
                TmpRecurringChargesRec1.Validate("End Date", EndDate_lDte);
            end;
        end else begin
            if ChargeStartDate <> 0D then
                TmpRecurringChargesRec1.Validate("End Date", ChargeStartDate);
        end;
        TmpRecurringChargesRec1."Discount Start Date" := ChargeStartDate;
        //SRBC-218 JIRA
        //SRBC-478 Start 
        if not IsMidWeekAgreement then begin
            if ChargeEndDate <> 0D then
                TmpRecurringChargesRec1."Discount End Date" := ChargeEndDate
            else
                TmpRecurringChargesRec1.Validate("Discount End Date", AgreementEndDate);

            if ChargeEndDate <> 0D then
                TmpRecurringChargesRec1.Validate("End Date", ChargeEndDate)
            else
                TmpRecurringChargesRec1.Validate("End Date", AgreementEndDate);
        end else
            TmpRecurringChargesRec1."Discount End Date" := ChargeEndDate;
        //SRBC-478 End
        if ((IsMidWeekAgreement) and (ChargeEndDate <> 0D)) then
            TmpRecurringChargesRec1.Validate("End Date", ChargeEndDate);
        //SRBC-218 JIRA

        TmpRecurringChargesRec1.Validate("Shortcut Dimension 1 Code", CustomerRec."Global Dimension 1 Code");  //salon 
        TmpRecurringChargesRec1.Validate("Shortcut Dimension 2 Code", CustomerRec."Global Dimension 2 Code");  //studio
        TmpRecurringChargesRec1.Validate(Licensee, AgreementSchedueRec."Licensee ID");
        TmpRecurringChargesRec1.Validate("Agreement ID", AgreementSchedueRec.sr_agreementid);
        TmpRecurringChargesRec1.Validate("Agreement Schedule ID", AgreementSchedueRec.sr_agreementscheduleId);
        TmpRecurringChargesRec1.Validate(Sequence, AgreementSchedueRec.Sequence);
        TmpRecurringChargesRec1."Source Table ID" := Database::"Agreement Schedule";
        TmpRecurringChargesRec1."Source Table RecordID" := AgreementSchedueRec.sr_agreementscheduleId;
        TmpRecurringChargesRec1.Inactive := AgreementSchedueRec.Inactive;
        //SY- Change Start
        OneDayDiscountAmount_lVar := 0;
        if (TmpRecurringChargesRec1."End Date" <> 0D) and (TmpRecurringChargesRec1."Start Date" <> 0D) then
            TmpRecurringChargesRec1."No. of Days for Disc" := TmpRecurringChargesRec1."End Date" - TmpRecurringChargesRec1."Start Date" + 1;
        if (AgreementSchedueRec.new_abatementfee <> 0) and (AgreementSchedueRec."No. of Days for Disc" <> 0) then
            OneDayDiscountAmount_lVar := abs(AgreementSchedueRec.new_abatementfee) / abs(AgreementSchedueRec."No. of Days for Disc");
        TmpRecurringChargesRec1.Validate(Amount, Deposit);
        //SY -Change End
        //SRBC-405 JSG 13092025 Start
        TmpRecurringChargesRec1."CRM Renewal" := AgreementSchedueRec."CRM Renewal";
        TmpRecurringChargesRec1.sr_renewalLADocuSign := AgreementSchedueRec.sr_renewalLADocuSign;
        //SRBC-405 JSG 13092025 End
        TmpRecurringChargesRec1.Insert();
    end;
    //SY-End
    procedure CreateRecurringChargesLASecurity(var Agreement_iRec: Record Agreements)
    var
        FindLastRecurringCharge: Record "Recurring Charges";
        RecurringCharges: Record "Recurring Charges";
        TmpReccuringCharge: Record "Recurring Charges" temporary;
        MODAgreements: Record Agreements;
    begin
        srsetup.Get();
        FindLastRecurringCharge.Reset();
        if FindLastRecurringCharge.FindLast() then
            EntryNo := FindLastRecurringCharge."Entry No." + 1
        else
            EntryNo := 1;

        TmpReccuringCharge.Init();
        TmpReccuringCharge."Entry No." := EntryNo;
        TmpReccuringCharge.Validate("Customer No.", Agreement_iRec."Customer Code");
        TmpReccuringCharge.Validate(Frequency, TmpReccuringCharge.Frequency::Once);
        TmpReccuringCharge.Validate(Description, 'License Fee Security');
        TmpReccuringCharge.Validate(Amount, Agreement_iRec.sr_LASecurityDepositAmount);
        TmpReccuringCharge.Validate("Start Date", Agreement_iRec."Current Agreement Start Date");
        TmpReccuringCharge.Validate("End Date", Agreement_iRec."Current Agreement Start Date");
        TmpReccuringCharge.Validate("Auto Charge Type", srsetup."LICENSE FEE SECURITY");
        TmpReccuringCharge.Validate("Agreement ID", Agreement_iRec."Agreement ID");
        TmpReccuringCharge.Validate(Licensee, Agreement_iRec."Licensee 1");
        TmpReccuringCharge."Source Table ID" := Database::Agreements;
        TmpReccuringCharge."Source Table RecordID" := Agreement_iRec."Agreement ID";
        TmpReccuringCharge."LA Security Deposit" := true;
        TmpReccuringCharge.Insert(true);
        RecurringCharges.Init();
        RecurringCharges.TransferFields(TmpReccuringCharge);
        RecurringCharges.Insert(true);
        MarkLASecurityCharges.SetRange("Entry No.", RecurringCharges."Entry No.");
        MarkLASecurityCharges.FindFirst();
        MarkLASecurityCharges.Mark(true);
        MODAgreements.Get(Agreement_iRec."Agreement ID");
        MODAgreements.Validate(sr_docusignintegrastatus_la, MODAgreements.sr_docusignintegrastatus_la::Completed);
        MODAgreements.Validate(LASecurity, true);
        MODAgreements.Modify();
        AutoCreateRecurringChargeLASecurity();
    end;

    local procedure CalculateRecurringChargeDtls(var AgreementSchedueRec: Record "Agreement Schedule")
    var
        IsLastAgreementLine: Boolean;
        DiffDays: Integer;
        TmpDate: Date;
    begin
        SrSetup.Get();
        Deposit := 0;
        ChargeStartDate := 0D;
        ChargeEndDate := 0D;
        AgreementStartDate := 0D;
        AgreementEndDate := 0D;
        IsLastAgreementLine := AgreementSchedueRec.sr_IsLastRow;
        AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";//SRBC-478
        If not IsMidWeekAgreement then begin
            Deposit := AgreementSchedueRec.sr_weeklylicensefee;

            //New change
            if AgreementSchedueRec.new_abatementfee <> 0 then
                ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1
            else
                ChargeStartDate := AgreementSchedueRec.sr_feeduedate;
            AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
            DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
            GetWeekDay(DayEnum, DateForWeek."Period Name");
            TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
            If IsLastAgreementLine then
                AgreementEndDate := AgreementSchedueRec."Current Agrement End Date"
            else
                ChargeEndDate := TmpDate;
            exit;
        end;
        if not IsMidWeekThirdLine then begin
            //Check MidWeek Agreement 1st line inserted
            TmpRecurringChargesRec.Reset();
            TmpRecurringChargesRec.SetRange("Source Table ID", Database::"Agreement Schedule");
            TmpRecurringChargesRec.SetRange("Source Table RecordID", AgreementSchedueRec.sr_agreementscheduleId);
            TmpRecurringChargesRec.SetRange("Auto Charge Type", SrSetup."LICENSE FEE");
            IF TmpRecurringChargesRec.FindFirst() then begin
                Deposit := AgreementSchedueRec.sr_weeklylicensefee;
                ChargeStartDate := CalcDate('1D', TmpRecurringChargesRec."End Date");
                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
                GetWeekDay(DayEnum, DateForWeek."Period Name");

                //2ndline end date
                //If staggered end due date is sunday then take current week friday for line 2
                if DayEnum = DayEnum::Sunday then begin
                    TmpDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Staggered End Due Date");
                    IsMidWeekThirdLine := true;
                end else begin
                    if DayEnum = DayEnum::Saturday then begin
                        TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
                    end else begin
                        TmpDate := CalcDate('CW-2W+5D', AgreementSchedueRec."Staggered End Due Date");
                        IsMidWeekThirdLine := true;
                    end;
                end;
                //2ndline end date

                If IsLastAgreementLine then
                    if not IsMidWeekThirdLine then
                        AgreementEndDate := AgreementSchedueRec."Staggered End Due Date";

                if IsMidWeekThirdLine then
                    ChargeEndDate := TmpDate;
            end else begin

                if AgreementSchedueRec.new_abatementfee <> 0 then
                    ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1
                else
                    ChargeStartDate := AgreementSchedueRec.sr_feeduedate;

                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";

                if DayEnum = DayEnum::Sunday then
                    ChargeEndDate := CalcDate('CW+5D', ChargeStartDate)
                else
                    ChargeEndDate := CalcDate('CW-2D', ChargeStartDate);  //Calculate Till Friday just before Next Contract starts on Saturday. 
                DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .

                Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7;
            end;
        end;


        //MIDWEEK LINE 3 START
        if (IsMidWeekThirdLine AND CheckChargesforLine3) then begin
            //Check MidWeek Agreement 2nd line inserted
            TmpRecurringChargesRec.Reset();
            TmpRecurringChargesRec.SetRange("Source Table ID", Database::"Agreement Schedule");
            TmpRecurringChargesRec.SetRange("Source Table RecordID", AgreementSchedueRec.sr_agreementscheduleId);
            TmpRecurringChargesRec.SetRange("Auto Charge Type", SrSetup."LICENSE FEE");
            IF TmpRecurringChargesRec.Findlast() then begin
                Deposit := AgreementSchedueRec.sr_weeklylicensefee;
                ChargeStartDate := CalcDate('1D', TmpRecurringChargesRec."End Date");
                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
                GetWeekDay(DayEnum, DateForWeek."Period Name");

                TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
                If IsLastAgreementLine then
                    //AgreementEndDate := AgreementSchedueRec."Staggered End Due Date"
                    AgreementEndDate := AgreementSchedueRec."Current Agrement End Date"
                else
                    ChargeEndDate := TmpDate;

                if ChargeEndDate <> 0D then
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1
                else
                    DiffDays := 1;  // Calculate from Saturday till start of agreement dates .
                Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7;
            end;
        end;
        //MIDWEEK LINE 3 END
    end;

    //SRBC-478 Start
    local procedure CalculateDiscountRecurringChargeDtls(var AgreementSchedueRec: Record "Agreement Schedule")
    var
        IsLastAgreementLine: Boolean;
        DiffDays: Integer;
        TmpDate: Date;
    begin
        SRSETUP.Get();
        Deposit := 0;
        ChargeStartDate := 0D;
        ChargeEndDate := 0D;
        AgreementStartDate := 0D;
        AgreementEndDate := 0D;

        IsLastAgreementLine := AgreementSchedueRec.sr_IsLastRow;

        //Case 1 - Full Week Agreement dates and amount calculation - START
        If not IsMidWeekAgreement then begin
            //SRBC-478 Start
            TmpRecurringChargesRec1.Reset();
            TmpRecurringChargesRec1.SetRange("Source Table ID", Database::"Agreement Schedule");
            TmpRecurringChargesRec1.SetRange("Source Table RecordID", AgreementSchedueRec.sr_agreementscheduleId);
            TmpRecurringChargesRec1.SetRange("Auto Charge Type", SRSETUP."LICENSE FEE CONCESSION");
            IF NOT TmpRecurringChargesRec1.FindFirst() then begin
                //1st Disc Line Insert
                Deposit := AgreementSchedueRec.new_abatementfee;

                if AgreementSchedueRec.new_abatementfee <> 0 then
                    ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1
                else
                    ChargeStartDate := AgreementSchedueRec.sr_feeduedate;

                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                //ChargeEndDate := CalcDate('-1D', AgreementSchedueRec."Discount End Date");
                TmpDate := CalcDate('-1D', AgreementSchedueRec."Discount End Date");
                If IsLastAgreementLine then
                    AgreementEndDate := AgreementSchedueRec."Discount End Date"
                else
                    ChargeEndDate := TmpDate;

                if NoOfDiscDays > 7 then begin
                    //23 DEC 
                    DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Discount End Date");
                    GetWeekDay(DayEnum, DateForWeek."Period Name");
                    if DayEnum = DayEnum::Sunday then begin
                        ChargeEndDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Discount End Date");
                        //IsMidWeekDiscThirdLine := true;
                    end else begin
                        if DayEnum = DayEnum::Saturday then begin
                            ChargeEndDate := CalcDate('-1D', AgreementSchedueRec."Discount End Date");
                        end else begin
                            //If staggered end due date is mid week then take previous week friday for line 2
                            if NoOfDiscDays > 7 then begin
                                if DayEnum <> DayEnum::Friday then
                                    ChargeEndDate := CalcDate('CW-2W+5D', AgreementSchedueRec."Discount End Date")
                                else
                                    //ChargeEndDate := ((ChargeStartDate + 7) - 1);
                                    ChargeEndDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Discount End Date");
                            end;

                            // IsMidWeekDiscThirdLine := true;
                        end;
                    end;
                    //23 DEC
                    //ChargeEndDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Discount End Date");
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    NoOfDiscDays := NoOfDiscDays - DiffDays;
                    Deposit := ((AgreementSchedueRec.new_abatementfee * 7) / AgreementSchedueRec."No. of Days for Disc");
                    If IsLastAgreementLine then
                        AgreementEndDate := AgreementSchedueRec."Discount End Date";
                    if NoOfDiscDays <> 0 then
                        IsInsertSecondLine := true;
                end;

            end else begin
                ChargeStartDate := CalcDate('1D', TmpRecurringChargesRec1."End Date");
                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                ChargeEndDate := AgreementSchedueRec."Discount End Date";
                DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;
                Deposit := ((AgreementSchedueRec.new_abatementfee * DiffDays) / AgreementSchedueRec."No. of Days for Disc");
            end;
            //SRBC-478 End
            exit;
        end;
        //Case 1 - Full Week Agreement dates and amount calculation - END

        //Case 2 - Check MidWeek Agreement where end date falls on weekdays - START
        if not IsMidWeekDiscThirdLine then begin
            TmpRecurringChargesRec1.Reset();
            TmpRecurringChargesRec1.SetRange("Source Table ID", Database::"Agreement Schedule");
            TmpRecurringChargesRec1.SetRange("Source Table RecordID", AgreementSchedueRec.sr_agreementscheduleId);
            TmpRecurringChargesRec1.SetRange("Auto Charge Type", SRSETUP."LICENSE FEE CONCESSION");
            IF TmpRecurringChargesRec1.FindFirst() then begin
                Deposit := AgreementSchedueRec.new_abatementfee;
                ChargeStartDate := CalcDate('1D', TmpRecurringChargesRec1."End Date");
                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Discount End Date");
                GetWeekDay(DayEnum, DateForWeek."Period Name");
                //Insert 2nd Line of discount  in midweek case
                //If staggered end due date is sunday then take current week friday for line 2
                if NoOfDiscDays >= 7 then begin
                    if DayEnum = DayEnum::Sunday then begin
                        TmpDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Discount End Date");
                        IsMidWeekDiscThirdLine := true;
                    end else begin
                        if DayEnum = DayEnum::Saturday then begin
                            TmpDate := CalcDate('-1D', AgreementSchedueRec."Discount End Date");
                            IsMidWeekDiscThirdLine := true;//SRBC-478-05022026
                        end else begin
                            //If staggered end due date is mid week then take previous week friday for line 2
                            //SRBC-478-05022026 Start
                            // if NoOfDiscDays > 7 then
                            //     TmpDate := CalcDate('CW-2W+5D', AgreementSchedueRec."Discount End Date")
                            // else
                            //     TmpDate := ((ChargeStartDate + 7) - 1);
                            //SRBC-478-05022026 End
                            if DayEnum <> DayEnum::Friday then begin//SRBC-478-05022026
                                TmpDate := CalcDate('CW-2W+5D', AgreementSchedueRec."Discount End Date");//SRBC-478-05022026
                                IsMidWeekDiscThirdLine := true;//SRBC-478-05022026
                            end else//SRBC-478-05022026
                                    //ChargeEndDate := ((ChargeStartDate + 7) - 1);
                                TmpDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Discount End Date");
                            // IsMidWeekDiscThirdLine := true;//SRBC-478-05022026
                        end;
                    end;

                    ChargeEndDate := TmpDate;
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    if NoOfDiscDays <> 0 then
                        IsInsertSecondLine := true;
                    NoOfDiscDays := NoOfDiscDays - DiffDays;
                    Deposit := ((AgreementSchedueRec.new_abatementfee * 7) / AgreementSchedueRec."No. of Days for Disc");

                    if NoOfDiscDays <> 0 then
                        IsMidWeekDiscThirdLine := true;

                end else begin
                    ChargeEndDate := AgreementSchedueRec."Discount End Date"; //if discount is upto 7 days
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    if NoOfDiscDays <> 0 then
                        IsInsertSecondLine := true;
                    NoOfDiscDays := NoOfDiscDays - DiffDays;
                    Deposit := ((AgreementSchedueRec.new_abatementfee * DiffDays) / AgreementSchedueRec."No. of Days for Disc");

                end;
            end else begin
                //Insert first line of discount in midweek case

                if AgreementSchedueRec.new_abatementfee <> 0 then
                    ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1
                else
                    ChargeStartDate := AgreementSchedueRec.sr_feeduedate;

                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                if DayEnum = DayEnum::Sunday then
                    ChargeEndDate := CalcDate('CW+5D', ChargeStartDate)
                else
                    ChargeEndDate := CalcDate('CW-2D', ChargeStartDate); //Calculate Till Friday just before Next Contract starts on Saturday.
                if AgreementSchedueRec."Discount End Date" <> 0D then begin//SRBC-478
                    if ChargeEndDate > AgreementSchedueRec."Discount End Date" then
                        ChargeEndDate := AgreementSchedueRec."Discount End Date";
                end;//SRBC-478
                DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                NoOfDiscDays := NoOfDiscDays - DiffDays;

                Deposit := ((AgreementSchedueRec.new_abatementfee * DiffDays) / AgreementSchedueRec."No. of Days for Disc");
            end;
        end;

        if NoOfDiscDays <> 0 then begin
            //MID WEEK 3rd Discount Line
            if (IsMidWeekDiscThirdLine AND CheckDiscforLine3) then begin
                IsInsertThirdLine := true;
                TmpRecurringChargesRec1.Reset();
                TmpRecurringChargesRec1.SetRange("Source Table ID", Database::"Agreement Schedule");
                TmpRecurringChargesRec1.SetRange("Source Table RecordID", AgreementSchedueRec.sr_agreementscheduleId);
                TmpRecurringChargesRec1.SetRange("Auto Charge Type", SRSETUP."LICENSE FEE CONCESSION");
                IF TmpRecurringChargesRec1.FindLast() then begin
                    Deposit := AgreementSchedueRec.new_abatementfee;
                    ChargeStartDate := CalcDate('1D', TmpRecurringChargesRec1."End Date");
                    AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                    DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Discount End Date");
                    GetWeekDay(DayEnum, DateForWeek."Period Name");
                    TmpDate := AgreementSchedueRec."Discount End Date";
                    ChargeEndDate := TmpDate;
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    Deposit := ((AgreementSchedueRec.new_abatementfee * DiffDays) / AgreementSchedueRec."No. of Days for Disc");
                end;
            end;
            //MID WEEK discount LINE 3 END
        end;
        //Case 2 - Check MidWeek Agreement where end date falls on weekdays - END
    end;
    //SRBC-478 End

    local procedure AutoCreateRecurringChargeLine()
    var
        AutoCreateRecurringCharges: Report "Auto Create Recurring Charges";
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
        AutoCreateRecurringCharges.SetReportParameters(false, MarkRecurrinChargesRec."Start Date", MarkRecurrinChargesRec."Auto Charge Type", false); //Need to check with Abhay
        AutoCreateRecurringCharges.UseRequestPage(false);
        AutoCreateRecurringCharges.RunModal();
    end;

    local procedure AutoCreateRecurringChargeLASecurity()
    var
        AutoCreateRecurringCharges: Report "Auto Create Recurring Charges";
    begin
        SRSetup.Get();
        If NOT SRSetup."Auto Create Recurring Charge" then
            exit;
        MarkLASecurityCharges.SetRange("Entry No.");
        MarkLASecurityCharges.MarkedOnly(true);
        IF MarkLASecurityCharges.IsEmpty then
            exit;
        Commit();

        MarkLASecurityCharges.FindSet();
        AutoCreateRecurringCharges.SetTableView(MarkLASecurityCharges);
        AutoCreateRecurringCharges.SetReportParameters(false, MarkLASecurityCharges."Start Date", MarkLASecurityCharges."Auto Charge Type", false); //Need to check with Abhay
        AutoCreateRecurringCharges.UseRequestPage(false);
        AutoCreateRecurringCharges.RunModal();
    end;
    /// <summary>
    /// GetWeekDay - Get Week for a given Week Day No.
    /// </summary>
    /// <param name="WeekDay">VAR Enum "Week Selection".</param>
    /// <param name="CurrDay">Code[20].</param>
    procedure GetWeekDay(var WeekDay: Enum "Week Selection"; CurrDay: Code[20])
    begin
        Case CurrDay of
            'SUNDAY':
                WeekDay := WeekDay::Sunday;
            'MONDAY':
                WeekDay := WeekDay::Monday;
            'TUESDAY':
                WeekDay := WeekDay::Tuesday;
            'WEDNESDAY':
                WeekDay := WeekDay::Wednesday;
            'THURSDAY':
                WeekDay := WeekDay::Thursday;
            'FRIDAY':
                WeekDay := WeekDay::Friday;
            'SATURDAY':
                WeekDay := WeekDay::Saturday;
        End;
    end;

    local procedure SetWeekDay()
        WeekDayEnum: Enum "Week Selection";
    begin
        Clear(WeekDayDictionary);
        WeekDayDictionary.Add(1, WeekDayEnum::Monday);
        WeekDayDictionary.Add(2, WeekDayEnum::Tuesday);
        WeekDayDictionary.Add(3, WeekDayEnum::Wednesday);
        WeekDayDictionary.Add(4, WeekDayEnum::Thursday);
        WeekDayDictionary.Add(5, WeekDayEnum::Friday);
        WeekDayDictionary.Add(6, WeekDayEnum::Saturday);
        WeekDayDictionary.Add(7, WeekDayEnum::Sunday);
    End;

    //Salon Code Update from Dimension Values
    procedure UpdateBCLocationSalonCode(var PaymentSrBC_iRec: Record "Payments SR BC")
    var
        Agreement_lRec: Record Agreements;
        salon_lRec: Record "Salon Building";
        DimValue_lRec: Record "Dimension Value";
        DimValue2_lRec: Record "Dimension Value";
        StudioName: Text[50];
    begin
        StudioName := '';
        if format(PaymentSrBC_iRec.sr_agreementid) <> '' then begin
            Agreement_lRec.Reset();
            if Agreement_lRec.Get(PaymentSrBC_iRec.sr_agreementid) then begin
                if format(Agreement_lRec.sr_salonlocationid) <> '' then begin
                    salon_lRec.Reset();
                    salon_lRec.SetRange(sr_CRMSalonPK, Agreement_lRec.sr_salonlocationid);
                    if salon_lRec.FindFirst() then begin
                        DimValue_lRec.Reset();
                        DimValue_lRec.SetRange("Dimension Code", 'LOC');  //Salon in CRM is LOC in BC 
                        DimValue_lRec.SetRange(Name, salon_lRec.sr_Name);
                        if DimValue_lRec.FindFirst() then begin
                            StudioName := salon_lRec.sr_Name + '-' + PaymentSrBC_iRec.sr_studio;
                            PaymentSrBC_iRec."BC Location Code" := DimValue_lRec.Code;
                            if PaymentSrBC_iRec."BC Location Code" <> '' then begin
                                DimValue2_lRec.Reset();
                                DimValue2_lRec.SetRange("Dimension Code", 'STUDIO');
                                DimValue2_lRec.SetRange(Name, StudioName);
                                if DimValue2_lRec.FindFirst() then begin
                                    PaymentSrBC_iRec."BC Salon Code" := DimValue2_lRec.Code;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
}
