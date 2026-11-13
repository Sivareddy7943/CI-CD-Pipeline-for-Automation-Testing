//SRBC-409 -20250825 - NU - Created a new Enum.
enum 90105 PaymentPlanType
{
    Extensible = true;
    value(0; " ") { }
    value(1; PhysicalPayment)
    {
        Caption = 'PhysicalPayment';
    }
    value(2; "E-Payment")
    {
        Caption = 'E-Payment';
    }
}
