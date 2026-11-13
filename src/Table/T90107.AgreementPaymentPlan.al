//SRBC-266 - 20250210 - NU - Payment Plan
//SRBC-308 - 11032025 - SY - Created field "Stripe Payment Method Status" for update status of Stripe bank account
//         - 20250424 - AM - Added three new fields "BC Cust. Bank Account" , "Bank Account Info ID" and account Name
//SRBC-409 - 20250826 - NU - Added a new field ID (60) from CRM to Dataverse table.
//                         - if sr_typeofpaymentplan::E-Payment then only created E-Pay Schedules from Agreement Payment Plan.
table 90107 "Agreement Payment Plan"
{
    Caption = 'Agreement Payment Plan';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; sr_AgreementPaymentPlanId; GUID)
        {

            Description = 'Unique identifier for entity instances';
            Caption = 'Agreement Payment Plan';
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
        field(6; CreatedOnBehalfBy; GUID)
        {
            ;
            Description = 'Unique identifier of the delegate user who created the record.';
            Caption = 'Created By (Delegate)';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(7; ModifiedOnBehalfBy; GUID)
        {

            Description = 'Unique identifier of the delegate user who modified the record.';
            Caption = 'Modified By (Delegate)';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(16; OwnerId; GUID)
        {

            Description = 'Owner Id';
            Caption = 'Owner';
        }
        field(21; OwningBusinessUnit; GUID)
        {

            Description = 'Unique identifier for the business unit that owns the record';
            Caption = 'Owning Business Unit';
            //TableRelation = "CRM Businessunit".BusinessUnitId;
        }
        field(22; OwningUser; GUID)
        {

            Description = 'Unique identifier for the user that owns the record.';
            Caption = 'Owning User';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(23; OwningTeam; GUID)
        {

            Description = 'Unique identifier for the team that owns the record.';
            Caption = 'Owning Team';
            //TableRelation = "CRM Team".TeamId;
        }
        field(25; statecode; Option)
        {

            Description = 'Status of the Agreement Payment Plan';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;

        }
        field(27; statuscode; Option)
        {

            Description = 'Reason for the status of the Agreement Payment Plan';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;

        }
        field(29; VersionNumber; BigInteger)
        {

            Description = 'Version Number';
            Caption = 'Version Number';
        }
        field(30; ImportSequenceNumber; Integer)
        {

            Description = 'Sequence number of the import that created this record.';
            Caption = 'Import Sequence Number';
        }
        field(31; OverriddenCreatedOn; Date)
        {

            Description = 'Date and time that the record was migrated.';
            Caption = 'Record Created On';
        }
        field(32; TimeZoneRuleVersionNumber; Integer)
        {

            Description = 'For internal use only.';
            Caption = 'Time Zone Rule Version Number';
        }
        field(33; UTCConversionTimeZoneCode; Integer)
        {

            Description = 'Time zone code that was in use when the record was created.';
            Caption = 'UTC Conversion Time Zone Code';
        }
        field(34; sr_EnvelopID; Text[850])
        {

            Description = '';
            Caption = 'EnvelopID';
        }
        field(35; sr_WeeklyAdditionalPaymentAmt; Decimal)
        {

            Description = '';
            Caption = 'Weekly Additional Payment Amount:';
        }
        field(36; TransactionCurrencyId; GUID)
        {

            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            //TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(38; ExchangeRate; Decimal)
        {

            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(39; sr_weeklyadditionalpayamt_Base; Decimal)
        {

            Description = 'Value of the Weekly Additional Payment Amount: in base currency.';
            Caption = 'Weekly Additional Payment Amount: (Base)';
        }
        field(40; sr_TotalWeeklyPaymentAmount; Decimal)
        {

            Description = '';
            Caption = 'Total Weekly Payment Amount';
        }
        field(41; sr_totalweeklypayamt_Base; Decimal)
        {

            Description = 'Value of the Total Weekly Payment Amount in base currency.';
            Caption = 'Total Weekly Payment Amount (Base)';
        }
        field(42; sr_PlanStartDate; Date)
        {

            Description = '';
            Caption = 'Plan Start Date';
        }
        field(43; sr_EstimatedPlanCompletionDate; Date)
        {

            Description = '';
            Caption = 'Estimated Plan Completion Date';
        }
        field(44; sr_LicThirdPartyEnteringPay; GUID)
        {

            Description = '';
            Caption = ' Licensee / Third Party Entering Payment Plan';
            //TableRelation = "CRM Contact".ContactId;
        }
        field(47; sr_PaymentPlanStatus; Option)
        {

            Description = '';
            Caption = 'Payment Plan Status';
            InitValue = Sent;
            OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1;

        }
        field(49; sr_Agreement; GUID)
        {

            Description = '';
            Caption = 'Agreement';
            //TableRelation = "CDS sr_agreement".sr_agreementId;
        }
        field(50; "Epayment Schedule Created"; Boolean)
        {
            Description = '';
            Caption = 'Epayment Schedule Created';
        }
        field(51; "Epayment Created By"; Text[65])
        {
            Description = '';
            Caption = 'Epayment Created By';
            TableRelation = User."User Name";
        }
        field(52; "Epayment Created DateTime"; DateTime)
        {
            Description = '';
            Caption = 'Epayment Created DateTime';
        }
        field(53; "Epayment Deletion By"; Text[65])
        {
            Description = '';
            Caption = 'Epayment Deletion By';
            TableRelation = User."User Name";
        }
        field(54; "Epayment Deletion DateTime"; DateTime)
        {
            Description = '';
            Caption = 'Epayment Deletion DateTime';
        }
        field(55; "Epayment Entry No."; Integer)
        {
            Description = '';
            Caption = 'Epayment Entry No.';
        }
        //SRBC-308 Start
        field(56; "Stripe Payment Method Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stripe Payment Method Status';
        }
        field(57; "Bank Account Info ID"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "BC Cust. Bank Account"; Code[20])
        {
            Description = '';
            Caption = 'BC Cust. Bank Account';
            DataClassification = ToBeClassified;
        }
        field(59; accountname; Text[500])
        {
            Description = 'The name of the Banking Account Info entity.';
            Caption = 'Account Name';
        }
        //SRBC-308 End

        //SRBC-409
        field(60; sr_typeofpaymentplan; Enum PaymentPlanType)
        {

            Description = 'option set for payment plan type';
            Caption = 'Payment Plan Type';
        }
        //SRBC-409
    }
    keys
    {
        key(PK; sr_AgreementPaymentPlanId)
        {
            Clustered = true;
        }
        key(Name; sr_EnvelopID)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; sr_EnvelopID)
        {
        }
    }
}