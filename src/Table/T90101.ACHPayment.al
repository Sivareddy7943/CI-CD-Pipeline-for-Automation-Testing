//SRBC-207 - 03012025 - SY - Field "Epayment Schedule Created" created for check Epayment Schedule is cretaed or not against any entry.
//         - 07012025 - SY - Added field Salon, Studio, "Current Agreement Start Date", "Current Agreement End Date", "Epayment Schedule Created Date", "Epayment Schedule Created Time"
//         - 07012025 - SY - Added field "ACH Payments ID" in primary key
//SRBC-307 - 10032025 - SY - Created field "Stripe Payment Method Status" for update status from Customer Bank Account
//SRBC-473 - 28012026 - SY - Created field "Payment For"
//         - 29042026 - AM - Added onVlidate trigger on the field "Payment For" and changed datatype from option to Code[50] and added one more field "Payment For Id"
table 90101 "ACH Payment List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "ACH Payments ID"; Guid) { DataClassification = ToBeClassified; }
        field(3; "Bank Account Info ID"; Guid) { DataClassification = ToBeClassified; }
        field(4; "Agreement ID"; Guid) { DataClassification = ToBeClassified; }
        field(5; "License ID"; Guid) { DataClassification = ToBeClassified; }
        field(6; "Authorized E-Payment Amount"; Decimal) { DataClassification = ToBeClassified; }
        field(7; "Authorized E-Payment Frequency"; Enum EpaymentFrequency)
        {
            Caption = 'Authorized E-Payment Frequency';
        }
        field(8; sr_authorizedepaymentstartdate; Datetime)
        {
            Description = 'Authorized E-Payment Start Date';
            Caption = 'Authorized E-Payment Start Date';
        }
        //SRBC-207 Start
        field(9; "Epayment Schedule Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Epayment Schedule Created';
        }
        //07012025
        field(10; Salon; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Studio; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Current Agreement Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Current Agreement End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Epayment Schedule Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Epayment Schedule Created Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "BC Cust. Bank Account"; Code[20])
        {
            Description = '';
            Caption = 'BC Cust. Bank Account';
        }
        field(19; sr_accountname; Text[500])
        {
            Description = 'The name of the Banking Account Info entity.';
            Caption = 'Account Name';
        }
        //SRBC-207 End
        //SRBC-473 START 28012026
        //AM Start 29042026
        // field(20; "Payment For"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = " ","License Fee - Payment","Payment Plan";
        // }
        field(20; "Payment For"; Code[50])
        {
            Caption = 'Payment For';
            TableRelation = "Auto Charge".Code where(Inactive = filter(false));
            trigger OnValidate()
            var
                AutoCharge: Record "Auto Charge";
            begin
                AutoCharge.Reset();
                AutoCharge.SetRange(Code, "Payment For");
                if AutoCharge.FindFirst() then begin
                    Rec."Payment For Id" := AutoCharge.sr_autochargetypeId;
                end;
            end;
        }
        field(21; "Payment For Id"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        //AM End 29042026
        //SRBC-473 END 28012026
        //SRBC-307 Start
        field(83; "Stripe Payment Method Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stripe Payment Method Status';
        }
        //SRBC-307 End
    }

    keys
    {
        key(Key1; "Entry No.", "ACH Payments ID")//SRBC-207
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}