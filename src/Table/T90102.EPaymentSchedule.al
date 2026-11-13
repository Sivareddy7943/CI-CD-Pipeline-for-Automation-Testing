//SRBC-175 - 20241128 - Creation of Recurring charge lines E-payment lines for Month to month renewal.
//                    - Created a new field ID 79,80,81
//SRBC-227 - 03032025 - SY - Added field "Stripe Payment Method Status" for update stripe bank account status.
//         - 20241202 - Added field "Stripe Payment Method Status" here for update customer payment method current status. 
//SRBC-207 - 03012025 - SY - Created Field "ACH Payment ID" for flow ACH Payment ID.
//         -          - Use trigger OnDelete if Epayment Schedule will be delete then "Epayment Schedule Created" Boolean should be false on "ACH Payment List" table.
//SRBC-266 - 10012025 - SY - Created field "Payment Plan ID" for flow "Agreement Payment Plan ID"
//SRBC-303 - 06032025 - SY - Used trigger - OnDelete for update Payment Plan list if epayment schedule's all entries will delete
//SRBC-326 - 06032025 - SY - Make Modify(false) for ACH Payment List
//SRBC-349 - 06062025 - SY - Did changes in OnDelete trigger for update in Agreement Schedule
//SRBC-405 - SY - 20082025 - Created field - sr_renewalLADocuSign
//SRBC-421 - 03092025 - SY - Added field - "Week Day", "Month Day", "Month Name"
//SRBC-473 - 28012026 - SY - Created field "Payment For"
//         - 29042026 - AM - Changed the data type of Field Payment for and added OnValidate trigger on the same field and added one more file Payment For Id
table 90102 "E Payment Schedule"
{
    Caption = 'E Payment Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(21; Payer; Guid)
        {
            Caption = 'Payer';
        }
        field(22; Account; Text[500])
        {
            Caption = 'Account';
        }
        field(23; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(24; Frequency; Enum "Recurring Charge Frequency")
        {
            Caption = 'Frequency';
        }
        field(25; "Payment Start Date"; Date)
        {
            Caption = 'Payment Start Date';
        }
        field(26; "Next Payment"; Date)
        {
            Caption = 'Next Payment';
        }
        field(27; "Payment End Date"; Date)
        {
            Caption = 'Payment End Date';
        }
        field(28; "Last Posted"; Date)
        {
            Caption = 'Last Posted';
        }
        field(29; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(30; "Agreement ID"; Guid)
        {
            Caption = 'Agreement ID';
            //TableRelation = Agreements."Agreement ID";//SRBC-349
        }
        field(31; "License ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'License ID';

        }
        field(32; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                If Customer.Get("Customer No.") then
                    "Customer Name" := Customer.Name
                else
                    "Customer Name" := '';
            end;
        }
        field(33; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
        }
        field(34; "Start Date"; Date)
        {
            Caption = 'Start Date';
            //Editable = false;
        }
        field(35; "End Date"; Date)
        {
            Caption = 'End Date';
            // Editable = false;
        }
        field(36; "Last Charged Date"; Date)
        {
            Caption = 'Last Payment Date';
            //Editable = false;
        }
        field(37; "Next Charge Date"; Date)
        {
            Caption = 'Next Payment Date';
            //Editable = false;
        }
        field(38; EFrequency; Enum EpaymentFrequency)
        {
            Caption = 'Authorized E Frequency';
        }
        field(39; "Due Day"; Enum "Week Selection")
        {
            Caption = 'Due Day';
        }
        field(40; Inactive; Boolean)
        {
            Caption = 'Inactive';
            //Editable = false;
        }
        field(41; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
        }
        field(42; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
        field(43; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));
        }
        field(44; "AutoCharge ID"; Guid)
        {
            DataClassification = ToBeClassified;
            //TableRelation = "CDS sr_autocharge".sr_autochargeId;
            Editable = false;
        }
        field(45; sr_autochargetypecode; GUID)
        {
            Description = 'Auto Charge Type GUID';
            Caption = 'Auto Charge Type GUID';
            //TableRelation = "CDS sr_autochargetype".sr_autochargetypeId;

        }
        field(46; CreatedOn; Datetime)
        {
            Description = 'Date and time when the record was created.';
            Caption = 'Created On';
        }
        field(47; CreatedBy; GUID)
        {

            Description = 'Unique identifier of the user who created the record.';
            Caption = 'Created By';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(48; ModifiedOn; Datetime)
        {

            Description = 'Date and time when the record was modified.';
            Caption = 'Modified On';
        }
        field(49; ModifiedBy; GUID)
        {

            Description = 'Unique identifier of the user who modified the record.';
            Caption = 'Modified By';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(50; sr_IsLastRow; Boolean)
        {
            Description = 'IsLastRow.';
            Caption = 'IsLastRow';
        }
        field(60; "Source Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Source Table ID';
        }
        field(61; "Source Table RecordID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Source Table RecordID';
        }
        field(62; "Banking Account Info"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Banking Account Info';
        }
        field(63; "BC Cust. Bank Account"; Code[20])
        {
            Description = '';
            Caption = 'BC Cust. Bank Account';
        }
        field(64; "Source Table EntryNo"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Source Table EntryNo';
        }
        field(65; "Recurring Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Recurring Entry No.';
        }
        field(66; Recurring; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Recurring';
        }
        field(67; sr_to; Integer)
        {

            Description = '';
            Caption = 'To';
        }
        field(68; sr_from; Integer)
        {
            Description = '';
            Caption = 'From';
        }
        field(69; "Agreement Schedule ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70; "Auto Epayment CRM ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71; "Payment Plan"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(72; sr_IsCRM; Boolean)
        {

            Description = '';
            Caption = 'Is CRM';
        }
        field(73; sr_IsBC; Boolean)
        {

            Description = 'Is BC';
            Caption = 'Is BC';
        }
        field(74; sr_TotalAmount; Decimal)
        {
            Description = '';
            Caption = 'Total Amount';
        }
        field(75; sr_ConvenienceFee; Decimal)
        {
            Description = '';
            Caption = 'Convenience Fee';
        }
        field(76; sr_RenewalStatus; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Status';

        }
        field(77; sr_TempLicensee; GUID)
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'Temp Licensee';
            //TableRelation = "CRM Contact".ContactId;
        }
        field(78; sr_IsRecurring; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'sr_IsRecurring';
        }
        field(79; "CRM Renewal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'CRM Renewal';
        }
        field(80; "Share %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'Share %';
        }
        field(81; "AS Sequence"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'AS Sequence';
        }
        field(82; "Payment Anticipated End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Anticipated End Date';
        }
        //SRBC-227 Start
        field(83; "Stripe Payment Method Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stripe Payment Method Status';
        }
        //SRBC-227 End
        //SRBC-207 Start
        field(84; "ACH Payment ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Caption = 'ACH Payment ID';
        }
        //SRBC-207 End
        //SRBC-266 Start
        field(85; "Payment Plan ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Plan ID';
        }
        //SRBC-266 End
        //SRBC-405 Start
        field(86; sr_renewalLADocuSign; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal LA DocuSign';
        }
        //SRBC-405 End
        //SRBC-421 Start
        field(87; "Week Day"; Option)
        {
            Caption = 'Week Day';
            OptionMembers = " ",Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
        }
        field(88; "Month Day"; Option)
        {
            Caption = 'Month Day';
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31";
        }
        field(92; "Month Name"; Option)
        {
            Caption = 'Month';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            DataClassification = ToBeClassified;
        }
        //SRBC-421 End
        //SRBC-473 START 28012026
        //SRBC-473 Start AM 29042026
        // field(93; "Payment For"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = " ","License Fee - Payment","Payment Plan";
        // }
        //SRBC-473 END 28012026
        field(93; "Payment For"; Code[50])
        {
            DataClassification = ToBeClassified;
            // OptionMembers = " ","License Fee - Payment","Payment Plan";
            TableRelation = "Auto Charge".Code where(Inactive = filter(false));
            trigger OnValidate()
            var
                AutoCharge: Record "Auto Charge";
            begin
                AutoCharge.Reset();
                AutoCharge.SetRange(Code, "Payment For");
                if AutoCharge.FindFirst() then begin
                    Rec."Payment For Id" := AutoCharge.sr_autochargetypeId;
                end;
            end;
        }
        field(94; "Payment For Id"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-473 End AM 29042026
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if Rec.IsTemporary then
            exit;
        if Rec.Frequency <> Rec.Frequency::Once then
            Validate(sr_IsRecurring, true)
        else
            Validate(sr_IsRecurring, false);
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        if Rec.Frequency <> Rec.Frequency::Once then
            Validate(sr_IsRecurring, true)
        else
            Validate(sr_IsRecurring, false);
    end;
    //SRBC-207 Start
    trigger OnDelete()
    var
        ACHPaymentList_lRec: Record "ACH Payment List";
        EpaymentSchedule_lRec: Record "E Payment Schedule";
        NoOfEpayScheduleRecord_lInt: Integer;
        AgreementPaymentPlan_lRec: Record "Agreement Payment Plan";//SRBC-303
        AgreementSchedule_lRec: Record "Agreement Schedule";//SRBC-349
    begin
        if not IsNullGuid(Rec."ACH Payment ID") then begin//SRBC-303
            NoOfEpayScheduleRecord_lInt := 0;
            EpaymentSchedule_lRec.Reset();
            EpaymentSchedule_lRec.SetRange("ACH Payment ID", Rec."ACH Payment ID");
            if EpaymentSchedule_lRec.FindSet() then
                repeat
                    NoOfEpayScheduleRecord_lInt += 1;
                until EpaymentSchedule_lRec.Next() = 0;
            if NoOfEpayScheduleRecord_lInt = 1 then begin
                ACHPaymentList_lRec.Reset();
                ACHPaymentList_lRec.SetRange("ACH Payments ID", Rec."ACH Payment ID");
                if ACHPaymentList_lRec.FindFirst() then begin
                    ACHPaymentList_lRec."Epayment Schedule Created" := false;
                    ACHPaymentList_lRec.Modify(false);//SRBC-326
                end;
            end;
        end;//SRBC-303

        //SRBC-303 Start
        if not IsNullGuid(Rec."Payment Plan ID") then begin
            NoOfEpayScheduleRecord_lInt := 0;
            EpaymentSchedule_lRec.Reset();
            EpaymentSchedule_lRec.SetRange("Payment Plan ID", Rec."Payment Plan ID");
            if EpaymentSchedule_lRec.FindFirst() then
                repeat
                    NoOfEpayScheduleRecord_lInt += 1;
                until EpaymentSchedule_lRec.Next() = 0;
            if NoOfEpayScheduleRecord_lInt = 1 then begin
                Clear(AgreementPaymentPlan_lRec);
                AgreementPaymentPlan_lRec.SetRange(sr_AgreementPaymentPlanId, Rec."Payment Plan ID");
                if AgreementPaymentPlan_lRec.FindFirst() then begin
                    AgreementPaymentPlan_lRec.Validate("Epayment Schedule Created", false);
                    AgreementPaymentPlan_lRec.Validate("Epayment Deletion By", UserId);
                    AgreementPaymentPlan_lRec.Validate("Epayment Deletion DateTime", CurrentDateTime);
                    AgreementPaymentPlan_lRec.Modify();
                end;
            end;
        end;
        //SRBC-303 End

        //SRBC-349 Start
        if not IsNullGuid(Rec."Agreement Schedule ID") then begin
            NoOfEpayScheduleRecord_lInt := 0;
            EpaymentSchedule_lRec.Reset();
            EpaymentSchedule_lRec.SetRange("Agreement Schedule ID", Rec."Agreement Schedule ID");
            if EpaymentSchedule_lRec.FindFirst() then
                repeat
                    NoOfEpayScheduleRecord_lInt += 1;
                until EpaymentSchedule_lRec.Next() = 0;
            if NoOfEpayScheduleRecord_lInt = 1 then begin
                Clear(AgreementSchedule_lRec);
                AgreementSchedule_lRec.SetRange(sr_agreementscheduleId, Rec."Agreement Schedule ID");
                if AgreementSchedule_lRec.FindFirst() then begin
                    AgreementSchedule_lRec.Validate("Epayment Schedule Created", false);
                    AgreementSchedule_lRec.Modify();
                end;
            end;
        end;
        //SRBC-349 End
    end;
    //SRBC-207 End
}
