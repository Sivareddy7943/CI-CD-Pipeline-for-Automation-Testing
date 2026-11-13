//SRBC-346 - SY - 05052025 Created Enum for customer ledger entry field - Processing Status
//SRBC-346 - AM - 04072025 Added three new values "BC Payment","Check Refund In Progress" and "Payment Deposit In Progress"
//SRBC-483 - SY - 08042026 Added Value dispute_lost for stripe payment
enum 90112 ProcessingStatus
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Sent From CRM To BC")
    {
        Caption = 'Sent From CRM To BC';
    }
    value(2; "Payment In Progress At Stripe")
    {
        Caption = 'Payment In Progress At Stripe';
    }
    value(3; Processed)
    {
        Caption = 'Processed';
    }
    value(4; Failed)
    {
        Caption = 'Failed';
    }
    //SRBC-346 - AM - Start
    value(5; "BC Payment")
    {
        Caption = 'BC Payment';
    }
    value(6; "Check Refund In Progress")
    {
        Caption = 'Check Refund In Progress';
    }
    //SRBC-346 - AM - End
    //SRBC -346 - AA Start
    value(7; "Payment Deposit In Progress")
    {
        Caption = 'Payment Deposit In Progress';
    }
    //SRBC -346 - AA End;
    value(8; dispute_lost) { Caption = 'dispute_lost'; }//SRBC-483
}