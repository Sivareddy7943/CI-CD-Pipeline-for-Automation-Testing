// <summary>
// Table Agreement Schedule (ID 50012).
//SRBC-175 - 20241128 - Creation of Recurring charge lines E-payment lines for Month to month renewal.
//                    - Created a new field ID 65
//                    - made field ID 20 , 21 as normal fields removed from flowfields
//SRBC-349 - SY - 06062025 - Created field - "Epayment Schedule Created", "Epayment Schedule Created Date", "Epayment Schedule Created Time"
//SRBC-405 - SY - 20082025 - Created field - sr_renewalLADocuSign 
table 90105 "Agreement Schedule"
{
    Caption = 'Agreement Schedule';
    Description = '';
    DataClassification = ToBeClassified;
    LookupPageId = "Agreement Schedule List";
    DrillDownPageId = "Agreement Schedule List";
    fields
    {
        field(1; sr_agreementscheduleId; GUID)
        {
            Description = 'Unique identifier for entity instances';
            Caption = 'Agreement Schedule';
        }
        field(2; CreatedOn; Datetime)
        {
            Description = 'Date and time when the record was created.';
            Caption = 'Created On';
        }
        field(3; CreatedBy; GUID)
        {
            Description = 'Unique identifier of the user who created the record.';
            Caption = 'Created By';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(4; ModifiedOn; Datetime)
        {

            Description = 'Date and time when the record was modified.';
            Caption = 'Modified On';
        }
        field(5; ModifiedBy; GUID)
        {

            Description = 'Unique identifier of the user who modified the record.';
            Caption = 'Modified By';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(6; statecode; Option)
        {

            Description = 'Status of the Agreement Schedule';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            //OptionOrdinalValues = -1, 0, 1;
        }
        field(7; statuscode; Option)
        {

            Description = 'Reason for the status of the Agreement Schedule';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            //OptionOrdinalValues = -1, 1, 2;
        }
        field(8; sr_name; Text[200])
        {

            Description = '';
            Caption = 'Name';
        }
        field(9; sr_agreementid; GUID)
        {

            Description = '';
            Caption = 'Agreement';
            //TableRelation = "CDS sr_agreement".sr_agreementId;
        }
        field(10; sr_feeduedate; Date)
        {

            Description = '';
            Caption = 'Fee Due Date';
        }
        field(11; sr_weeklylicensefee; Decimal)
        {

            Description = '';
            Caption = 'Weekly License Fee';
        }
        field(12; sr_weeklylicensefee_Base; Decimal)
        {

            Description = 'Value of the Weekly License Fee in base currency.';
            Caption = 'Weekly License Fee (Base)';
        }
        field(13; sr_to; Integer)
        {

            Description = '';
            Caption = 'To';
        }
        field(14; sr_from; Integer)
        {
            Description = '';
            Caption = 'From';
        }
        field(20; "Current Agrement Start Date"; Date)
        {
            Caption = 'Current Agrement Start Date';
            //FieldClass = FlowField;
            //CalcFormula = lookup(Agreements."Current Agreement Start Date" where("Agreement ID" = field(sr_agreementid)));
            Editable = false;
        }
        field(21; "Current Agrement End Date"; Date)
        {
            Caption = 'Current Agrement End Date';
            //FieldClass = FlowField;
            //CalcFormula = lookup(Agreements."Current Agreement End Date" where("Agreement ID" = field(sr_agreementid)));
            Editable = false;
        }
        field(22; "New Start Date"; Date)
        {
            Caption = 'New Start Date';
            FieldClass = FlowField;
            CalcFormula = lookup(Agreements."New Start Date" where("Agreement ID" = field(sr_agreementid)));
            Editable = false;
        }
        field(23; "New End Date"; Date)
        {
            Caption = 'New End Date';
            FieldClass = FlowField;
            CalcFormula = lookup(Agreements."New End Date" where("Agreement ID" = field(sr_agreementid)));
            Editable = false;
        }
        field(30; "Licensee ID"; Guid)
        {
            Caption = 'Licensee ID';
            FieldClass = FlowField;
            CalcFormula = lookup(Agreements."Licensee ID" where("Agreement ID" = field(sr_agreementid)));
            Editable = false;
        }
        field(31; "Security Deposit Amount"; Decimal)
        {
            Caption = 'Security Deposit Amount';
            FieldClass = FlowField;
            CalcFormula = lookup(Agreements."Security Deposit Amount" where("Agreement ID" = field(sr_agreementid)));
            Editable = false;
        }
        field(40; "Recurring Charge Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41; "Recurring Charge Created Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; "Recurring Charge Created Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(43; "No. of Weeks"; Integer)
        {
            Caption = 'No. of Weeks';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Staggered End Due Date"; Date)
        {
            //Editable = false;
            Caption = 'Staggered End Due Date';
        }
        field(51; new_abatementfee; Decimal)
        {
            Description = '';
            Caption = 'AbatementFee';
        }
        field(52; new_abatementfee_Base; Decimal)
        {
            Description = 'Value of the AbatementFee in base currency.';
            Caption = 'AbatementFee (Base)';
        }
        field(53; sr_IsLastRow; Boolean)
        {
            Description = '';
            Caption = 'Is Last Row';
            Editable = false;
        }
        field(55; "No. of Weeks for Disc"; Integer)
        {
            Description = '';
            Caption = 'No. of Weeks for Disc';
        }
        field(56; "No. of Days for Disc"; Integer)
        {
            Description = '';
            Caption = 'No. of Days for Disc';
        }
        field(57; "Discount Start Date"; Date)
        {
            Description = '';
            Caption = 'Discount Start Date';
        }
        field(58; "Discount End Date"; Date)
        {
            Description = '';
            Caption = 'Discount End Date';
        }
        field(59; "Agreement Status Reason"; Enum AgreementStatusReason)
        {
            Description = 'Agreement Status Reason';
            Caption = 'Agreement Status Reason';
            Editable = false;
        }
        field(60; "Agreement Status"; Enum AgreementStatus)
        {
            Description = 'Agreement Status';
            Caption = 'Agreement Status';
            Editable = false;
        }
        field(61; Inactive; Boolean)
        {
            Description = 'Inactive';
            Caption = 'Inactive';
            Editable = false;
        }
        field(62; "Recurring Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(63; Sequence; Integer)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(64; "Highest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Highest Amount';
        }
        field(65; "CRM Renewal"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'CRM Renewal';
        }
        //SRBC-349 Start
        field(66; "Epayment Schedule Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(67; "Epayment Schedule Created Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(68; "Epayment Schedule Created Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //SRBC-349 End
        //SRBC-405 Start
        field(69; sr_renewalLADocuSign; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal LA DocuSign';
        }
        //SRBC-405 End
    }
    keys
    {
        key(PK; sr_agreementscheduleId)
        {
            Clustered = true;
        }
        key(Name; sr_name)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; sr_name)
        {
        }
    }
}