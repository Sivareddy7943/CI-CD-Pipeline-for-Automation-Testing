//SRBC-185 - 20241126 - One Time Payment Method Changes - Portal.
//                    - Added new fields ID 85 to 90 and 105
//SRBC-493 - SY - 01062026 - Added fields Stripe Mandate Id,Stripe Verification Status,Setup Intent Status,Stripe Account Status,Status Reason,Status Description
//SRBC-493 - SY - 09082026 - Added trigger OnValidate of field-"Setup Intent Status" for update value in field-"Stripe Verification Status"
table 90106 "Banking Account Info"
{
    Description = 'E-PAYMENT / BANKING ACCOUNT INFO';
    Caption = 'E-PAYMENT / BANKING ACCOUNT INFO';
    DataClassification = ToBeClassified;
    LookupPageId = "Banking Account Info";
    DrillDownPageId = "Banking Account Info";
    fields
    {
        field(1; sr_bankingaccountinfoId; GUID)
        {
            Description = 'Unique identifier for entity instances';
            Caption = 'Banking Account Info';
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
        field(25; statecode; Option)
        {
            Description = 'Status of the Banking Account Info';
            Caption = 'Status';
            // InitValue = " "; //SRBC-505
            OptionMembers = " ",Active,Inactive;
        }
        field(27; statuscode; Option)
        {
            Description = 'Reason for the status of the Banking Account Info';
            Caption = 'Status';
            // InitValue = " "; //SRBC-505
            OptionMembers = " ","ActiveE-Payments","InactiveE-Payments";
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
        field(34; sr_accountname; Text[500])
        {
            Description = 'The name of the Banking Account Info entity.';
            Caption = 'Account Name';
        }
        field(35; sr_accountnickname; Text[200])
        {
            Description = 'Account Nickname';
            Caption = 'Account Nickname';
        }
        field(36; sr_bankname; Text[500])
        {
            Description = 'Bank Name';
            Caption = 'Bank Name';
        }
        field(37; sr_accounttype; Option)
        {
            Description = 'Account Type';
            Caption = 'Account Type';
            // InitValue = " ";//SRBC-505
            // OptionMembers = " ",Checking,Savings;//SRBC-493
            OptionMembers = " ",Checking,Savings,CreditCard;//SRBC-493
        }
        field(39; sr_routingnumber; Text[100])
        {
            Description = 'Routing Number';
            Caption = 'Routing Number';
        }
        field(40; sr_accountnumber; Text[100])
        {
            Description = 'Account Number';
            Caption = 'Account Number';
        }
        field(41; sr_birthdate; Date)
        {
            Description = 'Birth Date';
            Caption = 'Birth Date';
        }
        field(42; sr_socialsecuritynumber; Text[100])
        {
            Description = 'Social Security #';
            Caption = 'Social Security #';
        }
        field(43; sr_drivinglicensenumber; Text[100])
        {
            Description = 'Driving License #';
            Caption = 'Driving License #';
        }
        field(44; sr_drivinglicensestateprovince; Text[100])
        {
            Description = 'Driving License State/Province';
            Caption = 'Driving License State/Province';
        }
        field(45; sr_firstname; Text[100])
        {
            Description = 'First Name';
            Caption = 'First Name';
        }
        field(46; sr_lastname; Text[100])
        {
            Description = 'Last Name';
            Caption = 'Last Name';
        }
        field(47; sr_phonenumber; Text[100])
        {
            Description = 'Phone Number';
            Caption = 'Phone Number';
        }
        field(48; sr_billingaddress; BLOB)
        {
            Description = 'Billing Address';
            Caption = 'Billing Address';
            Subtype = Memo;
        }
        field(49; sr_address2; BLOB)
        {
            Description = 'Address 2';
            Caption = 'Address 2';
            Subtype = Memo;
        }
        field(50; sr_city; Text[100])
        {
            Description = 'City';
            Caption = 'City';
        }
        field(51; sr_stateprovince; Text[100])
        {
            Description = 'State/Province';
            Caption = 'State/Province';
        }
        field(52; sr_zippostalcode; Text[100])
        {
            Description = 'Zip/Postal Code';
            Caption = 'Zip/Postal Code';
        }
        field(53; sr_billingemail; Text[200])
        {
            Description = 'Billing Email';
            Caption = 'Billing Email';
        }
        field(54; sr_expirydate; Date)
        {
            Description = 'Expiry Date';
            Caption = 'Expiry Date';
        }
        field(55; sr_salonid; GUID)
        {
            Description = 'Salon';
            Caption = 'Salon';
            //TableRelation = "CDS sr_Building".sr_BuildingId;
        }
        field(57; sr_studioid; GUID)
        {
            Description = 'Studio #';
            Caption = 'Studio';
            //TableRelation = "CDS sr_Studio".sr_StudioId;
        }
        field(59; sr_licenseeid; GUID)
        {
            Description = 'Licensee';
            Caption = 'Licensee';
            //TableRelation = "CRM Contact".ContactId;
        }
        field(63; sr_keepitsecret; Boolean)
        {
            Description = 'Keep It Secret';
            Caption = 'Keep It Secret';
        }
        field(65; sr_accountnumbermasked; Text[100])
        {
            Description = 'Account Number (Masked)';
            Caption = 'Account Number (Masked)';
        }
        field(66; sr_authorizedepaymentstartdate; Datetime)
        {
            Description = 'Authorized E-Payment Start Date';
            Caption = 'Authorized E-Payment Start Date';
        }
        field(67; sr_authorizedepaymentfrequency; Option)
        {
            Description = 'Authorized E-Payment Frequency';
            Caption = 'Authorized E-Payment Frequency';
            InitValue = " ";
            OptionMembers = " ",Weekly,Monthly,Other,Quarterly,Yearly;
        }
        field(69; sr_authorizedepaymentamount; Decimal)
        {
            Description = 'Authorized E-Payment Amount';
            Caption = 'Authorized E-Payment Amount';
        }
        field(70; TransactionCurrencyId; GUID)
        {
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            //TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(72; ExchangeRate; Decimal)
        {
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(73; sr_authorizedepaymentamt_Base; Decimal)
        {
            Description = 'Value of the Authorized E-Payment Amount in base currency.';
            Caption = 'Authorized E-Payment Amount (Base)';
        }
        field(75; sr_achlicenseeguid; Text[100])
        {
            Description = '';
            Caption = 'ACH Licensee Guid';
        }
        field(76; sr_achsalonandpropertymanager; Text[100])
        {
            Description = '';
            Caption = 'ACH Salon and Property Manager Guid';
        }
        field(77; sr_achdocumentenvelopeid; Text[100])
        {
            Description = '';
            Caption = 'ACH Document Envelope Id';
        }
        field(78; sr_frequencyother; Text[100])
        {
            Description = '';
            Caption = 'Frequency Other';
        }
        field(79; sr_currentparticipation; Text[100])
        {
            Description = '';
            Caption = 'Current Participation';
        }
        field(80; sr_agreement; GUID)
        {
            Description = '';
            Caption = 'Agreement';
            //TableRelation = "CDS sr_agreement".sr_agreementId;
        }
        field(82; sr_AccountAddress; Text[1000])
        {
            Description = '';
            Caption = 'Account Address';
        }
        field(83; "BC Customer Code"; Code[20])
        {
            Description = '';
            Caption = 'BC Customer Codes';
        }
        field(84; "BC Cust. Bank Account"; Code[20])
        {
            Description = '';
            Caption = 'BC Cust. Bank Account';
        }
        field(85; sr_StripePaymentMethodId; Text[100])
        {
            Description = '';
            Caption = 'Stripe Payment Method Id';
        }
        field(86; sr_StripeCustomerId; Text[100])
        {
            Description = '';
            Caption = 'Stripe Customer Id';
        }
        field(87; sr_StripeSetupIntentId; Text[100])
        {
            Description = '';
            Caption = 'Stripe Setup Intent Id';
        }
        field(88; sr_StripeSecret; Text[100])
        {
            Description = '';
            Caption = 'Stripe Secret';
        }
        field(89; sr_SyncedToBC; Boolean)
        {
            Description = '';
            Caption = 'Synced To BC';
        }
        field(90; sr_OneTimePayment; Boolean)
        {
            Description = '';
            Caption = 'One Time Payment';
        }
        field(100; "Epayment Created"; Boolean)
        {
            Description = '';
            Caption = 'Epayment Created';
            Editable = false;
        }
        field(101; "Source Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Source Table ID';
        }
        field(102; "Source Table RecordID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Source Table RecordID';
        }
        field(103; "Epayment Created Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Epayment Created Date';
        }
        field(104; "Epayment Created Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Epayment Created Time';
        }
        field(105; Duplicate; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Duplicate';
        }
        field(106; "Current Agreement Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Agreement Start Date';
            //Editable = false;
        }
        field(107; "Current Agreement End Date "; Date)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Current Agreement End Date';
        }
        field(108; IsStripeVerified; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'IsStripeVerified';
        }
        //SRBC-493 Start
        field(109; "Stripe Mandate Id"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Stripe Verification Status"; Option)
        {
            DataClassification = ToBeClassified;
            InitValue = AwaitingStripeResponse;
            OptionMembers = Verified,PendingVerification,Failed,Canceled,Expired,AwaitingStripeResponse;
        }
        field(111; "Setup Intent Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Setup Intent Status" = 'succeeded' then
                    Rec."Stripe Verification Status" := Rec."Stripe Verification Status"::Verified;
                if Rec."Setup Intent Status" = 'requires_action' then
                    Rec."Stripe Verification Status" := Rec."Stripe Verification Status"::PendingVerification;
                if (Rec."Setup Intent Status" = 'requires_payment_method') and (Rec."Status Reason" <> 'setup_intent_setup_attempt_expired') then
                    Rec."Stripe Verification Status" := Rec."Stripe Verification Status"::Failed;
                if (Rec."Setup Intent Status" = 'requires_payment_method') and (Rec."Status Reason" = 'setup_intent_setup_attempt_expired') then
                    Rec."Stripe Verification Status" := Rec."Stripe Verification Status"::Expired;
                if Rec."Setup Intent Status" = 'canceled' then
                    Rec."Stripe Verification Status" := Rec."Stripe Verification Status"::Canceled;
                //SRBC-505 Start
                if Rec."Setup Intent Status" = 'failed' then
                    Rec."Stripe Verification Status" := Rec."Stripe Verification Status"::Failed;
                //SRBC-505 End
            end;
        }
        field(112; "Stripe Mandate Status"; Text[100])//Mandate Status
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec."Stripe Mandate Status" = 'active' then
                    Rec."Stripe Account Status" := Rec."Stripe Account Status"::Active;
                if Rec."Stripe Mandate Status" = 'inactive' then
                    Rec."Stripe Account Status" := Rec."Stripe Account Status"::Inactive;
                if Rec."Stripe Mandate Status" = 'pending' then
                    Rec."Stripe Account Status" := Rec."Stripe Account Status"::Pending;
                if (Rec."Stripe Mandate Status" = '') or (Rec."Stripe Mandate Status" = 'null') then
                    Rec."Stripe Account Status" := Rec."Stripe Account Status"::" ";
            end;
        }
        field(113; "Status Reason"; Text[100])//Failure Code
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Status Description"; Text[500])//Failure Description
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Stripe Finger Print ID"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Stripe Account Status"; Option)//Mandate Status
        {
            DataClassification = ToBeClassified;
            InitValue = " ";
            OptionMembers = " ",Active,Inactive,Pending;//SRBC-SRBC-493 
        }
        //SRBC-493 End
    }
    keys
    {
        key(PK; sr_bankingaccountinfoId)
        {
            Clustered = true;
        }
        key(Name; sr_accountname)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; sr_accountname)
        {
        }
    }
}