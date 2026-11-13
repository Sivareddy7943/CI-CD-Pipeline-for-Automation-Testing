tableextension 90103 ContactExt extends Contact
{
    fields
    {
        field(50000; "CRM Contact ID"; Text[100])
        {
            Caption = 'CRM Contact ID';
            Editable = false;
            DataClassification = ToBeClassified;
            //TableRelation = "CRM Contact".ContactId;
        }
        field(50001; "Created From Crm"; Boolean)
        {
            Caption = 'Created From Crm';
            DataClassification = ToBeClassified;
        }
        field(50002; "CRM Agreement ID"; Text[100])
        {
            Caption = 'CRM Agreement ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50004; "Stripe Customer ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stripe Customer ID';
            Editable = false;
        }
    }
}
