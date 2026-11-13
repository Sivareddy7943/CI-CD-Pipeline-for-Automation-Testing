//SRBC-505 SY 05082026 Cretaed this codeunit for cretae customer bank account & update stripe details on Banking Account Info
codeunit 90106 "Banking Account Info Sync"
{
    TableNo = 90106;
    trigger OnRun()
    begin
        SyncBankingAccountInfoFromCustomerBankAccount(Rec);
    end;

    procedure SyncBankingAccountInfoFromCustomerBankAccount(Rec: Record "Banking Account Info")
    var
        // JQMgmnt: Codeunit "Job Queue Events"; //PS_16102026
        BankingAccInfo: Record "Banking Account Info";
        CustBankAcc: Record "Customer Bank Account";
        EpayManagement: Codeunit "Epayment Management";
        CustBankAccPar: Code[20];
        Agreement_lRec: Record Agreements;
    begin
        if NOT Rec.sr_OneTimePayment then begin
            EpayManagement.InsertCustBankAccount(CustBankAccPar, Rec."BC Customer Code", Agreement_lRec."Agreement ID", Rec);
            Rec.Validate("BC Cust. Bank Account", CustBankAccPar);
            CustBankAcc.Reset();
            CustBankAcc.SetRange(Code, Rec."BC Cust. Bank Account");
            CustBankAcc.SetRange("Bank Account Info", Rec.sr_bankingaccountinfoId);
            CustBankAcc.SetRange("License ID", Rec.sr_licenseeid);
            if CustBankAcc.FindFirst() then begin
                Rec.Validate(sr_StripePaymentMethodId, CustBankAcc."Payment Method ID2");
                Rec.Validate(sr_StripeCustomerId, CustBankAcc."Stripe Customer ID2");
                Rec.Validate(sr_StripeSetupIntentId, CustBankAcc."Setup Intent ID2");
                Rec.Validate(sr_StripeSecret, CustBankAcc."Card URL2");
                Rec.Validate(IsStripeVerified, true);
                Rec.Validate("Setup Intent Status", CustBankAcc."Setup Intent Status");
                Rec.Validate("Stripe Mandate Status", CustBankAcc."Mandate Status");
                Rec.Validate("Stripe Mandate Id", CustBankAcc."Stripe Mandate ID");
                Rec.Validate("Stripe Finger Print ID", CustBankAcc."Stripe Finger Print ID");
            end;
        end;
        Rec.Validate(sr_SyncedToBC, true);
        Rec.Modify();
    end;
}