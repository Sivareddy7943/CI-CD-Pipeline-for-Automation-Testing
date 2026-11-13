/// <summary>
/// Table Recurring Charges (ID 50000).
///SRBC-175 - 20241128 - Creation of Recurring charge lines E-payment lines for Month to month renewal.
///                    - Created a new field ID 88
/// </summary>
//SRBC-326 - 25032025 - SY - Used OnDelete trigger for after delete recurring charge lines these should be updated on Agreement Schedule
//SRBC-405 - SY - 20082025 - Created field - sr_renewalLADocuSign
//SRBC-421 - 03092025 - SY - Added field - "Week Day", "Month Day", "Month Name"
//SRBC-518 - 17082026 - SY - Added field-"Frequency of Charge", Did changes on trigger-OnInsert, OnModify-for flow value in field-"Frequency of Charge" on basis of field-Frequency
table 90108 "Recurring Charges"
{
    Caption = 'Recurring Charges';
    DataClassification = ToBeClassified;
    LookupPageId = "Recurring Charges List";
    DrillDownPageId = "Recurring Charges List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(21; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                If Customer.Get("Customer No.") then begin
                    "Customer Name" := Customer.Name;
                    Validate("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
                    Validate("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
                end else begin
                    "Customer Name" := '';
                end;


            end;
        }
        field(22; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
        }
        field(23; "CRM Contact Code"; Code[20])
        {
            Caption = 'CRM Contact Code';
            TableRelation = "CRM Contact";
        }
        field(24; "Auto Charge Type"; Code[50])
        {
            Caption = 'Auto Charge Type Code';
            TableRelation = "Auto Charge".Code where(Inactive = filter(false));
            trigger OnValidate()
            var
                AutoCharge: Record "Auto Charge";
            begin
                AutoCharge.Reset();
                AutoCharge.SetRange(Code, "Auto Charge Type");
                if AutoCharge.FindFirst() then begin
                    Rec."GL Account" := AutoCharge."GL Account No.";
                    Rec."Due Day" := AutoCharge."Default Recurring Due Day";
                    rec.sr_autochargetypecode := AutoCharge.sr_autochargetypeId;
                    Rec."Charge Category" := Rec."Charge Category";
                    //If Rec.Frequency = Rec.Frequency::Once then begin
                    IF DateForWeek.Get(DateForWeek."Period Type"::Date, "Start Date") then
                        RecurringChrgeMgt.GetWeekDay(Rec."Due Day", DateForWeek."Period Name");
                    //end;
                end else begin
                    Rec."GL Account" := '';
                    Clear(Rec.sr_autochargetypecode);
                end;
                ;
            end;
        }
        field(25; "GL Account"; Code[20])
        {
            Caption = 'GL Account';
            TableRelation = "G/L Account";
            Editable = false;
        }
        field(26; Frequency; Enum "Recurring Charge Frequency")
        {
            Caption = 'Frequency';
        }
        field(27; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(28; "Start Date"; Date)
        {
            Caption = 'Start Date';
            //SY-06022026
            trigger OnValidate()
            var
                CRMIntegrationMgmt: Codeunit "CRM Integration Management";
                AutoCharge: Record "CDS sr_autocharge";
            begin
                if CRMIntegrationMgmt.IsCDSIntegrationEnabled() then begin
                    AutoCharge.Reset();
                    if Rec.ISBC then
                        AutoCharge.SetRange(new_SrBCEntryNo, Rec."Entry No.")
                    else
                        AutoCharge.SetRange(sr_autochargeId, Rec."AutoCharge ID");
                    // Check if record exists
                    if AutoCharge.FindFirst() then
                        if AutoCharge.ModifiedOn > Rec.SystemModifiedAt then
                            if AutoCharge.sr_chargestartdate = 0D then
                                Rec."Start Date" := AutoCharge.sr_chargestartdate;
                end;
            end;
            //SY-06022026
        }
        field(29; "End Date"; Date)
        {
            Caption = 'End Date';
            //SY-06022026
            trigger OnValidate()
            var
                CRMIntegrationMgmt: Codeunit "CRM Integration Management";
                AutoCharge: Record "CDS sr_autocharge";
            begin
                if CRMIntegrationMgmt.IsCDSIntegrationEnabled() then begin
                    AutoCharge.Reset();
                    if Rec.ISBC then
                        AutoCharge.SetRange(new_SrBCEntryNo, Rec."Entry No.")
                    else
                        AutoCharge.SetRange(sr_autochargeId, Rec."AutoCharge ID");
                    // Check if record exists
                    if AutoCharge.FindFirst() then
                        if AutoCharge.ModifiedOn > Rec.SystemModifiedAt then
                            if AutoCharge.sr_chargeenddate = 0D then
                                Rec."End Date" := AutoCharge.sr_chargeenddate;
                end;
            end;
            //SY-06022026
        }
        field(30; "Due Day"; Enum "Week Selection")
        {
            Caption = 'Due Day';
        }
        field(31; "Last Charged Date"; Date)
        {
            Caption = 'Last Charged Date';
        }
        field(32; "Next Charge Date"; Date)
        {
            Caption = 'Next Charge Date';
        }
        field(33; Inactive; Boolean)
        {
            Caption = 'Inactive';
            //Editable = false;
        }
        field(34; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
        }
        field(35; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
        field(36; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));
        }
        field(37; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(38; "Agreement Start Date"; Date)
        {
            Caption = 'Agreement Start Date';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Agreement Start Date" <> 0D then begin
                    IF DateForWeek.Get(DateForWeek."Period Type"::Date, "Agreement Start Date") then
                        RecurringChrgeMgt.GetWeekDay("Agreement Start Day", DateForWeek."Period Name");
                end;
            end;
        }
        field(39; "Agreement Start Day"; Enum "Week Selection")
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(40; "Licensee"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Contact No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
        field(42; "Agreement ID"; Guid)
        {
            DataClassification = ToBeClassified;
            //TableRelation = "CDS sr_autocharge".sr_agreementid;
            Editable = false;
        }
        field(43; "AutoCharge ID"; Guid)
        {
            DataClassification = ToBeClassified;
            //TableRelation = "CDS sr_autocharge".sr_autochargeId;
            Editable = false;
        }
        field(44; "Charge Anticipated End Date"; Date)
        {
            DataClassification = ToBeClassified;
            //TableRelation = ;
            //Editable = false;
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
            Caption = 'CRM Created On';
        }
        field(47; CreatedBy; GUID)
        {
            Description = 'Unique identifier of the user who created the record.';
            Caption = 'CRM Created By';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(48; ModifiedOn; Datetime)
        {
            Description = 'Date and time when the record was modified.';
            Caption = 'CRM Modified On';
        }
        field(49; ModifiedBy; GUID)
        {
            Description = 'Unique identifier of the user who modified the record.';
            Caption = 'CRM Modified By';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(50; sr_IsCRM; Boolean)
        {
            Editable = false;
            Description = '';
            Caption = 'IsCRM';
        }
        field(60; "Source Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(61; "Source Table RecordID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // SR..BKP -- 12/01/2024 NS
        field(62; "Charge Category"; Enum "Charges Category")
        {
            Editable = false;
            CalcFormula = lookup("Auto Charge"."Charge Category" where(Code = field("Auto Charge Type")));
            FieldClass = FlowField;
        }
        // SR..BKP -- 12/01/2024 NE
        field(65; "Discount Start Date"; Date)
        {
            Description = '';
            Caption = 'Discount Start Date';
        }
        field(66; "Discount End Date"; Date)
        {
            Description = '';
            Caption = 'Discount End Date';
        }
        field(67; "No. of Weeks for Disc"; Integer)
        {
            Description = '';
            Caption = 'No. of Weeks for Disc';
        }
        field(68; "No. of Days for Disc"; Integer)
        {
            Description = '';
            Caption = 'No. of Days for Disc';
        }
        field(69; "Agreement Schedule ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70; "Transaction Type"; Enum TransactionType)
        {
            DataClassification = ToBeClassified;
            Caption = 'Transaction Type';
            Editable = false;
            TableRelation = "Auto Charge"."Transaction Type";
        }
        field(71; sr_to; Integer)
        {

            Description = '';
            Caption = 'To';
        }
        field(72; sr_from; Integer)
        {
            Description = '';
            Caption = 'From';
        }

        field(73; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(74; sr_DocusignPaymentType; Option)
        {
            Description = '';
            Caption = 'Docusign Payment Type';
            InitValue = " ";
            OptionMembers = " ","DocuSignHoldDeposit-InPreson","DocuSignHoldDeposit-Remote","DocuSign-Resend","DocuSignLA-InPerson","DocuSignLA-Remote","DocusignHoldDepositTransfer-InPerson","DocusignHoldDepositTransfer-Remote",DocusignACH,"MoveOutHDA-InPerson","MoveOutHDA-Remote","AddStudioHDA-InPerson","AddStudioHDA-Remote","RenewalLA-InPerson","RenewalLA-Remote","PaymentPlan-Remote","ConstructionAgreement-Remote";
        }
        field(75; sr_AmountShare; Decimal)
        {
            Description = '';
            Caption = 'Amount Share';
        }
        field(76; IsLastRow; Boolean)
        {
            Description = '';
            Caption = 'IsLastRow';
        }
        field(77; "MultiSigner Hold Deposit"; Boolean)
        {
            Description = '';
            Caption = 'MultiSigner Hold Deposit';
        }
        field(78; "Payment SR BC"; Guid)
        {
            Description = '';
            Caption = 'Payment SR BC';
        }
        field(79; "Additional Security Charge"; Boolean)
        {
            Description = '';
            Caption = 'Additional Security Charge';
        }
        field(80; "LA Security Deposit"; Boolean)
        {
            Description = '';
            Caption = 'LA Security Deposit';
        }
        field(81; "Construction Agreement"; Boolean)
        {
            Description = '';
            Caption = 'Construction Agreement';
        }
        field(82; sr_RenewalStatus; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Status';

        }
        field(83; IsBC; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'IsBC';
            Editable = false;
        }
        field(84; Sequence; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(85; sr_IsRecurring; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(86; "Skip Calculation"; Boolean)
        {
            Caption = 'Skip Calculation';
        }
        field(87; sr_chargeid; Text[100])
        {
            Description = '';
            Caption = 'Charge ID';
            Editable = false;
        }
        field(88; "CRM Renewal"; Boolean) { DataClassification = ToBeClassified; }
        //SRBC-405 Start
        field(89; sr_renewalLADocuSign; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal LA DocuSign';
        }
        //SRBC-405 End
        //SRBC-421 Start
        field(90; "Week Day"; Option)
        {
            Caption = 'Week Day';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(91; "Month Day"; Option)
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
        //SRBC-518
        field(93; "Frequency of Charge"; Option)
        {
            Description = '';
            Caption = 'Frequency of Charge';
            InitValue = " ";
            OptionMembers = " ",Once,Daily,Weekly,Monthly,Quarterly,Yearly;
        }
        //SRBC-518
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
        //SRBC-518 Start
        if Rec.Frequency = Rec.Frequency::Once then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Once;
        if Rec.Frequency = Rec.Frequency::Daily then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Daily;
        if Rec.Frequency = Rec.Frequency::Weekly then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Weekly;
        if Rec.Frequency = Rec.Frequency::Monthly then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Monthly;
        if Rec.Frequency = Rec.Frequency::Quarterly then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Quarterly;
        if Rec.Frequency = Rec.Frequency::Yearly then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Yearly;
        //SRBC-518 End

        if Rec.Frequency <> Rec.Frequency::Once then
            Validate(sr_IsRecurring, true)
        else
            Validate(sr_IsRecurring, false);
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        //SRBC-518 Start
        if Rec.Frequency = Rec.Frequency::Once then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Once;
        if Rec.Frequency = Rec.Frequency::Daily then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Daily;
        if Rec.Frequency = Rec.Frequency::Weekly then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Weekly;
        if Rec.Frequency = Rec.Frequency::Monthly then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Monthly;
        if Rec.Frequency = Rec.Frequency::Quarterly then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Quarterly;
        if Rec.Frequency = Rec.Frequency::Yearly then
            Rec."Frequency of Charge" := Rec."Frequency of Charge"::Yearly;
        //SRBC-518 End

        if Rec.Frequency <> Rec.Frequency::Once then
            Validate(sr_IsRecurring, true)
        else
            Validate(sr_IsRecurring, false);
    end;

    //SRBC-326 Start
    trigger OnDelete()
    var
        NoOfRecurringChargesRecord_lInt: Integer;
        AgreementSchedule_lRec: Record "Agreement Schedule";
        RecurringCharges_lRec: Record "Recurring Charges";
    begin
        if not IsNullGuid(Rec."Agreement Schedule ID") then begin
            NoOfRecurringChargesRecord_lInt := 0;
            RecurringCharges_lRec.Reset();
            RecurringCharges_lRec.SetRange("Agreement Schedule ID", Rec."Agreement Schedule ID");
            if RecurringCharges_lRec.FindSet() then
                repeat
                    NoOfRecurringChargesRecord_lInt += 1;
                until RecurringCharges_lRec.Next() = 0;
            if NoOfRecurringChargesRecord_lInt = 1 then begin
                AgreementSchedule_lRec.Reset();
                AgreementSchedule_lRec.SetRange(sr_agreementscheduleId, Rec."Agreement Schedule ID");
                if AgreementSchedule_lRec.FindFirst() then begin
                    AgreementSchedule_lRec.Validate("Recurring Charge Created", false);
                    AgreementSchedule_lRec.Validate("Recurring Entry No.", 0);
                    AgreementSchedule_lRec.Modify();
                end;
            end;
        end;
    end;
    //SRBC-326 End

    var
        DateForWeek: Record Date;
        RecurringChrgeMgt: Codeunit "Recurring Charges Mgt.";
}
