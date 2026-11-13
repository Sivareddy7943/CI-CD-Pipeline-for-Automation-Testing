//SRBC-232 - 20241114 - Update Stripe Payment Method ID , Stripe Cus ID , Stripe SetupIntentID , Secret Key in Banking Account Info BC Table
//SRBC-227 - 02012025 - SY - Use event OnAfterInsert of Epayment schedule for update Customer Bank Account verification status from stripe.
//SRBC-227 - 25022025 - SY - Did changes for update Next Payment Date of Epayment Schedule.
//         - 03032025 - SY - Created procedure CalculateEpaymentScheduleNextPaymentDate for calculate next charge date in epayment schedule. 
//SRBC-207 - 03012025 - SY - Procedure CreateEpaymentFromACHPayments created for Create Epayment Schedule from ACH Payment list
//                    - Added one parameter ACHPaymentList in procedure InsertEpaymentScheduleFromBankInfo for flow ID in Epayment Schedule
//                    - Added parameter ACHPaymentList in procedure - InsertTmpEpaymentFromBankInfo for assign ACH Payment List ID & Customer No. in TempEpaymentSchedule.
//                    - On trigger OnAfterInsert_ACHPaymentList flow some fields from Agreements and Customer
//SRBC-266 - 01282025 - NU - Payment Plan design change - BC 
//                    - Created functions //SRBC-303 -Auto Create Epay
//                    - InsertEpaymentScheduleFromPaymentPlan , CalculateChargesForPaymentPlan , InsertTmpEpaymentForPaymentPlan , InsertEpaymentFromPaymentPlan
//SRBC-303 - 06032025 - Used event - OnAfterInsertEvent of Epayment Schedule for Updated in Payment Plan List.
//SRBC-307 - 18032025 - SY - Update stripe bank account status in ACH Payment List on event - OnAfterInsertEvent
//                    - Flow from ACH Payment List to Epayment Schedule Stripe Bank Account Status on procedure - InsertTmpEpaymentFromBankInfo
//SRBC-325 - 18032025 - SY - Commented filter of CRM Renewal(false) in procedure CreateEpaymentFromACHPayments for production bug
//                      Used event OnAfterModifyEvent of ACH Payment List for create epayment schedule after update Current Agreement Start/End Date
//                    - Did some changes in event - OnAfterInsertEvent of ACH Payment list if Current Agreement Start/End date is blank then epayment schedule should not create.
//                    - Did changes in procedure - InsertEpaymentScheduleFromCRMRenewal if epayment schedule doesn't exist then will not create new epayment schedule.
//                    - Did changes in procedure - InsertTmpEpaymentFromCRMRenewal flow fields from ACH Payment List to Epayment schedule
//         - 29032025 - Did changes on event - OnAfterInsertEvent, OnAfterModifyEvent of ACH Payment List for skip modify event on insert time.
//SRBC-297 - SY - 20032025 - In procedure CalculateEpaymentScheduleNextPaymentDate did change for frequency-Once
//SRBC-348 - SY - 21042025 - Added event OnAfterModifyEvent of Bank Account Info for update data in ACH Payment List after create Bank Account.
//SRBC-308 - AM - 24042025 - created a procedure UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus and called it in onAfterInsertEvent of Agreemnet Payment Plan to "Updated bank acc info id","Bank Account Info ID",BC cust bank acc, Bank accout name and stipe Paymt method in Agreemnet Payment Plan
//                         - and added a condition on CreatePaymentPlan procedure to check stipe payment method status
//                29042025 - Uncommented code on onAfterInsertEvent of epayment schedule to update the field "Stripe Payment Method Status" in epayment schedule
//SRBC-360 - SY - 27052025 - Did changes on OnAfterModifyEvent of "ACH Payment List" added one filter and in procedure - CreatePaymentPlan
//SRBC-349 - SY - 03062025 - Did changes on event - OnAfterInsertEvent of Epayment Schedule for update IsBC & Customer No field 
//                           Did changes in procedure - InsertEpaymentScheduleFromCRMRenewal in filter of ExistingEpaymentSchedule
//SRBC-349 - NU - 20260627 - Code changes Added to related to AS.HighestAmount Logic
//SRBC-404 - SY - 12082025 - Did changes in procedure - InsertTmpEpaymentFromBankInfo for update frequency in Epayment Schedule
//SRBC-405 - SY - 19082025 - Did changes in procedure - InsertEpaymentScheduleFromCRMRenewal, InsertTmpEpaymentFromCRMRenewal
//SRBC-409 - 20250826 - NU - Added a new Validation Check 
//                         - if sr_typeofpaymentplan::E-Payment then only created E-Pay Schedules from Agreement Payment Plan.
//SRBC-421 - SY - 03092025 - Did changes on event - OnAfterInsertEvent "E Payment Schedule"
//SRBC-405 - JSG- 13092025 - Recurring charge end date not populating post renewal.
//                         - Added a condition in //SRBC-405 JSG 13092025 end date should not update for the same sequence for staggered case.
//                         - Did change in getting the weekly licensee fee from Agreement Schedule insted of Highest amount for creating e-payment schedule
//                         - Added filter of field sr_renewalLADocuSign as false in procedure - CreateEpaymentFromACHPayments
//SRBC-441 - SY - 24102025 - Did changes in procedure - UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus
//SRBC-443 - SY - 24102205 - Did changes in procedure - InsertTmpEpaymentFromBankInfo, InsertEpaymentScheduleFromCRMRenewal
//SRBC-447 - AM - 07112025 - Did changes in procedure - CreateEPaymentFromPaymentPlan and CreatePaymentPlan
//                         - Did changes in the event - on OnAfterModifyEvent and OnAfterInsertEvent of ACH payment list table
//SRBC-397 - SY - 03122025 - Did changes in procedure - InsertCustBankAccount for Handling Creation of Duplicate Customer bank account for Banking account created from Portal
//SRBC-463 JSG Start 18122025 - Did changes in procedure - InsertEpaymentScheduleFromPaymentPlan for updating end date in epayment schedule while creating epayment schedule from agreement payment plan
//SRBC-463 JSG Start 19122025 - Did changes in procedure - InsertEpaymentScheduleFromCRMRenewal If FindExistingEpayemntSchedule_lRec was not found with first licensee it was exiting the procedure. Changed the logic to loop through all the licensee to find the existing epayment schedule
//SRBC-463 JSG Start 22122025 - Did changes in procedure - InsertEpaymentScheduleFromCRMRenewal added Banking Account Info guid not equal to blank filter in FindExistingEpayemntSchedule_lRec
//SRBC-463 - ST - 18122025 - Did changes in procedure - OnAfterModifyEvent_ACHPaymentList and T50117_OnAfterInsertEvent not to Create E-Pay Schedules from ACH Payments for the Frequency type "Others"
//SRBC-471 - SY - Commented code on procedure - InsertEpaymentScheduleFromCRMRenewal and did changes in procedure-ProcessFullWeekPlan, ProcessMidWeekPlan
//SRBC-473 - 28012026 - SY - Did changes on event-OnAfterInsertEvent of Epayment Schedule and in procedure-InsertTmpEpaymentFromBankInfo, InsertTmpEpaymentForPaymentPlan, ProcessMidWeekPlan, ProcessFullWeekPlan
//SRBC-432 - 02042026 - SY - Created procedure-IsBankingAccountInfoAvailable for check from CRM Banking Account Info available or not in BC 
//SRBC-432 - 24042026 - SY - Added event-OnBeforeModifyEvent for update "BC Cust. Bank Account" field of "Banking Account Info" table
//SRBC-473 - 29042026 - AM - Did changes on the event OnAfterInsertEvent of ACH Payment table to update the Payment For field for Auto Charge
//SRBC-473 - 17062026 - SY - Did changes on procedure-CalculateRecurringChargeDtls before calculate ChargeStartDate, ChargeEndDate fields-sr_authorizedepaymentstartdate, "Discount End Date" must have value.
//SRBC-473 - 17062026 - SY - Did changes on ProcessMidWeekPlan, ProcessFullWeekPlan, InsertTmpEpaymentForPaymentPlan, InsertEpaymentScheduleFromCRMRenewal
//SRBC-489 - 27052026 - SY - Did changes on procedure-UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus for update Agreement Payment Plan
//SRBC-489 - 28052026 - SY - Did changes on procedure-ProcessFullWeekPlan, ProcessMidWeekPlan for update fields-sr_IsCRM, sr_IsBC during the insertion "Epayment Schedule" records.
//SRBC-493 - 08062026 - SY - Did changes on event-OnBeforeModifyEvent of "Banking Account Info" and added event-OnBeforeInsertEvent for update if field-"Setup Intent ID" is blank then field-"Stripe Verification Status" must be AwaitingStripeResponse
//SRBC-493 - 06072026 - SY - Did changes on event-OnBeforeModifyEvent/OnBeforeInsertEvent of Banking Account Info for update "Stripe Verification Status" as failed
//SRBC-473 - 24062026 - SY - Did changes on procedure-InsertEpaymentScheduleFromCRMRenewal in codeunit 50003 "Epayment Management" applied filter on Old Epayment Schedule variable for calculate & create New Epayment schedule. 
//SRBC-473 - 24062026 - SY - Did changes on prodedure-CalculateRecurringChargeForCRMRenewal, InsertTmpEpaymentFromCRMRenewal & removed extra parameter from these procedures.
//SRBC-493 - 20072026 - AM - Did changes in the procedure BankAccInfo_OnBeforeModifyEvent of OnBeforeModifyEvent of Banking account info
//SRBC-493 - 28072026 - SY - Did changes on event-OnAfterInsertEvent of "Banking Account Info" for update fields from customer bank account
//SRBC-505 - 05082026 - SY - Commented code from event-OnAfterInsertEvent & update in codeuni-50133
//SRBC-512 - 13082026 - SY - Did changes on event-OnBeforeModifyEvent, OnBeforeModifyEvent, OnAfterInsertEvent of "E Payment Schedule" for calculate share % & added some filters
//SRBC-513 - 13082026 - SY - Did changes in procedure-InsertEpaymentScheduleFromCRMRenewal added filter of inactive boolean false
//SRBC-514 - 13082026 - SY - Did changes on procedure-InsertEpaymentScheduleFromCRMRenewal 
//SRBC-515 - 13082026 - SY - Did changes on procedure-UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus added filter in EpaymentSchedule_lRec variable
//SRBC-516 - 13082026 - SY - Did changes on procedure-CalculateRecurringChargeDtls 
codeunit 90101 "Epayment Management"
{
    var
        SICU_Codeunit: Codeunit "Single Instance Mgt.";//SRBC-325 - 29032025
        ACHPaymentList_gRec: Record "ACH Payment List";//SRBC-207
        TmpEPaymentScheduleRec: Record "E Payment Schedule" temporary;
        EPaymentScheduleRec: Record "E Payment Schedule";
        MarkEPaymentScheduleRec: Record "E Payment Schedule";
        SRSetup: Record "Salon Republic Setup";
        EntryNo: Integer;
        DefaultWeekSelectionEnum: Enum "Week Selection";
        DayEnum: Enum "Week Selection";
        FullWeekEnumPaymentPlan: Enum "Week Selection";
        ChargeStartDate: Date;
        ChargeEndDate: Date;
        DateForWeek: Record Date;
        WeekDayDictionary: Dictionary of [Integer, Enum "Week Selection"];
        Deposit: Decimal;
        IsMidWeekAgreement: Boolean;
        IsPlanStartDateMidWeek: Boolean;
        IsPlanEndDateMidWeek: Boolean;
        LessThanOrEqualTo7Days: Boolean;
        AmountWithConvFee: Decimal;
        IsCreatedFromBankInfo_gBln: Boolean;
        ChargesLineCount: Integer;
        SelectChargeDate: Boolean;
        AgreementStartDate: Date;
        AgreementEndDate: Date;
        IsMidWeekThirdLine: Boolean;
        IsFullWeekSecondLine: Boolean;
        Is7DaysSecondLine: Boolean;
        CheckChargesforLine3: Boolean;
        IsStaggeredEnDDateMidWeek: Boolean;
        //SRBC-175
        SharePercent_gDec: Decimal;
        TotalAmountShare_gDec: Decimal;
        CustNo_gCod: Code[20];
        Agreement_gRec: Record Agreements;
        //BankAccountGuid_gGui: Guid;//SRBC-207//SRBC-441 JSG 29102025
        //CustBankAccountNo_gCod: Code[20];//SRBC-441 JSG 29102025
        SharePercentage: Decimal;
        DifferenceofDays: Integer;
        IsFirstLine: Text;
        FirstLineInsert: Boolean;
        EndDateFirstLine: Date;
        StartDateFirstLine: Date;
        SharePercentageForFirstLine: Decimal;
        TotalAmountShareForFirstLine: Decimal;
        FindLastExistingEpayemntSchedule: Record "E Payment Schedule";
        AgreementPaymentPlan: Record "Agreement Payment Plan";
        SharePercentageForRemewal: Decimal; //SRBC-405 JSG 19092025
        SharePercentage_Diffday: Decimal; //SRBC-405 JSG 19092025

    //SRBC-349 04082025 Start
    [EventSubscriber(ObjectType::Table, Database::"E Payment Schedule", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModifyEvent_EpaymentSchedule(var Rec: Record "E Payment Schedule"; RunTrigger: Boolean)
    var
        CustomerBankAccount_lRec: Record "Customer Bank Account";
        Customer_lRec: Record Customer;
        BankingAccInfo: Record "Banking Account Info";
        AgreementList: Record Agreements;//SRBC-512
        CRMIntegrationMgmt: Codeunit "CRM Integration Management";//SY-06022026
        // EpaymentDataverse: Record "CDS sr_autoepayment";//SY-06022026 //PS_16102026
        //SRBC-512 AM 29042026 Start
        SalonSetup: Record "Salon Republic Setup";
        RecurringChargeList: Record "Recurring Charges";
        SharePercentage_lDec: Decimal;
        //SRBC-512 AM 29042026 End
        AutoCharge: Record "Auto Charge";//SRBC-473
    begin
        SalonSetup.Get();//SRBC-512 AM 29042026
        CustomerBankAccount_lRec.Reset();
        CustomerBankAccount_lRec.SetRange("Bank Account Info", Rec."Banking Account Info");
        if CustomerBankAccount_lRec.FindFirst() then begin
            Rec.Validate("BC Cust. Bank Account", CustomerBankAccount_lRec.Code);
            Rec.Validate("Stripe Payment Method Status", CustomerBankAccount_lRec."Verification Status");
        end;
        if BankingAccInfo.Get(UpperCase(Rec."Banking Account Info")) then
            Rec.Validate(Account, BankingAccInfo.sr_accountname);
        Customer_lRec.Reset();
        Customer_lRec.SetRange("CRM Agreement ID", Rec."Agreement ID");
        if Customer_lRec.FindFirst() then begin
            Rec.Validate("Customer No.", Customer_lRec."No.");
            Rec.Validate("Customer Name", Customer_lRec.Name);
        end;
        //SRBC-512 Start
        //SRBC-512 AM Start 29042026
        // if Rec."Payment For" = Rec."Payment For"::"License Fee - Payment" then
        // if not Rec.sr_IsBC then
        //     if AgreementList.Get(Rec."Agreement ID") then
        //         if (Rec.Amount <> 0) and (AgreementList."Current Rent Rate" <> 0) then
        //             Rec.Validate("Share %", (Rec.Amount / AgreementList."Current Rent Rate") * 100);
        if (Rec."Payment For" = SalonSetup."LICENSE FEE") and (Rec.Frequency = Rec.Frequency::Weekly) then begin //SRBC-512 AM 29042026
            if not Rec.sr_IsBC then begin
                RecurringChargeList.Reset();
                RecurringChargeList.SetRange("Agreement ID", Rec."Agreement ID");
                RecurringChargeList.SetRange(Frequency, RecurringChargeList.Frequency::Weekly);
                //SRBC-512 Start
                RecurringChargeList.SetFilter("End Date", '>=%1|%2', Rec."Start Date", 0D);
                if Rec."End Date" <> 0D then
                    RecurringChargeList.SetFilter("Start Date", '<=%1', Rec."End Date")
                else
                    RecurringChargeList.SetFilter("Start Date", '<=%1', Rec."Start Date");
                // RecurringChargeList.SetFilter("Start Date", '>=%1|%2', Today, 0D);
                //SRBC-512 End
                // Charge.StartDate <= Payment.EndDate
                // AND
                // Charge.EndDate >= Payment.StartDate
                RecurringChargeList.SetRange(Inactive, false);
                RecurringChargeList.SetRange("Auto Charge Type", SalonSetup."LICENSE FEE");
                RecurringChargeList.SetCurrentKey("Start Date");
                RecurringChargeList.Ascending(true);
                if RecurringChargeList.FindSet() then
                    repeat
                        if RecurringChargeList."End Date" <> 0D then begin
                            if RecurringChargeList."End Date" - RecurringChargeList."Start Date" >= 7 then
                                if (Rec.Amount <> 0) and (RecurringChargeList.Amount <> 0) then begin
                                    if Rec."Share %" = 0 then begin//SRBC-512 18062026
                                        Rec.Validate("Share %", (Rec.Amount / RecurringChargeList.Amount) * 100);
                                        SharePercentage_lDec := Rec."Share %";
                                    end;//SRBC-512 18062026
                                end;
                        end else
                            if (Rec.Amount <> 0) and (RecurringChargeList.Amount <> 0) then begin
                                if Rec."Share %" = 0 then begin//SRBC-512 18062026
                                    Rec.Validate("Share %", (Rec.Amount / RecurringChargeList.Amount) * 100);
                                    SharePercentage_lDec := Rec."Share %";
                                end;//SRBC-512 18062026
                            end;
                    until (SharePercentage_lDec <> 0) or (RecurringChargeList.Next() = 0);
            end;
        end;
        //SRBC-512 AM 17082026
        if Rec."Payment For" = SalonSetup."Payment Plan" then begin
            Rec.validate("Payment Plan", True);
        end;
        if Rec."Payment For" <> SalonSetup."Payment Plan" then begin
            Rec.validate("Payment Plan", false);
        end;
        //SRBC-512 AM 17082026
        //SRBC-473 Start
        if not IsNullGuid(Rec."Payment For Id") then begin
            AutoCharge.Reset();
            AutoCharge.SetRange(sr_autochargetypeId, Rec."Payment For Id");
            if AutoCharge.FindFirst() then
                Rec.Validate("Payment For", AutoCharge.Code);
        end;
        //SRBC-473 End 29042026
    end;
    //SRBC-349 04082025 End

    //SRBC-227 Start -SY - 02/01/2025
    [EventSubscriber(ObjectType::Table, Database::"E Payment Schedule", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertEvent_EpaymentSchedule(var Rec: Record "E Payment Schedule"; RunTrigger: Boolean)
    var
        CustomerBankAccount_lRec: Record "Customer Bank Account";
        EpaymentSchedule_lRec: Record "E Payment Schedule";
        ACHPaymentList_lRec: Record "ACH Payment List";
        // AutoCreateEpaymentJournal_lRep: Report 50012; //PS_16102026
        NextPaymentDate: Date;
        AgreementPaymentPlan_lRec: Record "Agreement Payment Plan";//SRBC-303
        Customer_lRec: Record Customer;//SRBC-349
        IsHandled: Boolean;//SRBC-349
        AgreementSchedule_lRec: Record "Agreement Schedule";//SRBC-349
        BankingAccInfo: Record "Banking Account Info";//SRBC-349 04082025
        Month: Integer;//SRBC-421
        DateForWeek: Record Date;//SRBC-421
        AutoCharge: Record "Auto Charge";//SRBC-473
        AgreementList: Record Agreements;//SRBC-512
        SalonSetup: Record "Salon Republic Setup"; //SRBC-512 2904206
        RecurringChargeList: Record "Recurring Charges"; //SRBC-512 2904206
        SharePercentage_lDec: Decimal; //SRBC-512 29042026
    begin
        //SRBC-349 Start
        // if Rec.sr_IsCRM then begin//SRBC-349 04082025
        Clear(BankingAccInfo);
        Clear(CustomerBankAccount_lRec);
        CustomerBankAccount_lRec.Reset();
        CustomerBankAccount_lRec.SetRange("Bank Account Info", Rec."Banking Account Info");
        if CustomerBankAccount_lRec.FindFirst() then begin
            IsHandled := true;
            Rec.Validate("BC Cust. Bank Account", CustomerBankAccount_lRec.Code);
            // Rec.Validate(Account, CustomerBankAccount_lRec.Name);//SRBC-349 04082025
            Rec.Validate("Stripe Payment Method Status", CustomerBankAccount_lRec."Verification Status");
        end;
        if BankingAccInfo.Get(UpperCase(Rec."Banking Account Info")) then//SRBC-349 04082025
            Rec.Validate(Account, BankingAccInfo.sr_accountname);//SRBC-349 04082025
        // end;//SRBC-349 04082025
        //SRBC-349 - End
        IsHandled := false;//SRBC-349
        if (Rec."Source Table ID" <> 0) and (not IsNullGuid(Rec."Source Table RecordID")) then begin
            Rec.Validate(sr_IsBC, true);
            IsHandled := true;
        end;
        Customer_lRec.Reset();
        Customer_lRec.SetRange("CRM Agreement ID", Rec."Agreement ID");
        if Customer_lRec.FindFirst() then begin
            // if Customer_lRec.get(Rec."Agreement ID") then begin
            Rec.Validate("Customer No.", Customer_lRec."No.");
            Rec.Validate("Customer Name", Customer_lRec.Name);//SRBC-349 - 04082025
            IsHandled := true;
        end;
        //SRBC-349 End

        //SRBC-207 Start After insert data in epayment schedule from ACH Payment List Boolean "Epayment Schedule Created" must be true.
        if not IsNullGuid(Rec."ACH Payment ID") then begin
            ACHPaymentList_lRec.Reset();
            ACHPaymentList_lRec.SetRange("ACH Payments ID", Rec."ACH Payment ID");
            if ACHPaymentList_lRec.FindFirst() then begin
                if not ACHPaymentList_lRec."Epayment Schedule Created" then begin
                    ACHPaymentList_lRec."Epayment Schedule Created Date" := Today;//07012025
                    ACHPaymentList_lRec."Epayment Schedule Created Time" := Time;//07012025
                    ACHPaymentList_lRec."Epayment Schedule Created" := true;
                    ACHPaymentList_lRec.Modify(false);//SRBC-325
                end;
            end;
        end;
        //SRBC-207 End

        //SRBC-303 Start
        if not IsNullGuid(Rec."Payment Plan ID") then begin
            AgreementPaymentPlan_lRec.Reset();
            AgreementPaymentPlan_lRec.SetRange(sr_AgreementPaymentPlanId, Rec."Payment Plan ID");
            if AgreementPaymentPlan_lRec.FindFirst() then begin
                if not AgreementPaymentPlan_lRec."Epayment Schedule Created" then begin
                    AgreementPaymentPlan_lRec.Validate("Epayment Created DateTime", CurrentDateTime);
                    AgreementPaymentPlan_lRec.Validate("Epayment Created By", UserId);
                    AgreementPaymentPlan_lRec.Validate("Epayment Schedule Created", true);
                    AgreementPaymentPlan_lRec.Modify();
                end;
            end;
        end;
        //SRBC-303 End

        //SRBC-349 Start
        if not IsNullGuid(Rec."Agreement Schedule ID") then begin
            AgreementSchedule_lRec.Reset();
            AgreementSchedule_lRec.SetRange(sr_agreementscheduleId, Rec."Agreement Schedule ID");
            if AgreementSchedule_lRec.FindFirst() then begin
                if not AgreementSchedule_lRec."Epayment Schedule Created" then begin
                    AgreementSchedule_lRec.Validate("Epayment Schedule Created Date", today);
                    AgreementSchedule_lRec.Validate("Epayment Schedule Created Time", Time);
                    AgreementSchedule_lRec.Validate("Epayment Schedule Created", true);
                    AgreementSchedule_lRec.Modify();
                end;
            end;
        end;
        //SRBC-349 End

        CustomerBankAccount_lRec.Reset();
        CustomerBankAccount_lRec.SetRange("Bank Account Info", Rec."Banking Account Info");
        CustomerBankAccount_lRec.SetRange(Code, Rec."BC Cust. Bank Account");
        if CustomerBankAccount_lRec.FindFirst() then begin
            EpaymentSchedule_lRec.Reset();
            if EpaymentSchedule_lRec.Get(Rec."Entry No.") then begin
                //SRBC-307 Start
                // if CustomerBankAccount_lRec."Verification Status" <> EpaymentSchedule_lRec."Stripe Payment Method Status" then
                Rec.Validate("BC Cust. Bank Account", CustomerBankAccount_lRec.Code);//SRBC-349
                Rec.Validate(Account, CustomerBankAccount_lRec.Name);//SRBC-349
                Rec.Validate("Stripe Payment Method Status", CustomerBankAccount_lRec."Verification Status");//SRBC-308
                IsHandled := true;//SRBC-349
                //SRBC-307 End
                //SRBC-227 25022025 Start
                if Rec."Start Date" < Today then begin
                    if Rec."End Date" = 0D then begin
                        Rec.Validate("Next Charge Date", CalculateEpaymentScheduleNextPaymentDate(Rec));
                    end else begin
                        NextPaymentDate := CalculateEpaymentScheduleNextPaymentDate(Rec);
                        if NextPaymentDate < Rec."End Date" then begin
                            Rec.Validate("Next Charge Date", NextPaymentDate);
                        end else
                            Rec.Validate(Inactive, true);
                    end;
                end;
                // Rec.Modify();//SRBC-349
                //SRBC-227 25022025 End
            end;
        end;
        //SRBC-421 Start
        Month := 0;
        IF DateForWeek.Get(DateForWeek."Period Type"::Date, Rec."Start Date") then
            GetWeekDay(Rec."Due Day", DateForWeek."Period Name");
        if Rec.sr_IsBC then begin
            IsHandled := true;
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
        if (Rec."Payment For" = SalonSetup."LICENSE FEE") and (Rec.Frequency = Rec.Frequency::Weekly) then begin //SRBC-512 AM 29042026
            if not Rec.sr_IsBC then begin
                RecurringChargeList.Reset();
                RecurringChargeList.SetRange("Agreement ID", Rec."Agreement ID");
                RecurringChargeList.SetRange(Frequency, RecurringChargeList.Frequency::Weekly);
                //SRBC-512 Start
                // RecurringChargeList.SetFilter("Start Date", '<=%1', Rec."Start Date");
                // if Rec."End Date" <> 0D then
                //     RecurringChargeList.SetFilter("End Date", '>=%1', Rec."End Date")
                // else
                //     RecurringChargeList.SetFilter("End Date", '>=%1|%2', Today, 0D);
                RecurringChargeList.SetFilter("End Date", '>=%1|%2', Rec."Start Date", 0D);
                if Rec."End Date" <> 0D then
                    RecurringChargeList.SetFilter("Start Date", '<=%1', Rec."End Date")
                else
                    RecurringChargeList.SetFilter("Start Date", '<=%1', Rec."Start Date");
                //SRBC-512 End
                RecurringChargeList.SetRange(Inactive, false);
                RecurringChargeList.SetRange("Auto Charge Type", SalonSetup."LICENSE FEE");
                RecurringChargeList.SetCurrentKey("Start Date");
                RecurringChargeList.Ascending(true);
                if RecurringChargeList.FindSet() then
                    repeat
                        if RecurringChargeList."End Date" <> 0D then
                            if RecurringChargeList."End Date" - RecurringChargeList."Start Date" >= 7 then
                                if (Rec.Amount <> 0) and (RecurringChargeList.Amount <> 0) then begin
                                    if Rec."Share %" = 0 then begin//SRBC-512 18062026
                                        Rec.Validate("Share %", (Rec.Amount / RecurringChargeList.Amount) * 100);
                                        SharePercentage_lDec := Rec."Share %";
                                    end;//SRBC-512 18062026
                                end;
                    until (SharePercentage_lDec <> 0) or (RecurringChargeList.Next() = 0);
            end;
        end;
        //SRBC-512 AM 17082026
        if Rec."Payment For" = SalonSetup."Payment Plan" then begin
            Rec.validate("Payment Plan", True);
            IsHandled := true;
        end;
        if Rec."Payment For" <> SalonSetup."Payment Plan" then begin
            Rec.validate("Payment Plan", false);
            IsHandled := true;
        end;
        //SRBC-512 AM 17082026
        //SRBC-473 AM End 29042026
        if not IsNullGuid(Rec."Payment For Id") then begin
            AutoCharge.Reset();
            AutoCharge.SetRange(sr_autochargetypeId, Rec."Payment For Id");
            if AutoCharge.FindFirst() then begin
                Rec.Validate("Payment For", AutoCharge.Code);
                IsHandled := true;
            end;
        end;
        //SRBC-473 End 29042026
        if IsHandled then//SRBC-349
            Rec.Modify();//SRBC-349
    end;
    //SRBC-227 End

    //SRBC-348 - Start
    [EventSubscriber(ObjectType::Table, Database::"ACH Payment List", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModifyEvent_ACHPaymentList(var Rec: Record "ACH Payment List"; RunTrigger: Boolean)
    var
        CustBankAcc: Record "Customer Bank Account";
        AutoCharge: Record "Auto Charge";//SRBC-473 05052026
    begin
        CustBankAcc.Reset();
        CustBankAcc.SetRange("Bank Account Info", Rec."Bank Account Info ID");
        CustBankAcc.SetRange("License ID", Rec."License ID");
        CustBankAcc.SetRange(Code, Rec."BC Cust. Bank Account");
        if CustBankAcc.FindFirst() then
            Rec.Validate("Stripe Payment Method Status", CustBankAcc."Verification Status");
        //SRBC-473 Start 05052026 
        if not IsNullGuid(Rec."Payment For Id") then begin
            AutoCharge.Reset();
            AutoCharge.SetRange(sr_autochargetypeId, Rec."Payment For Id");
            if AutoCharge.FindFirst() then
                Rec.Validate("Payment For", AutoCharge.Code);
        end;
        //SRBC-473 End 05052026
    end;
    //SRBC-348 - End
    //SRBC-325 Start
    [EventSubscriber(ObjectType::Table, Database::"ACH Payment List", 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterModifyEvent_ACHPaymentList(var Rec: Record "ACH Payment List"; RunTrigger: Boolean)
    var
        Variant: Variant;
        CustBankAcc: Record "Customer Bank Account";
        ACHPaymentList_lRec: Record "ACH Payment List";
    begin
        //SRBC-325 - 29032025 Start
        if not SICU_Codeunit.CheckOnAfterInsertOfACHPaymentList() then begin
            //SRBC-325 - 29032025 End
            //SRBC-447 Start
            SRSetup.Get();
            if not srsetup."Create Epay From Bank Info" then
                exit;
            //SRBC-447 End
            //SRBC-463 Start
            if Rec."Authorized E-Payment Frequency" = Rec."Authorized E-Payment Frequency"::Other then
                exit;
            //SRBC-463 End
            CustBankAcc.Reset();
            CustBankAcc.SetRange("Bank Account Info", Rec."Bank Account Info ID");
            CustBankAcc.SetRange("License ID", Rec."License ID");
            CustBankAcc.SetRange(Code, Rec."BC Cust. Bank Account");
            if CustBankAcc.FindFirst() then begin
                Rec.Validate("Stripe Payment Method Status", CustBankAcc."Verification Status");
                ACHPaymentList_lRec.Reset();
                if ACHPaymentList_lRec.Get(Rec."Entry No.", Rec."ACH Payments ID") then begin
                    if CustBankAcc."Verification Status" = 'active' then begin
                        Variant := ACHPaymentList_lRec;
                        //SRBC-447 Start
                        // if (ACHPaymentList_lRec."Current Agreement Start Date" <> 0D) and (ACHPaymentList_lRec."Current Agreement End Date" <> 0D) then begin
                        if (ACHPaymentList_lRec."Current Agreement Start Date" <> 0D) and (ACHPaymentList_lRec."Current Agreement End Date" <> 0D) and (ACHPaymentList_lRec.sr_authorizedepaymentstartdate <> 0DT) and (ACHPaymentList_lRec."Customer No." <> '')
                        and (not IsNullGuid(ACHPaymentList_lRec."Bank Account Info ID")) and (ACHPaymentList_lRec."BC Cust. Bank Account" <> '') and (ACHPaymentList_lRec."Stripe Payment Method Status" = 'active') and (not IsNullGuid(ACHPaymentList_lRec."License ID"))
                        and (not IsNullGuid(ACHPaymentList_lRec."Agreement ID")) then begin
                            if (ACHPaymentList_lRec."Authorized E-Payment Frequency" = ACHPaymentList_lRec."Authorized E-Payment Frequency"::Monthly) or (ACHPaymentList_lRec."Authorized E-Payment Frequency" = ACHPaymentList_lRec."Authorized E-Payment Frequency"::Weekly) then
                                //SRBC-447 End
                                if not ACHPaymentList_lRec."Epayment Schedule Created" then begin
                                    if Rec."Epayment Schedule Created Date" = 0D then begin
                                        if Rec."Authorized E-Payment Amount" <> 0 then begin//SRBC-360 Start
                                            CreateEpaymentFromACHPayments(ACHPaymentList_lRec."Agreement ID", Variant);
                                            UpdateAnticipatedEndDateInEpayment(ACHPaymentList_lRec);
                                        end;//SRBC-360 End
                                    end;
                                end;
                        end;
                    end;
                end;
            end;
        end;//SRBC-325 - 29032025
    end;
    //SRBC-325 End

    [EventSubscriber(ObjectType::Table, Database::"ACH Payment List", 'OnAfterInsertEvent', '', false, false)]
    local procedure T50117_OnAfterInsertEvent(var Rec: Record "ACH Payment List"; RunTrigger: Boolean)
    var
        Variant: Variant;
        Agreement_lRec: Record Agreements;
        Cust: Record Customer;
        CustBankAccPar: Code[20];
        srsetup: Record "Salon Republic Setup";
        CustBankAcc: Record "Customer Bank Account";
        BankAccInfo: Record "Banking Account Info";
        Epaymentschedule: Record "E Payment Schedule";
        ACHPaymentList_lRec: Record "ACH Payment List";//SRBC-307
        AutoCharge: Record "Auto Charge";//SRBC-473
    begin
        //SRBC-325 - 29032025 Start
        SICU_Codeunit.OnAfterInsertOfACHPaymentList(true);
        //SRBC-325 - 29032025 End
        //SRBC-207 Start - 07012025
        srsetup.Get();
        Agreement_lRec.Reset();
        if Agreement_lRec.Get(Rec."Agreement ID") then begin
            Rec.Validate(Salon, Agreement_lRec.sr_salonlocationid);
            Rec.Validate(Studio, Agreement_lRec."Studio 1");
            Rec.Validate("Current Agreement Start Date", Agreement_lRec."Current Agreement Start Date");
            Rec.Validate("Current Agreement End Date", Agreement_lRec."Current Agreement End Date");
            if Cust.Get(Agreement_lRec."Customer Code") then begin
                if NOT IsNullGuid(Rec."Agreement ID") then begin
                    Rec.Validate("Customer No.", Cust."No.");
                    Rec.Validate("Customer Name", Cust.Name);
                end;
            end;

            if BankAccInfo.Get(Rec."Bank Account Info ID") then begin
                Rec."BC Cust. Bank Account" := BankAccInfo."BC Cust. Bank Account";
                Rec.sr_accountname := BankAccInfo.sr_accountname;
            end;
            // Rec.Modify(); //SRBC-473 29042026
        end;
        //SRBC-207 End
        //SRBC-473 Start 29042026
        if not IsNullGuid(Rec."Payment For Id") then begin
            AutoCharge.Reset();
            AutoCharge.SetRange(sr_autochargetypeId, Rec."Payment For Id");
            if AutoCharge.FindFirst() then
                Rec.Validate("Payment For", AutoCharge.Code);
        end;
        //SRBC-473 End 29042026
        if not srsetup."Create Epay From Bank Info" then
            exit;
        //SRBC-463 Start    
        if Rec."Authorized E-Payment Frequency" = Rec."Authorized E-Payment Frequency"::Other then
            exit;
        //SRBC-463 End
        //rec.freq = rec.fre::others then exit;
        CustBankAcc.Reset(); //SRBC-307
        CustBankAcc.SetRange("Bank Account Info", Rec."Bank Account Info ID"); //SRBC-307
        CustBankAcc.SetRange("License ID", Rec."License ID"); //SRBC-307
        CustBankAcc.SetRange(Code, Rec."BC Cust. Bank Account"); //SRBC-307
        if CustBankAcc.FindFirst() then begin //SRBC-307
            Rec.Validate("Stripe Payment Method Status", CustBankAcc."Verification Status"); //SRBC-307
            // Rec.Modify();//SRBC-307//SRBC-473
            ACHPaymentList_lRec.Reset();//SRBC-307
            if ACHPaymentList_lRec.Get(Rec."Entry No.", Rec."ACH Payments ID") then begin
                Variant := ACHPaymentList_lRec;//SRBC-307
                if CustBankAcc."Verification Status" = 'active' then begin //SRBC-307
                    if ACHPaymentList_lRec."Authorized E-Payment Amount" <> 0 then begin
                        //SRBC-447 Start
                        // if (ACHPaymentList_lRec."Current Agreement Start Date" <> 0D) and (ACHPaymentList_lRec."Current Agreement End Date" <> 0D) then begin//SRBC-325
                        if (ACHPaymentList_lRec."Current Agreement Start Date" <> 0D) and (ACHPaymentList_lRec."Current Agreement End Date" <> 0D) and (ACHPaymentList_lRec.sr_authorizedepaymentstartdate <> 0DT) and (ACHPaymentList_lRec."Customer No." <> '')
                        and (not IsNullGuid(ACHPaymentList_lRec."Bank Account Info ID")) and (ACHPaymentList_lRec."BC Cust. Bank Account" <> '') and (ACHPaymentList_lRec."Stripe Payment Method Status" = 'active') and (not IsNullGuid(ACHPaymentList_lRec."License ID"))
                        and (not IsNullGuid(ACHPaymentList_lRec."Agreement ID")) then begin
                            if (ACHPaymentList_lRec."Authorized E-Payment Frequency" = ACHPaymentList_lRec."Authorized E-Payment Frequency"::Monthly) or (ACHPaymentList_lRec."Authorized E-Payment Frequency" = ACHPaymentList_lRec."Authorized E-Payment Frequency"::Weekly) then begin
                                CreateEpaymentFromACHPayments(ACHPaymentList_lRec."Agreement ID", Variant);
                                UpdateAnticipatedEndDateInEpayment(ACHPaymentList_lRec);
                            end;//SRBC-447 End
                        end;//SRBC-325
                    end;//SRBC-307
                end;//SRBC-307
            end;//SRBC-307
        end;
        //SRBC-325 - 29032025 Start
        Rec.Modify();//SRBC-473 //NT 23062026
        SICU_Codeunit.OnAfterInsertOfACHPaymentList(false);
        //SRBC-325 - 29032025 End
    end;


    [EventSubscriber(ObjectType::Table, Database::"Banking Account Info", 'OnAfterInsertEvent', '', true, true)]
    local procedure T50013_OnAfterInsertEvent(var Rec: Record "Banking Account Info"; RunTrigger: Boolean)
    var
        Variant: Variant;
        Agreement_lRec: Record Agreements;
        Cust: Record Customer;
        CustBankAccPar: Code[20];
        srsetup: Record "Salon Republic Setup";
        CustBankAcc: Record "Customer Bank Account";
        BankAccInfo: Record "Banking Account Info";
        Epaymentschedule: Record "E Payment Schedule";
        // JQMgmnt: Codeunit "Job Queue Events"; //PS_16102026
        CurrDateTimeVar: DateTime;//SRBC-505
    begin
        //SRBC-505 Start Commented this code & created new codeunit-50133 & pasted there this code
        //SRBC-207
        // If Bank acc info comes without Agreement ID
        // if NOT Rec.sr_OneTimePayment then begin
        //     InsertCustBankAccount(CustBankAccPar, Rec."BC Customer Code", Agreement_lRec."Agreement ID", Rec);
        //     Rec.Validate("BC Cust. Bank Account", CustBankAccPar);
        //     CustBankAcc.Reset();
        //     //CustBankAcc.SetRange("Customer No.", Rec."BC Customer Code");
        //     CustBankAcc.SetRange(Code, Rec."BC Cust. Bank Account");
        //     CustBankAcc.SetRange("Bank Account Info", Rec.sr_bankingaccountinfoId);
        //     CustBankAcc.SetRange("License ID", Rec.sr_licenseeid);
        //     //CustBankAcc.SetRange("Agreement ID", Rec.sr_agreement);
        //     if CustBankAcc.FindFirst() then begin
        //         Rec.Validate(sr_StripePaymentMethodId, CustBankAcc."Payment Method ID2");
        //         Rec.Validate(sr_StripeCustomerId, CustBankAcc."Stripe Customer ID2");
        //         Rec.Validate(sr_StripeSetupIntentId, CustBankAcc."Setup Intent ID2");
        //         Rec.Validate(sr_StripeSecret, CustBankAcc."Card URL2");
        //         Rec.Validate(IsStripeVerified, true);
        //         //SRBC-493 Start 27072026
        //         Rec.Validate("Setup Intent Status", CustBankAcc."Setup Intent Status");
        //         Rec.Validate("Stripe Mandate Status", CustBankAcc."Mandate Status");
        //         Rec.Validate("Stripe Mandate Id", CustBankAcc."Stripe Mandate ID");
        //         Rec.Validate("Stripe Finger Print ID", CustBankAcc."Stripe Finger Print ID");
        //         //SRBC-493 End 27072026
        //     end;
        //     //SRBC-232
        //     Rec.Validate(sr_SyncedToBC, true);
        //     Rec.Modify();
        // end;
        // JQMgmnt.RestartBankingAccInfoJQ();
        CurrDateTimeVar := CurrentDateTime + 3000;
        TaskScheduler.CreateTask(Codeunit::"Banking Account Info Sync", 0, true, CompanyName, CurrDateTimeVar, Rec.RecordId);
        //SRBC-505 End 
    end;
    //SRBC-207 - 09012025
    procedure UpdateAnticipatedEndDateInEpayment(ACHPayments: Record "ACH Payment List")
    var
        EpaymentSchedule_lRec: Record "E Payment Schedule";
        EpaymentSchedule: Record "E Payment Schedule";
    Begin
        EpaymentSchedule_lRec.Reset();
        EpaymentSchedule_lRec.SetRange("Agreement ID", ACHPayments."Agreement ID");
        EpaymentSchedule_lRec.SetRange("License ID", ACHPayments."License ID");

        if EpaymentSchedule_lRec.FindLast() then begin
            EpaymentSchedule.Reset();
            if EpaymentSchedule.Get(EpaymentSchedule_lRec."Entry No.") then begin
                if EpaymentSchedule."Payment Anticipated End Date" = 0D then begin
                    EpaymentSchedule."Payment Anticipated End Date" := ACHPayments."Current Agreement End Date";
                    EpaymentSchedule.Modify();
                end;
            end;
        end;
    end;


    procedure InsertEpaymentScheduleFromBankInfo(var Variant: Variant; var ReccCharges_iRec: record "Recurring Charges"; var AS: Record "Agreement Schedule"; ACHPaymentList: Record "ACH Payment List")
    //SRBC-207
    var
        RecRef: RecordRef;
        BankAccountInfo: Record "Banking Account Info";
        Frquency: Enum "Recurring Charge Frequency";
        ReccuringCharges: Record "Recurring Charges";
        SalonRepublicSetup: Record "Salon Republic Setup";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Banking Account Info":
                begin
                    ACHPaymentList_gRec := ACHPaymentList;
                    BankAccountInfo := Variant;
                    AmountWithConvFee := 0;
                    SalonRepublicSetup.Get();
                    SalonRepublicSetup.TestField("Convenience Fee");
                    AmountWithConvFee := SalonRepublicSetup."Convenience Fee";

                    EntryNo := 0;
                    IsMidWeekAgreement := false;
                    TmpEPaymentScheduleRec.Reset();
                    TmpEPaymentScheduleRec.DeleteAll();
                    DefaultWeekSelectionEnum := DefaultWeekSelectionEnum::Saturday;

                    if DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate) > AS.sr_feeduedate then begin
                        //SRBC-207 - SY - 09012025 Start

                        IF DateForWeek.Get(DateForWeek."Period Type"::Date, DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate)) then
                            GetWeekDay(DayEnum, DateForWeek."Period Name");
                    end else begin
                        IF DateForWeek.Get(DateForWeek."Period Type"::Date, AS.sr_feeduedate) then
                            GetWeekDay(DayEnum, DateForWeek."Period Name");
                    end;

                    IsMidWeekAgreement := DayEnum <> DefaultWeekSelectionEnum;

                    if not AS.sr_IsLastRow then begin
                        if not IsMidWeekAgreement then begin
                            IF DateForWeek.Get(DateForWeek."Period Type"::Date, (AS."Staggered End Due Date")) then begin
                                GetWeekDay(DayEnum, DateForWeek."Period Name");
                                IsMidWeekAgreement := DayEnum <> DefaultWeekSelectionEnum;
                                IsStaggeredEnDDateMidWeek := true;
                            end;

                        end;

                    end;

                    //If Full Week Agreement
                    If Not IsMidWeekAgreement then begin

                        if not IsCreatedFromBankInfo_gBln then
                            CalculateRecurringChargeDtls(BankAccountInfo, AS, ACHPaymentList)
                        else
                            CalculateChargesFromBankAccInfo(BankAccountInfo, AS, ACHPaymentList);


                        InsertTmpEpaymentFromBankInfo(BankAccountInfo, ReccCharges_iRec, AS, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 0, ACHPaymentList);
                        InsertEpayment();
                        exit;
                    end;

                    IsMidWeekThirdLine := false;
                    CheckChargesforLine3 := false;
                    //Mid Week Agreement - 1st Line
                    if not IsCreatedFromBankInfo_gBln then
                        CalculateRecurringChargeDtls(BankAccountInfo, AS, ACHPaymentList)
                    else
                        CalculateChargesFromBankAccInfo(BankAccountInfo, AS, ACHPaymentList);

                    InsertTmpEpaymentFromBankInfo(BankAccountInfo, ReccCharges_iRec, AS, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 1, ACHPaymentList);


                    //Mid Week Agreement - 2nd Line
                    if not IsCreatedFromBankInfo_gBln then
                        CalculateRecurringChargeDtls(BankAccountInfo, AS, ACHPaymentList)
                    else
                        CalculateChargesFromBankAccInfo(BankAccountInfo, AS, ACHPaymentList);

                    InsertTmpEpaymentFromBankInfo(BankAccountInfo, ReccCharges_iRec, AS, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 2, ACHPaymentList);
                    if not IsMidWeekThirdLine then
                        InsertEpayment();

                    //Midweek agreement - 3line
                    if IsMidWeekThirdLine then begin
                        CheckChargesforLine3 := true;
                        if not IsCreatedFromBankInfo_gBln then
                            CalculateRecurringChargeDtls(BankAccountInfo, AS, ACHPaymentList)
                        else
                            CalculateChargesFromBankAccInfo(BankAccountInfo, AS, ACHPaymentList);

                        InsertTmpEpaymentFromBankInfo(BankAccountInfo, ReccCharges_iRec, AS, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 3, ACHPaymentList);
                        InsertEpayment();
                    end;
                end;
        end;
    end;
    //SRBC-207 Start Added extra parameter ACHPaymentList
    local procedure CalculateRecurringChargeDtls(var BankAccInfo: Record "Banking Account Info"; var AgreementSchedueRec: Record "Agreement Schedule"; ACHPaymentList: Record "ACH Payment List")
    var
        IsLastAgreementLine: Boolean;
        DiffDays: Integer;
        TmpDate: Date;
    begin
        Deposit := 0;
        SharePercentage := 0;
        ChargeStartDate := 0D;
        ChargeEndDate := 0D;
        AgreementStartDate := 0D;
        AgreementEndDate := 0D;

        IsLastAgreementLine := AgreementSchedueRec.sr_IsLastRow;
        If not IsMidWeekAgreement then begin
            Deposit := AgreementSchedueRec.sr_weeklylicensefee;
            Deposit := Deposit * ((ACHPaymentList."Authorized E-Payment Amount" - 1) / AgreementSchedueRec."Highest Amount");
            //SRBC-175
            if (Deposit <> 0) and (AgreementSchedueRec.sr_weeklylicensefee <> 0) then
                SharePercentage := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;

            // if (AgreementSchedueRec.new_abatementfee <> 0) then begin //SRBC-516 17062026
            if (AgreementSchedueRec.new_abatementfee <> 0) and (AgreementSchedueRec."Discount End Date" <> 0D) and (ACHPaymentList.sr_authorizedepaymentstartdate <> 0DT) then begin//SRBC-516 17062026
                ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1;
                if (ChargeStartDate >= DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate)) then
                    ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1
                else
                    if AgreementSchedueRec."Discount End Date" >= DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate) then//SRBC-516 17062026
                        ChargeStartDate := AgreementSchedueRec."Discount End Date" + 1 //SRBC-516 17062026
                    else//SRBC-516 17062026
                        ChargeStartDate := DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate);//SRBC-516 17062026
            end else begin
                if AgreementSchedueRec.sr_feeduedate >= DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate) then
                    ChargeStartDate := AgreementSchedueRec.sr_feeduedate
                else
                    ChargeStartDate := DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate);
            end;

            AgreementStartDate := AgreementSchedueRec.sr_feeduedate;
            DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
            GetWeekDay(DayEnum, DateForWeek."Period Name");
            TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
            If IsLastAgreementLine then
                AgreementEndDate := AgreementSchedueRec."Current Agrement End Date"
            else
                ChargeEndDate := TmpDate;
            exit;
        end;

        //Check MidWeek Agreement 1st line inserted
        if not IsMidWeekThirdLine then begin
            TmpEPaymentScheduleRec.Reset();
            TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"ACH Payment List");
            TmpEPaymentScheduleRec.SetRange("Source Table RecordID", ACHPaymentList."ACH Payments ID");
            IF TmpEPaymentScheduleRec.FindFirst() then begin
                Deposit := AgreementSchedueRec.sr_weeklylicensefee;
                ChargeStartDate := CalcDate('1D', TmpEPaymentScheduleRec."End Date");
                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
                GetWeekDay(DayEnum, DateForWeek."Period Name");

                //2ndline end date
                //If staggered end due date is sunday then take current week friday for line 2
                if DayEnum = DayEnum::Sunday then begin
                    TmpDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Staggered End Due Date");
                    if not IsLastAgreementLine then
                        IsMidWeekThirdLine := true;
                end else begin
                    if DayEnum = DayEnum::Saturday then begin
                        TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
                    end else begin
                        if not IsStaggeredEnDDateMidWeek then
                            TmpDate := CalcDate('CW-2W+5D', AgreementSchedueRec."Staggered End Due Date")
                        else
                            ChargeEndDate := AgreementSchedueRec."Staggered End Due Date" - 1;
                        if not IsStaggeredEnDDateMidWeek then
                            if not IsLastAgreementLine then
                                IsMidWeekThirdLine := true;
                    end;
                end;
                //2ndline end date


                if IsMidWeekThirdLine then
                    ChargeEndDate := TmpDate;

                if IsStaggeredEnDDateMidWeek then begin
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7;
                end;
                if IsLastAgreementLine then begin
                    ChargeEndDate := 0D;
                end;

            end else begin
                //LINE 1 INSERT

                if AgreementSchedueRec.new_abatementfee <> 0 then begin

                    ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1;
                    if (ChargeStartDate >= DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate)) then
                        ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1
                    else
                        ChargeStartDate := DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate);
                end else begin
                    if AgreementSchedueRec.sr_feeduedate >= DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate) then
                        ChargeStartDate := AgreementSchedueRec.sr_feeduedate
                    else
                        ChargeStartDate := DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate);
                end;

                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";

                if IsStaggeredEnDDateMidWeek then begin
                    //5 JULY
                    DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
                    GetWeekDay(DayEnum, DateForWeek."Period Name");

                    if DayEnum = DayEnum::Sunday then begin
                        TmpDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Staggered End Due Date");
                        //IsMidWeekThirdLine := true;
                    end else begin
                        if DayEnum = DayEnum::Saturday then begin
                            TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
                        end else begin
                            TmpDate := CalcDate('CW-2W+5D', AgreementSchedueRec."Staggered End Due Date");
                            //IsMidWeekThirdLine := true;
                        end;
                    end;
                    //5 JULY
                    ChargeEndDate := TmpDate;
                end;

                if not IsStaggeredEnDDateMidWeek then begin
                    if DayEnum = DayEnum::Sunday then
                        ChargeEndDate := CalcDate('CW+5D', ChargeStartDate)
                    else
                        ChargeEndDate := CalcDate('CW-2D', ChargeStartDate);  //Calculate Till Friday just before Next Contract starts on Saturday. 
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7;
                end else begin
                    Deposit := AgreementSchedueRec.sr_weeklylicensefee;
                end;

            end;
            if AgreementSchedueRec."Highest Amount" <> 0 then begin  //SRBC-349 - NU - 20260627
                Deposit := Deposit * ((ACHPaymentList."Authorized E-Payment Amount" - 1) / AgreementSchedueRec."Highest Amount");
                //SRBC-175
                if (Deposit <> 0) and (AgreementSchedueRec.sr_weeklylicensefee <> 0) then
                    SharePercentage := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;
            end; //SRBC-349 - NU - 20260627
        end;


        if not IsLastAgreementLine then begin
            //MID WEEK 3rd LINE START
            //Check MidWeek Agreement 1st line inserted
            if (IsMidWeekThirdLine AND CheckChargesforLine3) then begin
                TmpEPaymentScheduleRec.Reset();
                TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"ACH Payment List");
                TmpEPaymentScheduleRec.SetRange("Source Table RecordID", ACHPaymentList."ACH Payments ID");
                IF TmpEPaymentScheduleRec.Findlast() then begin
                    Deposit := AgreementSchedueRec.sr_weeklylicensefee;
                    ChargeStartDate := CalcDate('1D', TmpEPaymentScheduleRec."End Date");
                    AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                    DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
                    GetWeekDay(DayEnum, DateForWeek."Period Name");

                    TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
                    If IsLastAgreementLine then
                        AgreementEndDate := AgreementSchedueRec."Staggered End Due Date"
                    else
                        ChargeEndDate := TmpDate;

                    if ChargeEndDate <> 0D then
                        DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1
                    else
                        DiffDays := 1;  // Calculate from Saturday till start of agreement dates .
                    Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7;
                end;
                Deposit := Deposit * ((ACHPaymentList."Authorized E-Payment Amount" - 1) / AgreementSchedueRec."Highest Amount");
                //SRBC-175
                if (Deposit <> 0) and (AgreementSchedueRec.sr_weeklylicensefee <> 0) then
                    SharePercentage := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;
                //SRBC-175
            end;
            //MID WEEK 3rd LINE END
        end;
    end;


    //SRBC-207 Added parameter ACHPaymentList for flow ACH Payment ID in Epayment Schedule.
    local procedure InsertTmpEpaymentFromBankInfo(var BankAccInfo: Record "Banking Account Info"; var ReccCharges: record "Recurring Charges"; var AS_iRec: Record "Agreement Schedule"; Frquency: Enum "Recurring Charge Frequency"; IsCreatedFromBankInfo: Boolean;
                                                                                                                                                                                                       MidWeekLineNo: Integer;
                                                                                                                                                                                                       ACHPaymentList: Record "ACH Payment List")

    var
        SRsetup: Record "Salon Republic Setup";
        Customer_lRec: Record Customer;//SRBC-207
        EPaymentSchedule_lRec: Record "E Payment Schedule";//SRBC-405 JSG 12092025
        EpaymentScheduleCreatedDate: Date;//SRBC-405 JSG 12092025
    begin

        SRsetup.Get();
        SRsetup.TestField("Convenience Fee");
        AmountWithConvFee := SRsetup."Convenience Fee";
        //Epayment Creation From Banking account Info.

        EntryNo += 1;
        TmpEPaymentScheduleRec.Init();
        TmpEPaymentScheduleRec."Entry No." := EntryNo;
        TmpEPaymentScheduleRec.Validate(Payer, BankAccInfo.sr_licenseeid);
        TmpEPaymentScheduleRec.Validate("Customer No.", ACHPaymentList."Customer No.");
        TmpEPaymentScheduleRec.Validate(EFrequency, ACHPaymentList."Authorized E-Payment Frequency");
        //SRBC-404 Start
        // TmpEPaymentScheduleRec.Validate(Frequency, Frquency);
        if ACHPaymentList."Authorized E-Payment Frequency" = ACHPaymentList."Authorized E-Payment Frequency"::Monthly then
            TmpEPaymentScheduleRec.Validate(Frequency, TmpEPaymentScheduleRec.Frequency::Monthly);
        if ACHPaymentList."Authorized E-Payment Frequency" = ACHPaymentList."Authorized E-Payment Frequency"::Quarterly then
            TmpEPaymentScheduleRec.Validate(Frequency, TmpEPaymentScheduleRec.Frequency::Quarterly);
        if ACHPaymentList."Authorized E-Payment Frequency" = ACHPaymentList."Authorized E-Payment Frequency"::Weekly then
            TmpEPaymentScheduleRec.Validate(Frequency, TmpEPaymentScheduleRec.Frequency::Weekly);
        if ACHPaymentList."Authorized E-Payment Frequency" = ACHPaymentList."Authorized E-Payment Frequency"::Yearly then
            TmpEPaymentScheduleRec.Validate(Frequency, TmpEPaymentScheduleRec.Frequency::Yearly);
        //SRBC-404 End
        TmpEPaymentScheduleRec.Validate(Description, 'Epayment Schedule');
        TmpEPaymentScheduleRec.Validate("Agreement ID", ACHPaymentList."Agreement ID");
        TmpEPaymentScheduleRec.Validate(Amount, Deposit);
        TmpEPaymentScheduleRec.Validate("Stripe Payment Method Status", ACHPaymentList."Stripe Payment Method Status");//SRBC-307
        //SRBC-207 Start
        if not IsNullGuid(ACHPaymentList."ACH Payments ID") then begin
            TmpEPaymentScheduleRec."ACH Payment ID" := ACHPaymentList."ACH Payments ID";
            Customer_lRec.Reset();
            Customer_lRec.SetRange("CRM Agreement ID", ACHPaymentList."Agreement ID");
            if Customer_lRec.FindFirst() then
                TmpEPaymentScheduleRec."Customer No." := Customer_lRec."No.";
        end;
        //SRBC-207 End
        //SRBC-175
        TmpEPaymentScheduleRec.Validate("Share %", SharePercentage);
        TmpEPaymentScheduleRec.Validate("AS Sequence", AS_iRec.Sequence);
        //SRBC-175
        TmpEPaymentScheduleRec.Validate(sr_ConvenienceFee, AmountWithConvFee);
        TmpEPaymentScheduleRec.Validate(sr_TotalAmount, TmpEPaymentScheduleRec.Amount + TmpEPaymentScheduleRec.sr_ConvenienceFee);

        TmpEPaymentScheduleRec.Validate(Account, ACHPaymentList.sr_accountname);

        TmpEPaymentScheduleRec.Validate("Start Date", ChargeStartDate);
        TmpEPaymentScheduleRec.Validate("End Date", ChargeEndDate);

        TmpEPaymentScheduleRec.Validate("Payment End Date", ChargeEndDate);

        if MidWeekLineNo = 1 then
            TmpEPaymentScheduleRec.Validate("End Date", ChargeEndDate);

        TmpEPaymentScheduleRec.Validate("Banking Account Info", ACHPaymentList."Bank Account Info ID");
        TmpEPaymentScheduleRec.Validate("BC Cust. Bank Account", ACHPaymentList."BC Cust. Bank Account");


        TmpEPaymentScheduleRec.Validate("Payment Start Date", DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate));
        Evaluate(TmpEPaymentScheduleRec."License ID", ACHPaymentList."License ID");
        TmpEPaymentScheduleRec.Validate(sr_IsBC, true);

        TmpEPaymentScheduleRec."Source Table ID" := Database::"ACH Payment List";
        TmpEPaymentScheduleRec."Source Table RecordID" := ACHPaymentList."ACH Payments ID";
        //SRBC-473 Start
        TmpEPaymentScheduleRec.Validate("Payment For", SRsetup."LICENSE FEE");
        // TmpEPaymentScheduleRec.Validate("Payment For Id", ACHPaymentList."Payment For Id");
        //SRBC-473 End
        //SRBC-405 Start 12092025
        //Update End Date for Existing E-Payment Schedules
        EPaymentSchedule_lRec.Reset();
        EPaymentSchedule_lRec.SetRange("Agreement ID", ACHPaymentList."Agreement ID");
        EPaymentSchedule_lRec.SetRange("License ID", ACHPaymentList."License ID");
        EPaymentSchedule_lRec.SetRange(Frequency, EPaymentSchedule_lRec.Frequency::Weekly);
        EPaymentSchedule_lRec.SetRange("Payment Plan", false);
        if EPaymentSchedule_lRec.FindSet() then
            repeat
                if EPaymentSchedule_lRec."AS Sequence" < AS_iRec.Sequence then begin //SRBC-405 End JSG 13092025
                    //if EPaymentSchedule_lRec."Start Date" < (ACHPaymentList."Current Agreement Start Date" - 2) then begin //SRBC-405 End JSG 13092025  
                    if (EPaymentSchedule_lRec."End Date" >= (ACHPaymentList."Current Agreement Start Date" - 2)) or (EPaymentSchedule_lRec."End Date" = 0D) and ((ACHPaymentList."Current Agreement Start Date" - 2) >= Today) then begin
                        EPaymentSchedule_lRec."End Date" := (ACHPaymentList."Current Agreement Start Date" - 2)
                        //end else if (EPaymentSchedule_lRec."End Date" >= (ACHPaymentList."Current Agreement Start Date" - 2)) or (EPaymentSchedule_lRec."End Date" = 0D) and ((ACHPaymentList."Current Agreement Start Date" - 2) < Today) then begin//SRBC-443 JSG 15102025 Old
                    end else if (EPaymentSchedule_lRec."End Date" >= (ACHPaymentList."Current Agreement Start Date" - 2)) or (EPaymentSchedule_lRec."End Date" = 0D) and ((ACHPaymentList."Current Agreement Start Date" - 2) < Today) and (AS_iRec.sr_feeduedate <> Today) then begin//SRBC-443 JSG 15102025 New
                        EPaymentSchedule_lRec."End Date" := Today;
                        //SRBC-443 JSG 15102025 Start
                        //EPaymentSchedule_lRec.Inactive := true;
                    end else if (EPaymentSchedule_lRec."End Date" >= (ACHPaymentList."Current Agreement Start Date" - 2)) or (EPaymentSchedule_lRec."End Date" = 0D) and ((ACHPaymentList."Current Agreement Start Date" - 2) < Today) and (AS_iRec.sr_feeduedate = Today) then begin
                        EPaymentSchedule_lRec."End Date" := Today - 1;
                    end;
                    if EPaymentSchedule_lRec."End Date" <= Today then
                        EPaymentSchedule_lRec.Inactive := True;
                    //SRBC-443 JSG 15102025 End
                    EPaymentSchedule_lRec.Modify();
                end;
            until EPaymentSchedule_lRec.Next() = 0;
        MakeExistingEpaymentScheduleInactive(TmpEPaymentScheduleRec);
        TmpEPaymentScheduleRec.Validate(Inactive, false);
        //SRBC-405 End JSG 12092025    
        TmpEPaymentScheduleRec.Insert(true);

    end;


    //Calculate charges from bank acc info
    //20Aug
    //SRBC-207 - 08012025 - SY - Added parameter ACHPaymentList
    local procedure CalculateChargesFromBankAccInfo(var BankAccInfo: Record "Banking Account Info"; var AgreementSchedueRec: Record "Agreement Schedule"; ACHPaymentList: Record "ACH Payment List")
    var
        IsLastAgreementLine: Boolean;
        DiffDays: Integer;
        TmpDate: Date;
    begin
        Deposit := 0;
        ChargeStartDate := 0D;
        ChargeEndDate := 0D;
        AgreementStartDate := 0D;
        AgreementEndDate := 0D;

        If not IsMidWeekAgreement then begin
            Deposit := ACHPaymentList."Authorized E-Payment Amount" - 1;
            AgreementStartDate := DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate);

        end;

        //Check MidWeek Agreement 1st line inserted
        if not IsMidWeekThirdLine then begin
            TmpEPaymentScheduleRec.Reset();
            TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"ACH Payment List");
            TmpEPaymentScheduleRec.SetRange("Source Table RecordID", ACHPaymentList."ACH Payments ID");
            IF TmpEPaymentScheduleRec.FindFirst() then begin
                //LINE 2 Insert
                Deposit := ACHPaymentList."Authorized E-Payment Amount" - 1;
                ChargeStartDate := CalcDate('1D', TmpEPaymentScheduleRec."End Date");

                DateForWeek.Get(DateForWeek."Period Type"::Date, ChargeStartDate);
                GetWeekDay(DayEnum, DateForWeek."Period Name");
                //2ndline end date

                //If line 1 is midweek then take current week friday for line 2
                if DayEnum = DayEnum::Sunday then begin
                    TmpDate := CalcDate('CW-1W+5D', ChargeStartDate);
                end else begin
                    if DayEnum = DayEnum::Saturday then begin
                        TmpDate := CalcDate('-1D', ChargeStartDate);
                    end else begin
                        ChargeEndDate := ChargeStartDate - 1;
                    end;
                end;

                if IsMidWeekThirdLine then
                    ChargeEndDate := TmpDate;

                if IsStaggeredEnDDateMidWeek then begin
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7;
                end;
                if IsLastAgreementLine then begin
                    ChargeEndDate := 0D;
                end;

            end else begin
                //LINE 1 INSERT

                AgreementStartDate := DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate);
                ChargeStartDate := DT2Date(ACHPaymentList.sr_authorizedepaymentstartdate);


                DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementStartDate);
                GetWeekDay(DayEnum, DateForWeek."Period Name");

                if DayEnum = DayEnum::Sunday then begin
                    TmpDate := CalcDate('CW-1W+5D', AgreementStartDate);

                end else begin
                    if DayEnum = DayEnum::Saturday then begin
                        TmpDate := CalcDate('-1D', AgreementStartDate);
                    end else begin
                        TmpDate := CalcDate('CW-2W+5D', AgreementStartDate);

                    end;
                end;

                ChargeEndDate := TmpDate;

                DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                Deposit := (ACHPaymentList."Authorized E-Payment Amount" * DiffDays) / 7;

            end;
        end;

        //MID WEEK 3rd LINE START
        //Check MidWeek Agreement 2nd line inserted
        //MID WEEK 3rd LINE END

    end;

    local procedure CalculateEpaymentChargeDtls(var BankAccInfo: Record "Banking Account Info"; var ReccCharges: Record "Recurring Charges")
    var
        //IsLastAgreementLine: Boolean;
        DiffDays: Integer;
        TmpDate: Date;
        Amt: Decimal;
    begin
        Deposit := 0;
        ChargeStartDate := 0D;
        ChargeEndDate := 0D;
        Amt := 0;
        DiffDays := 0;

        If not IsMidWeekAgreement then begin
            Deposit := BankAccInfo.sr_authorizedepaymentamount;

            ChargeStartDate := DT2Date(BankAccInfo.sr_authorizedepaymentstartdate);

            DateForWeek.Get(DateForWeek."Period Type"::Date, ChargeStartDate);
            GetWeekDay(DayEnum, DateForWeek."Period Name");

        end;


        if ChargeStartDate > ReccCharges."Start Date" then begin
            ChargeStartDate := DT2Date(BankAccInfo.sr_authorizedepaymentstartdate);
            SelectChargeDate := true;
        end else begin
            ChargeStartDate := ReccCharges."Start Date";
            SelectChargeDate := false;
        end;



        if DayEnum = DayEnum::Sunday then
            ChargeEndDate := CalcDate('CW+5D', ChargeStartDate)
        else
            ChargeEndDate := CalcDate('CW-2D', ChargeStartDate);  //Calculate Till Friday just before Next Contract starts on Saturday. 

        if ReccCharges."Skip Calculation" then begin
            DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
            Amt := BankAccInfo.sr_authorizedepaymentamount - 1;
            Deposit := (Amt * DiffDays) / 7;
        end else
            Deposit := BankAccInfo.sr_authorizedepaymentamount - 1;

    end;


    local procedure InsertEpayment()
    var
        //BankAccInfo: Record "Banking Account Info";
        ACHPaymentList_lRec: Record "ACH Payment List";
    begin
        MarkEPaymentScheduleRec.Reset();
        TmpEPaymentScheduleRec.Reset();
        IF TmpEPaymentScheduleRec.FindSet() then
            repeat
                EPaymentScheduleRec.Init();
                EPaymentScheduleRec.TransferFields(TmpEPaymentScheduleRec);
                EPaymentScheduleRec."Entry No." := 0;
                EPaymentScheduleRec.Insert(true);
                MarkEPaymentScheduleRec.SetRange("Entry No.", EPaymentScheduleRec."Entry No.");
                MarkEPaymentScheduleRec.FindFirst();
                MarkEPaymentScheduleRec.Mark(true);

                case TmpEPaymentScheduleRec."Source Table ID" of
                    DATABASE::"ACH Payment List":
                        begin
                            ACHPaymentList_lRec.Reset();
                            ACHPaymentList_lRec.SetRange("ACH Payments ID", ACHPaymentList_gRec."ACH Payments ID");
                            if ACHPaymentList_lRec.FindFirst() then begin
                                ACHPaymentList_lRec."Epayment Schedule Created" := true;
                                ACHPaymentList_lRec."Epayment Schedule Created Date" := Today;
                                ACHPaymentList_lRec."Epayment Schedule Created Time" := Time;
                            end;
                        end;
                end;
            until TmpEPaymentScheduleRec.Next() = 0;
    end;

    procedure InsertCustBankAccount(var CustBankAccCode: Code[20]; CustCode: Code[20]; AgreementsGUID: Guid; var BankAccInfo: Record "Banking Account Info");
    var
        CustBankAcc: Record "Customer Bank Account";
        CustBankAcc2: Record "Customer Bank Account";
        Code: Code[20];
        EntryNo: Integer;
        Contact: Record Contact;
    begin
        Code := CopyStr(BankAccInfo.sr_accountname, 1, 3);
        CustBankAcc.Reset();
        CustBankAcc.SetCurrentKey("Entry No.");
        if CustCode <> '' then //SRBC-232
            CustBankAcc.SetRange("Customer No.", CustCode);

        if CustBankAcc.FindLast() then
            EntryNo := CustBankAcc."Entry No." + 1
        else
            EntryNo := 1;

        CustBankAcc2.Reset();
        if CustCode <> '' then //SRBC-232 
            CustBankAcc2.SetRange("Customer No.", CustCode);

        CustBankAcc2.SetRange("Bank Account Info", BankAccInfo.sr_bankingaccountinfoId); //{ba08433e-f36b-1410-80e3-000c2cbe6cf3}

        if not CustBankAcc2.FindFirst() then begin
            CustBankAcc2.Init();
            if CustCode <> '' then //SRBC-232 
                CustBankAcc2.Validate("Customer No.", CustCode);
            CustBankAcc2.Validate(Code, Code + Format(EntryNo));
            CustBankAcc2.Validate(Name, BankAccInfo.sr_bankname);
            CustBankAcc2.Validate("Account Type", BankAccInfo.sr_accounttype);
            CustBankAcc2.Validate("Transit No.", BankAccInfo.sr_routingnumber);
            CustBankAcc2.Validate("Bank Account No.", BankAccInfo.sr_accountnumber);
            CustBankAcc2.Validate("Expiry Date", BankAccInfo.sr_expirydate);
            CustBankAcc2.Validate(City, BankAccInfo.sr_city);
            CustBankAcc2.Validate(County, BankAccInfo.sr_stateprovince);
            CustBankAcc2.Validate("Post Code", BankAccInfo.sr_zippostalcode);
            CustBankAcc2."License ID" := BankAccInfo.sr_licenseeid;
            CustBankAcc2."Agreement ID" := AgreementsGUID;
            CustBankAcc2."Bank Account Info" := BankAccInfo.sr_bankingaccountinfoId;
            CustBankAcc2."Entry No." := EntryNo;
            CustBankAcc2.Validate(IsCRM, false); //SRBC-232 

            IF BankAccInfo.sr_billingemail <> '' then begin
                CustBankAcc2.Validate("E-Mail", BankAccInfo.sr_billingemail);
            end else begin
                Contact.Reset();
                Contact.SetRange("CRM Contact ID", BankAccInfo.sr_licenseeid);
                if Contact.FindFirst() then begin
                    if Contact."E-Mail" <> '' then
                        CustBankAcc2.Validate("E-Mail", Contact."E-Mail");
                end;
            end;

            //OneTimePayment - Start
            //SRBC-232 
            IF BankAccInfo.sr_OneTimePayment then begin
                CustBankAcc2.Validate(IsCRM, true);
                CustBankAcc2.Validate("Stripe Customer ID2", BankAccInfo.sr_StripeCustomerId);
                CustBankAcc2.Validate("Payment Method ID2", BankAccInfo.sr_StripePaymentMethodId);
                CustBankAcc2.Validate("Setup Intent ID2", BankAccInfo.sr_StripeSetupIntentId);
                CustBankAcc2.Validate("Card URL2", BankAccInfo.sr_StripeSecret);
            end;
            //OneTimePayment - End
            if not IsNullGuid(CustBankAcc2."License ID") then //SRBC-397 JSG 07102025 Handling Creation of Duplicate Customer bank account for Banking account created from Portal
                CustBankAcc2.Insert(true);
            CustBankAccCode := CustBankAcc2.Code;
        end else begin
            CustBankAcc2.Validate(Name, BankAccInfo.sr_bankname);
            CustBankAcc2.Validate("Account Type", BankAccInfo.sr_accounttype);
            CustBankAcc2.Validate("Transit No.", BankAccInfo.sr_routingnumber);
            CustBankAcc2.Validate("Bank Account No.", BankAccInfo.sr_accountnumber);
            CustBankAcc2.Validate("Expiry Date", BankAccInfo.sr_expirydate);
            CustBankAcc2.Validate(City, BankAccInfo.sr_city);
            CustBankAcc2.Validate(County, BankAccInfo.sr_stateprovince);
            CustBankAcc2.Validate("Post Code", BankAccInfo.sr_zippostalcode);
            CustBankAcc2."License ID" := BankAccInfo.sr_licenseeid;
            CustBankAcc2."Agreement ID" := AgreementsGUID;
            CustBankAcc2.Validate(IsCRM, false); //SRBC-232 
            CustBankAcc2.Modify(true);
            CustBankAccCode := CustBankAcc2.Code;
        end;

    end;

    local procedure AutoCreateEpaymentScheduleLines()
    var
        AutoCreateEpaymentSchedule: Report AutoCreateEpaymentJournals;
    begin
        SRSetup.Get();
        if not SRSetup."Auto Create Epayment Jnl" then
            exit;
        MarkEPaymentScheduleRec.SetRange("Entry No.");
        MarkEPaymentScheduleRec.MarkedOnly(true);
        if MarkEPaymentScheduleRec.IsEmpty then
            exit;
        Commit();
        MarkEPaymentScheduleRec.FindSet();
        AutoCreateEpaymentSchedule.SetTableView(MarkEPaymentScheduleRec);
        AutoCreateEpaymentSchedule.SetReportParameters(false, MarkEPaymentScheduleRec."Start Date");
        AutoCreateEpaymentSchedule.UseRequestPage(false);
        AutoCreateEpaymentSchedule.RunModal();
    end;
    //SRBC-207 Start
    procedure CreateEpaymentFromACHPayments(AgreementID: Guid; var Variant: Variant)
    var
        RecurringCharges: Record "Recurring Charges";
        AgreementSchedule: Record "Agreement Schedule";
        bankaccinfo: Record "Banking Account Info";
        ACHPaymentList_lRec: Record "ACH Payment List";
        Frquency: Enum "Recurring Charge Frequency";
        RecRef: RecordRef;
        srsetp: Record "Salon Republic Setup";
        SequenceNo: Integer;
        EpaymentSchedule_lRec: Record "E Payment Schedule";
        Variant_lVar: Variant;
    begin
        SequenceNo := 0;
        ChargesLineCount := 0;
        srsetp.Get();
        RecRef.GetTable(Variant);
        case RecRef.Number of
            // DATABASE::"Banking Account Info":
            DATABASE::"ACH Payment List":
                begin
                    ACHPaymentList_lRec := Variant;
                    //bankaccinfo := Variant;
                    bankaccinfo.Reset();
                    bankaccinfo.SetRange(sr_bankingaccountinfoId, ACHPaymentList_lRec."Bank Account Info ID");
                    if bankaccinfo.FindFirst() then
                        Variant_lVar := bankaccinfo;
                    //FIND Sequence No
                    AgreementSchedule.Reset();
                    AgreementSchedule.SetRange(sr_agreementid, AgreementID);
                    AgreementSchedule.SetRange("CRM Renewal", false);
                    AgreementSchedule.SetRange(sr_renewalLADocuSign, false);//SRBC-405 SY 23092025
                    if AgreementSchedule.FindLast() then
                        SequenceNo := AgreementSchedule.Sequence;

                    AgreementSchedule.Reset();
                    //SRBC-175
                    AgreementSchedule.SetCurrentKey(sr_feeduedate);
                    //SRBC-175
                    AgreementSchedule.SetRange(sr_agreementid, AgreementID);
                    AgreementSchedule.SetRange(Sequence, SequenceNo);
                    //AgreementSchedule.SetRange("CRM Renewal", false);
                    if AgreementSchedule.FindSet() then begin
                        repeat
                            IsStaggeredEnDDateMidWeek := false;
                            //InsertEpaymentScheduleFromBankInfo(Variant, RecurringCharges, AgreementSchedule);
                            InsertEpaymentScheduleFromBankInfo(Variant_lVar, RecurringCharges, AgreementSchedule, ACHPaymentList_lRec);
                        until AgreementSchedule.Next() = 0;

                        EpaymentSchedule_lRec.Reset();
                        //SRBC-207 - 09012025 - Start
                        // EpaymentSchedule_lRec.SetRange("Agreement ID", bankaccinfo.sr_agreement);
                        // EpaymentSchedule_lRec.SetRange("License ID", bankaccinfo.sr_licenseeid);
                        EpaymentSchedule_lRec.SetRange("Agreement ID", ACHPaymentList_lRec."Agreement ID");
                        EpaymentSchedule_lRec.SetRange("ACH Payment ID", ACHPaymentList_lRec."ACH Payments ID");
                        //EpaymentSchedule_lRec.SetRange("License ID", ACHPaymentList_lRec."License ID");
                        //SRBC-207 - 09012025 - End
                        EpaymentSchedule_lRec.SetRange("CRM Renewal", false);
                        if EpaymentSchedule_lRec.FindLast() then begin
                            //SRBC-207 - 09012025 Start
                            EpaymentSchedule_lRec."Payment Anticipated End Date" := ACHPaymentList_lRec."Current Agreement End Date";
                            //EpaymentSchedule_lRec."Payment Anticipated End Date" := AgreementEndDate;
                            //SRBC-207 - 09012025 End
                            EpaymentSchedule_lRec.Modify();
                        end;
                        //SRBC-207 Testing
                        //until AgreementSchedule.Next() = 0;

                    end else begin

                    end;
                end;
        end;
    end;
    //SRBC-207 End
    //PAYMENT PLAN PROCESS
    [EventSubscriber(ObjectType::Table, Database::"Agreement Payment Plan", OnAfterInsertEvent, '', false, false)]
    local procedure PaymentPlanOnAfterInsertEvent(var Rec: Record "Agreement Payment Plan"; RunTrigger: Boolean)
    begin
        UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus(Rec);//SRBC-308
        if (Rec."Stripe Payment Method Status" = 'active') and (Rec.sr_PaymentPlanStatus = Rec.sr_PaymentPlanStatus::Completed) then//SRBC-308
            //CreatePaymentPlan(Rec);//SRBC-441 JSG Old
            CreateEPaymentFromPaymentPlan(Rec);//SRBC-441 JSG New
    end;
    // //SRBC-441 JSG Start
    // [EventSubscriber(ObjectType::Table, Database::"Agreement Payment Plan", OnAfterModifyEvent, '', false, false)]
    // local procedure PaymentPlanOnBeforeModifyEvent(var Rec: Record "Agreement Payment Plan"; RunTrigger: Boolean)
    // begin
    //     if (Rec."Epayment Created By" = '') and (Rec."Epayment Created DateTime" = 0DT) then begin
    //         UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus(Rec);//SRBC-308
    //         if (Rec."Stripe Payment Method Status" = 'active') and (Rec.sr_PaymentPlanStatus = Rec.sr_PaymentPlanStatus::Completed) then//SRBC-308
    //             CreateEPaymentFromPaymentPlan(Rec);
    //     end;
    // end;
    // //SRBC-441 JSG End
    //SRBC-308 Start

    //SRBC-441 JSG Start 29102025
    // procedure UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus(var AgreementPaymentPlan: Record "Agreement Payment Plan")
    // var
    //     EpaymentSchedule_lRec: Record "E Payment Schedule";
    //     bankingAccInfo_lRec: Record "Banking Account Info";
    //     CustBankAcc: Record "Customer Bank Account";
    // begin
    //     EpaymentSchedule_lRec.Reset();
    //     EpaymentSchedule_lRec.SetRange("Agreement ID", AgreementPaymentPlan.sr_Agreement);
    //     EpaymentSchedule_lRec.SetRange("License ID", AgreementPaymentPlan.sr_LicThirdPartyEnteringPay);
    //     EpaymentSchedule_lRec.SetCurrentKey("Payment Start Date");//SRBC-441 JSG 14102025
    //     if EpaymentSchedule_lRec.FindLast() then begin
    //         AgreementPaymentPlan.Validate("Bank Account Info ID", EpaymentSchedule_lRec."Banking Account Info");
    //         if bankingAccInfo_lRec.Get(AgreementPaymentPlan."Bank Account Info ID") then begin
    //             AgreementPaymentPlan.Validate("BC Cust. Bank Account", bankingAccInfo_lRec."BC Cust. Bank Account");
    //             AgreementPaymentPlan.Validate(accountname, bankingAccInfo_lRec.sr_accountname);
    //             CustBankAcc.Reset();
    //             CustBankAcc.SetRange("Bank Account Info", AgreementPaymentPlan."Bank Account Info ID");
    //             CustBankAcc.SetRange(Code, AgreementPaymentPlan."BC Cust. Bank Account");
    //             if CustBankAcc.FindFirst() then
    //                 AgreementPaymentPlan.Validate("Stripe Payment Method Status", CustBankAcc."Verification Status");
    //         end;
    //         AgreementPaymentPlan.Modify();
    //     end;
    // end;

    procedure UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus(var AgreementPaymentPlan: Record "Agreement Payment Plan")
    var
        EpaymentSchedule_lRec: Record "E Payment Schedule";
        bankingAccInfo_lRec: Record "Banking Account Info";
        CustBankAcc: Record "Customer Bank Account";
        BankAccInfoID: Guid;
        IsFind: Boolean;
        IsHandled: Boolean;//SRBC-489
    begin
        Clear(IsHandled);//SRBC-489
        Clear(BankAccInfoID);

        // Step 1: Try to find latest active E-payment schedule
        EpaymentSchedule_lRec.Reset();
        EpaymentSchedule_lRec.SetRange("Agreement ID", AgreementPaymentPlan.sr_Agreement);
        EpaymentSchedule_lRec.SetRange("License ID", AgreementPaymentPlan.sr_LicThirdPartyEnteringPay);
        EpaymentSchedule_lRec.SetRange(Inactive, false);
        EpaymentSchedule_lRec.SetFilter("Payment Start Date", '<=%1', AgreementPaymentPlan.sr_PlanStartDate);//SRBC-515 16062026
        EpaymentSchedule_lRec.SetFilter("Stripe Payment Method Status", '%1', 'active');//SRBC-515 16062026
        EpaymentSchedule_lRec.SetCurrentKey("Payment Start Date");

        // Step 2: If no active schedule found, include inactive E-payment schedule
        IsFind := EpaymentSchedule_lRec.FindLast();
        //SRBC-515 Start
        // if not IsFind then begin
        //     EpaymentSchedule_lRec.SetRange(Inactive);
        //     IsFind := EpaymentSchedule_lRec.FindLast();
        // end;
        //SRBC-515 End
        if IsFind then
            if not IsNullGuid(EpaymentSchedule_lRec."Banking Account Info") then
                BankAccInfoID := EpaymentSchedule_lRec."Banking Account Info";

        // Step 3: If still no record found, get latest active customer bank account
        if not IsNullGuid(AgreementPaymentPlan.sr_LicThirdPartyEnteringPay) then
            if IsNullGuid(BankAccInfoID) then begin
                CustBankAcc.Reset();
                CustBankAcc.SetRange("License ID", AgreementPaymentPlan.sr_LicThirdPartyEnteringPay);
                CustBankAcc.SetRange("Verification Status", 'active');
                CustBankAcc.SetCurrentKey(SystemCreatedAt);
                if CustBankAcc.FindLast() then
                    BankAccInfoID := CustBankAcc."Bank Account Info";
            end;

        // Step 4: Update Agreement Payment Plan fields if valid Bank Account Info found
        if not IsNullGuid(BankAccInfoID) then begin
            if bankingAccInfo_lRec.Get(BankAccInfoID) then begin
                //SRBC-489 Start
                if AgreementPaymentPlan."Bank Account Info ID" <> BankAccInfoID then begin
                    AgreementPaymentPlan.Validate("Bank Account Info ID", BankAccInfoID);
                    IsHandled := true;
                end;
                if AgreementPaymentPlan."BC Cust. Bank Account" <> bankingAccInfo_lRec."BC Cust. Bank Account" then begin
                    AgreementPaymentPlan.Validate("BC Cust. Bank Account", bankingAccInfo_lRec."BC Cust. Bank Account");
                    IsHandled := true;
                end;
                if AgreementPaymentPlan.accountname <> bankingAccInfo_lRec.sr_accountname then begin
                    AgreementPaymentPlan.Validate(accountname, bankingAccInfo_lRec.sr_accountname);
                    IsHandled := true;
                end;
                CustBankAcc.Reset();
                CustBankAcc.SetRange("Bank Account Info", BankAccInfoID);
                CustBankAcc.SetRange(Code, bankingAccInfo_lRec."BC Cust. Bank Account");
                if CustBankAcc.FindFirst() then
                    if AgreementPaymentPlan."Stripe Payment Method Status" <> CustBankAcc."Verification Status" then begin
                        AgreementPaymentPlan.Validate("Stripe Payment Method Status", CustBankAcc."Verification Status");
                        IsHandled := true;
                    end;
                if IsHandled then
                    AgreementPaymentPlan.Modify();
                //SRBC-489 End
            end;
        end;
    end;
    //SRBC-441 JSG End 29102025

    //SRBC-308 End

    [EventSubscriber(ObjectType::Table, Database::"E Payment Schedule", OnAfterDeleteEvent, '', false, false)]
    local procedure EpayOnAfterDeleteEvent()
    begin

    end;

    procedure CreatePaymentPlan(AgreementPaymentPlanList: Record "Agreement Payment Plan") //SRBC-266
    var
        EpaymentSchedule: Record "E Payment Schedule";
        Agreements: Record Agreements;
        ACHPaymentList_lRec: Record "ACH Payment List";//SRBC-207
        SRSetup: Record "Salon Republic Setup";

    begin
        SRSetup.get;
        SRSetup.TestField("Convenience Fee");
        //SRBC-447 Start
        if (AgreementPaymentPlanList.sr_TotalWeeklyPaymentAmount = 0) or
          (AgreementPaymentPlanList.sr_WeeklyAdditionalPaymentAmt = 0) or
          (AgreementPaymentPlanList.sr_typeofpaymentplan <> AgreementPaymentPlanList.sr_typeofpaymentplan::"E-Payment") or (AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate = 0D) or
           (AgreementPaymentPlanList.sr_PlanStartDate = 0D) or (IsNullGuid(AgreementPaymentPlanList.sr_Agreement)) or (IsNullGuid(AgreementPaymentPlanList."Bank Account Info ID")) or
           (IsNullGuid(AgreementPaymentPlanList.sr_LicThirdPartyEnteringPay)) or (AgreementPaymentPlanList."Stripe Payment Method Status" <> 'active') then
            exit;
        // if AgreementPaymentPlanList.sr_TotalWeeklyPaymentAmount = 0 then
        //     exit;
        // AgreementPaymentPlanList.TestField(sr_typeofpaymentplan, AgreementPaymentPlanList.sr_typeofpaymentplan::"E-Payment"); //SRBC-409
        //SRBC-447 End;
        EpaymentSchedule.Reset();
        //EpaymentSchedule.SetCurrentKey("Entry No.");//SRBC-441 JSG Old
        EpaymentSchedule.SetCurrentKey("Payment Start Date");//SRBC-441 JSG New
        EpaymentSchedule.SetRange("Agreement ID", AgreementPaymentPlanList.sr_Agreement);
        EpaymentSchedule.SetRange("License ID", AgreementPaymentPlanList.sr_LicThirdPartyEnteringPay);
        EpaymentSchedule.SetRange(Frequency, EpaymentSchedule.Frequency::Weekly);//SRBC-441 JSG New
        EpaymentSchedule.SetRange("Payment Plan", false);
        EpaymentSchedule.SetRange(Inactive, false);
        if EpaymentSchedule.FindSet() then begin
            repeat
                //SRBC-463 JSG Start 18122025
                if (EpaymentSchedule."End Date" >= (AgreementPaymentPlanList.sr_PlanStartDate - 1)) or (EpaymentSchedule."End Date" = 0D) and ((AgreementPaymentPlanList.sr_PlanStartDate - 1) >= Today) then
                    EpaymentSchedule.Validate("End Date", AgreementPaymentPlanList.sr_PlanStartDate - 1)
                else if (EpaymentSchedule."End Date" >= (AgreementPaymentPlanList.sr_PlanStartDate - 1)) or (EpaymentSchedule."End Date" = 0D) and ((AgreementPaymentPlanList.sr_PlanStartDate - 1) < Today) then
                    EpaymentSchedule.Validate("End Date", Today);
                //SRBC-463 JSG End 18122025
                EpaymentSchedule.Validate(Inactive, true);
                EpaymentSchedule.Modify(true);
            until EpaymentSchedule.Next() = 0;
        end;
        //If epayment schedule found
        ACHPaymentList_lRec.Reset();
        ACHPaymentList_lRec.SetRange("Agreement ID", AgreementPaymentPlanList.sr_Agreement);
        if ACHPaymentList_lRec.FindFirst() then;
        //InsertEpaymentScheduleFromPaymentPlan(AgreementPaymentPlanList, EpaymentSchedule, ACHPaymentList_lRec);//SRBC-441 JSG Old 29102025
        InsertEpaymentScheduleFromPaymentPlan(AgreementPaymentPlanList, EpaymentSchedule);//SRBC-441 JSG New 29102025

        // if MarkEPaymentScheduleRec."Start Date" <> 0D then //SRBC-360 
        //     AutoCreateEpaymentScheduleLines(); //SRBC-360
    end;
    //SRBC-207 - 08012025 - SY - End

    procedure GetWeekDay(var WeekDay: Enum "Week Selection";
                                          CurrDay:
                Code[20])
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

    //JIRA SRBC-175 Create Epayment on CRM renewal Boolean from Agreement Schedule.
    //procedure InsertEpaymentScheduleFromCRMRenewal(var Variant: Variant; var ReccCharges_iRec: record "Recurring Charges")
    procedure InsertEpaymentScheduleFromCRMRenewal(var AS_iREc: record "Agreement Schedule"; var ReccCharges_iRec: record "Recurring Charges")
    var
        RecRef: RecordRef;
        // BankAccountInfo: Record "Banking Account Info"; //SRBC-514 24062026
        //ACHPaymentList: Record "ACH Payment List";//SRBC-207//SRBC-441 JSG 29102025
        Frquency: Enum "Recurring Charge Frequency";
        ReccuringCharges: Record "Recurring Charges";
        SalonRepublicSetup: Record "Salon Republic Setup";
        AgreementSchedule: Record "Agreement Schedule";
        EpayemntSchedule_lRec: Record "E Payment Schedule";
        FindExistingEpayemntSchedule_lRec: Record "E Payment Schedule";
        // FindExistingEpayemntSchedule: Record "E Payment Schedule";
        WeekDay: Text;
        ReadMultipleLine: Boolean;
        EPaySchedule_lRec: Record "E Payment Schedule";
        EpaymentScheduleCreatedDate: Date;//SRBC-349
                                          //SRBC-441 JSG Start 29102025
        Agreement: Record Agreements;
        i: Integer;
        LicenseeID: Guid;
        TempLicensee: Record "Licensee";
        NullGUID: Guid;//SRBC-463 JSG 22122025
                       //SRBC-441 JSG End 29102025
        EpaySchedule: Record "E Payment Schedule";//SRBC-514 24062026 
    begin
        AgreementSchedule.Copy(AS_iREc);
        AmountWithConvFee := 0;
        SalonRepublicSetup.Get();
        SalonRepublicSetup.TestField("Convenience Fee");
        AmountWithConvFee := SalonRepublicSetup."Convenience Fee";

        //SRBC-441 JSG Start 29102025

        Agreement.Reset();
        Agreement.SetRange("Agreement ID", AgreementSchedule.sr_agreementid);
        if Agreement.FindFirst() then begin
            // Clear existing temp data (optional, if you want a fresh list each time)
            TempLicensee.DeleteAll();

            for i := 1 to 10 do begin
                // Get the value of Licensee fields dynamically
                case i of
                    1:
                        LicenseeID := Agreement."Licensee 1";
                    2:
                        LicenseeID := Agreement."Licensee 2";
                    3:
                        LicenseeID := Agreement."Licensee 3";
                    4:
                        LicenseeID := Agreement."Licensee 4";
                    5:
                        LicenseeID := Agreement."Licensee 5";
                    6:
                        LicenseeID := Agreement."Licensee 6";
                    7:
                        LicenseeID := Agreement."Licensee 7";
                    8:
                        LicenseeID := Agreement."Licensee 8";
                    9:
                        LicenseeID := Agreement."Licensee 9";
                    10:
                        LicenseeID := Agreement."Licensee 10";
                end;

                // If LicenseeID exists, insert into temp table
                if not IsNullGuid(LicenseeID) then begin
                    TempLicensee.Init();
                    //TempLicensee."Entry No." := +1;//SRBC-463 JSG 19122025 Old
                    TempLicensee."Entry No." := i;//SRBC-463 JSG 19122025 New
                    TempLicensee."Licensee ID" := LicenseeID;
                    TempLicensee."Agreement ID" := AgreementSchedule.sr_agreementid;
                    TempLicensee.Insert();
                end;
            end;
        end;

        //SRBC-175-Start
        // ACHPaymentList.Reset();//SRBC-207
        // ACHPaymentList.SetRange("Agreement ID", AgreementSchedule.sr_agreementid);//SRBC-207
        // if ACHPaymentList.FindSet() then begin//SRBC-207

        //SRBC-441 JSG End 29102025

        TempLicensee.Reset();//SRBC-441 JSG 29102025
        TempLicensee.SetRange("Agreement ID", AgreementSchedule.sr_agreementid);//SRBC-441 JSG 29102025
        if TempLicensee.FindSet() then begin//SRBC-441 JSG 29102025
            repeat
                SharePercent_gDec := 0;
                TotalAmountShare_gDec := 0;
                //CustBankAccountNo_gCod := '';//SRBC-441 JSG 29102025
                WeekDay := '';
                ReadMultipleLine := false;
                EndDateFirstLine := 0D;
                DifferenceofDays := 0;
                TotalAmountShareForFirstLine := 0;
                SharePercentageForFirstLine := 0;
                SharePercentage_Diffday := 0; //SRBC-405 JSG 19092025

                FindExistingEpayemntSchedule_lRec.Reset();
                FindExistingEpayemntSchedule_lRec.SetCurrentKey("Start Date");//SRBC-405 19082025
                // FindExistingEpayemntSchedule_lRec.SetAscending("Start Date", false);//SRBC-405 19082025 //SRBC-514 17062026 Commented this line code
                FindExistingEpayemntSchedule_lRec.SetAscending("Start Date", true);//SRBC-514 17062026
                //FindExistingEpayemntSchedule_lRec.SetRange("Agreement ID", ACHPaymentList."Agreement ID");//SRBC-207//SRBC-441 JSG Old 29102025
                FindExistingEpayemntSchedule_lRec.SetRange("Agreement ID", AgreementSchedule.sr_agreementid);//SRBC-441 JSG New 29102025
                //FindExistingEpayemntSchedule_lRec.SetRange("License ID", ACHPaymentList."License ID");//SRBC-207//SRBC-441 JSG Old 29102025
                FindExistingEpayemntSchedule_lRec.SetRange("License ID", TempLicensee."Licensee ID");//SRBC-441 JSG New 29102025
                FindExistingEpayemntSchedule_lRec.SetFilter("Banking Account Info", '<>%1', NullGUID);//SRBC-463 JSG 22122025
                FindExistingEpayemntSchedule_lRec.SetRange(Frequency, FindExistingEpayemntSchedule_lRec.Frequency::Weekly);//SRBC-349 13062025
                FindExistingEpayemntSchedule_lRec.SetRange("Payment Plan", false);//SRBC-349 13062025
                FindExistingEpayemntSchedule_lRec.SetRange("Payment For", SalonRepublicSetup."LICENSE FEE");//SRBC-514 17062026
                FindExistingEpayemntSchedule_lRec.SetRange(Inactive, false);//SRBC-513 16062026
                // FindExistingEpayemntSchedule_lRec.SetFilter("End Date", '>=%1|%2', AgreementSchedule."Current Agrement Start Date", 0D);//SRBC-514 16062026
                if FindExistingEpayemntSchedule_lRec.FindSet() then begin
                    IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedule.sr_feeduedate) then begin //CHECK this when sandeep is on leave
                        GetWeekDay(DayEnum, DateForWeek."Period Name");
                        IsFirstLine := Format(DayEnum);
                        //IsFirstLine := 'Sunday';
                    end;
                    repeat
                        //SRBC-405 JSG 19092025 Start
                        if FindExistingEpayemntSchedule_lRec."End Date" = 0D then
                            SharePercentage_Diffday := 7
                        else
                            SharePercentage_Diffday := FindExistingEpayemntSchedule_lRec."End Date" - FindExistingEpayemntSchedule_lRec."Start Date";//SRBC-405 JSG 19092025
                        if SharePercentage_Diffday >= 7 then begin//SRBC-405 JSG 19092025
                            if WeekDay = '' then begin
                                IF DateForWeek.Get(DateForWeek."Period Type"::Date, FindExistingEpayemntSchedule_lRec."Start Date") then
                                    GetWeekDay(DayEnum, DateForWeek."Period Name");
                                if DayEnum = DayEnum::Saturday then begin
                                    WeekDay := Format(DayEnum);
                                    SharePercent_gDec := FindExistingEpayemntSchedule_lRec."Share %";
                                    //SRBC-405 JSG 13092025 Start
                                    if (AgreementSchedule.sr_weeklylicensefee <> 0) and (SharePercent_gDec <> 0) then
                                        TotalAmountShare_gDec := (AgreementSchedule.sr_weeklylicensefee * SharePercent_gDec) / 100;
                                    //SRBC-405 JSG 13092025 End
                                    //SRBC-405 JSG 13092025 Old
                                    //if (AgreementSchedule."Highest Amount" <> 0) and (SharePercent_gDec <> 0) then 
                                    //TotalAmountShare_gDec := (AgreementSchedule."Highest Amount" * SharePercent_gDec) / 100;
                                    //SRBC-405 JSG 13092025 Old
                                end else begin//SRBC-405 Start 19082025
                                    // if (DayEnum <> DayEnum::Saturday) and (FindExistingEpayemntSchedule."End Date" = 0D) then begin//SRBC-514 24062026
                                    if (DayEnum <> DayEnum::Saturday) and (FindExistingEpayemntSchedule_lRec."End Date" = 0D) then begin//SRBC-514 24062026
                                        SharePercent_gDec := FindExistingEpayemntSchedule_lRec."Share %";
                                        //SRBC-405 JSG 13092025 Start
                                        if (AgreementSchedule.sr_weeklylicensefee <> 0) and (SharePercent_gDec <> 0) then
                                            TotalAmountShare_gDec := (AgreementSchedule.sr_weeklylicensefee * SharePercent_gDec) / 100;
                                        //SRBC-405 JSG 13092025 End
                                        //SRBC-405 JSG 13092025 - Old
                                        //if (AgreementSchedule."Highest Amount" <> 0) and (SharePercent_gDec <> 0) then 
                                        //TotalAmountShare_gDec := (AgreementSchedule."Highest Amount" * SharePercent_gDec) / 100;
                                        //SRBC-405 JSG 13092025 - Old
                                    end;
                                end;//SRBC-405 End 19082025
                            end;
                        end;//SRBC-405 JSG 19092025 End
                        //SRBC-405 Start 12092025
                        // //SRBC-349 Start
                        // EpaymentScheduleCreatedDate := 0D;
                        // EpaymentScheduleCreatedDate := DT2Date(FindExistingEpayemntSchedule_lRec.SystemCreatedAt);
                        // if EpaymentScheduleCreatedDate > AgreementSchedule.sr_feeduedate then begin
                        //     if FindExistingEpayemntSchedule_lRec."End Date" = 0D then
                        //         FindExistingEpayemntSchedule_lRec."End Date" := EpaymentScheduleCreatedDate
                        //     else
                        //         if FindExistingEpayemntSchedule_lRec."End Date" >= EpaymentScheduleCreatedDate then
                        //             FindExistingEpayemntSchedule_lRec."End Date" := EpaymentScheduleCreatedDate
                        // end else
                        //     if FindExistingEpayemntSchedule_lRec."End Date" = 0D then
                        //         FindExistingEpayemntSchedule_lRec."End Date" := AgreementSchedule.sr_feeduedate - 1
                        //     else begin
                        //         if FindExistingEpayemntSchedule_lRec."End Date" >= AgreementSchedule.sr_feeduedate then
                        //             FindExistingEpayemntSchedule_lRec."End Date" := AgreementSchedule.sr_feeduedate - 1;
                        //     end;
                        // FindExistingEpayemntSchedule_lRec.Modify();
                        // //SRBC-349 End
                        //SRBC-349 Start
                        //if FindExistingEpayemntSchedule_lRec."Start Date" < (AgreementSchedule."Current Agrement Start Date" - 2) then begin //SRBC-405 JSG 13092025 Old
                        if FindExistingEpayemntSchedule_lRec."AS Sequence" < AgreementSchedule.Sequence then begin//SRBC-405 JSG 13092025 New
                            if (FindExistingEpayemntSchedule_lRec."End Date" >= (AgreementSchedule."Current Agrement Start Date" - 2)) or (FindExistingEpayemntSchedule_lRec."End Date" = 0D) and ((AgreementSchedule."Current Agrement Start Date" - 2) >= Today) then begin
                                FindExistingEpayemntSchedule_lRec."End Date" := (AgreementSchedule."Current Agrement Start Date" - 2);
                                //end else if (FindExistingEpayemntSchedule_lRec."End Date" >= (AgreementSchedule."Current Agrement Start Date" - 2)) or (FindExistingEpayemntSchedule_lRec."End Date" = 0D) and ((AgreementSchedule."Current Agrement Start Date" - 2) < Today) then begin //SRBC-443 JSG 15102025 Old
                            end else if (FindExistingEpayemntSchedule_lRec."End Date" >= (AgreementSchedule."Current Agrement Start Date" - 2)) or (FindExistingEpayemntSchedule_lRec."End Date" = 0D) and ((AgreementSchedule."Current Agrement Start Date" - 2) < Today) and (AgreementSchedule.sr_feeduedate <> Today) then begin //SRBC-443 JSG 15102025 New
                                FindExistingEpayemntSchedule_lRec."End Date" := Today;
                                //SRBC-443 JSG 15102025 Start
                                //FindExistingEpayemntSchedule_lRec.Inactive := true;
                            end else if (FindExistingEpayemntSchedule_lRec."End Date" >= (AgreementSchedule."Current Agrement Start Date" - 2)) or (FindExistingEpayemntSchedule_lRec."End Date" = 0D) and ((AgreementSchedule."Current Agrement Start Date" - 2) < Today) and (AgreementSchedule.sr_feeduedate = Today) then begin
                                FindExistingEpayemntSchedule_lRec."End Date" := Today - 1;
                            end;
                            if FindExistingEpayemntSchedule_lRec."End Date" <= Today then
                                FindExistingEpayemntSchedule_lRec.Inactive := True;
                            //SRBC-443 JSG 15102025 End
                            FindExistingEpayemntSchedule_lRec.Modify();
                        end;
                    //SRBC-405 End 12092025
                    //SRBC-349 End
                    until FindExistingEpayemntSchedule_lRec.next = 0;
                    //Need to check
                    //SRBC-349 Start
                    // if FindExistingEpayemntSchedule.Get(FindExistingEpayemntSchedule_lRec."Entry No.") then begin
                    //     FindExistingEpayemntSchedule."End Date" := FindExistingEpayemntSchedule."Payment Anticipated End Date";
                    //     FindExistingEpayemntSchedule.Modify();
                    // end;
                    //SRBC-349 End
                    // end else//SRBC-325//SRBC-463 JSG 19122025
                    //     exit;//SRBC-325//SRBC-463 JSG 19122025

                    //SRBC-405 JSG 19092025 Start
                    if (IsFirstLine <> 'Saturday') and (AgreementSchedule.new_abatementfee <> 0) then begin
                        IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedule.sr_feeduedate + (AS_iRec."No. of Days for Disc")) then
                            GetWeekDay(DayEnum, DateForWeek."Period Name");
                        if DayEnum = DayEnum::Sunday then begin
                            EndDateFirstLine := CalcDate('CW+5D', AgreementSchedule.sr_feeduedate + (AS_iRec."No. of Days for Disc"));
                        end else begin
                            EndDateFirstLine := CalcDate('CW-2D', AgreementSchedule.sr_feeduedate + (AS_iRec."No. of Days for Disc"));
                        end;
                        StartDateFirstLine := AgreementSchedule.sr_feeduedate + (AS_iRec."No. of Days for Disc");
                        DifferenceofDays := CalcDate('1D', EndDateFirstLine) - CalcDate('1D', AgreementSchedule.sr_feeduedate + (AS_iRec."No. of Days for Disc")) + 1;
                        TotalAmountShareForFirstLine := (TotalAmountShare_gDec / 7) * DifferenceofDays;
                        if (TotalAmountShareForFirstLine <> 0) and (AgreementSchedule.sr_weeklylicensefee <> 0) then
                            SharePercentageForFirstLine := (TotalAmountShareForFirstLine / AgreementSchedule.sr_weeklylicensefee) * 100;
                        FirstLineInsert := true;
                        //end else begin
                        //if IsFirstLine <> 'Saturday' then begin //SRBC-405 JSG 19092025 Old
                    end else if (IsFirstLine <> 'Saturday') and (AgreementSchedule.new_abatementfee = 0) then begin //SRBC-405 JSG 19092025 New
                        IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedule.sr_feeduedate) then
                            GetWeekDay(DayEnum, DateForWeek."Period Name");
                        if DayEnum = DayEnum::Sunday then begin
                            EndDateFirstLine := CalcDate('CW+5D', AgreementSchedule.sr_feeduedate);
                        end else begin
                            EndDateFirstLine := CalcDate('CW-2D', AgreementSchedule.sr_feeduedate);
                        end;
                        StartDateFirstLine := AgreementSchedule.sr_feeduedate;
                        DifferenceofDays := CalcDate('1D', EndDateFirstLine) - CalcDate('1D', AgreementSchedule.sr_feeduedate) + 1;
                        TotalAmountShareForFirstLine := (TotalAmountShare_gDec / 7) * DifferenceofDays;
                        if (TotalAmountShareForFirstLine <> 0) and (AgreementSchedule.sr_weeklylicensefee <> 0) then
                            SharePercentageForFirstLine := (TotalAmountShareForFirstLine / AgreementSchedule.sr_weeklylicensefee) * 100;
                        FirstLineInsert := true;
                    end else IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedule.sr_feeduedate) then
                            GetWeekDay(DayEnum, DateForWeek."Period Name");
                    //SRBC-405 JSG 19092025 End
                    //SRBC-207
                    //CustBankAccountNo_gCod := BankAccountInfo."BC Cust. Bank Account";//SRBC-207//SRBC-441 JSG 29102025
                    //CustBankAccountNo_gCod := ACHPaymentList."BC Cust. Bank Account";//SRBC-207//SRBC-441 JSG 29102025
                    //BankAccountGuid_gGui := ACHPaymentList."Bank Account Info ID";//SRBC-207//SRBC-441 JSG 29102025
                    //SRBC-175-End

                    EntryNo := 0;
                    IsMidWeekAgreement := false;
                    TmpEPaymentScheduleRec.Reset();
                    TmpEPaymentScheduleRec.DeleteAll();
                    DefaultWeekSelectionEnum := DefaultWeekSelectionEnum::Saturday;
                    //SRBC-405 JSG 19092025 Start
                    // IF DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedule.sr_feeduedate) then
                    //     GetWeekDay(DayEnum, DateForWeek."Period Name");
                    //SRBC-405 JSG 19092025 End
                    IsMidWeekAgreement := DayEnum <> DefaultWeekSelectionEnum;

                    if not AgreementSchedule.sr_IsLastRow then begin
                        if not IsMidWeekAgreement then begin
                            IF DateForWeek.Get(DateForWeek."Period Type"::Date, (AgreementSchedule."Staggered End Due Date")) then begin
                                GetWeekDay(DayEnum, DateForWeek."Period Name");
                                IsMidWeekAgreement := DayEnum <> DefaultWeekSelectionEnum;
                                IsStaggeredEnDDateMidWeek := true;
                            end;
                        end;
                    end;
                    //SRBC-514 Start
                    EpaySchedule.Reset();
                    EpaySchedule.SetCurrentKey("Start Date");
                    EpaySchedule.SetAscending("Start Date", true);
                    EpaySchedule.SetRange("Agreement ID", AgreementSchedule.sr_agreementid);
                    EpaySchedule.SetRange("License ID", TempLicensee."Licensee ID");
                    EpaySchedule.SetFilter("Banking Account Info", '<>%1', NullGUID);
                    EpaySchedule.SetRange(Frequency, EpaySchedule.Frequency::Weekly);
                    EpaySchedule.SetRange("Payment Plan", false);
                    EpaySchedule.SetRange("Payment For", SalonRepublicSetup."LICENSE FEE");
                    EpaySchedule.SetRange(Inactive, false);
                    if AgreementSchedule.sr_feeduedate <> 0D then begin
                        EpaySchedule.SetFilter("Start Date", '<=%1', AgreementSchedule.sr_feeduedate);
                        EpaySchedule.SetFilter("End Date", '>=%1|%2', AgreementSchedule.sr_feeduedate - 1, 0D);
                    end else begin
                        EpaySchedule.SetFilter("Start Date", '<=%1', Today);
                        EpaySchedule.SetFilter("End Date", '>=%1|%2', Today, 0D);
                    end;
                    if EpaySchedule.FindLast() then begin
                        //SRBC-514 End
                        //If Full Week Agreement
                        If Not IsMidWeekAgreement then begin
                            FirstLineInsert := false;
                            //CalculateRecurringChargeForCRMRenewal(BankAccountInfo, AgreementSchedule, ACHPaymentList);//SRBC-441 JSG Old 29102025
                            // CalculateRecurringChargeForCRMRenewal(BankAccountInfo, AgreementSchedule, FindExistingEpayemntSchedule_lRec);//SRBC-441 JSG New 29102025//SRBC-514 24062026 
                            CalculateRecurringChargeForCRMRenewal(AgreementSchedule, EpaySchedule);//SRBC-514 24062026 

                            //InsertTmpEpaymentFromCRMRenewal(BankAccountInfo, ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 0, FindExistingEpayemntSchedule_lRec, ACHPaymentList);//SRBC-325//SRBC-441 JSG Old 29102025
                            // InsertTmpEpaymentFromCRMRenewal(BankAccountInfo, ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 0, FindExistingEpayemntSchedule_lRec);//SRBC-441 JSG New 29102025 //SRBC-514 24062026 
                            InsertTmpEpaymentFromCRMRenewal(ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 0, EpaySchedule);//SRBC-514 24062026 

                            InsertEpaymentForCRMRenewal(); //SR..BKP - 06/08/2024
                            ReadMultipleLine := true;
                        end;
                        if not ReadMultipleLine then begin
                            IsMidWeekThirdLine := false;
                            CheckChargesforLine3 := false;
                            //Mid Week Agreement - 1st Line
                            //CalculateRecurringChargeForCRMRenewal(BankAccountInfo, AgreementSchedule, ACHPaymentList);//SRBC-441 JSG Old 29102025
                            // CalculateRecurringChargeForCRMRenewal(BankAccountInfo, AgreementSchedule, FindExistingEpayemntSchedule_lRec);//SRBC-441 JSG New 29102025 //SRBC-514 24062026 
                            CalculateRecurringChargeForCRMRenewal(AgreementSchedule, EpaySchedule);//SRBC-514 24062026 
                                                                                                   //InsertTmpEpaymentFromCRMRenewal(BankAccountInfo, ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 1, FindExistingEpayemntSchedule_lRec, ACHPaymentList);//SRBC-325//SRBC-441 JSG Old 29102025
                                                                                                   // InsertTmpEpaymentFromCRMRenewal(BankAccountInfo, ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 1, FindExistingEpayemntSchedule_lRec);//SRBC-441 JSG New 29102025 //SRBC-514 24062026 
                            InsertTmpEpaymentFromCRMRenewal(ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 1, EpaySchedule);//SRBC-514 24062026 

                            FirstLineInsert := false;
                            //Mid Week Agreement - 2nd Line
                            //CalculateRecurringChargeForCRMRenewal(BankAccountInfo, AgreementSchedule, ACHPaymentList);//SRBC-441 JSG Old 29102025
                            // CalculateRecurringChargeForCRMRenewal(BankAccountInfo, AgreementSchedule, FindExistingEpayemntSchedule_lRec);//SRBC-441 JSG New 29102025 //SRBC-514 24062026 
                            CalculateRecurringChargeForCRMRenewal(AgreementSchedule, EpaySchedule);//SRBC-514 24062026 

                            //InsertTmpEpaymentFromCRMRenewal(BankAccountInfo, ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 2, FindExistingEpayemntSchedule_lRec, ACHPaymentList);//SRBC-325//SRBC-441 JSG Old 29102025
                            // InsertTmpEpaymentFromCRMRenewal(BankAccountInfo, ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 2, FindExistingEpayemntSchedule_lRec);//SRBC-441 JSG New 29102025 //SRBC-514 24062026 
                            InsertTmpEpaymentFromCRMRenewal(ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 2, EpaySchedule);//SRBC-441 JSG New 29102025 //SRBC-514 24062026
                            if not IsMidWeekThirdLine then
                                InsertEpaymentForCRMRenewal(); //SR..BKP - 06/08/2024

                            //Midweek agreement - 3line
                            if IsMidWeekThirdLine then begin
                                CheckChargesforLine3 := true;
                                //CalculateRecurringChargeForCRMRenewal(BankAccountInfo, AgreementSchedule, ACHPaymentList);//SRBC-441 JSG Old 29102025
                                // CalculateRecurringChargeForCRMRenewal(BankAccountInfo, AgreementSchedule, FindExistingEpayemntSchedule_lRec);//SRBC-441 JSG New 29102025 //SRBC-514 24062026
                                CalculateRecurringChargeForCRMRenewal(AgreementSchedule, EpaySchedule);//SRBC-441 JSG New 29102025 //SRBC-514 24062026

                                //InsertTmpEpaymentFromCRMRenewal(BankAccountInfo, ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 3, FindExistingEpayemntSchedule_lRec, ACHPaymentList);//SRBC-325//SRBC-441 JSG Old 29102025
                                // InsertTmpEpaymentFromCRMRenewal(BankAccountInfo, ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 3, FindExistingEpayemntSchedule_lRec);//SRBC-441 JSG New 29102025 //SRBC-514 24062026
                                InsertTmpEpaymentFromCRMRenewal(ReccCharges_iRec, AgreementSchedule, Frquency::Weekly, IsCreatedFromBankInfo_gBln, 3, EpaySchedule);//SRBC-441 JSG New 29102025 //SRBC-514 24062026
                                InsertEpaymentForCRMRenewal(); //SR..BKP - 06/08/2024
                            end;
                        end;
                    end;
                    //SRBC-514 24062026
                end;//SRBC-463 JSG 19122025
            //until ACHPaymentList.Next() = 0;//SRBC-441 JSG Old 29102025
            until TempLicensee.Next() = 0;//SRBC-441 JSG New 29102025
        end;
    end;

    //Temp Table  
    //local procedure InsertTmpEpaymentFromCRMRenewal(var BankAccInfo: Record "Banking Account Info"; var ReccCharges: record "Recurring Charges"; var AS_iRec: Record "Agreement Schedule"; Frquency: Enum "Recurring Charge Frequency"; IsCreatedFromBankInfo: Boolean; MidWeekLineNo: Integer; Epay_iRec: Record "E Payment Schedule"; ACHPayList: Record "ACH Payment List")//SRBC-325 //SRBC-441 JSG Old 29102025
    // local procedure InsertTmpEpaymentFromCRMRenewal(var BankAccInfo: Record "Banking Account Info"; var ReccCharges: record "Recurring Charges"; var AS_iRec: Record "Agreement Schedule"; Frquency: Enum "Recurring Charge Frequency"; IsCreatedFromBankInfo: Boolean; MidWeekLineNo: Integer; Epay_iRec: Record "E Payment Schedule")//SRBC-441 JSG New 29102025 //SRBC-514 24062026 
    local procedure InsertTmpEpaymentFromCRMRenewal(var ReccCharges: record "Recurring Charges"; var AS_iRec: Record "Agreement Schedule"; Frquency: Enum "Recurring Charge Frequency"; IsCreatedFromBankInfo: Boolean;
                                                                                                                                                         MidWeekLineNo: Integer;
                                                                                                                                                         Epay_iRec: Record "E Payment Schedule")//SRBC-514 24062026 
    var
        SRsetup: Record "Salon Republic Setup";
        EpayemntSchedule: Record "E Payment Schedule";
        Agreement: Record Agreements;
    begin

        SRsetup.Get();
        SRsetup.TestField("Convenience Fee");
        AmountWithConvFee := SRsetup."Convenience Fee";
        //Epayment Creation From Banking account Info.

        EntryNo += 1;
        TmpEPaymentScheduleRec.Init();
        TmpEPaymentScheduleRec."Entry No." := EntryNo;
        TmpEPaymentScheduleRec.Validate(Payer, Epay_iRec.Payer); //- AEH..BKP - 06/08/2024

        //SRBC-175
        //TmpEPaymentScheduleRec.Validate("Share %", SharePercent_gDec);//SRBC-405 JSG 19092025 Old
        TmpEPaymentScheduleRec.Validate("Share %", SharePercentageForRemewal);//SRBC-405 JSG 19092025 New
        TmpEPaymentScheduleRec.Validate("AS Sequence", AS_iRec.Sequence);
        // TmpEPaymentScheduleRec.Validate("Customer No.", BankAccInfo."BC Customer Code");//SRBC-325
        //TmpEPaymentScheduleRec.Validate("Customer No.", ACHPayList."Customer No.");//SRBC-325//SRBC-441 JSG Old 29102025
        TmpEPaymentScheduleRec.Validate("Customer No.", Epay_iRec."Customer No.");//SRBC-441 JSG New 29102025
        //TmpEPaymentScheduleRec.Validate(Amount, TotalAmountShare_gDec);//SRBC-405 JSG 19092025 Old
        TmpEPaymentScheduleRec.Validate(Amount, Deposit);//SRBC-405 JSG 19092025 New
        //TmpEPaymentScheduleRec.Validate("BC Cust. Bank Account", CustBankAccountNo_gCod);//SRBC-441 JSG Old 29102025
        TmpEPaymentScheduleRec.Validate("BC Cust. Bank Account", Epay_iRec."BC Cust. Bank Account");//SRBC-441 JSG New 29102025
        // TmpEPaymentScheduleRec.Validate("Banking Account Info", BankAccInfo.sr_bankingaccountinfoId);//SRBC-325
        //TmpEPaymentScheduleRec.Validate("Banking Account Info", ACHPayList."Bank Account Info ID");//SRBC-325//SRBC-325//SRBC-441 JSG Old 29102025
        TmpEPaymentScheduleRec.Validate("Banking Account Info", Epay_iRec."Banking Account Info");//SRBC-441 JSG New 29102025
        //SRBC-175
        TmpEPaymentScheduleRec.Validate(EFrequency, Epay_iRec.EFrequency); //- AEH..BKP - 06/08/2024
        TmpEPaymentScheduleRec.Validate(Frequency, Frquency);
        // TmpEPaymentScheduleRec.Validate("Payment For", Epay_iRec."Payment For");//SRBC-473
        TmpEPaymentScheduleRec.Validate(Description, 'Epayment Schedule');
        // TmpEPaymentScheduleRec.Validate("Agreement ID", BankAccInfo.sr_agreement);//- AEH..BKP - 06/08/2024 //SRBC-325
        //TmpEPaymentScheduleRec.Validate("Agreement ID", ACHPayList."Agreement ID");//SRBC-325//SRBC-441 JSG Old 29102025
        TmpEPaymentScheduleRec.Validate("Agreement ID", AS_iRec.sr_agreementid);//SRBC-441 JSG New 29102025

        TmpEPaymentScheduleRec.Validate(sr_ConvenienceFee, AmountWithConvFee);
        //TmpEPaymentScheduleRec.Validate(sr_TotalAmount, TmpEPaymentScheduleRec.Amount + TmpEPaymentScheduleRec.sr_ConvenienceFee);//SRBC-405 JSG 19092025 old
        TmpEPaymentScheduleRec.Validate(sr_TotalAmount, Deposit + AmountWithConvFee);//SRBC-405 JSG 19092025 New
        TmpEPaymentScheduleRec.Validate("CRM Renewal", AS_iRec."CRM Renewal");
        TmpEPaymentScheduleRec.Validate(sr_renewalLADocuSign, AS_iRec.sr_renewalLADocuSign);//SRBC-405 20082025

        TmpEPaymentScheduleRec.Validate(Account, Epay_iRec.Account); //- AEH..BKP - 06/08/2024
        //SRBC-405 JSG 13092025 Start
        if AS_iRec.sr_IsLastRow then
            //TmpEPaymentScheduleRec.Validate("Payment Anticipated End Date", AS_iRec."Current Agrement End Date");//SRBC-405 JSG 19092025 old
            TmpEPaymentScheduleRec.Validate("Payment Anticipated End Date", AgreementEndDate);//SRBC-405 JSG 19092025 New

        //SRBC-405 JSG 19092025 Start  
        // if AS_iRec.new_abatementfee <> 0 then begin
        //     TmpEPaymentScheduleRec.Validate("Start Date", (ChargeStartDate + (AS_iRec."No. of Days for Disc")));
        // end else
        //     TmpEPaymentScheduleRec.Validate("Start Date", ChargeStartDate);
        //SRBC-405 JSG 19092025 End
        TmpEPaymentScheduleRec.Validate("Start Date", ChargeStartDate);
        //SRBC-405 JSG 13092025 End
        //SRBC-405 JSG 19092025 Start
        TmpEPaymentScheduleRec."Source Table ID" := Database::"Agreement Schedule";
        TmpEPaymentScheduleRec."Source Table RecordID" := AS_iRec.sr_agreementscheduleId;
        //SRBC-405 JSG 19092025 End
        TmpEPaymentScheduleRec.Validate("End Date", ChargeEndDate);

        TmpEPaymentScheduleRec.Validate("Payment End Date", ChargeEndDate);

        if MidWeekLineNo = 1 then
            //SRBC-405 JSG 13092025 Start
            if AS_iRec.new_abatementfee <> 0 then//SRBC-405 JSG 19092025
                TmpEPaymentScheduleRec.Validate("Start Date", (ChargeStartDate + (AS_iRec."No. of Days for Disc")))
            else//SRBC-405 JSG 19092025
                TmpEPaymentScheduleRec.Validate("Start Date", ChargeStartDate);
        //TmpEPaymentScheduleRec.Validate("Start Date", ChargeStartDate);
        //SRBC-405 JSG 13092025 End
        TmpEPaymentScheduleRec.Validate("End Date", ChargeEndDate);

        TmpEPaymentScheduleRec.Validate("Payment Start Date", AS_iRec.sr_feeduedate);
        // TmpEPaymentScheduleRec.Validate("License ID", BankAccInfo.sr_licenseeid);//SRBC-325
        //TmpEPaymentScheduleRec.Validate("License ID", ACHPayList."License ID");//SRBC-325//SRBC-441 JSG Old 29102025
        TmpEPaymentScheduleRec.Validate("License ID", Epay_iRec."License ID");//SRBC-441 JSG New 29102025
        TmpEPaymentScheduleRec.Validate("Agreement Schedule ID", AS_iRec.sr_agreementscheduleId);//SRBC-325
        TmpEPaymentScheduleRec.Validate(sr_IsBC, true);
        //SRBC-473 Start
        TmpEPaymentScheduleRec.Validate("Payment For", SRsetup."LICENSE FEE");
        // TmpEPaymentScheduleRec.Validate("Payment For Id", Epay_iRec."Payment For Id");
        //SRBC-473 End
        if FirstLineInsert then begin
            TmpEPaymentScheduleRec.Validate("Start Date", StartDateFirstLine);
            TmpEPaymentScheduleRec.Validate("End Date", EndDateFirstLine);
            TmpEPaymentScheduleRec.Validate(Amount, TotalAmountShareForFirstLine);
            TmpEPaymentScheduleRec.Validate("Share %", SharePercentageForFirstLine);
            TmpEPaymentScheduleRec.Validate(sr_TotalAmount, TmpEPaymentScheduleRec.Amount + TmpEPaymentScheduleRec.sr_ConvenienceFee);

        end else begin

        end;
        TmpEPaymentScheduleRec.Insert(true);
    end;

    local procedure InsertEpaymentForCRMRenewal()
    //Original Table
    var
        BankAccInfo: Record "Banking Account Info";
    begin
        MarkEPaymentScheduleRec.Reset();
        TmpEPaymentScheduleRec.Reset();
        IF TmpEPaymentScheduleRec.FindSet() then
            repeat
                EPaymentScheduleRec.Init();
                EPaymentScheduleRec.TransferFields(TmpEPaymentScheduleRec);
                EPaymentScheduleRec."Entry No." := 0;
                EPaymentScheduleRec.Insert(true);
                MarkEPaymentScheduleRec.SetRange("Entry No.", EPaymentScheduleRec."Entry No.");
                MarkEPaymentScheduleRec.FindFirst();
                MarkEPaymentScheduleRec.Mark(true);


            until TmpEPaymentScheduleRec.Next() = 0;
    end;

    //SRBC-207 - 08012025 -SY - Added parameter ACHPaymentList
    //local procedure CalculateRecurringChargeForCRMRenewal(var BankAccInfo: Record "Banking Account Info"; var AgreementSchedueRec: Record "Agreement Schedule"; ACHPaymentList: Record "ACH Payment List")//SRBC-441 JSG Old 29102025
    // local procedure CalculateRecurringChargeForCRMRenewal(var BankAccInfo: Record "Banking Account Info"; var AgreementSchedueRec: Record "Agreement Schedule"; var EPaymentScheduleRec: Record "E Payment Schedule")//SRBC-441 JSG New 29102025 //SRBC-514 24062026
    local procedure CalculateRecurringChargeForCRMRenewal(var AgreementSchedueRec: Record "Agreement Schedule"; var EPaymentScheduleRec: Record "E Payment Schedule")//SRBC-514 24062026
    var
        IsLastAgreementLine: Boolean;
        DiffDays: Integer;
        TmpDate: Date;
    begin
        //SRBC-405 JSG 19092025 End
        SRsetup.Get();
        SRsetup.TestField("Convenience Fee");
        AmountWithConvFee := SRsetup."Convenience Fee";
        SharePercentageForRemewal := 0;
        //SRBC-405 JSG 19092025 Start
        Deposit := 0;
        ChargeStartDate := 0D;
        ChargeEndDate := 0D;
        AgreementStartDate := 0D;
        AgreementEndDate := 0D;

        IsLastAgreementLine := AgreementSchedueRec.sr_IsLastRow;
        If not IsMidWeekAgreement then begin
            //Deposit := AgreementSchedueRec.sr_weeklylicensefee + 1;//SRBC-405 JSG 19092025 Old
            Deposit := TotalAmountShare_gDec;//SRBC-405 JSG 19092025 New
            SharePercentageForRemewal := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;//SRBC-405 JSG 19092025 New

            ChargeStartDate := AgreementSchedueRec.sr_feeduedate;

            AgreementStartDate := AgreementSchedueRec.sr_feeduedate;
            DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
            GetWeekDay(DayEnum, DateForWeek."Period Name");
            TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
            If IsLastAgreementLine then
                AgreementEndDate := AgreementSchedueRec."Current Agrement End Date"
            else
                ChargeEndDate := TmpDate;
            exit;
        end;

        //Check MidWeek Agreement 1st line inserted
        if not IsMidWeekThirdLine then begin
            TmpEPaymentScheduleRec.Reset();
            //TmpEPaymentScheduleRec.SetRange("Agreement ID", ACHPaymentList."Agreement ID");//SRBC-441 JSG Old 29102025
            TmpEPaymentScheduleRec.SetRange("Agreement ID", AgreementSchedueRec.sr_agreementid);//SRBC-441 JSG New 29102025
            //TmpEPaymentScheduleRec.SetRange("Banking Account Info", ACHPaymentList."Bank Account Info ID");//SRBC-441 JSG Old 29102025
            TmpEPaymentScheduleRec.SetRange("Banking Account Info", EPaymentScheduleRec."Banking Account Info");//SRBC-441 JSG New 29102025
            //TmpEPaymentScheduleRec.SetRange("License ID", ACHPaymentList."License ID");//SRBC-441 JSG Old 29102025
            TmpEPaymentScheduleRec.SetRange("License ID", EPaymentScheduleRec."License ID");//SRBC-441 JSG New 29102025
            //SRBC-405 JSG 19092025 Start
            //TmpEPaymentScheduleRec.SetRange("CRM Renewal", true);
            if AgreementSchedueRec."CRM Renewal" then
                TmpEPaymentScheduleRec.SetRange("CRM Renewal", true);
            if AgreementSchedueRec.sr_renewalLADocuSign then
                TmpEPaymentScheduleRec.SetRange(sr_renewalLADocuSign, true);
            //SRBC-405 JSG 19092025 Start
            IF TmpEPaymentScheduleRec.FindFirst() then begin
                //Deposit := AgreementSchedueRec.sr_weeklylicensefee;//SRBC-405 JSG 19092025 Old
                Deposit := TotalAmountShare_gDec;//SRBC-405 JSG 19092025 New
                SharePercentageForRemewal := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;//SRBC-405 JSG 19092025 New
                ChargeStartDate := CalcDate('1D', TmpEPaymentScheduleRec."End Date");
                AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
                GetWeekDay(DayEnum, DateForWeek."Period Name");

                //2ndline end date
                //If staggered end due date is sunday then take current week friday for line 2
                if DayEnum = DayEnum::Sunday then begin
                    TmpDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Staggered End Due Date");
                    if not IsLastAgreementLine then
                        IsMidWeekThirdLine := true;
                end else begin
                    if DayEnum = DayEnum::Saturday then begin
                        TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
                    end else begin
                        if not IsStaggeredEnDDateMidWeek then
                            TmpDate := CalcDate('CW-2W+5D', AgreementSchedueRec."Staggered End Due Date")
                        else
                            ChargeEndDate := AgreementSchedueRec."Staggered End Due Date" - 1;
                        if not IsStaggeredEnDDateMidWeek then
                            if not IsLastAgreementLine then
                                IsMidWeekThirdLine := true;
                    end;
                end;
                //2ndline end date
                //SRBC-405 JSG 19092025 Start
                If IsLastAgreementLine then
                    if not IsMidWeekThirdLine then
                        AgreementEndDate := AgreementSchedueRec."Staggered End Due Date";
                //SRBC-405 JSG 19092025 End
                if IsMidWeekThirdLine then
                    ChargeEndDate := TmpDate;

                if IsStaggeredEnDDateMidWeek then begin
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    //Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7; //SRBC-405 JSG 19092025 Old
                    TotalAmountShare_gDec := (AgreementSchedueRec.sr_weeklylicensefee * SharePercent_gDec) / 100; //SRBC-405 JSG 19092025 New
                    Deposit := (TotalAmountShare_gDec / 7) * DiffDays;//SRBC-405 JSG 19092025 New
                    SharePercentageForRemewal := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;//SRBC-405 JSG 19092025 New
                end;
                if IsLastAgreementLine then begin
                    ChargeEndDate := 0D;
                end;

            end else begin
                //LINE 1 INSERT

                if AgreementSchedueRec.new_abatementfee <> 0 then begin

                    ChargeStartDate := AgreementSchedueRec."Current Agrement Start Date" - 1;

                end else begin

                end;

                AgreementStartDate := AgreementSchedueRec.sr_feeduedate;

                if IsStaggeredEnDDateMidWeek then begin

                    DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
                    GetWeekDay(DayEnum, DateForWeek."Period Name");

                    if DayEnum = DayEnum::Sunday then begin
                        TmpDate := CalcDate('CW-1W+5D', AgreementSchedueRec."Staggered End Due Date");
                        //IsMidWeekThirdLine := true;
                    end else begin
                        if DayEnum = DayEnum::Saturday then begin
                            TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
                        end else begin
                            TmpDate := CalcDate('CW-2W+5D', AgreementSchedueRec."Staggered End Due Date");
                            //IsMidWeekThirdLine := true;
                        end;
                    end;

                    ChargeEndDate := TmpDate;
                end;

                if not IsStaggeredEnDDateMidWeek then begin
                    if DayEnum = DayEnum::Sunday then begin
                        ChargeStartDate := AgreementSchedueRec.sr_feeduedate;
                        ChargeEndDate := CalcDate('CW+5D', ChargeStartDate)
                    end else begin
                        if (ChargeStartDate = 0D) AND (AgreementStartDate <> 0D) then
                            ChargeStartDate := AgreementStartDate;
                        ChargeEndDate := CalcDate('CW-2D', ChargeStartDate);  //Calculate Till Friday just before Next Contract starts on Saturday
                    end;

                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    //Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7; //SRBC-405 JSG 19092025 Old
                    TotalAmountShare_gDec := (AgreementSchedueRec.sr_weeklylicensefee * SharePercent_gDec) / 100; //SRBC-405 JSG 19092025 New
                    Deposit := (TotalAmountShare_gDec / 7) * DiffDays;//SRBC-405 JSG 19092025 New
                    SharePercentageForRemewal := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;//SRBC-405 JSG 19092025 New
                end else begin
                    //Deposit := AgreementSchedueRec.sr_weeklylicensefee;//SRBC-405 JSG 19092025 Old
                    Deposit := TotalAmountShare_gDec;//SRBC-405 JSG 19092025 New
                    SharePercentageForRemewal := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;//SRBC-405 JSG 19092025 New
                end;


            end;

        end;


        if not IsLastAgreementLine then begin
            //MID WEEK 3rd LINE START
            //Check MidWeek Agreement 1st line inserted
            if (IsMidWeekThirdLine AND CheckChargesforLine3) then begin
                TmpEPaymentScheduleRec.Reset();
                //TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"ACH Payment List");//SRBC-405 JSG 19092025 old
                TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"Agreement Schedule");//SRBC-405 JSG 19092025 New
                TmpEPaymentScheduleRec.SetRange("Source Table RecordID", AgreementSchedueRec.sr_agreementscheduleId);//SRBC-405 JSG 19092025 New
                IF TmpEPaymentScheduleRec.Findlast() then begin
                    //Deposit := AgreementSchedueRec.sr_weeklylicensefee;//SRBC-405 JSG 19092025 Old
                    Deposit := TotalAmountShare_gDec;//SRBC-405 JSG 19092025 New
                    SharePercentageForRemewal := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;//SRBC-405 JSG 19092025 New
                    ChargeStartDate := CalcDate('1D', TmpEPaymentScheduleRec."End Date");
                    AgreementStartDate := AgreementSchedueRec."Current Agrement Start Date";
                    DateForWeek.Get(DateForWeek."Period Type"::Date, AgreementSchedueRec."Staggered End Due Date");
                    GetWeekDay(DayEnum, DateForWeek."Period Name");

                    //If staggered end due date is sunday then take current week friday for line 2

                    TmpDate := CalcDate('-1D', AgreementSchedueRec."Staggered End Due Date");
                    If IsLastAgreementLine then
                        AgreementEndDate := AgreementSchedueRec."Staggered End Due Date"
                    else
                        ChargeEndDate := TmpDate;

                    if ChargeEndDate <> 0D then
                        DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1
                    else
                        DiffDays := 1;  // Calculate from Saturday till start of agreement dates .
                    //Deposit := (AgreementSchedueRec.sr_weeklylicensefee * DiffDays) / 7; //SRBC-405 JSG 19092025 Old
                    TotalAmountShare_gDec := (AgreementSchedueRec.sr_weeklylicensefee * SharePercent_gDec) / 100; //SRBC-405 JSG 19092025 New
                    Deposit := (TotalAmountShare_gDec / 7) * DiffDays;//SRBC-405 JSG 19092025 New
                    SharePercentageForRemewal := (Deposit / AgreementSchedueRec.sr_weeklylicensefee) * 100;//SRBC-405 JSG 19092025 New
                end;

            end;
            //MID WEEK 3rd LINE END
        end;

    end;
    //JIRA SRBC-175`

    //procedure InsertEpaymentScheduleFromPaymentPlan(var PaymentPplan: Record "Agreement Payment Plan"; var EpaySchedule_iRec: record "E Payment Schedule"; var ACHPaymentList: Record "ACH Payment List")//SRBC-441 JSG Old 29102025
    procedure InsertEpaymentScheduleFromPaymentPlan(var PaymentPplan: Record "Agreement Payment Plan"; var EpaySchedule_iRec: record "E Payment Schedule")//SRBC-441 JSG New 29102025
    //SRBC-266
    var
        Frquency: Enum "Recurring Charge Frequency";
        SalonRepublicSetup: Record "Salon Republic Setup";
        DifferenceInDays: Integer;
    begin
        DifferenceInDays := 0;
        LessThanOrEqualTo7Days := false;
        IsFullWeekSecondLine := false;
        Is7DaysSecondLine := false;
        AgreementPaymentPlan := PaymentPplan;
        IsPlanStartDateMidWeek := false;
        AmountWithConvFee := 0;
        SalonRepublicSetup.Get();
        SalonRepublicSetup.TestField("Convenience Fee");
        AmountWithConvFee := SalonRepublicSetup."Convenience Fee";

        EntryNo := 0;
        IsMidWeekAgreement := false;
        TmpEPaymentScheduleRec.Reset();
        TmpEPaymentScheduleRec.DeleteAll();
        DefaultWeekSelectionEnum := DefaultWeekSelectionEnum::Saturday;

        IF DateForWeek.Get(DateForWeek."Period Type"::Date, PaymentPplan.sr_PlanStartDate) then
            GetWeekDay(DayEnum, DateForWeek."Period Name");

        IsMidWeekAgreement := DayEnum <> DefaultWeekSelectionEnum;
        IsPlanStartDateMidWeek := DayEnum <> DefaultWeekSelectionEnum; //NU

        if not IsMidWeekAgreement then begin
            IF DateForWeek.Get(DateForWeek."Period Type"::Date, (PaymentPplan.sr_EstimatedPlanCompletionDate)) then begin
                GetWeekDay(DayEnum, DateForWeek."Period Name");
                IsMidWeekAgreement := DayEnum <> DefaultWeekSelectionEnum;
                IsPlanEndDateMidWeek := DayEnum <> DefaultWeekSelectionEnum; //NU
                IsStaggeredEnDDateMidWeek := true;
                if (NOT IsPlanStartDateMidWeek AND IsPlanEndDateMidWeek) then
                    IsMidWeekAgreement := false;
            end;
        end;
        //Less Than equals to 7 days case
        DifferenceInDays := PaymentPplan.sr_EstimatedPlanCompletionDate - PaymentPplan.sr_PlanStartDate + 1;
        if DifferenceInDays <= 8 then
            LessThanOrEqualTo7Days := true;

        if LessThanOrEqualTo7Days then begin
            CalculateChargesForPaymentPlan(PaymentPplan);
            // InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, ACHPaymentList, EpaySchedule_iRec);//SRBC-441 JSG Old 29102025
            InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, EpaySchedule_iRec);//SRBC-441 JSG New 29102025
            if not Is7DaysSecondLine then
                InsertEpaymentFromPaymentPlan();
            if Is7DaysSecondLine then begin
                CalculateChargesForPaymentPlan(PaymentPplan);
                //InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, ACHPaymentList, EpaySchedule_iRec);//SRBC-441 JSG Old 29102025
                InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, EpaySchedule_iRec);//SRBC-441 JSG New 29102025
                InsertEpaymentFromPaymentPlan();
            end;
            exit;
        end;
        //Less Than equals to 7 days case


        //If Full Week Agreement
        If Not IsMidWeekAgreement then begin
            CalculateChargesForPaymentPlan(PaymentPplan);
            //InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, ACHPaymentList, EpaySchedule_iRec);//SRBC-441 JSG Old 29102025
            InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, EpaySchedule_iRec);//SRBC-441 JSG New 29102025
            if not IsFullWeekSecondLine then
                InsertEpaymentFromPaymentPlan();

            if IsFullWeekSecondLine then begin
                CalculateChargesForPaymentPlan(PaymentPplan);
                //InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, ACHPaymentList, EpaySchedule_iRec);//SRBC-441 JSG Old 29102025
                InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, EpaySchedule_iRec);//SRBC-441 JSG New 29102025
                InsertEpaymentFromPaymentPlan();
            end;

            exit;
        end;

        IsMidWeekThirdLine := false;
        CheckChargesforLine3 := false;
        //Mid Week Agreement - 1st Line

        CalculateChargesForPaymentPlan(PaymentPplan);
        //InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, ACHPaymentList, EpaySchedule_iRec);//SRBC-441 JSG Old 29102025
        InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, EpaySchedule_iRec);//SRBC-441 JSG New 29102025


        //Mid Week Agreement - 2nd Line
        CalculateChargesForPaymentPlan(PaymentPplan);
        //InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, ACHPaymentList, EpaySchedule_iRec);//SRBC-441 JSG Old 29102025
        InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, EpaySchedule_iRec);//SRBC-441 JSG New 29102025
        if not IsMidWeekThirdLine then
            InsertEpaymentFromPaymentPlan();

        //Midweek agreement - 3line
        if IsMidWeekThirdLine then begin
            CheckChargesforLine3 := true;
            CalculateChargesForPaymentPlan(PaymentPplan);
            //InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, ACHPaymentList, EpaySchedule_iRec);//SRBC-441 JSG Old 29102025
            InsertTmpEpaymentForPaymentPlan(PaymentPplan, Frquency::Weekly, EpaySchedule_iRec);//SRBC-441 JSG New 29102025
            InsertEpaymentFromPaymentPlan();
        end;


    end;

    local procedure CalculateChargesForPaymentPlan(var PaymentPlan: Record "Agreement Payment Plan")//SRBC-266
    var

        DiffDays: Integer;
        TmpDate: Date;
        IsDaysLessThan2Weeks: Integer;
    begin
        //IsFullWeekSecondLine := false;
        Deposit := 0;
        SharePercentage := 0;
        ChargeStartDate := 0D;
        ChargeEndDate := 0D;
        AgreementStartDate := 0D;
        AgreementEndDate := 0D;
        IsDaysLessThan2Weeks := 0;

        //Less then or equals to 7 days case
        if LessThanOrEqualTo7Days then begin
            Deposit := PaymentPlan.sr_TotalWeeklyPaymentAmount;
            TmpEPaymentScheduleRec.Reset();
            TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"Agreement Payment Plan");
            TmpEPaymentScheduleRec.SetRange("Source Table RecordID", AgreementPaymentPlan.sr_AgreementPaymentPlanId);
            if not TmpEPaymentScheduleRec.FindFirst() then begin //FIRST LINE

                DateForWeek.Get(DateForWeek."Period Type"::Date, PaymentPlan.sr_PlanStartDate);
                GetWeekDay(DayEnum, DateForWeek."Period Name");

                if DayEnum = DayEnum::Friday then begin //IF start date is Friday
                    ChargeStartDate := PaymentPlan.sr_PlanStartDate;
                    ChargeEndDate := ChargeStartDate;
                    Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * 1) / 7;
                    DiffDays := CalcDate('1D', PaymentPlan.sr_EstimatedPlanCompletionDate) - CalcDate('1D', ChargeStartDate) + 1;
                    if DiffDays > 1 then
                        Is7DaysSecondLine := true;
                end else begin
                    if DayEnum = DayEnum::Saturday then begin
                        ChargeStartDate := PaymentPlan.sr_PlanStartDate;
                        ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate;
                        DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;
                        if DiffDays <> 0 then
                            Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
                        Is7DaysSecondLine := false;
                    end else begin //Neither Friday Nor Saturday
                        ChargeStartDate := PaymentPlan.sr_PlanStartDate;

                        DateForWeek.Get(DateForWeek."Period Type"::Date, PaymentPlan.sr_EstimatedPlanCompletionDate);
                        GetWeekDay(FullWeekEnumPaymentPlan, DateForWeek."Period Name"); //check end date

                        if FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Friday then begin
                            ChargeEndDate := CalcDate('CW-2D', ChargeStartDate);
                            DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;
                            if DiffDays <> 0 then
                                Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
                            Is7DaysSecondLine := false;
                        end else begin //Start date Fall on any midweek and end date any midweek
                            ChargeStartDate := PaymentPlan.sr_PlanStartDate;
                            DiffDays := CalcDate('1D', PaymentPlan.sr_EstimatedPlanCompletionDate) - CalcDate('1D', ChargeStartDate) + 1;
                            if DiffDays > 5 then begin
                                Is7DaysSecondLine := true;
                                ChargeEndDate := CalcDate('CW-2D', ChargeStartDate);
                                DiffDays := 0;
                                DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;
                                Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
                            end else begin
                                ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate;
                                DiffDays := 0;
                                DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;
                                Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
                            end;
                        end;
                    end;
                end;
            end else begin //SECOND LINE
                ChargeStartDate := TmpEPaymentScheduleRec."End Date" + 1;
                ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate;
                DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;
                Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
            end;
            exit;
        end;



        //Full Week Case
        If not IsMidWeekAgreement then begin
            Deposit := PaymentPlan.sr_TotalWeeklyPaymentAmount;
            if (Deposit <> 0) then
                SharePercentage := (Deposit / PaymentPlan.sr_TotalWeeklyPaymentAmount) * 100;
            TmpEPaymentScheduleRec.Reset();
            TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"Agreement Payment Plan");
            TmpEPaymentScheduleRec.SetRange("Source Table RecordID", AgreementPaymentPlan.sr_AgreementPaymentPlanId);
            if not TmpEPaymentScheduleRec.FindFirst() then begin
                ChargeStartDate := PaymentPlan.sr_PlanStartDate;
                AgreementStartDate := PaymentPlan.sr_PlanStartDate;
                DateForWeek.Get(DateForWeek."Period Type"::Date, PaymentPlan.sr_PlanStartDate);
                GetWeekDay(DayEnum, DateForWeek."Period Name");
                TmpDate := CalcDate('CW-1W+5D', PaymentPlan.sr_PlanStartDate);
                ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate;

                //Case 1 if Start Date and End Date is Saturday then create 2 Epay Lines
                DateForWeek.Get(DateForWeek."Period Type"::Date, PaymentPlan.sr_EstimatedPlanCompletionDate);
                GetWeekDay(FullWeekEnumPaymentPlan, DateForWeek."Period Name");

                if FullWeekEnumPaymentPlan <> FullWeekEnumPaymentPlan::Friday then begin
                    IsFullWeekSecondLine := true;
                    if (FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Saturday) then
                        ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate - 1;
                    if (FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Sunday) then
                        ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate - 2;
                    if (FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Monday) then
                        ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate - 3;
                    if (FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Tuesday) then
                        ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate - 4;
                    if (FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Wednesday) then
                        ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate - 5;
                    if (FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Thursday) then
                        ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate - 6;
                end;
                exit;
            end else begin
                if IsFullWeekSecondLine then begin
                    ChargeStartDate := TmpEPaymentScheduleRec."End Date" + 1;
                    AgreementStartDate := TmpEPaymentScheduleRec."End Date";
                    ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate;
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;
                    //if FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Saturday then
                    Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
                    //else if FullWeekEnumPaymentPlan = FullWeekEnumPaymentPlan::Sunday then
                    //    Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * 2) / 7;
                end;
                exit;
            end;
        end;

        //###MIDWEEK Case START
        //Midweek Line 2 Charges
        if not IsMidWeekThirdLine then begin
            TmpEPaymentScheduleRec.Reset();
            TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"Agreement Payment Plan");
            TmpEPaymentScheduleRec.SetRange("Source Table RecordID", AgreementPaymentPlan.sr_AgreementPaymentPlanId);
            IF TmpEPaymentScheduleRec.FindFirst() then begin
                Deposit := PaymentPlan.sr_TotalWeeklyPaymentAmount;
                ChargeStartDate := CalcDate('1D', TmpEPaymentScheduleRec."End Date");
                AgreementStartDate := PaymentPlan.sr_PlanStartDate;

                DateForWeek.Get(DateForWeek."Period Type"::Date, PaymentPlan.sr_EstimatedPlanCompletionDate);
                GetWeekDay(DayEnum, DateForWeek."Period Name");

                IsPlanEndDateMidWeek := DayEnum <> DefaultWeekSelectionEnum; //NU

                //If staggered end due date is sunday then take current week friday for line 2
                if DayEnum = DayEnum::Sunday then begin
                    TmpDate := CalcDate('CW-1W+5D', PaymentPlan.sr_EstimatedPlanCompletionDate);
                    IsMidWeekThirdLine := true;
                end else begin
                    if DayEnum = DayEnum::Saturday then begin
                        TmpDate := CalcDate('-1D', PaymentPlan.sr_EstimatedPlanCompletionDate);
                        IsMidWeekThirdLine := true;
                    end else begin
                        if DayEnum = DayEnum::Friday then begin
                            IsMidWeekThirdLine := false;
                            IsStaggeredEnDDateMidWeek := true;
                            TmpDate := PaymentPlan.sr_EstimatedPlanCompletionDate;
                        end else begin
                            if IsPlanStartDateMidWeek AND IsPlanEndDateMidWeek THEN begin
                                IsDaysLessThan2Weeks := CalcDate('1D', PaymentPlan.sr_EstimatedPlanCompletionDate) - CalcDate('1D', PaymentPlan.sr_PlanStartDate) + 1;
                                IF IsDaysLessThan2Weeks > 14 then begin
                                    TmpDate := CalcDate('CW-2W+5D', PaymentPlan.sr_EstimatedPlanCompletionDate);
                                    IsMidWeekThirdLine := true;
                                end else begin
                                    IF IsDaysLessThan2Weeks <= 14 then begin
                                        TmpDate := PaymentPlan.sr_EstimatedPlanCompletionDate;
                                        IsMidWeekThirdLine := false;
                                    end else begin
                                        //if DayEnum = DayEnum::Monday then
                                    end;
                                end;
                            end;
                            //ChargeEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate;
                            // IsStaggeredEnDDateMidWeek := true;
                            // if not IsStaggeredEnDDateMidWeek then
                            //     IsMidWeekThirdLine := true;
                        end;
                    end;
                end;


                if TmpDate <> 0D then
                    ChargeEndDate := TmpDate;

                if IsStaggeredEnDDateMidWeek then begin
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    if DiffDays >= 7 then
                        Deposit := PaymentPlan.sr_TotalWeeklyPaymentAmount
                    else
                        Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
                end;
                //Midweek Line 2 Charges
            end else begin
                //Midweek Line 1 Charges

                ChargeStartDate := PaymentPlan.sr_PlanStartDate;

                AgreementStartDate := PaymentPlan.sr_PlanStartDate;

                if IsStaggeredEnDDateMidWeek then begin

                    DateForWeek.Get(DateForWeek."Period Type"::Date, PaymentPlan.sr_EstimatedPlanCompletionDate);
                    GetWeekDay(DayEnum, DateForWeek."Period Name");

                    if DayEnum = DayEnum::Sunday then begin
                        TmpDate := CalcDate('CW-1W+5D', PaymentPlan.sr_EstimatedPlanCompletionDate);

                    end else begin
                        if DayEnum = DayEnum::Saturday then begin
                            TmpDate := CalcDate('-1D', PaymentPlan.sr_EstimatedPlanCompletionDate);
                        end else begin
                            TmpDate := CalcDate('CW-2W+5D', PaymentPlan.sr_EstimatedPlanCompletionDate);

                        end;
                    end;
                    if TmpDate <> 0D then
                        ChargeEndDate := TmpDate;
                end;

                if not IsStaggeredEnDDateMidWeek then begin
                    if DayEnum = DayEnum::Sunday then
                        ChargeEndDate := CalcDate('CW+5D', ChargeStartDate)
                    else
                        ChargeEndDate := CalcDate('CW-2D', ChargeStartDate);  //Calculate Till Friday just before Next Contract starts on Saturday. 
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1;  // Calculate from Saturday till start of agreement dates .
                    Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
                end else begin
                    Deposit := PaymentPlan.sr_TotalWeeklyPaymentAmount;
                end;

            end;

        end;
        //Midweek Line 3 Charges
        if (IsMidWeekThirdLine AND CheckChargesforLine3) then begin
            TmpEPaymentScheduleRec.Reset();
            TmpEPaymentScheduleRec.SetRange("Source Table ID", Database::"Agreement Payment Plan");
            TmpEPaymentScheduleRec.SetRange("Source Table RecordID", PaymentPlan.sr_AgreementPaymentPlanId);
            IF TmpEPaymentScheduleRec.Findlast() then begin
                Deposit := PaymentPlan.sr_TotalWeeklyPaymentAmount;
                ChargeStartDate := CalcDate('1D', TmpEPaymentScheduleRec."End Date");
                AgreementStartDate := PaymentPlan.sr_PlanStartDate;
                DateForWeek.Get(DateForWeek."Period Type"::Date, PaymentPlan.sr_EstimatedPlanCompletionDate);
                GetWeekDay(DayEnum, DateForWeek."Period Name");

                TmpDate := CalcDate('-1D', PaymentPlan.sr_EstimatedPlanCompletionDate);

                AgreementEndDate := PaymentPlan.sr_EstimatedPlanCompletionDate;

                ChargeEndDate := AgreementEndDate;

                if ChargeEndDate <> 0D then
                    DiffDays := CalcDate('1D', ChargeEndDate) - CalcDate('1D', ChargeStartDate) + 1
                else
                    DiffDays := 1;  // Calculate from Saturday till start of agreement dates .
                Deposit := (PaymentPlan.sr_TotalWeeklyPaymentAmount * DiffDays) / 7;
            end;

        end;
        //Midweek Line 3 Charges
        //###MIDWEEK Case END
    end;
    //local procedure InsertTmpEpaymentForPaymentPlan(var paymentplan: Record "Agreement Payment Plan"; Frquency: Enum "Recurring Charge Frequency"; var ACHPaymentList: Record "ACH Payment List"; var EpaySchedule_iRec: record "E Payment Schedule")// SRBC-441 Old New 29102025
    local procedure InsertTmpEpaymentForPaymentPlan(var paymentplan: Record "Agreement Payment Plan"; Frquency: Enum "Recurring Charge Frequency"; var EpaySchedule_iRec: record "E Payment Schedule")//SRBC-441 JSG New 29102025
    //SRBC-266
    var
        SRsetup: Record "Salon Republic Setup";
        Customer_lRec: Record Customer;
        Agreement: Record Agreements;
    begin

        SRsetup.Get();
        SRsetup.TestField("Convenience Fee");
        AmountWithConvFee := SRsetup."Convenience Fee";

        EntryNo += 1;
        TmpEPaymentScheduleRec.Init();
        TmpEPaymentScheduleRec."Entry No." := EntryNo;
        TmpEPaymentScheduleRec.Validate(Payer, paymentplan.sr_LicThirdPartyEnteringPay);
        TmpEPaymentScheduleRec.Validate(Frequency, Frquency);
        TmpEPaymentScheduleRec.Validate(Description, 'Epayment Schedule');
        TmpEPaymentScheduleRec.Validate("Agreement ID", paymentplan."sr_Agreement");
        TmpEPaymentScheduleRec.Validate(Amount, Deposit);

        if not IsNullGuid(paymentplan.sr_AgreementPaymentPlanId) then begin
            TmpEPaymentScheduleRec."Payment Plan ID" := paymentplan.sr_AgreementPaymentPlanID;
            Customer_lRec.Reset();
            Customer_lRec.SetRange("CRM Agreement ID", paymentplan.sr_Agreement);
            if Customer_lRec.FindFirst() then
                TmpEPaymentScheduleRec."Customer No." := Customer_lRec."No.";
        end;

        //TmpEPaymentScheduleRec.Validate("Share %", SharePercentage);//SRBC-405 JSG 19092025

        TmpEPaymentScheduleRec.Validate(sr_ConvenienceFee, AmountWithConvFee);
        TmpEPaymentScheduleRec.Validate(sr_TotalAmount, TmpEPaymentScheduleRec.Amount + TmpEPaymentScheduleRec.sr_ConvenienceFee);
        TmpEPaymentScheduleRec.Validate("Start Date", ChargeStartDate);
        TmpEPaymentScheduleRec.Validate("End Date", ChargeEndDate);
        TmpEPaymentScheduleRec.Validate("Payment End Date", ChargeEndDate);
        // TmpEPaymentScheduleRec.Validate("Payment For", TmpEPaymentScheduleRec."Payment For"::"Payment Plan"); //SRBC-473  AM 29042026

        //SRBC-441 JSG Start 29102025
        // if Format(ACHPaymentList."Bank Account Info ID") <> '' then
        //     TmpEPaymentScheduleRec.Validate("Banking Account Info", ACHPaymentList."Bank Account Info ID")
        // else
        //     TmpEPaymentScheduleRec.Validate("Banking Account Info", EpaySchedule_iRec."Banking Account Info");

        // if ACHPaymentList."BC Cust. Bank Account" <> '' then
        //     TmpEPaymentScheduleRec.Validate("BC Cust. Bank Account", ACHPaymentList."BC Cust. Bank Account")
        // else
        //     TmpEPaymentScheduleRec.Validate("BC Cust. Bank Account", EpaySchedule_iRec."BC Cust. Bank Account");

        // if ACHPaymentList.sr_accountname <> '' then
        //     TmpEPaymentScheduleRec.Validate(Account, ACHPaymentList.sr_accountname)
        // else
        //     TmpEPaymentScheduleRec.Validate(Account, EpaySchedule_iRec.Account);

        // TmpEPaymentScheduleRec.Validate("ACH Payment ID", ACHPaymentList."ACH Payments ID");

        if Format(paymentplan."Bank Account Info ID") <> '' then
            TmpEPaymentScheduleRec.Validate("Banking Account Info", paymentplan."Bank Account Info ID")
        else
            TmpEPaymentScheduleRec.Validate("Banking Account Info", EpaySchedule_iRec."Banking Account Info");

        if paymentplan."BC Cust. Bank Account" <> '' then
            TmpEPaymentScheduleRec.Validate("BC Cust. Bank Account", paymentplan."BC Cust. Bank Account")
        else
            TmpEPaymentScheduleRec.Validate("BC Cust. Bank Account", EpaySchedule_iRec."BC Cust. Bank Account");

        if paymentplan.accountname <> '' then
            TmpEPaymentScheduleRec.Validate(Account, paymentplan.accountname)
        else
            TmpEPaymentScheduleRec.Validate(Account, EpaySchedule_iRec.Account);
        //SRBC-441 JSG End 29102025

        Evaluate(TmpEPaymentScheduleRec."License ID", paymentplan.sr_LicThirdPartyEnteringPay);
        TmpEPaymentScheduleRec.Validate("Payment Plan", true);
        TmpEPaymentScheduleRec.Validate(sr_IsBC, true);
        TmpEPaymentScheduleRec."Source Table ID" := Database::"Agreement Payment Plan";
        TmpEPaymentScheduleRec."Source Table RecordID" := paymentplan.sr_AgreementPaymentPlanId;
        TmpEPaymentScheduleRec.Validate("Payment For", SRsetup."Payment Plan");//SRBC-473 16062026 
        TmpEPaymentScheduleRec.Insert(true);

    end;

    local procedure InsertEpaymentFromPaymentPlan() //SRBC-266
    var
        PaymentPlan_lRec: Record "Agreement Payment Plan";
    begin
        MarkEPaymentScheduleRec.Reset();
        TmpEPaymentScheduleRec.Reset();
        IF TmpEPaymentScheduleRec.FindSet() then begin
            repeat
                EPaymentScheduleRec.Init();
                EPaymentScheduleRec.TransferFields(TmpEPaymentScheduleRec);
                EPaymentScheduleRec."Entry No." := 0;
                EPaymentScheduleRec.Insert(true);
                MarkEPaymentScheduleRec.SetRange("Entry No.", EPaymentScheduleRec."Entry No.");
                MarkEPaymentScheduleRec.FindFirst();
                MarkEPaymentScheduleRec.Mark(true);
            until TmpEPaymentScheduleRec.Next() = 0;
        end
    end;
    //SRBC-227 - Start
    procedure CalculateEpaymentScheduleNextPaymentDate(EpaymentSchedule: Record "E Payment Schedule") NextPaymentDate: Date
    var

    begin
        NextPaymentDate := 0D;
        repeat
            Case EpaymentSchedule.Frequency of
                //SRBC-297 Start
                EpaymentSchedule.Frequency::Once:
                    begin
                        NextPaymentDate := 0D;
                        exit;
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
        until NextPaymentDate > Today();
    end;
    //SRBC-227 - End

    //SRBC-348 - Start
    [EventSubscriber(ObjectType::Table, Database::"Banking Account Info", OnAfterModifyEvent, '', false, false)]
    local procedure T21_AfterModifyEvent(var Rec: Record "Banking Account Info");
    var
        ACHPaymentList: Record "ACH Payment List";
    begin
        if Rec."BC Cust. Bank Account" <> '' then begin
            ACHPaymentList.Reset();
            ACHPaymentList.SetRange("Bank Account Info ID", Rec.sr_bankingaccountinfoId);
            if ACHPaymentList.FindSet() then
                repeat
                    if (ACHPaymentList."BC Cust. Bank Account" <> Rec."BC Cust. Bank Account") or (ACHPaymentList.sr_accountname <> Rec.sr_accountname) then begin
                        ACHPaymentList.Validate("BC Cust. Bank Account", Rec."BC Cust. Bank Account");
                        ACHPaymentList.Validate(sr_accountname, Rec.sr_accountname);
                        ACHPaymentList.Modify();
                    end;
                until ACHPaymentList.Next() = 0;
        end;
    end;
    //SRBC-348  - End

    //SRBC-441 JSG Start
    procedure CreateEPaymentFromPaymentPlan(AgreementPaymentPlanList: Record "Agreement Payment Plan")
    var
        SRSetup: Record "Salon Republic Setup";
        StartDayOfWeek: Integer;
        EndDayOfWeek: Integer;
        EpaymentSchedule: Record "E Payment Schedule";
    begin
        SRSetup.Get;
        SRSetup.TestField("Convenience Fee");
        //SRBC-447 Start
        // if (AgreementPaymentPlanList.sr_TotalWeeklyPaymentAmount = 0) or
        //    (AgreementPaymentPlanList.sr_WeeklyAdditionalPaymentAmt = 0) or
        //    (AgreementPaymentPlanList.sr_typeofpaymentplan <> AgreementPaymentPlanList.sr_typeofpaymentplan::"E-Payment") then
        //     exit;
        if (AgreementPaymentPlanList.sr_TotalWeeklyPaymentAmount = 0) or
           (AgreementPaymentPlanList.sr_WeeklyAdditionalPaymentAmt = 0) or
           (AgreementPaymentPlanList.sr_typeofpaymentplan <> AgreementPaymentPlanList.sr_typeofpaymentplan::"E-Payment") or (AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate = 0D) or
            (AgreementPaymentPlanList.sr_PlanStartDate = 0D) or (IsNullGuid(AgreementPaymentPlanList.sr_Agreement)) or (IsNullGuid(AgreementPaymentPlanList."Bank Account Info ID")) or
            (IsNullGuid(AgreementPaymentPlanList.sr_LicThirdPartyEnteringPay)) or (AgreementPaymentPlanList."Stripe Payment Method Status" <> 'active') then
            exit;
        //SRBC-447 End

        EpaymentSchedule.Reset();
        EpaymentSchedule.SetCurrentKey("Payment Start Date");
        EpaymentSchedule.SetRange("Agreement ID", AgreementPaymentPlanList.sr_Agreement);
        EpaymentSchedule.SetRange("License ID", AgreementPaymentPlanList.sr_LicThirdPartyEnteringPay);
        EpaymentSchedule.SetRange(Frequency, EpaymentSchedule.Frequency::Weekly);
        EpaymentSchedule.SetRange(Inactive, false);
        EpaymentSchedule.SetFilter("Start Date", '<=%1', AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate);
        if EpaymentSchedule.FindSet() then begin

            // Determine the day of week numbers (1=Monday ... 7=Sunday)
            StartDayOfWeek := Date2DWY(AgreementPaymentPlanList.sr_PlanStartDate, 1);
            EndDayOfWeek := Date2DWY(AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate, 1);

            // CASE 1: Payment Plan Full week - Starts on Saturday, Ends on Friday
            if (StartDayOfWeek = 6) and (EndDayOfWeek = 5) then begin
                ProcessFullWeekPlan(AgreementPaymentPlanList, SRSetup);
            end
            else begin
                // CASE 2: Payment Plan Mid week (Start ≠ Saturday or End ≠ Friday)
                ProcessMidWeekPlan(AgreementPaymentPlanList, SRSetup);
            end;
        end else
            CreatePaymentPlan(AgreementPaymentPlanList);
    end;


    // =========================================
    // CASE 1: Full Week Plan (Existing Logic)
    // =========================================
    local procedure ProcessFullWeekPlan(AgreementPaymentPlanList: Record "Agreement Payment Plan"; SRSetup: Record "Salon Republic Setup")
    var
        EpaymentSchedule: Record "E Payment Schedule";
        EpaySchedulePaymentPlan: Record "E Payment Schedule";
        EpayScheduleExistingLine: Record "E Payment Schedule";
    begin
        SRSetup.Get();//SRBC-473 18062026
        EpaymentSchedule.Reset();
        EpaymentSchedule.SetCurrentKey("Payment Start Date");
        EpaymentSchedule.SetRange("Agreement ID", AgreementPaymentPlanList.sr_Agreement);
        EpaymentSchedule.SetRange("License ID", AgreementPaymentPlanList.sr_LicThirdPartyEnteringPay);
        EpaymentSchedule.SetRange(Frequency, EpaymentSchedule.Frequency::Weekly);
        EpaymentSchedule.SetRange(Inactive, false);
        EpaymentSchedule.SetFilter("Start Date", '<=%1', AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate);
        if EpaymentSchedule.FindSet() then begin
            repeat
                if (EpaymentSchedule."Payment Plan ID" = AgreementPaymentPlanList.sr_AgreementPaymentPlanId) or
                   ((EpaymentSchedule."End Date" < AgreementPaymentPlanList.sr_PlanStartDate) and (EpaymentSchedule."End Date" <> 0D)) then
                    continue
                else begin
                    // Create New E-Payment Schedule Lines
                    EpaySchedulePaymentPlan.Reset();
                    EpaySchedulePaymentPlan.Init();
                    EpaySchedulePaymentPlan.TransferFields(EpaymentSchedule, false);
                    EpaySchedulePaymentPlan."Entry No." := 0;
                    EpaySchedulePaymentPlan.Validate("Payment Plan ID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);

                    if EpaySchedulePaymentPlan."Start Date" < AgreementPaymentPlanList.sr_PlanStartDate then
                        EpaySchedulePaymentPlan.Validate("Start Date", AgreementPaymentPlanList.sr_PlanStartDate);
                    if (EpaySchedulePaymentPlan."End Date" > AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate) or
                       (EpaySchedulePaymentPlan."End Date" = 0D) then
                        EpaySchedulePaymentPlan.Validate("End Date", AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate);

                    EpaySchedulePaymentPlan.Validate("Payment Anticipated End Date", 0D);
                    EpaySchedulePaymentPlan.Validate("Last Charged Date", 0D);//SRBC-471 JSG 190126
                    EpaySchedulePaymentPlan.Validate("Next Charge Date", 0D);//SRBC-471 JSG 190126
                    EpaySchedulePaymentPlan.Validate(sr_ConvenienceFee, SRSetup."Convenience Fee");
                    EpaySchedulePaymentPlan.Validate(Amount, EpaySchedulePaymentPlan.Amount + AgreementPaymentPlanList.sr_WeeklyAdditionalPaymentAmt);
                    EpaySchedulePaymentPlan.Validate(sr_TotalAmount, EpaySchedulePaymentPlan.Amount + EpaySchedulePaymentPlan.sr_ConvenienceFee);
                    EpaySchedulePaymentPlan.Validate("Share %", 0);
                    EpaySchedulePaymentPlan.Validate("Payment Plan", true);
                    // EpaySchedulePaymentPlan.Validate("Payment For", EpaySchedulePaymentPlan."Payment For"::"Payment Plan");//SRBC-473  AM 29042026
                    EpaySchedulePaymentPlan.Validate("CRM Renewal", false);
                    EpaySchedulePaymentPlan.Validate(sr_renewalLADocuSign, false);
                    EpaySchedulePaymentPlan.Validate("Source Table ID", Database::"Agreement Payment Plan");
                    EpaySchedulePaymentPlan.Validate("Source Table RecordID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                    EpaySchedulePaymentPlan.Validate(sr_IsBC, true);//SRBC-489
                    EpaySchedulePaymentPlan.Validate(sr_IsCRM, false);//SRBC-489
                    EpaySchedulePaymentPlan.Validate("Payment For", SRSetup."Payment Plan"); //SRBC-473 16062026
                    EpaySchedulePaymentPlan.Insert();

                    // Recreate Remaining Lines (After Plan Ends)
                    if (EpaymentSchedule."End Date" > AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate) or (EpaymentSchedule."End Date" = 0D) then begin
                        EpayScheduleExistingLine.Reset();
                        EpayScheduleExistingLine.Init();
                        EpayScheduleExistingLine.TransferFields(EpaymentSchedule, false);
                        EpayScheduleExistingLine."Entry No." := 0;
                        EpayScheduleExistingLine.Validate("Payment Plan ID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        if EpayScheduleExistingLine."Start Date" < AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate then
                            EpayScheduleExistingLine.Validate("Start Date", AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate + 1);
                        EpayScheduleExistingLine.Validate("Payment Anticipated End Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Last Charged Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Next Charge Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Source Table ID", Database::"Agreement Payment Plan");
                        EpayScheduleExistingLine.Validate("Source Table RecordID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        EpayScheduleExistingLine.Validate(sr_IsBC, true);//SRBC-489
                        EpayScheduleExistingLine.Validate(sr_IsCRM, false);//SRBC-489
                        EpayScheduleExistingLine.Validate("Payment For", SRSetup."Payment Plan"); //SRBC-473 16062026
                        EpayScheduleExistingLine.Insert();
                    end;

                    // Update Old Line to Inactive
                    EpaymentSchedule.Validate("End Date", AgreementPaymentPlanList.sr_PlanStartDate - 1);
                    if ((AgreementPaymentPlanList.sr_PlanStartDate - 1) <= Today) or
                       (EpaymentSchedule."Start Date" >= (AgreementPaymentPlanList.sr_PlanStartDate - 1)) then
                        EpaymentSchedule.Validate(Inactive, true);
                    EpaymentSchedule.Modify(true);
                end;
            until EpaymentSchedule.Next() = 0;
        end;
    end;


    // =========================================
    // CASE 2: Mid Week Plan (New Logic)
    // =========================================
    local procedure ProcessMidWeekPlan(AgreementPaymentPlanList: Record "Agreement Payment Plan"; SRSetup: Record "Salon Republic Setup")
    var
        EpaymentSchedule: Record "E Payment Schedule";
        EpaySchedulePaymentPlan: Record "E Payment Schedule";
        EpayScheduleExistingLine: Record "E Payment Schedule";
        ExistingLine_NewPmtPlan: Record "E Payment Schedule";
        NewPmtPlan_ExistingLine: Record "E Payment Schedule";
        PartialStartAmt, PartialStartAmt1, PartialStartAmt2 : Decimal;
        PartialEndAmt: Decimal;
        //FullAmt, FullAmt1, FullAmt2 : Decimal;
        DaysInWeek: Integer;
        StartPartialEndDate, EndPartialStartDate, StartPartialStartDate, StartPartialEndDate1, StartPartialStartDate1 : Date;
    begin
        SRSetup.Get();//SRBC-473 18062026
        EpaymentSchedule.Reset();
        EpaymentSchedule.SetCurrentKey("Payment Start Date");
        EpaymentSchedule.SetRange("Agreement ID", AgreementPaymentPlanList.sr_Agreement);
        EpaymentSchedule.SetRange("License ID", AgreementPaymentPlanList.sr_LicThirdPartyEnteringPay);
        EpaymentSchedule.SetRange(Frequency, EpaymentSchedule.Frequency::Weekly);
        EpaymentSchedule.SetRange(Inactive, false);
        EpaymentSchedule.SetFilter("Start Date", '<=%1', AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate);
        if EpaymentSchedule.FindSet() then begin
            repeat
                if (EpaymentSchedule."Payment Plan ID" = AgreementPaymentPlanList.sr_AgreementPaymentPlanId) or
                   ((EpaymentSchedule."End Date" < AgreementPaymentPlanList.sr_PlanStartDate) and (EpaymentSchedule."End Date" <> 0D)) then
                    continue
                else begin

                    DaysInWeek := 7;

                    // Calculate StartPartialEndDate (Next Friday from Plan Start Date)
                    StartPartialEndDate := AgreementPaymentPlanList.sr_PlanStartDate;
                    if (Date2DWY(StartPartialEndDate, 1) <> 5) then
                        repeat
                            StartPartialEndDate := CalcDate('<+1D>', StartPartialEndDate);
                        until Date2DWY(StartPartialEndDate, 1) = 5; // 5 = Friday
                    PartialStartAmt := Round(((EpaymentSchedule.Amount + AgreementPaymentPlanList.sr_WeeklyAdditionalPaymentAmt) / DaysInWeek) * ((StartPartialEndDate) - (AgreementPaymentPlanList.sr_PlanStartDate - 1)), 0.01);
                    // Calculate EndPartialStartDate (Previous Saturday from Plan Completion Date)
                    EndPartialStartDate := AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate;
                    if (Date2DWY(EndPartialStartDate, 1) <> 6) then
                        repeat
                            EndPartialStartDate := CalcDate('<-1D>', EndPartialStartDate);
                        until Date2DWY(EndPartialStartDate, 1) = 6; // 6 = Saturday
                    PartialEndAmt := Round(((EpaymentSchedule.Amount + AgreementPaymentPlanList.sr_WeeklyAdditionalPaymentAmt) / DaysInWeek) * ((AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate) - (EndPartialStartDate - 1)), 0.01);

                    if (EpaymentSchedule."Start Date" < AgreementPaymentPlanList.sr_PlanStartDate) and (Date2DWY(AgreementPaymentPlanList.sr_PlanStartDate, 1) <> 6) then begin

                        // Calculate EndPartialStartDate (Previous Saturday from Plan Completion Date)
                        StartPartialStartDate1 := AgreementPaymentPlanList.sr_PlanStartDate - 1;
                        if (Date2DWY(StartPartialStartDate1, 1) <> 6) then
                            repeat
                                StartPartialStartDate1 := CalcDate('<-1D>', StartPartialStartDate1);
                            until Date2DWY(StartPartialStartDate1, 1) = 6; // 6 = Saturday
                        PartialStartAmt2 := Round((EpaymentSchedule.Amount / DaysInWeek) * ((AgreementPaymentPlanList.sr_PlanStartDate) - (StartPartialStartDate1)), 0.01);

                        //1. Existing E-Payment Schedule line Partial End Week + New Payment Plan E-Payment schedule line Partial Start Week
                        ExistingLine_NewPmtPlan.Reset();
                        ExistingLine_NewPmtPlan.Init();
                        ExistingLine_NewPmtPlan.TransferFields(EpaymentSchedule, false);
                        ExistingLine_NewPmtPlan."Entry No." := 0;
                        ExistingLine_NewPmtPlan.Validate("Payment Plan ID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        ExistingLine_NewPmtPlan.Validate("Start Date", StartPartialStartDate1);
                        ExistingLine_NewPmtPlan.Validate("End Date", StartPartialEndDate);
                        ExistingLine_NewPmtPlan.Validate(Description, 'Epayment Schedule + Payment Plan');
                        ExistingLine_NewPmtPlan.Validate(Amount, PartialStartAmt2 + PartialStartAmt);
                        ExistingLine_NewPmtPlan.Validate(sr_TotalAmount, ExistingLine_NewPmtPlan.Amount + ExistingLine_NewPmtPlan.sr_ConvenienceFee);
                        ExistingLine_NewPmtPlan.Validate("Share %", 0);
                        ExistingLine_NewPmtPlan.Validate("Payment Plan", true);
                        // ExistingLine_NewPmtPlan.Validate("Payment For", ExistingLine_NewPmtPlan."Payment For"::"Payment Plan");//SRBC-473  AM 29042026
                        ExistingLine_NewPmtPlan.Validate("CRM Renewal", false);
                        ExistingLine_NewPmtPlan.Validate(sr_renewalLADocuSign, false);
                        ExistingLine_NewPmtPlan.Validate("Payment Anticipated End Date", 0D);//SRBC-471 JSG 190126
                        ExistingLine_NewPmtPlan.Validate("Last Charged Date", 0D);//SRBC-471 JSG 190126
                        ExistingLine_NewPmtPlan.Validate("Next Charge Date", 0D);//SRBC-471 JSG 190126
                        ExistingLine_NewPmtPlan.Validate("Source Table ID", Database::"Agreement Payment Plan");
                        ExistingLine_NewPmtPlan.Validate("Source Table RecordID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        ExistingLine_NewPmtPlan.Validate(sr_IsBC, true);//SRBC-489
                        ExistingLine_NewPmtPlan.Validate(sr_IsCRM, false);//SRBC-489
                        ExistingLine_NewPmtPlan.Validate("Payment For", SRSetup."Payment Plan");//SRBC-473 16062026
                        ExistingLine_NewPmtPlan.Insert();
                    end;

                    //2. New Payment Plan E-Payment schedule line Full Week
                    EpaySchedulePaymentPlan.Reset();
                    EpaySchedulePaymentPlan.Init();
                    EpaySchedulePaymentPlan.TransferFields(EpaymentSchedule, false);
                    EpaySchedulePaymentPlan."Entry No." := 0;
                    EpaySchedulePaymentPlan.Validate("Payment Plan ID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                    if EpaySchedulePaymentPlan."Start Date" < AgreementPaymentPlanList.sr_PlanStartDate then
                        if (Date2DWY(AgreementPaymentPlanList.sr_PlanStartDate, 1) <> 6) then begin
                            if (Date2DWY(StartPartialEndDate, 1) <> 6) then
                                EpaySchedulePaymentPlan.Validate("Start Date", StartPartialEndDate + 1)
                            else
                                EpaySchedulePaymentPlan.Validate("Start Date", StartPartialEndDate);
                        end else
                            EpaySchedulePaymentPlan.Validate("Start Date", AgreementPaymentPlanList.sr_PlanStartDate);
                    if (EpaySchedulePaymentPlan."End Date" > AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate) or
                       (EpaySchedulePaymentPlan."End Date" = 0D) then
                        if (Date2DWY(AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate, 1) <> 5) then begin
                            if (Date2DWY(EndPartialStartDate, 1) <> 5) then
                                EpaySchedulePaymentPlan.Validate("End Date", EndPartialStartDate - 1)
                            else
                                EpaySchedulePaymentPlan.Validate("Start Date", StartPartialEndDate);
                        end else
                            EpaySchedulePaymentPlan.Validate("End Date", AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate);
                    EpaySchedulePaymentPlan.Validate(Amount, EpaymentSchedule.Amount + AgreementPaymentPlanList.sr_WeeklyAdditionalPaymentAmt);
                    EpaySchedulePaymentPlan.Validate(sr_ConvenienceFee, SRSetup."Convenience Fee");
                    EpaySchedulePaymentPlan.Validate(sr_TotalAmount, EpaySchedulePaymentPlan.Amount + EpaySchedulePaymentPlan.sr_ConvenienceFee);
                    EpaySchedulePaymentPlan.Validate("Share %", 0);
                    EpaySchedulePaymentPlan.Validate("Payment Plan", true);
                    // EpaySchedulePaymentPlan.Validate("Payment For", EpaySchedulePaymentPlan."Payment For"::"Payment Plan");//SRBC-473  AM 29042026
                    EpaySchedulePaymentPlan.Validate("CRM Renewal", false);
                    EpaySchedulePaymentPlan.Validate(sr_renewalLADocuSign, false);
                    EpaySchedulePaymentPlan.Validate("Payment Anticipated End Date", 0D);//SRBC-471 JSG 190126
                    EpaySchedulePaymentPlan.Validate("Last Charged Date", 0D);//SRBC-471 JSG 190126
                    EpaySchedulePaymentPlan.Validate("Next Charge Date", 0D);//SRBC-471 JSG 190126
                    EpaySchedulePaymentPlan.Validate("Source Table ID", Database::"Agreement Payment Plan");
                    EpaySchedulePaymentPlan.Validate("Source Table RecordID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                    EpaySchedulePaymentPlan.Validate(sr_IsBC, true);//SRBC-489
                    EpaySchedulePaymentPlan.Validate(sr_IsCRM, false);//SRBC-489
                    EpaySchedulePaymentPlan.Validate("Payment For", SRSetup."Payment Plan");//SRBC-473 16062026
                    EpaySchedulePaymentPlan.Insert();

                    if ((EpaymentSchedule."End Date" > AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate) or (EpaymentSchedule."End Date" = 0D)) and (Date2DWY(AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate, 1) <> 5) then begin

                        // Calculate StartPartialEndDate1 (Next Friday from Plan Completion Date)
                        StartPartialEndDate1 := AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate + 1;
                        if (Date2DWY(StartPartialEndDate1, 1) <> 5) then
                            repeat
                                StartPartialEndDate1 := CalcDate('<+1D>', StartPartialEndDate1);
                            until Date2DWY(StartPartialEndDate1, 1) = 5; // 5 = Friday

                        // Calculate EndPartialStartDate (Previous Saturday from Plan Completion Date)
                        StartPartialStartDate := AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate;
                        if (Date2DWY(StartPartialStartDate, 1) <> 6) then
                            repeat
                                StartPartialStartDate := CalcDate('<-1D>', StartPartialStartDate);
                            until Date2DWY(StartPartialStartDate, 1) = 6; // 6 = Saturday

                        PartialStartAmt1 := Round((EpaymentSchedule.Amount / DaysInWeek) * ((StartPartialEndDate1) - (AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate)), 0.01);

                        //3. New Payment Plan E-Payment schedule line Partial End Week + Existing E-Payment Schedule line Partial Start Week after Payment Plan
                        NewPmtPlan_ExistingLine.Reset();
                        NewPmtPlan_ExistingLine.Init();
                        NewPmtPlan_ExistingLine.TransferFields(EpaymentSchedule, false);
                        NewPmtPlan_ExistingLine."Entry No." := 0;
                        NewPmtPlan_ExistingLine.Validate("Payment Plan ID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        NewPmtPlan_ExistingLine.Validate("Start Date", EndPartialStartDate);
                        if (NewPmtPlan_ExistingLine."End Date" > AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate) or (NewPmtPlan_ExistingLine."End Date" = 0D) then
                            if (Date2DWY(AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate, 1) <> 5) then
                                NewPmtPlan_ExistingLine.Validate("End Date", StartPartialEndDate1)
                            else
                                NewPmtPlan_ExistingLine.Validate("End Date", AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate);
                        NewPmtPlan_ExistingLine.Validate(Description, 'Payment Plan + Epayment Schedule');
                        NewPmtPlan_ExistingLine.Validate(Amount, PartialEndAmt + PartialStartAmt1);
                        NewPmtPlan_ExistingLine.Validate(sr_TotalAmount, NewPmtPlan_ExistingLine.Amount + NewPmtPlan_ExistingLine.sr_ConvenienceFee);
                        NewPmtPlan_ExistingLine.Validate("Share %", 0);
                        NewPmtPlan_ExistingLine.Validate("Payment Plan", true);
                        // NewPmtPlan_ExistingLine.Validate("Payment For", NewPmtPlan_ExistingLine."Payment For"::"Payment Plan");//SRBC-473 AM 29042026
                        NewPmtPlan_ExistingLine.Validate("CRM Renewal", false);
                        NewPmtPlan_ExistingLine.Validate(sr_renewalLADocuSign, false);
                        NewPmtPlan_ExistingLine.Validate("Payment Anticipated End Date", 0D);//SRBC-471 JSG 190126
                        NewPmtPlan_ExistingLine.Validate("Last Charged Date", 0D);//SRBC-471 JSG 190126
                        NewPmtPlan_ExistingLine.Validate("Next Charge Date", 0D);//SRBC-471 JSG 190126
                        NewPmtPlan_ExistingLine.Validate("Source Table ID", Database::"Agreement Payment Plan");
                        NewPmtPlan_ExistingLine.Validate("Source Table RecordID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        NewPmtPlan_ExistingLine.Validate(sr_IsBC, true);//SRBC-489
                        NewPmtPlan_ExistingLine.Validate(sr_IsCRM, false);//SRBC-489
                        NewPmtPlan_ExistingLine.Validate("Payment For", SRSetup."Payment Plan");//SRBC-473 16062026
                        NewPmtPlan_ExistingLine.Insert();

                        //3. Existing E-Payment Schedule line Full Week after Payment Plan
                        EpayScheduleExistingLine.Reset();
                        EpayScheduleExistingLine.Init();
                        EpayScheduleExistingLine.TransferFields(EpaymentSchedule, false);
                        EpayScheduleExistingLine."Entry No." := 0;
                        EpayScheduleExistingLine.Validate("Payment Plan ID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        if (Date2DWY(AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate + 1, 1) <> 6) then
                            EpayScheduleExistingLine.Validate("Start Date", StartPartialEndDate1 + 1)
                        else
                            EpayScheduleExistingLine.Validate("Start Date", AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate + 1);
                        EpayScheduleExistingLine.Validate("Payment Anticipated End Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Last Charged Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Next Charge Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Source Table ID", Database::"Agreement Payment Plan");
                        EpayScheduleExistingLine.Validate("Source Table RecordID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        EpayScheduleExistingLine.Validate(sr_IsBC, true);//SRBC-489
                        EpayScheduleExistingLine.Validate(sr_IsCRM, false);//SRBC-489
                        EpayScheduleExistingLine.Validate("Payment For", SRSetup."Payment Plan");//SRBC-473 16062026
                        EpayScheduleExistingLine.Insert();
                    end;

                    if ((EpaymentSchedule."End Date" > AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate) or (EpaymentSchedule."End Date" = 0D)) and (Date2DWY(AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate, 1) = 5) then begin

                        //3. Existing E-Payment Schedule line Full Week after Payment Plan
                        EpayScheduleExistingLine.Reset();
                        EpayScheduleExistingLine.Init();
                        EpayScheduleExistingLine.TransferFields(EpaymentSchedule, false);
                        EpayScheduleExistingLine."Entry No." := 0;
                        EpayScheduleExistingLine.Validate("Payment Plan ID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        if EpayScheduleExistingLine."Start Date" < AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate then
                            EpayScheduleExistingLine.Validate("Start Date", AgreementPaymentPlanList.sr_EstimatedPlanCompletionDate + 1);
                        EpayScheduleExistingLine.Validate("Payment Anticipated End Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Last Charged Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Next Charge Date", 0D);//SRBC-471 JSG 190126
                        EpayScheduleExistingLine.Validate("Source Table ID", Database::"Agreement Payment Plan");
                        EpayScheduleExistingLine.Validate("Source Table RecordID", AgreementPaymentPlanList.sr_AgreementPaymentPlanId);
                        EpayScheduleExistingLine.Validate(sr_IsBC, true);//SRBC-489
                        EpayScheduleExistingLine.Validate(sr_IsCRM, false);//SRBC-489
                        EpayScheduleExistingLine.Validate("Payment For", SRSetup."Payment Plan");//SRBC-473 16062026
                        EpayScheduleExistingLine.Insert();
                    end;

                    // Update Existing E-Payment Schedule Line End Date and Inactive
                    if (Date2DWY(AgreementPaymentPlanList.sr_PlanStartDate, 1) <> 6) then begin
                        EpaymentSchedule.Validate("End Date", StartPartialStartDate1 - 1);
                        if ((AgreementPaymentPlanList.sr_PlanStartDate - 1) <= Today) or
                           (EpaymentSchedule."Start Date" >= (StartPartialStartDate1 - 1)) then
                            EpaymentSchedule.Validate(Inactive, true);
                    end else begin
                        EpaymentSchedule.Validate("End Date", AgreementPaymentPlanList.sr_PlanStartDate - 1);
                        if ((AgreementPaymentPlanList.sr_PlanStartDate - 1) <= Today) or
                           (EpaymentSchedule."Start Date" >= (AgreementPaymentPlanList.sr_PlanStartDate - 1)) then
                            EpaymentSchedule.Validate(Inactive, true);
                    end;
                    EpaymentSchedule.Modify(true);
                end;
            until EpaymentSchedule.Next() = 0;
        end;
    end;
    //SRBC-441 JSG End

    //SRBC-432 Start  Created API of this procedure to Check from CRM-"Banking Acc Info" ID is available or not in BC
    procedure IsBankingAccountInfoAvailable(BankingAccInfoGuid: Guid): Text
    var
        BankingAccountInfo: Record "Banking Account Info";
    begin
        BankingAccountInfo.Reset();
        BankingAccountInfo.SetRange(sr_bankingaccountinfoId, BankingAccInfoGuid);
        if BankingAccountInfo.FindFirst() then
            exit('{"isexist": "true"}')
        else
            exit('{"isexist": "false"}');
    end;
    //24042026 SY Start Added this event for update "BC Cust. Bank Account" field of "Banking Account Info".
    [EventSubscriber(ObjectType::Table, Database::"Banking Account Info", OnBeforeModifyEvent, '', false, false)]
    local procedure BankAccInfo_OnBeforeModifyEvent(var Rec: Record "Banking Account Info");
    var
        CustBankAcc: Record "Customer Bank Account";
    begin
        //SRBC-505 Start
        // if Rec."BC Cust. Bank Account" = '' then begin
        //     CustBankAcc.Reset();
        //     CustBankAcc.SetRange("Bank Account Info", Rec.sr_bankingaccountinfoId);
        //     if CustBankAcc.FindFirst() then begin
        //         Rec.Validate("BC Cust. Bank Account", CustBankAcc.Code);
        //     end;
        // end;
        //SRBC-505 End
    end;
    //24042026 SY End
    //SRBC-432 End

    //SRBC-489 Start
    [EventSubscriber(ObjectType::Table, Database::"Agreement Payment Plan", OnAfterModifyEvent, '', false, false)]
    local procedure PaymentPlanOnAfterModifyEvent(var Rec: Record "Agreement Payment Plan"; xRec: Record "Agreement Payment Plan"; RunTrigger: Boolean)
    begin
        UpdateBankAcctInfoBCCustomerBankAccStripPaymentMethodstatus(Rec);
        if (Rec."Stripe Payment Method Status" = 'active') and
         (Rec.sr_PaymentPlanStatus = Rec.sr_PaymentPlanStatus::Completed) and
         (Rec.sr_typeofpaymentplan = Rec.sr_typeofpaymentplan::"E-Payment") and
         (not Rec."Epayment Schedule Created") and
         (Rec."Epayment Created DateTime" = 0DT) then begin
            CreateEPaymentFromPaymentPlan(Rec);
        end;
    end;

    //> Start PS_21102026
    procedure CalculateEpaymentStartDate(
    DiscountEndDate: Date;
    ACHAuthorizedStartDate: Date): Date
    begin
        if DiscountEndDate >= ACHAuthorizedStartDate then
            exit(DiscountEndDate + 1);

        exit(ACHAuthorizedStartDate);
    end;

    procedure IsEpaymentScheduleCreatedFromACHPayment(
    EpaymentSchedule: Record "E Payment Schedule"): Boolean
    begin
        exit(
            (EpaymentSchedule."Source Table ID" =
                Database::"ACH Payment List") and
            (not IsNullGuid(EpaymentSchedule."ACH Payment ID")) and
            (EpaymentSchedule."Source Table RecordID" =
                EpaymentSchedule."ACH Payment ID"));
    end;

    procedure TryCalculateACHStartDate(
        EpaymentSchedule: Record "E Payment Schedule";
        DiscountEndDate: Date;
        ACHAuthorizedStartDate: Date;
        var CalculatedStartDate: Date): Boolean
    begin
        if not IsEpaymentScheduleCreatedFromACHPayment(
            EpaymentSchedule)
        then
            exit(false);
        CalculatedStartDate :=
            CalculateEpaymentStartDate(
                DiscountEndDate,
                ACHAuthorizedStartDate);

        exit(true);
    end;

    // JIRA-519: Deactivate existing schedules that match
    // Agreement ID + License ID + Payment For.
    // Bank Account ID is intentionally not part of the filter.
    procedure MakeExistingEpaymentScheduleInactive(
        NewEpaymentSchedule: Record "E Payment Schedule")
    var
        ExistingEpaymentSchedule: Record "E Payment Schedule";
    begin
        ExistingEpaymentSchedule.Reset();
        ExistingEpaymentSchedule.SetRange(
            "Agreement ID",
            NewEpaymentSchedule."Agreement ID");
        ExistingEpaymentSchedule.SetRange(
            "License ID",
            NewEpaymentSchedule."License ID");
        ExistingEpaymentSchedule.SetRange(
            "Payment For",
            NewEpaymentSchedule."Payment For");
        ExistingEpaymentSchedule.SetRange(Inactive, false);
        if ExistingEpaymentSchedule.FindSet(true) then
            repeat
                if NewEpaymentSchedule."Start Date" <> 0D then
                    ExistingEpaymentSchedule.Validate(
                        "End Date",
                        NewEpaymentSchedule."Start Date" - 1);

                ExistingEpaymentSchedule.Validate(Inactive, true);
                ExistingEpaymentSchedule.Modify(true);
            until ExistingEpaymentSchedule.Next() = 0;
    end;

    //<-- end.

    //SRBC-489 End

    // //SRBC-493 Start
    // [EventSubscriber(ObjectType::Table, Database::"Banking Account Info", OnBeforeInsertEvent, '', false, false)]
    // local procedure BankAccInfo_OnBeforeInsertEvent(var Rec: Record "Banking Account Info");
    // var
    //     CustBankAcc: Record "Customer Bank Account";
    // begin
    //     // if (Rec.sr_StripeSetupIntentId = '') and (Rec."Status Description" = '') then//SRBC-493 06072026
    //     //     Rec."Stripe Verification Status" := Rec."Stripe Verification Status"::AwaitingStripeResponse;
    // end;
    // //SRBC-493 End
}