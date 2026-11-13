//SRBC-297 - Created field "Skip Error lines", if it will true then customer code will work  else not
tableextension 90104 GeneralJournalBatchExt extends "Gen. Journal Batch"
{
    fields
    {
        field(50000; Epayment; Boolean)
        {
            Caption = 'Epayment';
            DataClassification = ToBeClassified;
        }
        //SRBC-297 Start
        field(50001; "Skip Error lines"; Boolean) { DataClassification = ToBeClassified; }
        //SRBC-297 Start
    }
}
