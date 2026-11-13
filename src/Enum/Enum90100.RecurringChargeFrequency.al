enum 90100 "Recurring Charge Frequency"
{
    Extensible = true;
    // value(0; " ")
    // {
    //     Caption = ' ';
    // }
    value(0; Once)
    {
        Caption = 'Once';
    }
    value(1; Daily)
    {
        Caption = 'Daily';
    }
    value(2; Weekly)
    {
        Caption = 'Weekly';
    }
    value(3; Monthly)
    {
        Caption = 'Monthly';
    }
    value(4; Quarterly)
    {
        Caption = 'Quarterly';
    }
    value(5; Yearly)
    {
        Caption = 'Yearly';
    }
}
