//SRBC-473 SY 17062026 Added value(9; "Payment For")
/// <summary>
/// Enum TransactionType (ID 50002).
/// </summary>
enum 90103 TransactionType
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Charge)
    {
        Caption = 'Charge';
    }
    value(2; Payment)
    {
        Caption = 'Payment';
    }
    value(3; Discount)
    {
        Caption = 'Discount';
    }
    value(4; "Returned Payment")
    {
        Caption = 'Returned Payment';
    }
    value(5; "Returned Fee")
    {
        Caption = 'Returned Fee';
    }
    value(6; "Credit Memo")
    {
        Caption = 'Credit Memo';
    }
    value(7; Adjustment)
    {
        Caption = 'Adjustment';
    }
    value(8; Refund)
    {
        Caption = 'Refund';
    }
    //SRBC-473 Start
    value(9; "Payment For")
    {
        Caption = 'Payment For';
    }
    //SRBC-473 En
}
