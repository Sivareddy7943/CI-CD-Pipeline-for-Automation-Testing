//SRBC-182 - 20241210 - SP - Refund Process change in BC - CRM
//SRBC-280 - 28012024 - SY - related to fail safe batch process
//SRBC-326 - 29032025 - SY - Created procedure -OnAfterInsertOfAgreementSchedule, CheckIsOfAgreementSchedule for OnAfterInsertEvent of Agreement Schedule
//SRBC-325 - 29032025 - SY - Created procedure -OnAfterInsertOfACHPaymentList, CheckOnAfterInsertOfACHPaymentList for skip OnAfterModifyEvent of ACH Payment List insert time
//SRBC-301 - 11042025 - SY - Created procedure - SkipCLEPostingDate, CheckCLEPostingDate for skip validation of posting date
//SRBC-342 - 23042025 - SY - Created procedure - SkipMessageGeneralPost, CheckSkipMessageGenJnl for skip message of reversal entry from Stripe Payment Request List.
//SRBC-362 - 12052025 - SY - Created procedure - ReturnMsg for return value of procedure - ApplyEntryForNewPayment of codeunit - API Management(50012).
//SRBC-378 - 14082025 - SY - Created procedure - ReversalCLENo, ReversalEntryNo for save CLE Entry No
//SRBC-394 - 21082025 - SY - Created procedure - SkipRunningBalanceCalculation, CheckSkipRunningBalanceCalculation
//SRBC-438 - 27102025 - AM - Created procedure - CheckSkipExternalDocNo and SkipExternalDocNo and CheckVendorCreatedMsg,SkipVendorCreatedMsg
//SRBC-422 - 26022026 - SY - Created procedure - SkipReconcileBankAccLedgEntry, CheckSkipReconcileBankAccLedgEntry 
//SRBC-480 - 31032026 - SY - Created procedure - UpdateOriginalOrReversalCLE, CheckUpdateOriginalOrReversalCLE 
//SRBC-483 - 10042026 - SY - Commented procedures - SkipReconcileBankAccLedgEntry and CheckSkipReconcileBankAccLedgEntry
//SRBC-483 - 28042026 - SY - Created procedure - ApplyRefundOnPayment, CheckApplyRefundOnPayment for update refund on payment entry
codeunit 90105 "Single Instance Mgt."
{
    SingleInstance = true;

    procedure MultipleUnApply(Bln: Boolean)
    begin
        ValidationActivate := Bln;
    end;

    procedure IsMultipleUnApplyValidation(): Boolean
    begin
        exit(ValidationActivate);
    end;

    procedure StoreAppliedEntryNo(DtdCustLedEntryNo: Integer)
    begin
        AppliedDtdCustLedEntryNo := DtdCustLedEntryNo;
    end;

    procedure FetchAppliedEntryNo(): Integer
    begin
        exit(AppliedDtdCustLedEntryNo);
    end;

    procedure ClearAppliedEntryNo()
    begin
        Clear(AppliedDtdCustLedEntryNo);
    end;

    //SRBC-280 Start
    procedure IsPreview(Bln: Boolean): Boolean
    begin
        Result := Bln;
        // exit(Bln);
    end;

    procedure IsPreviewCheck(): Boolean
    begin
        exit(Result);
    end;
    //SRBC-280 End

    //SRBC-326 - 29032025 Start
    procedure OnAfterInsertOfAgreementSchedule(IsHandle: Boolean)
    begin
        IsHandled_bool := false;
        IsHandled_bool := IsHandle;
    end;

    procedure CheckIsInsertOfAgreementSchedule(): Boolean
    begin
        exit(IsHandled_bool)
    end;
    //SRBC-326 - 29032025 End

    //SRBC-325 - 29032025 Start
    procedure OnAfterInsertOfACHPaymentList(IsHandled: Boolean)
    begin
        IsHandled_ACHPaymentList := false;
        IsHandled_ACHPaymentList := IsHandled;
    end;

    procedure CheckOnAfterInsertOfACHPaymentList(): Boolean
    begin
        exit(IsHandled_ACHPaymentList)
    end;
    //SRBC-325 - 29032025 End

    //SRBC-301 Start
    procedure SkipCLEPostingDate(IsHandled_SkipPostingDate: Boolean)
    begin
        SkipPostingDate_IsHandled := IsHandled_SkipPostingDate;
    end;

    procedure CheckCLEPostingDate(): Boolean
    begin
        exit(SkipPostingDate_IsHandled);
    end;
    //SRBC-301 End

    //SRBC-342 Start
    procedure SkipMessageGeneralPost(IsHandled_SkipMessage: Boolean)
    begin
        SkipMessage_IsHandled := IsHandled_SkipMessage;
    end;

    procedure CheckSkipMessageGenJnl(): Boolean
    begin
        exit(SkipMessage_IsHandled);
    end;
    //SRBC-342 End

    //SRBC-362 Start
    procedure ReturnMsg(InvoiceTxt: Text; PaymentTxt: Text) ReturnMessage: Text
    begin
        if InvoiceTxt <> '' then begin
            JsonObject.Remove('Sales Journal (Conveniencee Fee)');
            JsonObject.Add('Sales Journal (Conveniencee Fee)', InvoiceTxt);
        end;
        if PaymentTxt <> '' then begin
            JsonObject.Remove('Cash Receipt Journal (Payment))');
            JsonObject.Add('Cash Receipt Journal (Payment))', PaymentTxt);
        end;
        JsonObject.WriteTo(ReturnMessage);
    end;
    //SRBC-362 End
    //SRBC-378 Start
    procedure ReversalCLENo(CustLedgerEntryNo: Integer)
    begin
        CLENo := CustLedgerEntryNo;
    end;

    procedure ReversalEntryNo(): Integer
    begin
        exit(CLENo);
    end;
    //SRBC-378 End

    //SRBC-394 Start
    procedure SkipRunningBalanceCalculation(IsHandled: Boolean)
    begin
        SkipRunningBalance_Calculation := IsHandled;
    end;

    procedure CheckSkipRunningBalanceCalculation(): Boolean
    begin
        exit(SkipRunningBalance_Calculation);
    end;
    //SRBC-394 End
    //SRBC-438 Start
    procedure SkipExternalDocNo(IsHandled: Boolean)
    begin
        SkipExtDocNo := IsHandled;
    end;

    procedure CheckSkipExternalDocNo(): Boolean
    begin
        exit(SkipExtDocNo);
    end;

    procedure SkipVendorCreatedMsg(IsHandled: Boolean)
    begin
        VendorCreated := IsHandled;
    end;

    procedure CheckVendorCreatedMsg(): Boolean
    begin
        exit(VendorCreated);
    end;
    //SRBC-438 End
    //SRBC-422 Start//SRBC-483 Start 
    // procedure SkipReconcileBankAccLedgEntry(ReconcileEntry: Boolean)
    // begin
    //     ReconcileBankAccLedgEntry := ReconcileEntry;
    // end;
    // procedure CheckSkipReconcileBankAccLedgEntry(): Boolean
    // begin
    //     exit(ReconcileBankAccLedgEntry);
    // end;
    //SRBC-422 End
    procedure SetRefundGenCreationforDisputeLost(RefundCreation: Boolean)
    begin
        DisputeLostRefundCreation := RefundCreation;
    end;

    procedure CheckRefundGenCreationforDisputeLost(): Boolean
    begin
        exit(DisputeLostRefundCreation);
    end;
    //SRBC-483 End

    //SRBC-480 Start  
    procedure UpdateOriginalOrReversalCLE(UpdateCLE: Boolean)
    begin
        ModifyCLE := UpdateCLE;
    end;

    procedure CheckUpdateOriginalOrReversalCLE(): Boolean
    begin
        exit(ModifyCLE);
    end;
    //SRBC-480 End

    //SRBC-483 28042026 Start
    procedure ApplyRefundOnPayment(IsHandle: Boolean)
    begin
        CheckRefundJnl := IsHandle;
    end;

    procedure CheckApplyRefundOnPayment(): Boolean
    begin
        exit(CheckRefundJnl);
    end;
    //SRBC-483 28042026 End
    var
        AppliedDtdCustLedEntryNo: Integer;
        ValidationActivate: Boolean;
        Result: Boolean;
        GenJnlPost_bln: Boolean;
        IsHandled_bool: Boolean;//SRBC-326 - 29032025 Start
        IsHandled_ACHPaymentList: Boolean;//SRBC-325 - 29032025
        SkipPostingDate_IsHandled: Boolean;//SRBC-301
        SkipMessage_IsHandled: Boolean;//SRBC-342
        JsonObject: JsonObject;//SRBC-362
        CLENo: Integer;//SRBC-378
        SkipRunningBalance_Calculation: Boolean; //SRBC-394
        SkipExtDocNo: Boolean;//SRBC-438
        VendorCreated: Boolean;//SRBC-438
        //ReconcileBankAccLedgEntry: Boolean; //SRBC-422
        ModifyCLE: Boolean;//SRBC-480
        DisputeLostRefundCreation: Boolean; //SRBC-483
        CheckRefundJnl: Boolean;//SRBC-483 28042026
}