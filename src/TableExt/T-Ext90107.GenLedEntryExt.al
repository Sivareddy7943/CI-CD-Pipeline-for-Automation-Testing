//SRBC-210 - Added New Field Sr_Description.
//         - Flow Sr_Description same as Standard Description field.
//SRBC-216 - 20241126 - BC > Stripe payment settlements Flow Stripe Invoice Number & Transfer ID to G/L Entries in BC.
//                    - Added new fields ID 50021 to 50023 and 50044
//SRBC-299 - 27022025 - SY - Created field "Source Name" for update Customer/Vendor Name on basis of "Source Type" & "Source No."".
//SRBC-368 - 04062025 - SY - Created field - "Customer No"(50050), "Customer Name"(50051), "Customer Email"(50052)
tableextension 90107 GenLedEntryExt extends "G/L Entry"
{
    fields
    {
        field(50000; "Charge/Payment Type"; Code[50])
        {
            Caption = 'Charge/Payment Type';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50004; "Charge Category"; Enum "Charges Category")
        {
            //DataClassification = ToBeClassified;
            Editable = false;
            CalcFormula = lookup("Auto Charge"."Charge Category" where(Code = field("Charge/Payment Type")));
            FieldClass = FlowField;
        }
        field(50047; Sr_Description; Text[2048])
        {
            Description = '';
            Caption = 'SR Description';
            Editable = false;
        }
        field(50021; "Stripe Invoice ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Stripe Invoice ID';
        }
        field(50023; "Stripe Invoice Number"; Code[50])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            Caption = 'Stripe Invoice Number';
        }
        field(50044; "Payment Intent ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Payment Intent ID';
        }
        //SRBC-299 Start
        field(50045; "Source Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Name';
        }
        //SRBC-299 End
        //SRBC-368 start
        field(50050; "Customer ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer ID';
        }
        field(50051; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }
        field(50052; "Customer Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Email';
        }
        //SRBC-368 end;
    }
}
