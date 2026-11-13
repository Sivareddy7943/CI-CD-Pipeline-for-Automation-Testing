
table 90100 "Top Ten Customers"
{
    Caption = 'Top Ten Customers';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            // AutoIncrement = true;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(4; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(5; City; Text[50])
        {
            Caption = 'City';
        }
        field(6; Country; Text[50])
        {
            Caption = 'Country';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
