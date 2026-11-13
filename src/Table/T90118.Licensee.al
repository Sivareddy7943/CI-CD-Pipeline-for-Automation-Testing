//SRBC-441 JSG 29102025
table 90118 Licensee
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Licensee ID"; Guid) { DataClassification = ToBeClassified; }
        field(3; "Agreement ID"; Guid) { DataClassification = ToBeClassified; }
    }

    keys
    {
        key(Key1; "Entry No.", "Licensee ID", "Agreement ID")
        {
            Clustered = true;
        }
    }

}