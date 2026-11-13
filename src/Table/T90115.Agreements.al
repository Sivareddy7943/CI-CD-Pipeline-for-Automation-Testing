//SRBC-253 - 20241226 - NU - Update Customer Name in Customer Master after modification in the change in Agreement Name
//SRBC-358 - 10052025 - SY - Created field MoveoutTerminate(ID-214) for Move Out functionaity
//SRBC-375 - 22062025 - SY - Did changes in some of fields lenght & OptionMembers property
//SRBC-416 - 28082025 - AM - Added a new filter "Reversed=filter(false)" on fields sr_securitydepositamount,sr_petdepositamount,sr_stylingchairdepositamount,sr_constrmoddepositamount,sr_paintwallpaperdepositamount
table 90115 Agreements
{
    Caption = 'Agreements';
    DataClassification = ToBeClassified;
    LookupPageId = "Agreement Lists";
    DrillDownPageId = "Agreement Lists";
    fields
    {
        field(1; "Agreement ID"; Guid)
        {
            Caption = 'Agreement ID';
        }
        field(21; "Licensee ID"; Guid)
        {
            Caption = 'Licensee ID';
        }
        field(22; AutoChargeCode; Code[50])
        {
            Caption = 'AutoChargeCode';
        }
        field(23; "Security Deposit Amount"; Decimal)
        {
            Caption = 'Security Deposit Amount';
        }
        field(24; "Created On"; DateTime)
        {
            Caption = 'Created On';
        }
        field(25; "Modified On"; DateTime)
        {
            Caption = 'Modified On';
        }
        field(26; "Created By"; Guid)
        {
            Caption = 'Created By';
        }
        field(27; "Modified By"; Guid)
        {
            Caption = 'Modified By';
        }
        field(28; "GL Account"; Code[2])
        {
            Caption = 'GL Account';
        }
        //field(29; sr_name; Text[500])//SRBC-375
        field(29; sr_name; Text[850])//SRBC-375
        {
            Description = 'The name of the Agreement entity.';
            Caption = 'Quick link to Agreement/ Ledger';
            //SRBC-253
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if xRec.sr_name <> Rec.sr_name then begin
                    Cust.Reset;
                    Cust.SetRange("CRM Agreement ID", Rec."Agreement ID");
                    if Cust.FindFirst() then begin
                        Cust.Validate(Name, CopyStr(Rec.sr_name, 1, 100));//SRBC-375
                        Cust.Modify();
                    end;
                end;
            end;
            //SRBC-253
        }
        field(30; sr_studioid; GUID)
        {
            Description = 'Studio #';
            Caption = 'Studio #';
            //TableRelation = "CDS sr_Studio".sr_StudioId;
        }
        field(31; sr_salonlocationid; GUID)
        {
            Description = 'Salon Location';
            Caption = 'Salon Location';
            //TableRelation = "CDS sr_Building".sr_BuildingId;
        }
        field(41; "Current Agreement Start Date"; Date)
        {
            Description = 'Current Agreement Date';
            Caption = 'Current Agreement Start Date';
            trigger OnValidate()
            var
                RecurringMgmt: Codeunit "Recurring Charges Mgt.";
            begin
                // if Rec.sr_AdditionalSecurityDepAmt <> 0 then begin
                //     if NOT Rec."Additional Security Charge" then begin
                //         if Rec."Current Agreement Start Date" <> 0D then
                //             RecurringMgmt.CreateAdditionalSecurityDepositLines(Rec);
                //     end;
                // end;
            end;
        }
        field(42; "Current Agreement End Date"; Date)
        {
            Description = 'Current Agreement End Date';
            Caption = 'Current Agreement End Date';
        }
        // field(43; sr_Licensee; Text[2000])//SRBC-375
        field(43; sr_Licensee; Text[2048])//SRBC-375
        {
            Description = '';
            Caption = 'Licensee String';
        }
        field(44; "Licensee 1"; guid)
        {
            Description = '';
            Caption = 'Licensee 1';
        }
        field(45; "Licensee 2"; guid)
        {
            Description = '';
            Caption = 'Licensee 2';
        }
        field(46; "Licensee 3"; guid)
        {
            Description = '';
            Caption = 'Licensee 3';
        }
        field(47; "Licensee 4"; guid)
        {
            Description = '';
            Caption = 'Licensee 4';
        }
        field(48; "Licensee 5"; guid)
        {
            Description = '';
            Caption = 'Licensee 5';
        }
        field(49; "Licensee 6"; guid)
        {
            Description = '';
            Caption = 'Licensee 6';
        }
        field(50; "Licensee 7"; guid)
        {
            Description = '';
            Caption = 'Licensee 7';
        }
        field(51; "Licensee 8"; guid)
        {
            Description = '';
            Caption = 'Licensee 8';
        }
        field(52; "Licensee 9"; guid)
        {
            Description = '';
            Caption = 'Licensee 9';
        }
        field(53; "Licensee 10"; guid)
        {
            Description = '';
            Caption = 'Licensee 10';
        }
        field(54; "Studio 1"; Guid)
        {
            Description = '';
            Caption = 'Studio 1';
        }
        field(55; "Studio 2"; Guid)
        {
            Description = '';
            Caption = 'Studio 2';
        }
        field(56; "Studio 3"; Guid)
        {
            Description = '';
            Caption = 'Studio 3';
        }
        field(57; "Studio 4"; Guid)
        {
            Description = '';
            Caption = 'Studio 4';
        }
        field(58; "Studio 5"; Guid)
        {
            Description = '';
            Caption = 'Studio 5';
        }
        field(59; "Studio 6"; Guid)
        {
            Description = '';
            Caption = 'Studio 6';
        }
        field(60; "Studio 7"; Guid)
        {
            Description = '';
            Caption = 'Studio 7';
        }
        field(61; "Studio 8"; Guid)
        {
            Description = '';
            Caption = 'Studio 8';
        }
        field(62; "Studio 9"; Guid)
        {
            Description = '';
            Caption = 'Studio 9';
        }
        field(63; "Studio 10"; Guid)
        {
            Description = '';
            Caption = 'Studio 10';
        }
        // field(64; sr_Studio; Text[2000])//SRBC-375
        field(64; sr_Studio; Text[2048])//SRBC-375
        {
            Description = '';
            Caption = 'sr_Studio';
        }
        field(96; "New Start Date"; Date)
        {
            Description = 'New Start Date';
            Caption = 'New Start Date';
        }
        field(97; "New End Date"; Date)
        {
            Description = 'New End Date';
            Caption = 'New End Date';
        }
        field(98; "Agreement Status Reason"; Enum AgreementStatusReason)
        {
            Description = 'Agreement Status Reason';
            Caption = 'Agreement Status Reason';
            //Editable = false;
        }
        field(99; "Agreement Status"; Enum AgreementStatus)
        {
            Description = 'Agreement Status';
            Caption = 'Agreement Status';
            //Editable = false;
        }
        field(100; Inactive; Boolean)
        {
            Description = 'Inactive';
            Caption = 'Inactive';
            Editable = false;
        }
        field(101; "Customer Code"; Code[20])
        {
            Description = 'Customer Code';
            Caption = 'Customer Code';
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(102; "Current Rent Rate"; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(103; "Balance As Due"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("Customer Code"),
                                                                       "Posting Date" = field("Date Filter"),
                                                                       "Entry Type" = filter("Initial Entry")));
            Caption = 'Balance As Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(104; "BC Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(105; "BC Studio Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'BC Studio Code';
        }
        field(106; "Balance As Due 2"; Decimal)
        {
            Description = 'Balance As Due 2';
            Caption = 'Balance As Due 2';
            Editable = false;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("Customer Code"),
                                                                       "Posting Date" = field("Date Filter"), "Entry Type" = filter("Initial Entry")));
            FieldClass = FlowField;
        }
        field(159; sr_totalsecuritydeposit; Decimal)
        {

            Description = 'Total Security Deposit';
            Caption = 'Total Security Deposit';
        }
        field(160; sr_totalsecuritydeposit_Base; Decimal)
        {

            Description = 'Value of the Total Security Deposit in base currency.';
            Caption = 'Total Security Deposit (Base)';
        }
        field(161; sr_securitydepositamount; Decimal)
        {

            Description = 'Security Deposit Amount';
            Caption = 'Security Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Charge/Payment Type" = filter('LICENSE FEE SECURITY DEPOSIT' | 'ADDITIONAL SECURITY DEPOSIT'),
                                                                       "Agreement ID" = field("Agreement ID"),
                                                                       "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                       Reversed = filter(false))); //SRBC-416
            FieldClass = FlowField;
        }
        field(162; sr_securitydepositamount_Base; Decimal)
        {

            Description = 'Value of the Security Deposit Amount in base currency.';
            Caption = 'Security Deposit Amount (Base)';
            Editable = false;
        }
        field(163; sr_petdepositamount; Decimal)
        {

            Description = 'Pet Deposit Amount';
            Caption = 'Pet Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Charge/Payment Type" = filter('PET DEPOSIT'),
                                                                       "Agreement ID" = field("Agreement ID"),
                                                                       "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                       Reversed = filter(false))); //SRBC-416
            FieldClass = FlowField;
        }
        field(164; sr_petdepositamount_Base; Decimal)
        {

            Description = 'Value of the Pet Deposit Amount in base currency.';
            Caption = 'Pet Deposit Amount (Base)';
        }
        field(165; sr_stylingchairdepositamount; Decimal)
        {

            Description = 'Styling Chair Deposit Amount';
            Caption = 'Styling Chair Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Charge/Payment Type" = filter('CHAIR DEPOSIT'),
                                                                       "Agreement ID" = field("Agreement ID"),
                                                                       "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                       Reversed = filter(false))); //SRBC-416
            ;
            FieldClass = FlowField;
        }
        field(166; sr_stylchairdepositamount_Base; Decimal)
        {

            Description = 'Value of the Styling Chair Deposit Amount in base currency.';
            Caption = 'Styling Chair Deposit Amount (Base)';
        }
        field(167; sr_constrmoddepositamount; Decimal)
        {

            Description = 'Construction/Modification Deposit Amount';
            Caption = 'Construction/Modification Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Charge/Payment Type" = filter('STUDIO MODIFICATION DEPOSIT'),
                                                                      "Agreement ID" = field("Agreement ID"),
                                                                       "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                       Reversed = filter(false))); //SRBC-416
            FieldClass = FlowField;
        }
        field(168; sr_construmodepositamount_Base; Decimal)
        {

            Description = 'Value of the Construction/Modification Deposit Amount in base currency.';
            Caption = 'Construction/Modification Deposit Amount (Base)';
        }
        field(171; sr_paintwallpaperdepositamount; Decimal)
        {

            Description = 'Paint/Wallpaper Deposit Amount';
            Caption = 'Paint/Wallpaper Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Charge/Payment Type" = filter('PAINT DEPOSIT'),
                                                                       "Agreement ID" = field("Agreement ID"),
                                                                       "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                       Reversed = filter(false))); //SRBC-416
            FieldClass = FlowField;
        }
        field(172; sr_paintwalldepositamount_Base; Decimal)
        {

            Description = 'Value of the Paint/Wallpaper Deposit Amount in base currency.';
            Caption = 'Paint/Wallpaper Deposit Amount (Base)';
        }
        field(173; sr_vacateddate; Date)
        {
            Description = 'Vacated Date';
            Caption = 'Vacated Date';
        }
        field(174; sr_moveindate; Date)
        {
            Description = 'Move In Date (Actual)';
            Caption = 'Move In Date (Actual)';
        }
        field(175; sr_holddepositamount; Decimal)
        {
            Description = '';
            Caption = 'Hold Deposit Amount';
        }
        field(176; sr_holddeposittransferreq; Boolean)
        {
            Description = '';
            Caption = 'Hold Deposit Transfer Requested';
        }
        field(177; sr_DepositAmtforStudiotransto; Decimal)
        {

            Description = '';
            Caption = 'Deposit Amount for Studio transferring to';
        }
        field(178; sr_docusignintegstatustransfer; Option)
        {
            Description = '';
            Caption = 'Docusign Integration Status Transfer';
            InitValue = Draft;
            //SRBC-375 Start
            //OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed; 
            OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            //SRBC-375 End
        }
        field(179; sr_AdditionalSecDepAmtrequired; Decimal)
        {
            Description = '';
            Caption = 'Additional Security Deposit Amount required';
        }
        field(180; "New Agreement"; guid)
        {
            Description = '';
            Caption = 'New Agreement';
        }
        field(181; sr_studiomodcoststolicensee; Decimal)
        {
            Description = 'Studio Modification Costs to Licensee';
            Caption = 'Studio Modification Costs to Licensee';
        }
        field(182; sr_studiomodificationcoststosr; Decimal)
        {
            Description = 'Studio Modification Costs to SR';
            Caption = 'Studio Modification Costs to SR';
        }
        field(183; sr_studiomodsecdeptolicens; Decimal)
        {
            Description = 'Studio Modification Security Deposit to Licensee';
            Caption = 'Studio Modification Security Deposit to Licensee';
        }
        field(184; sr_studiomodpaymentreclicensee; Boolean)
        {
            Description = 'Studio Modification Payment Received (Licensee)?';
            Caption = 'Studio Modification Payment Received (Licensee)?';
        }
        field(185; sr_constructionagreeexecuted; Boolean)
        {
            Description = 'Construction Agreement Executed';
            Caption = 'Construction Agreement Executed';
        }
        field(186; sr_modificationcostagreement; Option)
        {

            Description = 'Modification Cost Agreement';
            Caption = 'Modification Cost Agreement';
            InitValue = " ";
            OptionMembers = " ","1Year(Licensee-100%Cost)","2Years(Licensee-50%Cost/SR50%Cost)","3Years+(SR100%Cost/Licensee-50%Deposit)","Other-Specify";
        }
        field(187; sr_combinationmodexecuted; Boolean)
        {

            Description = 'Combination/Modification Executed';
            Caption = 'Combination/Modification Executed';
        }
        field(188; sr_StudioCombinationStatus; Option)
        {

            Description = '';
            Caption = 'Construction Agreement Status';
            InitValue = " ";
            //SRBC-375 Start
            //OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            //SRBC-375 End
        }
        field(189; ModifiedDate; Date)
        {
            Description = '';
            Caption = 'Modified Date';
            Editable = false;
        }
        field(190; sr_PaymentPlanStatus; Option)
        {
            Description = '';
            Caption = 'Payment Plan Status';
            InitValue = " ";
            //SRBC-375 Start
            //OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            //SRBC-375 End
        }
        field(191; sr_weeklyaddpaymentamount; Decimal)
        {
            Description = '';
            Caption = 'Weekly Additional Payment Amount:';
        }
        field(192; sr_estimatedplancompletiondate; Date)
        {
            Description = '';
            Caption = 'Estimated Plan Completion Date';
        }
        field(193; sr_planstartdate; Date)
        {
            Description = '';
            Caption = 'Plan Start Date';
        }
        field(194; sr_PaymentPlanLicensee; GUID)
        {
            Description = '';
            Caption = 'Payment Plan Licensee';
            //TableRelation = "CRM Contact".ContactId;
        }
        field(195; sr_totalweeklypaymentplan; Decimal)
        {
            Description = '';
            Caption = 'TOTAL Weekly Payment Plan';
        }
        field(196; sr_RenewalQuantityOfMonths; Option)
        {

            Description = '';
            Caption = 'Renewal Quantity Of Months';
            InitValue = " ";
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100";

        }
        field(197; sr_RenewalNewStartDate; Date)
        {
            Description = '';
            Caption = 'Renewal New Start Date';
        }
        field(198; sr_RenewalNewEndDate; Date)
        {
            Description = '';
            Caption = 'Renewal New End Date';
        }
        field(199; sr_RenewalNewSecDepositAmount; Decimal)
        {
            Description = '';
            Caption = 'Renewal New Security Deposit Amount';
        }
        field(200; sr_renewalnewsecdepamt_Base; Decimal)
        {
            Description = 'Value of the Renewal New Security Deposit Amount in base currency.';
            Caption = 'Renewal New Security Deposit Amount (Base)';
        }
        field(201; sr_RenewalLAStatus; Option)
        {
            Description = '';
            Caption = 'Renewal LA Status';
            InitValue = Draft;
            //SRBC-375 Start
            //OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            //SRBC-375 End
        }
        field(202; sr_AdditionalSecurityDepAmt; Decimal)
        {
            Description = '';
            Caption = 'Additional Security Deposit Amount';
            Editable = false;
        }
        field(203; sr_docusignintegrastatus_la; Option)
        {
            Description = 'Docusign Integration Status LA';
            Caption = 'LA Docusign Status';
            InitValue = Draft;
            //SRBC-375 Start
            //OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            //SRBC-375 End
        }
        field(204; sr_LASecurityDepositAmount; Decimal)
        {
            Description = '';
            Caption = 'LA Security Deposit Amount';
        }
        field(71; "Payment Plan"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(205; sr_RenewalStatus; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Status';

        }
        field(206; sr_AgreementTransferStatus; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Agreement Transfer Status';
        }
        field(207; sr_BCconstructionExcexuted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'BC Construction Executed';
        }
        field(208; "Additional Security Charge"; Boolean)
        {
            Description = '';
            //Editable = false;
            Caption = 'Additional Security Charge';
        }
        field(209; "Security Charge Created Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Additional Security Charge Created Date';
        }
        field(210; "Security Charge Created Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Additional Security Charge Created Time';
        }
        field(211; "Additional Security Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Additional Security Charge Entry No.';
        }
        field(212; LASecurity; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'LASecurity';
        }
        field(213; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        //SRBC-358 Start
        field(214; MoveoutTerminate; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-358 End
    }
    keys
    {
        key(PK; "Agreement ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Customer: Record Customer;
        ModCustomer: Record Customer;

        SalonSetup: Record "Salon Republic Setup";
        CustTemplate: Record "Customer Templ.";
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
        isHandled: Boolean;
    begin
        // SalonSetup.Get();
        // SalonSetup.TestField("Customer Template");
        // Customer.Reset();
        // Customer.SetRange("CRM Agreement ID", Rec."Agreement ID");
        // if Customer.FindFirst() then
        //     exit;
        // CustTemplate.Get(SalonSetup."Customer Template");
        // CustomerTemplMgt.CreateCustomerFromTemplate(Customer, isHandled, CustTemplate.Code);
        // ModCustomer.get(Customer."No.");
        // ModCustomer.validate(Name, CopyStr(Rec.sr_name, 1, 100));
        // ModCustomer.Validate("Search Name", CopyStr(Rec.sr_name, 1, 100));
        // ModCustomer."CRM Agreement ID" := Rec."Agreement ID";
        // ModCustomer.Modify(true);
    end;

    trigger OnModify()
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        Validate(ModifiedDate, Today);

        // JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Integration Synch. Job Runner");
        // JobQueueEntry.SetRange(Description, ' AGREEMENTS - Dataverse synchronization job.');
        // if JobQueueEntry.FindFirst() then begin
        //     JobQueueEntry.Validate("Earliest Start Date/Time", 0DT);
        //     JobQueueEntry.Validate(Status, JobQueueEntry.Status::Ready);
        //     JobQueueEntry.Modify(true);
        // end;
    end;
}
