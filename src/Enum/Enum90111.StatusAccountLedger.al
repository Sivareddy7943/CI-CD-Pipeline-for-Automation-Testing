//SRBC-346 - SY - 2304225 - Created enum
//SRBC-483 - SY - 08042026 Added Value dispute_lost for stripe payment
enum 90111 StatusAccountLedger
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Initiated)
    {
        Caption = 'Initiated';
    }
    value(2; Processing)
    {
        Caption = 'Processing';
    }
    value(3; Processed)
    {
        Caption = 'Processed';
    }
    value(4; Failed)
    {
        Caption = 'Failed';
    }
    value(5; dispute_lost) { Caption = 'dispute_lost'; }//SRBC-483
}
