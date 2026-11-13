/// <summary>
/// Enum Payment Type (ID 50003).
/// </summary>
//SRBC-390 - AA - 18072025 - Added new enum value "Submission Pending" to Payment Type for CLE
enum 90109 "Payment Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Paid)
    {
        Caption = 'Paid';
    }
    value(2; Unpaid)
    {
        Caption = 'Unpaid';
    }
    value(3; "Returned/Unpaid")
    {
        Caption = 'Returned/Unpaid';
    }
    value(4; "Returned Payment")
    {
        Caption = 'Returned Payment';
    }
    value(5; "Unpaid(Returned)")
    {
        Caption = 'Unpaid(Returned)';
    }
    //SR..BKP -- 09/01/2024
    value(6; "Partial Payment")
    {
        Caption = 'Partial Payment';
    }
    value(7; Returned)
    {
        Caption = 'Returned';
    }
    value(8; Adjustment)
    {
        Caption = 'Adjustment';
    }
    value(9; Deposited)
    {
        Caption = 'Deposited';
    }
    value(10; Undeposited)
    {
        Caption = 'Undeposited';
    }
    value(11; "Pending Settlement")
    {
        Caption = 'Pending Settlement';
    }
    value(12; Settled)
    {
        Caption = 'Settled';
    }
    //SRBC-390 -Start
    value(13; "Submission Pending")
    {
        Caption = 'Submission Pending';
    }
    //SRBC-390 -End
}
