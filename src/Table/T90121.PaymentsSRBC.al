//SRBC-380 - SY - 10072025 - Created field - "Studio Modification Deposit"(ID-66)
//                         - Did changes in field - sr_DocusignPaymentType
//SRBC-406 - SY - 07082025 - Created field sr_paidontext 
table 90121 "Payments SR BC"
{
    Caption = 'Payments SR BC';
    DataClassification = ToBeClassified;
    LookupPageId = "Sr Payments";
    DrillDownPageId = "Sr Payments";
    fields
    {
        field(1; sr_paymentId; GUID)
        {

            Description = 'Unique identifier for entity instances';
            Caption = 'Payment';
        }
        field(2; CreatedOn; Datetime)
        {

            Description = 'Date and time when the record was created.';
            Caption = 'Created On';
        }
        field(4; ModifiedOn; Datetime)
        {

            Description = 'Date and time when the record was modified.';
            Caption = 'Modified On';
        }
        field(25; statecode; Option)
        {

            Description = 'Status of the Payment';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;

        }
        field(27; statuscode; Option)
        {

            Description = 'Reason for the status of the Payment';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",Draft,Paid,Completed,Failed;

        }
        field(34; sr_name; Text[100])
        {

            Description = '';
            Caption = 'name';
        }
        field(35; sr_payment_id; Text[100])
        {

            Description = '';
            Caption = 'Payment ID';
        }
        field(36; sr_amount; Decimal)
        {

            Description = '';
            Caption = 'Amount';
        }
        field(39; ExchangeRate; Decimal)
        {
            ;
            ;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(40; sr_amount_Base; Decimal)
        {

            Description = 'Value of the Amount in base currency.';
            Caption = 'Amount (Base)';
        }
        field(41; sr_studio; Text[100])
        {

            Description = '';
            Caption = 'Studio #';
        }
        field(42; sr_prospectid; Guid)
        {

            Description = '';
            Caption = 'Prospect';
            //TableRelation = "Prospect Lead ".LeadId;
        }
        field(48; sr_chargeid; Text[100])
        {

            Description = '';
            Caption = 'Charge ID';
        }
        field(51; sr_paidon; Datetime)
        {

            Description = '';
            Caption = 'Paid On';
        }
        field(52; sr_licenseID; Guid)
        {
            Description = '';
            Caption = 'LicenseeID';
            //TableRelation = "CRM Contact".ContactId;
        }

        field(53; sr_agreementid; Guid)
        {

            Description = '';
            Caption = 'AgreementID';
            //TableRelation = "CDS sr_agreement".sr_agreementId;
        }
        field(54; sr_DocusignPaymentType; Option)
        {
            Description = '';
            Caption = 'Docusign Payment Type';
            InitValue = " ";
            //SRBC-380
            //Old - "DocuSignHoldDeposit-InPreson"
            //New - "DocuSignHoldDeposit-InPerson"
            OptionMembers = " ","DocuSignHoldDeposit-InPerson","DocuSignHoldDeposit-Remote","DocuSign-Resend","DocuSignLA-InPerson","DocuSignLA-Remote","DocusignHoldDepositTransfer-InPerson","DocusignHoldDepositTransfer-Remote",DocusignACH,"MoveOutHDA-InPerson","MoveOutHDA-Remote","AddStudioHDA-InPerson","AddStudioHDA-Remote","RenewalLA-InPerson","RenewalLA-Remote","PaymentPlan-Remote","ConstructionAgreement-Remote";
        }
        field(56; sr_AmountShare; Decimal)
        {
            Description = '';
            Caption = 'Amount Share';
        }
        field(57; IsLastRow; Boolean)
        {
            Description = '';
            Caption = 'IsLastRow';
        }
        field(60; "Recurring Charge Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(61; "Recurring Charge Created Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(62; "Recurring Charge Created Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(63; "BC Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(64; "BC Salon Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(65; "Recurring Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        //SRBC-380 Start
        field(66; "Studio Modification Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-380 End
        //SRBC-406 Start
        field(67; sr_paidontext; Text[100])
        {
            Caption = 'Paid on Text';
            DataClassification = ToBeClassified;
        }
        //SRBC-406 Start


    }
    keys
    {
        key(PK; sr_paymentId)
        {
            Clustered = true;
        }
    }
}