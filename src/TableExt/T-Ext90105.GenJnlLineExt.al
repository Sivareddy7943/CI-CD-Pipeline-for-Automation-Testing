//SRBC-210 - Added New Field Sr_Description.
//         - Flow Sr_Description same as Standard Description field.
//SRBC-255 - 20241219 - NU - Update Payment intent ID & Banking Account Info GUID in the Refund Customer Ledger entry when Refund Journal is created from the applied Payment.
//                         -added field(50048; "Payment Intent ID"; Text[50])
//SRBC-280 - SY - 30012025 - Created Codeunit for fail safe batch process   
//SRBC-227 - SY - 04032025 - Added validation for field Recipient Bank Account, for check Customer Bank Account status is active or inactive.    
//SRBC-358 - AM - 08052025 - Created a field(50053; "Move Out Terminate"; Boolean)
//SRBC-380 - SY - 15072025 - Created field(50054; "Construction Agreement"; Boolean)
//SRBC-384 - AM - 19072025 - Added a new field (50055; "Schedule Charges And Payment"; Boolean) and (50056; "Queue Table Entry No."; Integer) to update it while posting journals from Edit delete trans queue table
//SRBC-438 - AM - 27102025 - Added a new field (50057; "Cust Ledger Entry No"; Integer)
//SRBC-455 - NT - 25012026 - Added a new field field(50058; "Refund Transactions"; Boolean)
//SRBC-352 - AM - 14032026 - Added a new field frequency
//SRBC-483 - SY - 08042026 - Created field - "Dispute Lost Entry No." for flow data from Payment to refund entry when dispute lost update on payment entry
//SRBC-494 - AM - 10062026 - Created a field Agreemen transfer to update it while agreement transfer process
tableextension 90105 GenJnlLineExt extends "Gen. Journal Line"
{
    fields
    {
        modify("Recipient Bank Account")
        {
            trigger OnAfterValidate()
            var
                CustomerBankAccount_lRec: Record "Customer Bank Account";
                Contacts_lRec: Record Contact;
                EpaymentSchedule_lRec: Record "E Payment Schedule";
            begin
                //SRBC-227 Start
                //Validated objects - Cod50012 - Line No - 604
                //Rep50012 - Line No - 32
                if (Rec."Document Type" = Rec."Document Type"::Payment) and ("Charge Payment Type" = 'E-PAYMENT') and
                ("Payment Method Code" = 'E-PAYMENT') then begin
                    if (Rec."Account Type" = Rec."Account Type"::Customer) and (Rec."Account No." <> '') then begin
                        CustomerBankAccount_lRec.Reset();
                        CustomerBankAccount_lRec.SetRange("Bank Account Info", Rec."Banking Account Info");
                        CustomerBankAccount_lRec.SetRange("License ID", Rec.License);
                        CustomerBankAccount_lRec.SetRange(Code, Rec."Recipient Bank Account");
                        if CustomerBankAccount_lRec.FindFirst() then
                            CustomerBankAccount_lRec.TestField("Verification Status", 'active');
                    end;
                end;
                //SRBC-227 End
            end;
        }
        field(50000; "Charge Payment Type"; Code[50])
        {
            Caption = 'Charge/Payment Type';
            //Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50001; "AutoCharge ID"; guid)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(50002; "License"; Guid)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            //TableRelation = Contact.;
        }
        field(50003; "Agreement ID"; Guid)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            TableRelation = Agreements."Agreement ID";
        }
        field(50004; "Charge Category"; Enum "Charges Category")
        {
            Editable = false;
            CalcFormula = lookup("Auto Charge"."Charge Category" where(Code = field("Charge Payment Type")));
            FieldClass = FlowField;
        }
        field(50005; "CRM Contact ID"; Text[100])
        {
            Caption = 'CRM Contact ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50008; "CRM AccountLedger ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'CRM AccountLedger ID';
        }
        field(50016; IsCheckDeposit; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'IsCheckDeposit';
        }
        field(50017; FromPowerFlow; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'FromPowerFlow';
        }
        field(50018; ReversedFromCRM; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
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
            //Editable = false;
            Caption = 'Epayment Schedule';
        }
        field(50021; "Edit Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'EditCharge';
        }
        field(50022; "Delete Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Delete Charge';
        }
        field(50023; "Edit Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Edit Payment';
        }
        field(50024; "Delete Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Delete Payment';
        }
        field(50025; "Edit Discount"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Edit Discount';
        }
        field(50026; "Delete Discount"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Delete Discount';
        }
        field(50027; "Transaction Type CRM"; Enum TransactionType)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Transaction Type CRM';
        }
        field(50028; "Banking Account Info"; Guid)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Banking Account Info';
            TableRelation = "Banking Account Info".sr_bankingaccountinfoId;
        }
        field(50029; "MultiSigner Hold Deposit"; Boolean)
        {
            Description = '';
            Caption = 'MultiSigner Hold Deposit';
        }
        field(50030; "Return Fee Calculation"; Boolean)
        {
            Description = '';
            Caption = 'Return Fee Calculation';
            Editable = false;
        }
        field(50047; Sr_Description; Text[2048])
        {
            Description = '';
            Caption = 'SR Description';
            //Editable = false;
            trigger OnValidate()
            begin
                Description := CopyStr(Sr_Description, 1, 100);
            end;
        }
        field(50048; "Payment Intent ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Payment Intent ID';
        }
        field(50050; "Error Message"; Text[2000]) //SRBC-280
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Error Message';
        }
        field(50051; "Email Sent"; Boolean) //SRBC-280
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50052; "Account Ledger GUID CRM"; Guid) //SRBC-280-290
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        //SRBC-358 Start
        field(50053; MoveOutTerminate; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-358 Start
        //SRBC-380 Start
        field(50054; "Construction Agreement"; Boolean)
        {
            Description = '';
            Caption = 'Construction Agreement';
        }
        //SRBC-380 End
        //SRBC-384 Start
        field(50055; "Schedule Charges And Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Queue Table Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-384 End
        //SRBC-438 Start
        field(50057; "CLE No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-438 End
        //SRBC-455 Start
        field(50058; "Refund Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-455 End
        //SRBC-352 Start
        field(50059; "Frequency"; Enum "Frequency")
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

        modify("Ship-to/Order Address Code")
        {
            trigger OnAfterValidate()
            var
                ShipToAdd: Record "Ship-to Address";
            begin
                if Rec."Ship-to/Order Address Code" <> '' then begin
                    if "Account Type" = "Account Type"::Customer then begin
                        ShipToAdd.Get("Account No.", "Ship-to/Order Address Code");
                        if ShipToAdd."Global Dimension 1 Code" <> '' then
                            Rec.Validate("Shortcut Dimension 1 Code", ShipToAdd."Global Dimension 1 Code");
                        if ShipToAdd."Global Dimension 2 Code" <> '' then
                            Rec.Validate("Shortcut Dimension 2 Code", ShipToAdd."Global Dimension 2 Code");
                    end;

                end else begin
                    Rec.CreateDimFromDefaultDim(FieldNo("Account No."));
                end;
            end;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                Cust: Record Customer;
                Contact: Record Contact;
                agreements: Record Agreements;
            begin
                if "Account Type" = "Account Type"::Customer then begin
                    Cust.Reset();
                    if Cust.get("Account No.") then begin
                        if Cust."CRM Agreement ID" <> '' then begin
                            //if Cust."CRM Contact ID" <> '' then begin
                            //Contact.Reset();
                            //Contact.SetRange("CRM Contact ID", Cust."CRM Contact ID");
                            //if Contact.FindFirst() then begin
                            //    License := Cust."CRM Contact ID";
                            agreements.Reset();
                            //agreements.SetRange("Licensee ID", Contact."CRM Contact ID");
                            agreements.SetRange("Agreement ID", Cust."CRM Agreement ID");
                            if agreements.FindFirst() then begin
                                "Agreement ID" := agreements."Agreement ID";
                            end else
                                clear("Agreement ID");
                        end else begin
                            Clear(License);
                            clear("Agreement ID");
                        end;
                    end;
                end else begin
                    Clear(License);
                    clear("Agreement ID");
                end;

            end;
            //            end;
        }
    }
}
