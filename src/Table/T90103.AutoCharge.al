/// <summary>
/// Table Auto Charge (ID 50001).
/// </summary>
table 90103 "Auto Charge"
{
    Caption = 'Auto Transaction/Charge Type';
    DataClassification = ToBeClassified;
    LookupPageId = "Auto Transaction Charge Types";
    DrillDownPageId = "Auto Transaction Charge Types";
    fields
    {
        field(1; "Transaction Type"; Enum TransactionType)
        {
            DataClassification = ToBeClassified;
            Caption = 'Transaction Type';
        }
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(21; "GL Account No."; Code[20])
        {
            Caption = 'GL Account No.';
            TableRelation = "G/L Account";
        }
        field(22; "Inactive"; Boolean)
        {
            Caption = 'Inactive';
        }
        field(23; "Default Recurring Due Day"; Enum "Week Selection")
        {
            DataClassification = ToBeClassified;
        }
        field(24; sr_autochargetypeId; GUID)
        {
            Description = 'Unique identifier for entity instances';
            Caption = 'CRM Auto Charge Type';
        }
        field(25; CreatedOn; Datetime)
        {

            Description = 'Date and time when the record was created.';
            Caption = 'CRM Created On';
        }
        field(26; CreatedBy; GUID)
        {
            Description = 'Unique identifier of the user who created the record.';
            Caption = 'CRM Created By';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(27; ModifiedOn; Datetime)
        {
            Description = 'Date and time when the record was modified.';
            Caption = 'CRM Modified On';
        }
        field(28; ModifiedBy; GUID)
        {
            Description = 'Unique identifier of the user who modified the record.';
            Caption = 'CRM Modified By';
            //TableRelation = "CRM Systemuser".SystemUserId;
        }
        // SR..BKP -- 12/01/2024 NS
        field(29; "Charge Category"; Enum "Charges Category")
        {
            DataClassification = ToBeClassified;
            Caption = 'Charge Category';
        }
        // SR..BKP -- 12/01/2024 NE
        field(30; "Incur late fee"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Incur late fee';
        }
        field(31; IsBC; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Incur late fee';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Transaction Type", "Code")
        {
            Clustered = true;
        }
    }
}
