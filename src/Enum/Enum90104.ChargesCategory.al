// SR..BKP -- 12/01/2024 NS

/// <summary>
/// Enum Charges Category (ID 50005).
/// </summary>
enum 90104 "Charges Category"
{
    Extensible = true;
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Bank)
    {
        Caption = 'Bank';
    }
    value(2; AR)
    {
        Caption = 'AR';
    }
    value(3; "Security Deposit")
    {
        Caption = 'Security Deposit';
    }
    value(4; Refunds)
    {
        Caption = 'Refunds';
    }
    value(5; Charge)
    {
        Caption = 'Charge';
    }
    value(6; Discount)
    {
        Caption = 'Discount';
    }
    value(7; "Repair Charge")
    {
        Caption = 'Repair Charge';
    }
    value(8; "Reset Charge")
    {
        Caption = 'Reset Charge';
    }
}
