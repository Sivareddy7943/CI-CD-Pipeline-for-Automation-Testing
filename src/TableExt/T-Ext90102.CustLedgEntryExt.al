//SRBC-210 - Added New Field Sr_Description.
//         - Flow Sr_Description same as Standard Description field.
//SRBC-185 - 20241114 - One Time Payment Method Changes - Portal.
//         - Added a new field(50050; "Recipient Bank Account Portal"; Code[20])
//         - We need to flow this field with Cust. Bank acc code in case of creates from portal payments.
//SRBC-217 - Added new field Stripe Payment Status Date, Failed stripe invoice boolean.
//         - Stripe Payment Status date - for update payment failure date & create reversel entry with same date
//         - Failed Stripe Invoice - Boolean for read one time code on OnAfterModifyEvent of CLE
//SRBC-279 - 20250131 - NU - Need Capabilities to Send Failure Email Notification 
//SRBC-322 - 12032025 - SY - Created field SkipEventTrigger for skip OnAfterModifyEvent of CLE
//SRBC-290 - 20250319- NU - Real Time Data Sync For Ledger Transactions- API and Virtual Tables
//                        - Added New fields from Field ID 50061 to 50066
//SRBC-346 - 23042025 - SY - Created field(50068; Status; Enum StatusAccountLedger), (50069; StatusTxt; Text[100])
//         - 05052025 - SY - Created field - "Processing Status", ProcessingStatusTxt
//SRBC-356 - AR - 29042025 - Created new Field ID 50030("Stripe Payment Method Type")
//SRBC-358 - AM - 08052025 - Created field(50073; "Move Out Terminate"; boolean)
//SRBC-366 - MY - 27052025 - Created fields NSF(50074),"Deposit date"(50075),"Deposit No."(50076)
//SRBC-328 - AM - 01072025 - Created field "StripePaymentStatusTxt" (50077) and added code in strip payment status field validate trigger
//SRBC-384 - AM - 19072025 - Added two fields field(50078; "Schedule Charges And Payment"; Boolean) and field(50079; "Queue Table Entry No."; Integer) to update it while posting journals from Edit delete trans queue table
//SRBC-346 - AM - 04082025 - Added a new field (50080; TransactionTypeTxt; Text[50]) to add it in virtual table and also code onValidation of Tranaction type to update it.
//SRBC-428 - AM - 17092025 - Added new fields "Licensee Name","Studio Description","Loc Description"and added code on modify of
//                Global Dim 1 and Global Dim 2 Code field also also code onValidate trigger of Licensee 
//SRBC-439 - SY - 15102025 - Created fields - "Edit Delete Failed", "Edit Delete Failure Reason"
//SRBC-438 - AM - 30102025 - Created field -  field(50087; "Purch. Inv Created"; Boolean)
//SRBC-352 - AM - 12032026 - created field - field(50088; "Frequency"; Enum "Recurring Frequency Late Fee")
//SRBC-483 - SY - 08042026 - Created field - "Dispute Lost Entry No." for flow data from Payment to refund entry when dispute lost update on payment entry
//SRBC-494 - AM - 10062026 - Created a field Agreemen transfer to update it while agreement transfer process
tableextension 90102 CustLedgEntryExt extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Charge/Payment Type"; Code[50])
        {
            Caption = 'Charge/Payment Type';
            Editable = false;
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(50001; "AutoCharge ID"; guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50002; "License"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            //SRBC-290 - START
            trigger OnValidate()
            var
                myInt: Integer;
                Contact_lRec: Record Contact;//SRBC-428
            begin
                //SRBC-428 Start
                if not IsNullGuid(Rec.License) then begin
                    Validate(LicenseIDTxt, Format(License));
                    Contact_lRec.Reset();
                    Contact_lRec.SetRange("CRM Contact ID", License);
                    if Contact_lRec.FindFirst() then
                        Validate("Licensee Name", Contact_lRec.Name);
                    //SRBC-428 End
                end;
            end;
            //SRBC-290 - END
        }
        field(50003; "Agreement ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            //SRBC-290 - START
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if not IsNullGuid(Rec."Agreement ID") then
                    Validate(AgreementIDTxt, Format("Agreement ID"));
            end;
            //SRBC-290 - END
        }
        field(50004; "Transaction Type"; Enum TransactionType)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Transaction Type';
            //SRBC-346 - Start
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate(TransactionTypeTxt, Format("Transaction Type"));
            end;
            //SRBC-346 - End
        }
        field(50005; "Payment Status"; Enum "Payment Type")
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Payment Status';
        }
        field(50006; "Charge Category"; Enum "Charges Category")
        {
            //DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Charge Category';
            CalcFormula = lookup("Auto Charge"."Charge Category" where(Code = field("Charge/Payment Type")));
            FieldClass = FlowField;
        }
        field(50007; "Payer/Licensee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Payer/Licensee Name';
        }
        field(50008; "CRM AccountLedger ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'CRM AccountLedger ID';
            //SRBC-290 - START
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate(CRMAccountLedgerIDTxt, Format("CRM AccountLedger ID"));
            end;
            //SRBC-290 - END
        }
        // SR..BKP -- 09/01/2024
        field(50009; "Returned Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Returned Payment';
            InitValue = false;
        }
        field(50010; "CRM Account Charge Type GUID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'CRM Auto Charge Type GUID';
            //SRBC-290 - START
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if not IsNullGuid(Rec."CRM Account Charge Type GUID") then
                    Validate(CRMAutochargeIDTxt, Format("CRM Account Charge Type GUID"));
            end;
            //SRBC-290 - END
        }
        field(50011; "Security Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Security Deposit';
        }
        field(50012; "Account Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Account Name';
        }
        field(50013; "Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Amount Paid';
        }
        field(50014; "Modified On"; DateTime)
        {
            Caption = 'Modified On';
        }
        field(50015; "Modified By"; Guid)
        {
            Caption = 'Modified By';
        }
        field(50016; IsCheckDeposit; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'IsCheckDeposit';
        }
        field(50017; FromPowerFlow; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'FromPowerFlow';
        }
        field(50018; ReversedFromCRM; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'ReversedFromCRM';
        }
        field(50019; "Studio Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Studio Transfer';
        }
        field(50020; "Epayment Schedule"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Epayment Schedule';
        }

        field(50021; "Stripe Invoice ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Stripe Invoice ID';
        }
        field(50022; RunningBalance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Custom CustLed Entry"."Running Balance" WHERE("Entry No." = FIELD("Entry No.")));
            Editable = false;
        }
        field(50023; "Stripe Inv Number"; Code[50])
        {
            Editable = false;
        }
        field(50024; "Edit Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Edit Charge';
        }
        field(50025; "Delete Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Delete Charge';
        }
        field(50026; "Edit Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Edit Payment';
        }
        field(50027; "Delete Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Delete Payment';
        }
        field(50028; "Edit Discount"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Edit Discount';
        }
        field(50029; "Delete Discount"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Delete Discount';
        }

        field(50030; "Sync Number"; Integer)
        {
            DataClassification = ToBeClassified;

            Caption = 'Sync Number';
        }
        field(50031; "Banking Account Info"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Banking Account Info';
            //TableRelation = "Banking Account Info".sr_bankingaccountinfoId;
        }
        field(50032; InvoiceBalance; Decimal)
        {
            Caption = 'Invoice Balance';
            Editable = false;
            CalcFormula = Lookup("Custom CustLed Entry"."Invoice Balance" WHERE("Entry No." = FIELD("Entry No.")));
            FieldClass = FlowField;
        }
        field(50033; ModifiedDate; Date)
        {
            Description = '';
            Caption = 'Modified Date';
            Editable = false;
        }
        field(50034; "Return Fee Calculation"; Boolean)
        {
            Description = '';
            Caption = 'Return Fee Calculation';
            Editable = false;
        }
        field(50035; "Stripe Invoice Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'Stripe Invoice Status';
            Editable = false;
        }
        field(50036; "Stripe Payment Status"; Enum "Stripe Payment-Status")
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'Stripe Payment Status';
            Editable = false;
            //SRBC-328 Start
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate(StripePaymentStatusTxt, Format("Stripe Payment Status"));
            end;
            //SRBC-328 End
        }
        field(50037; "Payment Status Failure Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'Payment Status Failure Code';
            //Editable = false;
        }
        field(50038; "Payment Status Failure Reason"; Text[500])
        {
            DataClassification = ToBeClassified;
            Description = '';
            Caption = 'Payment Status Failure Reason';
            Editable = false;
        }
        field(50039; "Check NSF"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Check NSF';
            InitValue = false;
        }
        field(50040; "Epay reversed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Epay reversed';
            InitValue = false;
        }
        field(50041; sr_Deposited; Boolean)
        {
            Description = '';
            Caption = 'Deposited';
        }
        field(50042; "Amount Deposited"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Amount Deposited';
        }
        field(50043; "Stripe Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Stripe Invoice';
        }
        field(50044; "Payment Intent ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Payment Intent ID';
        }
        field(50045; "Stripe Invoice Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Stripe Invoice Created';
        }
        field(50046; "Stripe Payment Req. Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Stripe Payment Req. Created';
        }
        field(50047; Sr_Description; Text[2048])
        {
            Description = '';
            Caption = 'SR Description';
            Editable = false;
        }
        field(50048; IsHandled; Boolean)
        {
            Description = '';
            Caption = 'IsHandled';
            Editable = false;
        }

        //SRBC-217 Start
        field(50049; "Failed Stripe Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Stripe Invoice failed';
        }
        //SRBC-217 End

        field(50050; "Recipient Bank Account Portal"; Code[20])
        {
            Caption = 'Recipient Bank Account Portal';
            Editable = false;
        }

        //SRBC-217 Start
        field(50051; "Stripe Payment Status Date"; Date)
        {
            Caption = 'Stripe Payment Status Date';
            Editable = false;
        }
        //SRBC-217 End

        //SRBC-249 Start
        field(50052; "Stripe Payment Req. Hold"; Boolean)
        {
            Caption = 'Stripe Payment Req. Hold';
            Editable = false;
        }
        //SRBC-249 End

        //SRBC-254 Start
        field(50053; "Stripe Refund ID"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Stripe Refund Status"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-254 End
        field(50060; "Email Sent"; Boolean) //SRBC-279
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50061; AgreementIDTxt; Text[50]) //SRBC-290
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50062; CRMAccountLedgerIDTxt; Text[50]) //SRBC-290
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50063; IsBCGuid; Boolean) //SRBC-290
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50064; "Opening Balance"; Boolean) //SRBC-290
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50065; CRMAutochargeIDTxt; Text[50]) //SRBC-290
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50066; LicenseIDTxt; Text[50]) //SRBC-290
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //SRBC-322 start
        field(50067; SkipEventTrigger; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-322
        //SRBC-346 Start
        field(50068; Status; Enum StatusAccountLedger)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate(StatusTxt, Format(Status));
            end;
        }
        field(50069; StatusTxt; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-346 End
        //SRBC-356 Start
        field(50070; "Stripe Payment Method Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Bank Account",Card;
        }
        //SRBC-356 End
        //SRBC-346 Start
        field(50071; "Processing Status"; Enum ProcessingStatus)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate(ProcessingStatusTxt, Format("Processing Status"));
            end;
        }
        field(50072; ProcessingStatusTxt; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-346 End
        //SRBC-358 Start
        field(50073; MoveOutTerminate; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-358 End
        //SRBC-366 Start
        field(50074; NSF; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Deposit date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Deposit No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-366 End 
        //SRBC-328 Start
        field(50077; StripePaymentStatusTxt; text[50])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-328 End
        //SRBC-384 Start
        field(50078; "Schedule Charges And Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "Queue Table Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-384 End
        //SRBC-346 Start
        field(50080; TransactionTypeTxt; Text[50]) //SRBC-346
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-346 End
        //SRBC-428 Start 
        field(50082; "Loc Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "Studio Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Licensee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        modify("Global Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                DimnesionValue: Record "Dimension Value";
            begin
                DimnesionValue.Reset();
                DimnesionValue.SetRange(Code, "Global Dimension 1 Code");
                if DimnesionValue.FindFirst() then
                    Validate("Loc Description", DimnesionValue.Name);
            end;
        }
        modify("Global Dimension 2 Code")
        {
            trigger OnAfterValidate()
            var
                DimnesionValue: Record "Dimension Value";
            begin
                DimnesionValue.SetRange(Code, "Global Dimension 2 Code");
                if DimnesionValue.FindFirst() then
                    Validate("Loc Description", DimnesionValue.Name);
            end;
        }
        //SRBC-428 End
        //SRBC-439 Start
        field(50085; "Edit Delete Failed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Edit Delete Failure Reason"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-439 End
        //SRBC-438 Start
        field(50087; "Purch. Inv Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-438 End
        //SRBC-352 Start
        field(50088; Frequency; Enum Frequency)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-352 End
        //SRBC-483 Start
        field(50089; "Dispute Lost Payment Entry No."; Integer) { DataClassification = ToBeClassified; }
        //SRBC-483 End
        //SRBC-494 Start
        field(50090; "Agreement Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-494 End
    }
    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        Validate(ModifiedDate, Today);
    end;
}