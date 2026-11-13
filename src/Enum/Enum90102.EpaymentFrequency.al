enum 90102 EpaymentFrequency
//" ",Weekly,Monthly,Other,Quarterly,Yearly;
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Weekly)
    {
        Caption = 'Weekly';
    }
    value(2; Monthly)
    {
        Caption = 'Monthly';
    }
    value(3; Other)
    {
        Caption = 'Other';
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
