//SRBC-223 - 20241205 - NU - Ledger Balance not updating
//                         - Added Flow Field 50005 to 50010
//SRBC-352 - 11062025 - SY - Created field - "Late Fee"(50011)
//SRBC-416 - 28082025 - AM - Added a new filter "Reversed=filter(false)" on fields sr_securitydepositamount,sr_petdepositamount,sr_stylingchairdepositamount,sr_constrmoddepositamount,sr_paintwallpaperdepositamount
tableextension 90100 CustomerExt extends Customer
{
    fields
    {
        field(50000; "CRM Contact ID"; Text[100])
        {
            Caption = 'CRM Contact ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50001; "CRM Created"; Boolean)
        {
            Caption = 'CRM Created';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50002; "CRM Agreement ID"; Text[100])
        {
            Caption = 'CRM Agreement ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50003; "Current Rent Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Stripe Customer ID"; Text[100])
        {
            Caption = 'Stripe Customer ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Salon Balance"; Decimal)
        {
            Description = 'Salon Balance';
            Caption = 'Salon Balance';
            Editable = false;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                       "Posting Date" = field("Date Filter"), "Entry Type" = filter("Initial Entry")));
            FieldClass = FlowField;
        }
        field(50006; sr_securitydepositamount; Decimal)
        {

            Description = 'Security Deposit Amount';
            Caption = 'Security Deposit Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Customer No." = field("No."),
                                                                           "Charge/Payment Type" = filter('LICENSE FEE SECURITY DEPOSIT' | 'ADDITIONAL SECURITY DEPOSIT'),
                                                                           "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                           Reversed = filter(false)));//SRBC-416

        }
        field(50007; sr_petdepositamount; Decimal)
        {

            Description = 'Pet Deposit Amount';
            Caption = 'Pet Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Customer No." = field("No."),
                                                                           "Charge/Payment Type" = filter('PET DEPOSIT'),
                                                                           "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                           Reversed = filter(false)));//SRBC-416

            FieldClass = FlowField;
        }

        field(50008; sr_stylingchairdepositamount; Decimal)
        {

            Description = 'Styling Chair Deposit Amount';
            Caption = 'Styling Chair Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Customer No." = field("No."),
                                                                           "Charge/Payment Type" = filter('CHAIR DEPOSIT'),
                                                                           "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                           Reversed = filter(false)));//SRBC-416

            FieldClass = FlowField;
        }

        field(50009; sr_constrmoddepositamount; Decimal)
        {

            Description = 'Construction/Modification Deposit Amount';
            Caption = 'Construction/Modification Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Customer No." = field("No."),
                                                                      "Charge/Payment Type" = filter('STUDIO MODIFICATION DEPOSIT'),
                                                                      "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                      Reversed = filter(false)));//SRBC-416
            FieldClass = FlowField;
        }

        field(50010; sr_paintwallpaperdepositamount; Decimal)
        {
            Description = 'Paint/Wallpaper Deposit Amount';
            Caption = 'Paint/Wallpaper Deposit Amount';
            Editable = false;
            CalcFormula = sum("Cust. Ledger Entry"."Amount Deposited" where("Customer No." = field("No."),
                                                                           "Charge/Payment Type" = filter('PAINT DEPOSIT'),
                                                                           "Document Type" = filter('Credit Memo' | 'Invoice'),
                                                                           Reversed = filter(false)));//SRBC-416
            FieldClass = FlowField;
        }
        //SRBC-352 Start
        field(50011; "Late Fee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-352 End
    }
}
