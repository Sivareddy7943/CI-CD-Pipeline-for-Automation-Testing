//SRBC-188 - 20241126 - Duplicate/Multiple Payment method Creation for the same bank account.
//                    - Added new fields ID 50104 to 50109
//                    - Added duplicate fields with name "ID2" to validate with orignial field.
//SRBC-264 - 31122024 - SY - Created field "Resend E-Mail", "Expired" for resent email to stripe customer.
//SRBC-396 - 03092025 - SY - Created field - "Inactive Mandate"
//SRBC-493 - 20072026 - AM - Added two fields Setup intent Status and Mandate status 
tableextension 90101 CustBankAccountExt extends "Customer Bank Account"
{
    fields
    {
        field(50000; "Account Type"; Enum BankAccountType)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = ToBeClassified;
        }
        field(50002; "License ID"; Guid)
        {
            Caption = 'License ID';
            DataClassification = ToBeClassified;
            Editable = false;
            //TableRelation = "CRM Contact".AccountId;
        }
        field(50003; "Agreement ID"; Guid)
        {
            Caption = 'Agreement ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Agreements."Agreement ID";
        }
        field(50004; "Bank Account Info"; Guid)
        {
            Caption = 'Bank Account Info';
            DataClassification = ToBeClassified;
            // Editable = false;
            TableRelation = "Banking Account Info".sr_bankingaccountinfoId;
        }
        field(50010; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //SY
        field(50011; "Bank Account Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec."Bank Account No." := Rec."Bank Account Number";
            end;
        }
        field(50012; "Transit Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec."Transit No." := Rec."Transit Number";
            end;
        }
        field(50013; "IsCRM"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(50100; "Payment Method ID2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Setup Intent ID2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Stripe Customer ID2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Card URL2"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; Inactive; Boolean)
        {
            Caption = 'Inactive';
            //Editable = false;
        }
        field(50105; "Error Details"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Verification Status"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Stripe Finger Print ID"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Stripe Mandate ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Cancel Setup Intent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Resend E-Mail"; Boolean) { DataClassification = ToBeClassified; }//SRBC-264
        field(50111; "Expired"; Boolean) { DataClassification = ToBeClassified; }//SRBC-264
        field(50112; "Inactive Mandate"; Boolean) { DataClassification = ToBeClassified; }//SRBC-396
        //SRBC-493 20072026 Start 
        field(50113; "Setup Intent Status"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Mandate Status"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-493 20072026 End
    }
}
