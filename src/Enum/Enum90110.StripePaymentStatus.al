//SRBC-483 - SY - 08042026 Added Value dispute_lost for stripe payment
enum 90110 "Stripe Payment-Status"
{
    Extensible = true;

    value(0; " ") { }
    value(1; succeeded) { }
    value(2; pending) { }
    value(3; failed) { }
    value(4; dispute_lost) { }//SRBC-483
}