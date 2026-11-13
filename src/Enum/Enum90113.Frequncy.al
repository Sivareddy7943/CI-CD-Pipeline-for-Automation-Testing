//SRBC-352 - AM - 12032025 Created the eunum becuase we want one more value i.e. blank
enum 90113 "Frequency"
{
    Extensible = true;

    value(0; " ")
    {
    }
    value(1; Once)
    {
        Caption = 'Once';
    }
    value(2; Daily)
    {
        Caption = 'Daily';
    }
    value(3; Weekly)
    {
        Caption = 'Weekly';
    }
    value(4; Monthly)
    {
        Caption = 'Monthly';
    }
    value(5; Quarterly)
    {
        Caption = 'Quarterly';
    }
    value(6; Yearly)
    {
        Caption = 'Yearly';
    }
}