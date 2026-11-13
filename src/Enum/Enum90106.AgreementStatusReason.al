//SRBC-375 - SY - 22062025 - Added more options - "Notice–StudioTransfer", "Terminated-ResetPending"
//SRBC-429 - AM - 17092025 - Added more values - , "AgreementCompleted–FutureCommencement", "Terminated–StudioTransfer", "Terminated–PaymentPlan", "Terminated–NotApproved", Abandoned
//                           and added space in each values
enum 90106 AgreementStatusReason
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Draft)
    {
        Caption = 'Draft';
    }
    value(2; Active)
    {
        Caption = 'Active';
    }
    value(3; Terminated)
    {
        Caption = 'Terminated';
    }
    value(4; "Notice Received-60 Days Notice(by Licensee)")
    {
        Caption = 'Notice Received-60 Days Notice(by Licensee)';
    }
    value(5; "Notice Received-Break Of Agreement(by Licensee)")
    {
        Caption = 'Notice Received-Break Of Agreement(by Licensee)';
    }
    value(6; "Notice Served-Non-Renewal(60 Days)")
    {
        Caption = 'Notice Served-Non-Renewal(60 Days)';
    }
    value(7; Evicted)
    {
        Caption = 'Evicted';
    }
    value(8; "Terminated-Eviction")
    {
        Caption = 'Terminated-Eviction';
    }
    value(9; "Delinquency Notice Served-3 Day Notice To Pay Rent Or Quit")
    {
        Caption = 'Delinquency Notice Served-3 Day Notice To Pay Rent Or Quit';
    }
    value(10; "Delinquency Notice Served-48 Hour Notice To Remit Payment")
    {
        Caption = 'Delinquency Notice Served-48 Hour Notice To Remit Payment';
    }
    value(11; "Eviction Notice Served-Final Notice Of Eviction")
    {
        Caption = 'Eviction Notice Served-Final Notice Of Eviction';
    }
    value(12; "Terminated-Withdrew")
    {
        Caption = 'Terminated-Withdrew';
    }
    //SRBC-375 Start
    value(13; "Notice-Studio Transfer")
    {
        Caption = 'Notice-Studio Transfer';
    }
    value(14; "Terminated-Reset Pending")
    {
        Caption = 'Terminated-Reset Pending';
    }
    value(15; Inactive)
    {
        Caption = 'Inactive';
    }
    //SRBC-375 End
    //SRBC-429 Start
    value(16; "Agreement Completed-Future Commencement")
    {
        Caption = 'Agreement Completed-Future Commencement';
    }
    value(17; "Terminated-StudioTransfer")
    {
        Caption = 'Terminated-Studio Transfer';
    }
    value(18; "Terminated-PaymentPlan")
    {
        Caption = 'Terminated-Payment Plan';
    }
    value(19; "Terminated-NotApproved")
    {
        Caption = 'Terminated-Not Approved';
    }
    value(20; "Abandoned")
    {
        Caption = 'Abandoned';
    }
    //SRBC-429 End
}
