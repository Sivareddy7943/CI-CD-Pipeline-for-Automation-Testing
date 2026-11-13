/// <summary> Comment
/// Codeunit Subscriber Codeunit (ID 50000).
/// </summary>
//SRBC-210 - Added New Field Sr_Description.
//         - Flow Sr_Description same as Standard Description field.
//SRBC-197 - Changes JIRA Tkt
//           -Changes being made related to Epay reverse functionality.
//SRBC-226 - Flow Recpt bank account and bank acc info
//         -1 Update Receipt Bank Account in CLE based on Bank Account info record cust. bank account field.
//         -2 Flow Bank acc info GUID in ApplyNewPayment API process.
//SRBC-185 - 20241114 - One Time Payment Method Changes - Portal.
//                    - Created a new function - UpdateReciepientBankAccDuplicatePortal
//                    - We need to flow this field with Cust. Bank acc code in case of creates from portal payments.
//SRBC-244 - 20241205 - NU - Salon Republic "partial payment" when fully paid.
//SRBC-255 - 20241219 - NU - Update Payment intent ID & Banking Account Info GUID in the Refund Customer Ledger entry when Refund Journal is created from the applied Payment.
//SRBC-279 - 20250131 - NU - Need Capabilities to Send Failure Email Notification
//SRBC-217 - 27122024 - SY - Check Epay Reverse Functionality.     
//SRBC-299 - 04032025 - SY - Did validation of GL Entry field "Source No." for get "Source Name" values on basis of "Source Type" 
//SRBC-322 - 12032025 - SY - Did modification on OnAfterModifyEvent of CLE for skip Code if field SkipEventTrigger
//SRBC-290 - 20250319 - NU - Real Time Data Sync For Ledger Transactions- API and Virtual Tables
//SRBC-325 - 22032025 - SY - Did some changes in event - OnAfterInsertEvent/OnAfterModifyEvent of Agreements for update ACH Payment List's fields Current Agreement Start/End Date.
//SRBC-326 - 24032025 - SY - Did changes in event - OnAfterInsertEvent/OnAfterModifyEvent of Agreements for updats Current Agreement Start/End Date of Agreement Schedule And did changes for create customer in BC on Based on field - "Create Customer from Agreement".    
//SRBC-330 - 04042025 - SY - Did change on event - OnAfterModifyEvent of Agreements.          
//SRBC-342 - 10042025 - SY - Did changes on event - OnBeforeModifyEvent of customer ledger entries for update "Payment Status".
//SRBC-346 - 23042025 - SY - Did changes on OnBeforeInsertEvent of Customer Ledger Entry for Update field Status as Initiated.
//SRBC-348 - 21042025 - SY - Did changes on event OnAfterModifyEvent of Agreements for update data in ACH Payment List after create Bank Account.
//SRBC-358 - 08052025 - AM - Did changes on event OnAfterCopyCustLedgerEntryFromGenJnlLine of Cust ledger entry to copy the "Move Out Terminate" boolean from GenJournalLine
//SRBC-353 - 27052025 - AG - Did changes in procedure - UpdateDimensionValuesonAgreement
//SRBC-368 - 03062025 - AM - Did changes in Event OnAfterCopyGLEntryFromGenJnlLine to update the three fields in G/L entry table
//SRBC-369 - 05062025 - AG - Did changes in Event  OnAfterCopyCustLedgerEntryFromGenJnlLine to update the Opening Balance field of CustLedgerEntry while posting GeneralJournal from Open Journal template 
//SRBC-374 - 16062025 - AG - Did changes on OnafterInsertEvent of Customer Ledger Entry for Update Payment Status as Pending Settlement.
//                           Commented Code written on OnBeforeModifyEvent of Customer Ledger Entry
//SRBC-346 - 04072025 - AM - Did changes in OnAfterInsert,OnBeforeInsert,OnBeforeModify and OnAfterModify event of Customer Ledger Entry to Update Paymnet status, Processing Status and Status fields
//                           Created a Procedure UpdateStatusField to update Paymnet status, Processing Status and Status fields fields for Invoice Entry 
//SRBC-346 - 09072025 - AM - Commented the code written on event  OnAfterInsertEvent of "Detailed Cust. Ledg. Entry" and OnAfterCopyCustLedgerEntryFromCVLedgEntryBuffer event of Cust Ledger entry
//SRBC-346 - 11072025 - AM - Added a filter of payment in onAfterInsertEvent of CLE and removed Doc type credit memo from OnBeforeCustLedgEntryModify event of "Gen. Jnl.-Post Line"
//SRBC-380 - 15072025 - SY - Did changes on event - OnAfterPostGenJournalLine, added one more filter field of Gen Journal Line - "Construction Agreement"
//SRBC-384 - 18072025 - AM - Did changes on event - OnAfterCopyCustLedgerEntryFromGenJnlLine to updated "Schedule Charges And Payment" and "Queue Table Entry No" in CLE from Gen Jnl Line
//SRBC-390 - 18072025 - AM - Did changes on event - OnBeforeInsertEvent to Update "Payment Status field" in CLE
//SRBC-387 - 30072025 - SY - Did changes on event - OnAfterInsertEvent, OnAfterModifyEvent of Agreements for update Agreement Schedule
//SRBC-393 - 06082025 - AM - Added a new event - OnBeforeApplyCustLedgEntry of "Gen. Jnl.-Post Line" CodeUnit to check the "Charge Payment Type" before applying open entries automatically
//                           Did changes in even - OnBeforeInsertEvent of CLE to keep payment status blank for Credit memo 
//SRBC-408 - 18082025 - SY - Added event OnAfterCopyCustLedgerEntryFromCVLedgEntryBuffer for update CLE's field Amount Paid.
//SRBC-416 - 28082025 - SY - Did changes on event - OnBeforeCustLedgEntryModify for update Amount Paid field for Unapply entry
//                    - SY - Added event - OnReverseCustLedgEntryOnBeforeModifyCustLedgerEntry for update Amount Paid field for reversal original entry 
//                    - SY - Added event - OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry for update Amount Paid field for reversal new entry
//SRBC-413 - 28082025 - SY - Did changes on event - OnAfterInsertEvent, OnAfterModifyEvent of Agreements
//SRBC-428 - SY - 19092025 - Did changes in procedure - MakeEpaymentScheduleInactive, EditDeletePaymentReverseCLETrans, AutoReverseCLETransactions for validate Transaction Type
//                         - Did changes on event - OnApplyCustLedgEntryByReversalOnAfterCustLedgEntryModify, OnAfterCopyCustLedgerEntryFromGenJnlLine, OnBeforeCustLedgEntryInsert for validate Transaction Type
//SRBC-438 - AM - 28102025 - Did changes on event OnAfterInsert of Cust ledger Entry and OnAfterPostGenJournalLine Event
//SRBC-470 - SY - 12012025 - Did changes on OnAfterInsertEvent & OnAfterModifyEvent of Agreements commented code
//SRBC-475 - NT - 22012026 - Did changes in SplitLicenseeJsonArray, SplitStudioJsonArray procedures and onbeforemodify event of Agreements table.
//SRBC-352 - AM - 14032026 - Did changes in the event OnAfterCopyCustLedgerEntryFromGenJnlLine to flow late fee frequency 
//SRBC-484 - SY - 18032026 - Did changes on event-OnBeforeCustLedgEntryModify for update "Amount Deposited"/"Amount Paid" field of CLE
//SRBC-455 - AM - 26032026 - Did changes on event OnBeforeInsertEvent to update payment status for refund case for Docusign
//SRBC-480 - SY - 31032026 - Did changes on event-OnReverseCustLedgEntryOnBeforeModifyCustLedgerEntry, OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry for update original or reversal CLE
//SRBC-480 - SY - 07042026 - Did changes on event-OnAfterInsertEvent commented code & called procedrue-UpdateCLEStatusfields, MarkPaymentAsDepositInProgress for update CLE
//SRBC-480 - SY - 07042026 - Did changes on event-OnBeforeInsertEvent commented code & called procedure-HandleCLEStatusOnBeforeInsert for update CLE
//SRBC-480 - SY - 07042026 - Did changes on event-OnBeforeModifyEvent commented code & called procedure-UpdateCLEStatusfields, HandleCLEStatusOnBeforeModify
//SRBC-480 - SY - 07042026 - Did changes on event-OnApplyCustLedgEntryByReversalOnAfterCustLedgEntryModify, before update CLE field-"Payment Status" it should check mandatory boolean fields
//SRBC-480 - AM - 09042026 - Did changes on event OnBeforeInsert ,OnBeforeModify Event of CLE
//         - AM - 13042026 - Did changes on the event OnBeforeCustLedgEntryInsert and OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry,OnApplyCustLedgEntryByReversalOnAfterCustLedgEntryModify of CLE to update Transaction type and Payment status
//SRBC-483 - AM - 22042026 - Did changes on the event OnAfterCopyCustLedgerEntryFromGenJnlLine,OnBeforeInsertEvent of CLE,OnAfterModifyEvent and OnBeforeInsertEvent of CLE
//SRBC-483 - SY - 28042026 - Did changes on event-OnBeforeModify/InsertEvent for updated reversed boolean
//SRBC-352 - AM - 28042026 - Create a new event OnBeforeInsertEvent for the Gen jnl line 
//SRBC-483 - SY - 29042026 - Did changes on event-OnBeforeInsertEvent for update "CRM Account Charge Type GUID" from "Auto Charge" table
//SRBC-352 - SY - 20052026 - Did changes on event-OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry for update frequency field of Reversed CLE
//SRBC-491 - SY - 24052026 - Did changes on event-OnApplyCustLedgEntryByReversalOnAfterCustLedgEntryModify for update field "CRM AccountLedger ID", IsBCGuid
//SRBC-494 - AM - 10062026 - Did chagnes in the event OnAfterCopyCustLedgerEntryFromGenJnlLine to update Agreement transfer boolean while agreement transfer process
codeunit 90102 "Subscriber Codeunit"
{
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line");
    var
        //SRBC-299 - Start
        Customer_lRec: Record Customer;
        Vendor_lRec: Record Vendor;
        BankAccuont_lRec: Record "Bank Account";
        FixedAsset_lRec: Record "Fixed Asset";
        Contact_lRec: Record Contact;//SRBC-368
    //SRBC-299 - End
    begin
        GLEntry."Charge/Payment Type" := GenJournalLine."Charge Payment Type";
        GLEntry.Sr_Description := GenJournalLine.Sr_Description;  //SRBC-210 JIRA
        //SRBC-299 Start
        Case GLEntry."Source Type" of
            GLEntry."Source Type"::Customer:
                if Customer_lRec.Get(GLEntry."Source No.") then
                    GLEntry.Validate("Source Name", Customer_lRec.Name);
            GLEntry."Source Type"::Vendor:
                if Vendor_lRec.Get(GLEntry."Source No.") then
                    GLEntry.Validate("Source Name", Vendor_lRec.Name);
            GLEntry."Source Type"::"Bank Account":
                if BankAccuont_lRec.get(GLEntry."Source No.") then
                    GLEntry.Validate("Source Name", BankAccuont_lRec.Name);
            GLEntry."Source Type"::"Fixed Asset":
                if FixedAsset_lRec.get(GLEntry."Source No.") then
                    GLEntry.Validate("Source Name", FixedAsset_lRec.Description);
        End;
        //SRBC-299 End
        //SRBC-368 Start
        if not IsNullGuid(GenJournalLine.License) then begin
            Contact_lRec.Reset();
            Contact_lRec.SetRange("CRM Contact ID", GenJournalLine.License);
            if Contact_lRec.FindFirst() then begin
                GLEntry.Validate("Customer ID", Contact_lRec."Stripe Customer ID");
                GLEntry.Validate("Customer Name", Contact_lRec.Name);
                GLEntry.Validate("Customer Email", Contact_lRec."E-Mail");
            end;
        end;
        //SRBC-368 End
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    var
        Autochargetype: Record "Auto Charge";
        GLAccount: Record "G/L Account";
        srsetup: Record "Salon Republic Setup";
    begin
        srsetup.Get();
        CustLedgerEntry."CRM AccountLedger ID" := GenJournalLine."Account Ledger GUID CRM";
        CustLedgerEntry."Charge/Payment Type" := GenJournalLine."Charge Payment Type";
        CustLedgerEntry.Validate(License, GenJournalLine.License);
        CustLedgerEntry."AutoCharge ID" := GenJournalLine."AutoCharge ID";
        CustLedgerEntry.Validate("Agreement ID", GenJournalLine."Agreement ID");
        CustLedgerEntry."Studio Transfer" := GenJournalLine."Studio Transfer";
        CustLedgerEntry."Epayment Schedule" := GenJournalLine."Epayment Schedule";
        CustLedgerEntry.FromPowerFlow := GenJournalLine.FromPowerFlow;
        CustLedgerEntry."Edit Charge" := GenJournalLine."Edit Charge";
        CustLedgerEntry."Edit Discount" := GenJournalLine."Edit Discount";
        CustLedgerEntry."Edit Payment" := GenJournalLine."Edit Payment";
        CustLedgerEntry."Delete Charge" := GenJournalLine."Delete Charge";
        CustLedgerEntry."Delete Discount" := GenJournalLine."Delete Discount";
        CustLedgerEntry."Delete Payment" := GenJournalLine."Delete Payment";
        CustLedgerEntry."Banking Account Info" := GenJournalLine."Banking Account Info";
        CustLedgerEntry."Return Fee Calculation" := GenJournalLine."Return Fee Calculation";
        CustLedgerEntry.Sr_Description := GenJournalLine.Sr_Description; //SRBC-210 JIRA
        CustLedgerEntry.Validate("Payment Intent ID", GenJournalLine."Payment Intent ID"); //SRBC-255
        CustLedgerEntry.Validate(MoveOutTerminate, GenJournalLine.MoveOutTerminate); //SRBC-358
        CustLedgerEntry.Validate("Schedule Charges And Payment", GenJournalLine."Schedule Charges And Payment"); //SRBC-384
        CustLedgerEntry.Validate("Queue Table Entry No.", GenJournalLine."Queue Table Entry No."); //SRBC-384
        CustLedgerEntry.Validate("Frequency", GenJournalLine."Frequency"); //SRBC-352
        CustLedgerEntry.Validate("Agreement Transfer", GenJournalLine."Agreement Transfer"); //SRBC-494
        if CustLedgerEntry."Charge/Payment Type" = srsetup."LICENSE FEE SECURITY" then
            CustLedgerEntry."Security Deposit" := true;

        Autochargetype.Reset();
        Autochargetype.SetRange(Code, CustLedgerEntry."Charge/Payment Type");
        if Autochargetype.FindFirst() then begin
            CustLedgerEntry.Validate("CRM Account Charge Type GUID", Autochargetype.sr_autochargetypeId);
            if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo" then begin
                if Autochargetype."Charge Category" = Autochargetype."Charge Category"::Discount then
                    CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::Discount)//SRBC-428
                else
                    CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::"Credit Memo");//SRBC-428
            end;
        end;
        if CustLedgerEntry."Bal. Account Type" = CustLedgerEntry."Bal. Account Type"::"G/L Account" then begin
            GLAccount.Reset();
            if GLAccount.Get(CustLedgerEntry."Bal. Account No.") then
                CustLedgerEntry."Account Name" := GLAccount."No." + '-' + GLAccount.Name;
        end;
        //SRBC-226
        if (CustLedgerEntry."Charge/Payment Type" = 'E-PAYMENT') AND (CustLedgerEntry."Payment Method Code" = 'E-PAYMENT') then begin
            //Uncomment in PROD
            // BankAccInfo_lRec.Reset();
            // if BankAccInfo_lRec.Get(CustLedgerEntry."Banking Account Info") then begin
            //     if BankAccInfo_lRec."BC Cust. Bank Account" <> '' then
            //         if Format(BankAccInfo_lRec.sr_agreement) <> '' then  //27 NOV
            //             CustLedgerEntry.Validate("Recipient Bank Account", BankAccInfo_lRec."BC Cust. Bank Account");
            // end;
            //Uncomment in PROD
            CustLedgerEntry.Validate("Epayment Schedule", true);
            UpdateReciepientBankAccDuplicatePortal(CustLedgerEntry); //SRBC-185
        end;
        //SRBC-226
        //SRBC-369 Start
        if GenJournalLine."Journal Template Name" = 'OPENING' then
            CustLedgerEntry.Validate("Opening Balance", true);
        //SRBC-369 End
        //SRBC-483 Start
        if ((GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund) or (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice)) and (GenJournalLine."Dispute Lost Payment Entry No." <> 0) then
            CustLedgerEntry.Validate("Dispute Lost Payment Entry No.", GenJournalLine."Dispute Lost Payment Entry No.");
        //SRBC-483 End
    end;

    // Start -->PS_16102026 this event is not used any where.

    // //automate job queue
    // [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterInsertEvent, '', false, false)]
    // local procedure T21_OnAfterInsertEvent(var Rec: Record "Cust. Ledger Entry");
    // var
    //     JobQueueEntry: Record "Job Queue Entry";
    //     // AccountLedger: Record "Account Ledger"; //PS_16102026
    //     InsertCheckNSF: Codeunit "Check NSF & Epay Reverse";
    //     MODAgreements: Record Agreements;
    //     CLE_lRec: Record "Cust. Ledger Entry";
    //     JQMgmnt: Codeunit "Job Queue Events";
    //     UpdateCLE: Record "Cust. Ledger Entry"; //SRBC-346 - AM 
    // begin
    //     if Rec.IsTemporary then
    //         exit;
    //     UpdateStatusField(Rec);//SRBC-346 - AM//SRBC-480

    //     //SRBC-346 - AM - Start 04072025 Commneted this and added in onbefore insert
    //     // //SRBC-374 - start
    //     // if (Rec."Document Type" = Rec."Document Type"::Refund) and (Rec."Payment Method Code" = 'CHECK') and (Rec."Charge/Payment Type" = 'CHECK') and (Rec."Payment Status" <> Rec."Payment Status"::"Pending Settlement") then
    //     //     Rec."Payment Status" := Rec."Payment Status"::"Pending Settlement";
    //     // //SRBC-374 - End
    //     //SRBC-346 - AM - End

    //     // Rec.Modify();//SRBC-408
    //     if (Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::failed) then begin
    //         if (Rec."Epay reversed" = false) then begin
    //             //SRBC-217 Start
    //             if not Rec."Failed Stripe Invoice" then begin
    //                 InsertCheckNSF.AutoCreateReverseEntryInCLEByCheckNSG(Rec);
    //                 //SRBC-279 Start
    //                 if CLE_lRec.Get(Rec."Entry No.") then begin
    //                     if CLE_lRec."Failed Stripe Invoice" then begin
    //                         InsertCheckNSF.ReverseCustomerLedEntryByEpayReverse(CLE_lRec);
    //                         InsertCheckNSF.UpdateCustLedEntORCreateGenJnlLineByEapyReverse(CLE_lRec);
    //                     end;
    //                 end;
    //                 //SRBC-279 End
    //             end;
    //             //SRBC-217 End
    //         end;
    //     end;
    //     //SRBC-480  - AM - Start 0904206
    //     CustLedgStatusHandler_gCU.MarkPaymentAsDepositInProgress(Rec);
    //     //SRBC-346 - AM - Start 08072025
    //     // UpdateCLE.Reset();
    //     // UpdateCLE.SetRange("Entry No.", Rec."Entry No.");
    //     // UpdateCLE.SetRange("Document Type", UpdateCLE."Document Type"::Payment); //SRBC-346 11072025
    //     // UpdateCLE.SetFilter("Charge/Payment Type", '%1|%2|%3', 'CHECK', 'CASHIERS C', 'MONEY ORDE');
    //     // UpdateCLE.SetFilter("Payment Method Code", '%1|%2|%3', 'CHECK', 'CASHIERS C', 'MONEY ORDE');
    //     // UpdateCLE.SetRange(sr_Deposited, false);
    //     // UpdateCLE.SetRange("Check NSF", false);
    //     // UpdateCLE.SetRange(Reversed, false);
    //     // if UpdateCLE.FindFirst() then begin
    //     //     Rec.Validate("Processing Status", Rec."Processing Status"::"Payment Deposit In Progress");
    //     //     Rec.Validate(Status, Rec.Status::Initiated);
    //     //     Rec.Validate("Payment Status", Rec."Payment Status"::Undeposited);
    //     //     // Rec.Modify();//SRBC-408
    //     // end;
    //     //SRBC-480  - AM - End  0904206
    //     Rec.Modify();//SRBC-408
    //     //SRBC-346 - AM - END
    //     // JQMgmnt.RestartCLEJobQueue; //NU
    // end;
    // <-- End

    //SRBC-290 - START
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnBeforeInsertEvent, '', false, false)]
    local procedure T21_OnBeforeInsertEvent(var Rec: Record "Cust. Ledger Entry")
    var
        DimensionValue: Record "Dimension Value";//SRBC-428
        PaymentCLE: Record "Cust. Ledger Entry";//SRBC-483
        Autochargetype: Record "Auto Charge";//SRBC-483
    begin
        if Rec.IsTemporary then
            exit;
        if IsNullGuid(Rec."CRM AccountLedger ID") then begin
            Rec.validate("CRM AccountLedger ID", Rec.SystemId);
            Rec.Validate(IsBCGuid, true);
        end;
        //SRBC-480 AM 09042026 Start
        // CustLedgStatusHandler_gCU.HandleCLEStatusOnBeforeInsert(Rec); //PS_16102026 not used any where
        // //SRBC-346 - Start
        // if (Rec."Recipient Bank Account" <> '') or (Rec."Recipient Bank Account Portal" <> '') then begin
        //     if (Rec."Document Type" = Rec."Document Type"::Payment) and (Rec."Payment Method Code" = 'E-PAYMENT') and
        //     (not Rec.Reversed) and (Rec."Charge/Payment Type" = 'E-PAYMENT') and (not Rec."Stripe Invoice Created") and
        //     (Rec."Epayment Schedule") and not IsNullGuid(Rec."Banking Account Info") then begin//05052025
        //         Rec.Validate(Status, Rec.Status::Initiated);
        //         Rec.Validate("Processing Status", Rec."Processing Status"::"Sent From CRM To BC");//05052025
        //     end;//05052025
        // end;
        // //SRBC-346 - AM - Start 08072025
        // // if (Rec."Payment Method Code" <> 'E-PAYMENT') and (Rec."Charge/Payment Type" <> 'E-PAYMENT') then begin//05052025
        // //     Rec.Validate(Status, Rec.Status::Processed);//05052025
        // //     Rec.Validate("Processing Status", Rec."Processing Status"::Processed);//05052025
        // // end;//05052025
        // //SRBC-346 - AM - End
        // //SRBC-346 - End

        // //SRBC-346 - AM - Start
        // if (Rec."Document Type" = Rec."Document Type"::Refund) and (Rec."Charge/Payment Type" = 'CHECK') and (Rec."Payment Method Code" = 'CHECK') then begin
        //     Rec.Validate("Payment Status", Rec."Payment Status"::"Pending Settlement");
        //     Rec.Validate("Processing Status", Rec."Processing Status"::"Check Refund In Progress");
        //     Rec.Validate(Status, Rec.Status::Initiated);
        // end;
        // if (Rec."Document Type" = Rec."Document Type"::Refund) and (Rec."Payment Method Code" = 'E-PAYMENT') and (Rec."Charge/Payment Type" = 'E-PAYMENT') then begin
        //     // Rec.Validate("Payment Status", Rec."Payment Status"::" "); //SRBC-390
        //     Rec.Validate("Payment Status", Rec."Payment Status"::"Submission Pending"); //SRBC-390
        //     Rec.Validate(Status, Rec.Status::Initiated);
        //     Rec.Validate("Processing Status", Rec."Processing Status"::"Sent From CRM To BC");
        // end;
        // if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then begin
        //     Rec.Validate("Payment Status", Rec."Payment Status"::Settled);
        //     Rec.Validate("Processing Status", Rec."Processing Status"::Processed);
        //     Rec.Validate(Status, Rec.Status::Processed);
        // end;
        // //SRBC-455 - 26032026 Start
        // if (Rec."Document Type" = Rec."Document Type"::Refund) and (Rec."Charge/Payment Type" = 'DOCUSIGN CREDIT/DEBIT') and (Rec."Payment Method Code" = 'DOCUSIGN') then
        //     Rec.Validate("Payment Status", Rec."Payment Status"::"Pending Settlement");
        // //SRBC-455 - 26032026  End
        // //SRBC-346 - AM - End

        // //SRBC-346 - AA - Start
        // if (Rec."Document Type" = Rec."Document Type"::Payment) and (Rec."Charge/Payment Type" = 'E-PAYMENT') and (Rec."Payment Method Code" = 'E-PAYMENT') then begin
        //     if not Rec.IsBCGuid then
        //         Rec.Validate("Processing Status", Rec."Processing Status"::"Sent From CRM To BC")
        //     else
        //         Rec.Validate("Processing Status", Rec."Processing Status"::"BC Payment");
        //     // if (not Rec."Edit Charge") and (not Rec."Edit Payment") and (not Rec."Edit Discount") and (not Rec."Delete Charge") and (not Rec."Delete Payment") and (not Rec."Delete Discount") then//SRBC-480
        //     // if (not Rec."Edit Charge") and (not Rec."Edit Payment") and (not Rec."Edit Discount") and (not Rec."Delete Charge") and (not Rec."Delete Payment") and (not Rec."Delete Discount") then//SRBC-480
        //     Rec.Validate(Status, Rec.Status::Initiated);
        //     // Rec.Validate("Payment Status", Rec."Payment Status"::" "); //SRBC-390
        //     // if (not Rec."Edit Charge") and (not Rec."Edit Payment") and (not Rec."Edit Discount") and (not Rec."Delete Charge") and (not Rec."Delete Payment") and (not Rec."Delete Discount") then//SRBC-480
        //     Rec.Validate("Payment Status", Rec."Payment Status"::"Submission Pending"); //SRBC-390
        // end;

        // //SRBC-346 - AM - Start 08072025
        // // UpdateCLE.Reset();
        // // UpdateCLE.SetRange("Entry No.", Rec."Entry No.");
        // // UpdateCLE.SetFilter("Charge/Payment Type", '%1|%2|%3', 'CHECK', 'CASHIERS C', 'MONEY ORDE');
        // // UpdateCLE.SetFilter("Payment Method Code", '%1|%2|%3', 'CHECK', 'CASHIERS C', 'MONEY ORDE');
        // // UpdateCLE.SetRange(sr_Deposited, false);
        // // UpdateCLE.SetRange("Check NSF", false);
        // // UpdateCLE.SetRange(Reversed, false);
        // // if UpdateCLE.FindFirst() then begin
        // //     Rec.Validate("Processing Status", Rec."Processing Status"::"Payment Deposit In Progress");
        // //     Rec.Validate(Status, Rec.Status::Initiated);
        // //     Rec.Validate("Payment Status", Rec."Payment Status"::Undeposited);
        // // end;
        // //SRBC-346 - AM - END
        // if (Rec."Document Type" = Rec."Document Type"::Payment) and (Rec."Charge/Payment Type" = 'DOCUSIGN CREDIT/DEBIT') and (Rec."Payment Method Code" = 'DOCUSIGN') then begin
        //     Rec.Validate("Payment Status", Rec."Payment Status"::Settled);
        //     Rec.Validate("Processing Status", Rec."Processing Status"::Processed);
        //     Rec.Validate(Status, Rec.Status::Processed);
        // end;
        //SRBC-346 - AA - End
        //SRBC-480 AM 09042026 End
        //SRBC-428 Start
        DimensionValue.Reset();
        DimensionValue.SetRange(Code, Rec."Global Dimension 1 Code");
        if DimensionValue.FindFirst() then
            Rec.Validate("Loc Description", DimensionValue.Name);
        DimensionValue.Reset();
        DimensionValue.SetRange(Code, Rec."Global Dimension 2 Code");
        if DimensionValue.FindFirst() then
            Rec.Validate("Studio Description", DimensionValue.Name);
        //SRBC-428 End
        //SRBC-483 Start
        if (Rec."Document Type" = Rec."Document Type"::Refund) and (Rec."Dispute Lost Payment Entry No." <> 0) then begin
            if PaymentCLE.Get(Rec."Dispute Lost Payment Entry No.") then
                if (PaymentCLE."Document Type" = PaymentCLE."Document Type"::Payment) or (PaymentCLE."Stripe Payment Status" = PaymentCLE."Stripe Payment Status"::dispute_lost) then begin
                    Rec.Validate("Stripe Payment Status", Rec."Stripe Payment Status"::dispute_lost);
                    Rec.Validate("Epay reversed", true);
                    Rec.Validate("Return Fee Calculation", true);
                    Rec.Validate(Sr_Description, PaymentCLE."Payment Status Failure Reason" + ' - ' + PaymentCLE."Stripe Inv Number");
                    Rec.Validate(Description, CopyStr(PaymentCLE."Payment Status Failure Reason", 1, 80) + ' - ' + PaymentCLE."Stripe Inv Number");
                    Rec.Validate("Posting Date", PaymentCLE."Stripe Payment Status Date");
                    Rec.Validate("Payment Status", Rec."Payment Status"::"Returned Payment");
                    Rec.Validate(Status, Rec.Status::Failed);
                    Rec.Validate("Processing Status", Rec."Processing Status"::Failed);
                    Rec.Validate("Transaction Type", Rec."Transaction Type"::"Returned Payment");
                    //AM 23042026
                    Rec.Validate("Stripe Invoice ID", PaymentCLE."Stripe Invoice ID");
                    Rec.Validate("Stripe Inv Number", PaymentCLE."Stripe Inv Number");
                    Rec.Validate("Stripe Invoice Status", PaymentCLE."Stripe Invoice Status");
                    Rec.Validate("Payment Status Failure Code", PaymentCLE."Payment Status Failure Code");
                    Rec.Validate("Payment Status Failure Reason", PaymentCLE."Payment Status Failure Reason");
                    Rec.Validate("Stripe Payment Status Date", PaymentCLE."Stripe Payment Status Date");
                    Rec.Validate("Payment Intent ID", PaymentCLE."Payment Intent ID");
                    Rec.Validate("Stripe Refund ID", PaymentCLE."Stripe Refund ID");
                    //AM 23042026
                    Rec.Validate("Charge/Payment Type", PaymentCLE."Charge/Payment Type");
                    Rec.Validate("Recipient Bank Account Portal", PaymentCLE."Recipient Bank Account Portal");
                    Rec.Validate(License, PaymentCLE.License);
                    //SY 29042026
                    Autochargetype.Reset();
                    Autochargetype.SetRange(Code, PaymentCLE."Charge/Payment Type");
                    if Autochargetype.FindFirst() then
                        Rec.Validate("CRM Account Charge Type GUID", Autochargetype.sr_autochargetypeId);
                    if not PaymentCLE.Open then //SY 28042026
                        Rec.Validate(Reversed, true);
                end;
        end;
        //SRBC-483 End
    end;
    //SRBC-290 - END
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnBeforeModifyEvent, '', false, false)]
    local procedure T21_OnBeforeModifyEvent(var Rec: Record "Cust. Ledger Entry");
    var
    begin
        if Rec.IsTemporary then
            exit;
        Rec.Validate(ModifiedDate, DT2Date(Rec.SystemModifiedAt));

        //SRBC-346 - SY - Start
        // if ((Rec.sr_Deposited) AND (Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::" ")) then
        //     Rec.Validate("Payment Status", CLE."Payment Status"::Deposited);
        //SRBC-346 - SY - Start

        //SRBC-342 Start    
        // if (Rec."Document Type" = Rec."Document Type"::Payment) and (Rec."Payment Method Code" = 'E-PAYMENT') and (Rec."Charge/Payment Type" = 'E-PAYMENT') and (Rec."Epayment Schedule") and (not Rec.Reversed) then
        //     if not Rec."Stripe Invoice Created" then
        //         Rec.Validate("Payment Status", Rec."Payment Status"::"Pending Stripe Request");
        //SRBC-346 - AM - Start
        // if (Rec."Document Type" = Rec."Document Type"::Payment) and (Rec."Payment Method Code" = 'E-PAYMENT') and (Rec."Charge/Payment Type" = 'E-PAYMENT') and (Rec."Epayment Schedule") then begin
        //     if Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::succeeded then
        //         Rec.Validate("Payment Status", Rec."Payment Status"::Settled);
        //     if Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::pending then
        //         Rec.Validate("Payment Status", Rec."Payment Status"::"Pending Settlement");
        // end;
        //SRBC-346 - AM - END

        // if Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::succeeded then begin
        //     if (Rec."Document Type" = Rec."Document Type"::Payment) AND (Rec."Payment Method Code" = 'E-PAYMENT') then
        //         Rec.Validate("Payment Status", CLE."Payment Status"::Settled);
        // end else begin
        //     if ((Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::failed) OR (Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::pending)) then begin
        //         if (Rec."Document Type" = Rec."Document Type"::Payment) and (Rec."Payment Method Code" = 'E-PAYMENT') then begin
        //             if (not Rec.Reversed) AND (NOT rec."Epay reversed") then //SRBC-197
        //                 Rec.Validate("Payment Status", CLE."Payment Status"::"Pending Settlement");
        //         end;
        //     end;
        // end;
        //SRBC-342 End
        //SRBC-374 Start
        // SRBC-261 
        // if (Rec."Document Type" = Rec."Document Type"::Refund) AND (Rec."Payment Method Code" = 'CHECK') then  //AG i commented bacuase above write the code same on onafterinsertevent of CLE
        //     Rec.Validate("Payment Status", CLE."Payment Status"::Settled);
        // SRBC-261  
        //SRBC-374 End

        //SRBC-346 - AA - Start
        //SRBC-480 - AM - Start 09042026
        // CustLedgStatusHandler_gCU.HandleCLEStatusOnBeforeModify(Rec); //PS_16102026 not used any where
        // if (Rec."Document Type" = Rec."Document Type"::Payment) and (Rec."Payment Method Code" = 'E-PAYMENT') and (Rec."Charge/Payment Type" = 'E-PAYMENT') then begin
        //     if Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::pending then begin
        //         Rec.Validate("Payment Status", Rec."Payment Status"::"Pending Settlement");
        //         Rec.Validate("Processing Status", Rec."Processing Status"::"Payment In Progress At Stripe");
        //         Rec.Validate(Status, Rec.Status::Processing);
        //     end else
        //         if Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::succeeded then begin
        //             Rec.Validate("Payment Status", Rec."Payment Status"::Settled);
        //             Rec.Validate("Processing Status", Rec."Processing Status"::Processed);
        //             Rec.Validate(Status, Rec.Status::Processed);
        //         end else
        //             if Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::failed then begin
        //                 Rec.Validate("Processing Status", Rec."Processing Status"::Failed);
        //                 Rec.Validate(Status, Rec.Status::Failed);
        //                 if Rec."Reversed by Entry No." <> 0 then
        //                     Rec.Validate("Payment Status", Rec."Payment Status"::Returned)
        //                 else if Rec."Reversed Entry No." <> 0 then
        //                     Rec.Validate("Payment Status", Rec."Payment Status"::"Returned Payment");
        // end;
        //SRBC-480 - AM - End 09042026

        //SRBC-346 - AM - 08072025
        // UpdateCLE.Reset();
        // UpdateCLE.SetRange("Entry No.", Rec."Entry No.");
        // UpdateCLE.SetFilter("Charge/Payment Type", '%1|%2|%3', 'CHECK', 'CASHIERS C', 'MONEY ORDE');
        // UpdateCLE.SetFilter("Payment Method Code", '%1|%2|%3', 'CHECK', 'CASHIERS C', 'MONEY ORDE');
        // if Rec.sr_Deposited then begin
        //     UpdateCLE.SetRange(sr_Deposited, true);
        //     if UpdateCLE.FindFirst() then begin
        //         Rec.Validate("Processing Status", Rec."Processing Status"::Processed);
        //         Rec.Validate(Status, Rec.Status::Processed);
        //         Rec.Validate("Payment Status", Rec."Payment Status"::Deposited);
        //     end;
        // end else begin
        //     if not Rec.sr_Deposited then begin
        //         UpdateCLE.SetRange(sr_Deposited, false);
        //         UpdateCLE.SetRange("Check NSF", false);
        //         UpdateCLE.SetRange(Reversed, false);
        //         if UpdateCLE.FindFirst() then begin
        //             Rec.Validate("Processing Status", Rec."Processing Status"::"Payment Deposit In Progress");
        //             Rec.Validate(Status, Rec.Status::Initiated);
        //             Rec.Validate("Payment Status", Rec."Payment Status"::Undeposited);
        //         end;
        //     end;
        // end;

        //SRBC-346 - AA - End
        //SRBC-346 - AM - Start
        //SRBC-480 - AM - Start 09042026

        // if (Rec."Document Type" = Rec."Document Type"::Refund) and (Rec."Payment Method Code" = 'E-PAYMENT') and (Rec."Charge/Payment Type" = 'E-PAYMENT') then begin
        //     if Rec."Stripe Refund Status" = 'pending' then begin
        //         Rec.Validate("Payment Status", Rec."Payment Status"::"Pending Settlement");
        //         Rec.Validate("Processing Status", Rec."Processing Status"::"Payment In Progress At Stripe");
        //         Rec.Validate(Status, Rec.Status::Processing);
        //     end else if Rec."Stripe Refund Status" = 'succeeded' then begin
        //         Rec.Validate("Payment Status", Rec."Payment Status"::Settled);
        //         Rec.Validate("Processing Status", Rec."Processing Status"::Processed);
        //         Rec.Validate(Status, Rec.Status::Processed);
        //     end else
        //         if Rec."Stripe Refund Status" = 'failed' then begin
        //             Rec.Validate("Payment Status", Rec."Payment Status"::Returned);
        //             Rec.Validate("Processing Status", Rec."Processing Status"::Failed);
        //             Rec.Validate(Status, Rec.Status::Failed);
        //         end;
        // end;
        // if (Rec."Document Type" = Rec."Document Type"::Refund) and (Rec."Payment Method Code" = 'CHECK') and (Rec."Charge/Payment Type" = 'CHECK') then begin
        //     if Rec."Payment Status" = Rec."Payment Status"::Settled then begin
        //         Rec.Validate("Processing Status", Rec."Processing Status"::Processed);
        //         Rec.Validate(Status, Rec.Status::Processed);
        //     end else
        //         if Rec."Payment Status" = Rec."Payment Status"::"Pending Settlement" then begin
        //             Rec.Validate("Processing Status", Rec."Processing Status"::"Check Refund In Progress");
        //             Rec.Validate(Status, Rec.Status::Initiated);
        //         end;
        // end;
        //SRBC-480 - AM - End 09042026
        UpdateStatusField(Rec); //SRBC-480

        //SRBC-346 - AM - End
    end;

    // Start -->PS_16102026
    // [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterModifyEvent, '', false, false)]
    // local procedure T21_AfterModifyEvent(var Rec: Record "Cust. Ledger Entry");
    // var
    //     InsertCheckNSF: Codeunit "Check NSF & Epay Reverse";
    //     CLE_lRec: Record "Cust. Ledger Entry";
    //     ReconcileBnakAcc: Codeunit "Reconcile Bank Acc Ledg Entry";//SRBC-483
    //     RefundCLE: Record "Cust. Ledger Entry";//SRBC-483
    //     GenJnlLine: Record "Gen. Journal Line";//SRBC-483
    //     SingleInstance: Codeunit "Single Instance Mgt.";//SRBC-483
    //     SRSetup: Record "Salon Republic Setup";//SRBC-483
    // begin
    //     SRSetup.Get();//SRBC-483
    //     if Rec.IsTemporary then
    //         exit;
    //     if not Rec.SkipEventTrigger then begin//SRBC-322
    //         if (Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::failed) then begin
    //             if (Rec."Epay reversed" = false) then begin
    //                 //SRBC-217 Start
    //                 if not Rec."Failed Stripe Invoice" then begin
    //                     InsertCheckNSF.AutoCreateReverseEntryInCLEByCheckNSG(Rec);
    //                     //SRBC-279 Start
    //                     if CLE_lRec.get(Rec."Entry No.") then begin
    //                         if CLE_lRec."Failed Stripe Invoice" then begin
    //                             InsertCheckNSF.ReverseCustomerLedEntryByEpayReverse(CLE_lRec);
    //                             InsertCheckNSF.UpdateCustLedEntORCreateGenJnlLineByEapyReverse(CLE_lRec);
    //                         end;
    //                     end;
    //                     //SRBC-279 End
    //                 end;
    //                 //SRBC-217 End
    //             end;
    //         end;
    //         //SRBC-483 Start
    //         if (Rec."Document Type" = Rec."Document Type"::Payment) and (Rec."Stripe Payment Status" = Rec."Stripe Payment Status"::dispute_lost) then begin
    //             GenJnlLine.Reset();
    //             GenJnlLine.SetRange("Journal Template Name", SRSetup."Refund Template");
    //             GenJnlLine.SetRange("Journal Batch Name", SRSetup."Refund Batch");
    //             GenJnlLine.SetRange("Dispute Lost Payment Entry No.", Rec."Entry No.");
    //             if not GenJnlLine.FindFirst() then begin
    //                 RefundCLE.Reset();
    //                 RefundCLE.SetRange("Document Type", RefundCLE."Document Type"::Refund);
    //                 RefundCLE.SetRange("Dispute Lost Payment Entry No.", Rec."Entry No.");
    //                 if not RefundCLE.FindFirst() then
    //                     if not SingleInstance.CheckRefundGenCreationforDisputeLost() then
    //                         ReconcileBnakAcc.ProcessStripeDisputeLostRefundJournal(Rec);
    //             end;
    //         end; //SRBC-483 End
    //     end;//SRBC-322
    //         //SRBC -346 - AM - 08072025 Commented
    //         // UpdateCLE.Reset();
    //         // UpdateCLE.SetRange("Entry No.", Rec."Entry No.");
    //         // UpdateCLE.SetFilter("Charge/Payment Type", '%1|%2|%3', 'CHECK', 'CASHIERS C', 'MONEY ORDE');
    //         // UpdateCLE.SetFilter("Payment Method Code", '%1|%2|%3', 'CHECK', 'CASHIERS C', 'MONEY ORDE');
    //         // if Rec.sr_Deposited then begin
    //         //     UpdateCLE.SetRange(sr_Deposited, true);
    //         //     if UpdateCLE.FindFirst() then begin
    //         //         UpdateCLE.Validate("Processing Status", UpdateCLE."Processing Status"::Processed);
    //         //         UpdateCLE.Validate(Status, UpdateCLE.Status::Processed);
    //         //         UpdateCLE.Validate("Payment Status", UpdateCLE."Payment Status"::Deposited);
    //         //         UpdateCLE.Modify();
    //         //     end;
    //         // end else begin
    //         //     if not Rec.sr_Deposited then begin
    //         //         UpdateCLE.SetRange(sr_Deposited, false);
    //         //         UpdateCLE.SetRange("Check NSF", false);
    //         //         UpdateCLE.SetRange(Reversed, false);
    //         //         if UpdateCLE.FindFirst() then begin
    //         //             UpdateCLE.Validate("Processing Status", UpdateCLE."Processing Status"::"Payment Deposit In Progress");
    //         //             UpdateCLE.Validate(Status, UpdateCLE.Status::Initiated);
    //         //             UpdateCLE.Validate("Payment Status", UpdateCLE."Payment Status"::Undeposited);
    //         //             UpdateCLE.Modify();
    //         //         end;
    //         //     end;
    // end;
    // <-- End

    //SRBC-346 - AM - Start
    procedure UpdateStatusField(var CustLedgEntry_vRec: Record "Cust. Ledger Entry")
    begin
        if (CustLedgEntry_vRec."Document Type" = CustLedgEntry_vRec."Document Type"::Invoice) and (CustLedgEntry_vRec.Reversed = false) then begin
            CustLedgEntry_vRec.CalcFields(Amount, "Remaining Amount");
            if not CustLedgEntry_vRec.Open then
                CustLedgEntry_vRec.Validate("Payment Status", CustLedgEntry_vRec."Payment Status"::Paid)
            else
                if CustLedgEntry_vRec."Remaining Amount" = CustLedgEntry_vRec.Amount then
                    if CustLedgEntry_vRec."Returned Payment" then
                        CustLedgEntry_vRec.Validate("Payment Status", CustLedgEntry_vRec."Payment Status"::"Unpaid(Returned)")
                    else
                        CustLedgEntry_vRec.Validate("Payment Status", CustLedgEntry_vRec."Payment Status"::Unpaid)
                else
                    CustLedgEntry_vRec.Validate("Payment Status", CustLedgEntry_vRec."Payment Status"::"Partial Payment");
            CustLedgEntry_vRec.Validate("Processing Status", CustLedgEntry_vRec."Processing Status"::Processed);
            CustLedgEntry_vRec.Validate(Status, CustLedgEntry_vRec.Status::Processed);
        end;
    end;
    //SRBC-346 - AM - End

    [EventSubscriber(ObjectType::Table, Database::"Detailed Cust. Ledg. Entry", OnAfterInsertEvent, '', false, false)]
    local procedure T379_OnAfterInsertEvent(var Rec: Record "Detailed Cust. Ledg. Entry");
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        UnpaidReturned: Boolean;
    begin
        if Rec.IsTemporary then
            exit;
        UnpaidReturned := false;
        CustLedgerEntry.Reset();
        if not CustLedgerEntry.Get(Rec."Cust. Ledger Entry No.") then
            exit;

        //SRBC-346 - AM - Start - 09072025
        // If Not (CustLedgerEntry."Document Type" in [CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Finance Charge Memo", CustLedgerEntry."Document Type"::"Credit Memo"]) then
        //     exit;

        // //Partial Payment case
        // if ((not CustLedgerEntry.sr_Deposited) AND (CustLedgerEntry."Stripe Payment Status" = CustLedgerEntry."Stripe Payment Status"::" ")) then begin
        //     CustLedgerEntry.CalcFields("Remaining Amount", "Original Amount");
        //     if (CustLedgerEntry.Open) AND (CustLedgerEntry."Remaining Amount" <> 0) AND (CustLedgerEntry."Payment Status" <> CustLedgerEntry."Payment Status"::"Partial Payment") then begin
        //         if CustLedgerEntry."Original Amount" <> CustLedgerEntry."Remaining Amount" then begin
        //             CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::"Partial Payment";
        //             CustLedgerEntry.Modify();
        //             exit;
        //         end;
        //     end;
        // end;

        // //Partial Payment case
        // IF NOT CustLedgerEntry."Returned Payment" then begin
        //     CustLedgerEntry."Returned Payment" := Rec.Unapplied;
        //     CustLedgerEntry.Modify();
        // end;

        // //SRBC-244 - NU - OLD
        // //<< Commented code so it update correct payment status
        // // if (CustLedgerEntry."Payment Status" <> CustLedgerEntry."Payment Status"::Unpaid) then
        // //     exit;
        // //SRBC-244 - NU - OLD

        // UnpaidReturned := CustLedgerEntry."Returned Payment";

        // if ((not CustLedgerEntry.sr_Deposited) AND (CustLedgerEntry."Stripe Payment Status" = CustLedgerEntry."Stripe Payment Status"::" ")) then begin
        //     If UnpaidReturned AND (CustLedgerEntry.Open) then
        //         CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::"Unpaid(Returned)";

        //     if (not UnpaidReturned) AND (Rec."Entry Type" = Rec."Entry Type"::Application) AND (NOT CustLedgerEntry.Open) then
        //         if not CustLedgerEntry.Reversed then
        //             CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::Paid;

        //     CustLedgerEntry.Modify();
        // end;
        //SRBC-346 - AM - End

    end;
    //SR..BKP --10/01/2024 - NS
    //apply
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromCVLedgEntryBuffer, '', false, false)]
    local procedure T21_OnAfterCopyCustLedgerEntryFromCVLedgEntryBuffer(var CustLedgerEntry: Record "Cust. Ledger Entry"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer");
    var
    begin
        //SRBC-408 Start
        //SRBC-416 Start//01092025
        if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo" then begin
            CustLedgerEntry."Amount Paid" := CVLedgerEntryBuffer."Original Amount";
            CustLedgerEntry.Validate("Amount Deposited", CustLedgerEntry."Amount Paid");
        end else begin
            if CVLedgerEntryBuffer.Amount = 0 then
                CustLedgerEntry."Amount Paid" := CVLedgerEntryBuffer."Original Amount" - CVLedgerEntryBuffer."Remaining Amount"
            else
                CustLedgerEntry."Amount Paid" := CVLedgerEntryBuffer.Amount - CVLedgerEntryBuffer."Remaining Amount";
            CustLedgerEntry.Validate("Amount Deposited", CustLedgerEntry."Amount Paid");
        end;

        //SRBC-416 End
    end;
    //SRBC-408 End

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr, '', false, false)]
    local procedure T36_OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr(var SalesHeader: Record "Sales Header"; var ShipToAddress: Record "Ship-to Address"; var IsHandled: Boolean);
    begin
        if not IsHandled then begin
            if ShipToAddress."Global Dimension 1 Code" <> '' then
                SalesHeader.Validate("Shortcut Dimension 1 Code", ShipToAddress."Global Dimension 1 Code");
            if ShipToAddress."Global Dimension 2 Code" <> '' then
                SalesHeader.Validate("Shortcut Dimension 2 Code", ShipToAddress."Global Dimension 2 Code");
        end;
    end;

    //Update Default dimensions on Sales Order /Invoice from Sell to Cust No.
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterCopyShipToCustomerAddressFieldsFromCustomer, '', false, false)]
    local procedure T36_OnAfterCopyShipToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SelltoCustomer: Record Customer; xSalesHeader: Record "Sales Header");
    begin
        SalesHeader.CreateDimFromDefaultDim(SalesHeader.FieldNo("Sell-to Customer No."));

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnAfterPostGenJournalLine, '', false, false)]
    local procedure CU13_OnAfterPostGenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; var Result: Boolean);
    begin
        //SRBC-438
        if (GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Vendor) and (not GenJournalLine."MultiSigner Hold Deposit") and (not GenJournalLine."Construction Agreement") then//SRBC-380
            InsertGenJnlPaymentEntryAfterInvoiceInsertion(GenJournalLine); //Create Payment Entries against Invoice for Gen Jnl Lines.
    end;

    // Start -->PS_16102026
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertDtldCustLedgEntry, '', false, false)]
    // local procedure OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GLRegister: Record "G/L Register");
    // begin
    //     DtldCustLedgEntry."Charge/Payment Type" := GenJournalLine."Charge Payment Type";
    // end;
    // <-- End

    //Unapply CLE 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeCustLedgEntryModify, '', false, false)]
    local procedure CU12_OnBeforeCustLedgEntryModify(var CustLedgerEntry: Record "Cust. Ledger Entry"; DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry");
    begin
        //SRBC-484 -18032026
        //SRBC-416 Start
        // if CustLedgerEntry.Open then begin
        //     CustLedgerEntry.CalcFields(Amount, "Remaining Amount");
        //     CustLedgerEntry."Amount Paid" := CustLedgerEntry.Amount - CustLedgerEntry."Remaining Amount";
        //     CustLedgerEntry.Validate("Amount Deposited", CustLedgerEntry."Amount Paid");
        // end else begin
        //     CustLedgerEntry."Amount Paid" := 0;
        //     CustLedgerEntry."Amount Deposited" := 0;
        // end;
        //SRBC-416 End
        CustLedgerEntry.CalcFields(Amount, "Remaining Amount");
        if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo" then begin
            CustLedgerEntry."Amount Paid" := CustLedgerEntry.Amount;
            CustLedgerEntry.Validate("Amount Deposited", CustLedgerEntry."Amount Paid");
        end else begin
            CustLedgerEntry."Amount Paid" := CustLedgerEntry.Amount - CustLedgerEntry."Remaining Amount";
            CustLedgerEntry.Validate("Amount Deposited", CustLedgerEntry."Amount Paid");
        end;
        //SRBC-484 -18032026
        if not CustLedgerEntry.Open then
            exit;
        //SRBC-346 - AM - Start - 11072025
        // If Not (CustLedgerEntry."Document Type" in [CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Finance Charge Memo", CustLedgerEntry."Document Type"::"Credit Memo"]) then 
        //     exit;
        If Not (CustLedgerEntry."Document Type" in [CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Finance Charge Memo"]) then
            exit;
        //SRBC-346 - AM End
        //Partial Payment case - Unapply
        CustLedgerEntry.CalcFields("Remaining Amount", "Original Amount");
        if ((not CustLedgerEntry.sr_Deposited) AND (CustLedgerEntry."Stripe Payment Status" = CustLedgerEntry."Stripe Payment Status"::" ")) then begin
            if (CustLedgerEntry.Open) AND (CustLedgerEntry."Remaining Amount" <> 0) AND (CustLedgerEntry."Payment Status" <> CustLedgerEntry."Payment Status"::"Partial Payment") then begin
                if CustLedgerEntry."Original Amount" <> CustLedgerEntry."Remaining Amount" then
                    CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::"Partial Payment"
                else
                    CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::"Unpaid(Returned)";
            end else
                CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::"Unpaid(Returned)";
        end;

    end;

    //Original Reverse Transaction CLE 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnApplyCustLedgEntryByReversalOnAfterCustLedgEntryModify, '', false, false)]
    local procedure CU17_OnApplyCustLedgEntryByReversalOnAfterCustLedgEntryModify(var CustLedgerEntry: Record "Cust. Ledger Entry");
    Var
        CLE: record "Cust. Ledger Entry";
    begin
        CLE.Get(CustLedgerEntry."Entry No.");
        if not cle.Reversed then
            exit;

        if ((CLE."Stripe Payment Status" <> CLE."Stripe Payment Status"::succeeded) OR (CLE."Stripe Payment Status" <> CLE."Stripe Payment Status"::pending)) then begin
            if (CLE."Document Type" = CLE."Document Type"::Invoice) OR (CLE."Document Type" = CLE."Document Type"::Payment) THEN begin
                if CLE."Reversed by Entry No." <> 0 then
                    if (not CLE."Edit Charge") and (not CLE."Edit Payment") and (not CLE."Edit Discount") and (not CLE."Delete Charge") and (not CLE."Delete Payment") and (not CLE."Delete Discount") then//SRBC-480
                        CLE."Payment Status" := CLE."Payment Status"::Returned;
                if cle."Reversed Entry No." <> 0 then //SRBC-480
                    if (not CLE."Edit Charge") and (not CLE."Edit Payment") and (not CLE."Edit Discount") and (not CLE."Delete Charge") and (not CLE."Delete Payment") and (not CLE."Delete Discount") then begin//SRBC-480
                        CLE."Payment Status" := CLE."Payment Status"::"Returned Payment";
                        CLE.Validate("Transaction Type", CLE."Transaction Type"::"Returned Payment")//SRBC-428
                    end;//SRBC-480
            end else begin
                cle.CalcFields("Charge Category");
                if (CLE."Document Type" = CLE."Document Type"::"Credit Memo") AND (cle."Charge Category" = cle."Charge Category"::Discount) then begin
                    if (not CLE."Edit Charge") and (not CLE."Edit Payment") and (not CLE."Edit Discount") and (not CLE."Delete Charge") and (not CLE."Delete Payment") and (not CLE."Delete Discount") then //SRBC-480 AM 13042026 
                        CLE.Validate("Transaction Type", CLE."Transaction Type"::Discount)//SRBC-428
                end;
            end;
        end;
        //SRBC-290 - START
        if CLE."Reversed Entry No." <> 0 then begin//SRBC-491
            cle.Validate("CRM AccountLedger ID", CLE.SystemId);
            CLE.Validate(IsBCGuid, true);
        end;//SRBC-491
        CLE.Modify();
        //SRBC-290 - END
    end;

    //Create Customer From CRM Contact Card Insertion -Start
    [EventSubscriber(ObjectType::Table, Database::Agreements, 'OnAfterInsertEvent', '', true, true)]
    local procedure T50011_OnAfterInsertEvent(var Rec: Record Agreements; RunTrigger: Boolean)
    var
        cdssrageement: Record "CDS sr_agreement";
        CDSAgreement_lPg: Page "Agreement - Dataverse";
        _AgreementSchedule: Record "Agreement Schedule";//SRBC-326
        _SRSetup_lRec: Record "Salon Republic Setup";//SRBC-326
        _ACHPaymentList: Record "ACH Payment List";//SRBC-325
        _IsHandled: Boolean;//SRBC-387
        AgreementSchedule: Record "Agreement Schedule";//SRBC-413
        CalcCurrAgreementStartDate: date;//SRBC-413
    begin
        //SRBC-326 Start
        _AgreementSchedule.Reset();
        _AgreementSchedule.SetRange(sr_agreementid, Rec."Agreement ID");
        if _AgreementSchedule.FindSet() then
            repeat
                //SRBC-413 Start AM 29082025	    
                AgreementSchedule.Reset();
                AgreementSchedule.SetCurrentKey(sr_feeduedate);
                AgreementSchedule.SetRange(sr_agreementid, _AgreementSchedule.sr_agreementid);
                AgreementSchedule.SetRange(sr_agreementscheduleId, _AgreementSchedule.sr_agreementscheduleId);
                AgreementSchedule.SetRange(Sequence, _AgreementSchedule.Sequence);
                if AgreementSchedule.FindFirst() then begin
                    if (AgreementSchedule."Current Agrement Start Date" = 0D) or (AgreementSchedule."Current Agrement End Date" = 0D) then begin
                        _IsHandled := false;
                        if AgreementSchedule."Recurring Entry No." = 0 then begin
                            if (Rec."Current Agreement Start Date" >= AgreementSchedule.sr_feeduedate) and (Rec."Current Agreement End Date" >= AgreementSchedule.sr_feeduedate) then begin
                                if Rec."Current Agreement End Date" > Rec."Current Agreement Start Date" then begin
                                    AgreementSchedule.Validate("Current Agrement Start Date", Rec."Current Agreement Start Date");
                                    AgreementSchedule.Validate("Current Agrement End Date", Rec."Current Agreement End Date");
                                    _IsHandled := true;
                                end;
                            end else begin
                                if (AgreementSchedule."No. of Days for Disc" <> 0) and (AgreementSchedule.new_abatementfee <> 0) then begin //SRBC-413 AM 29082025
                                    Clear(CalcCurrAgreementStartDate);
                                    CalcCurrAgreementStartDate := (AgreementSchedule.sr_feeduedate - AgreementSchedule."No. of Days for Disc") + 1;
                                    if (CalcCurrAgreementStartDate = Rec."Current Agreement Start Date") and (Rec."Current Agreement End Date" > Rec."Current Agreement Start Date") then begin
                                        AgreementSchedule.Validate("Current Agrement Start Date", Rec."Current Agreement Start Date");
                                        AgreementSchedule.Validate("Current Agrement End Date", Rec."Current Agreement End Date");
                                        _IsHandled := true;
                                    end;
                                end else begin
                                    if (AgreementSchedule."No. of Days for Disc" = 0) and (AgreementSchedule.new_abatementfee = 0) then begin //SRBC-413 AM 29082025
                                        Clear(CalcCurrAgreementStartDate);
                                        CalcCurrAgreementStartDate := (AgreementSchedule.sr_feeduedate - ((AgreementSchedule.sr_from - 1) * 7)) + 1;
                                        if (Rec."Current Agreement Start Date" = CalcCurrAgreementStartDate) and (Rec."Current Agreement End Date" >= AgreementSchedule.sr_feeduedate) then //SRBC-413 JSG 10092025
                                            if Rec."Current Agreement End Date" > Rec."Current Agreement Start Date" then begin
                                                AgreementSchedule.Validate("Current Agrement Start Date", Rec."Current Agreement Start Date");
                                                AgreementSchedule.Validate("Current Agrement End Date", Rec."Current Agreement End Date");
                                                _IsHandled := true;
                                            end;
                                    end;
                                end;
                            end;
                            if (AgreementSchedule.new_abatementfee <> 0) AND (AgreementSchedule.sr_weeklylicensefee <> 0) then begin
                                if AgreementSchedule."Current Agrement Start Date" <> 0D then begin
                                    AgreementSchedule."Discount Start Date" := AgreementSchedule."Current Agrement Start Date" - 1;
                                    AgreementSchedule."Discount End Date" := AgreementSchedule."Discount Start Date" + AgreementSchedule."No. of Days for Disc" - 1;
                                    _IsHandled := true;
                                end;
                            end;
                        end;
                    end;
                end;
                if _IsHandled then
                    AgreementSchedule.Modify();
            until _AgreementSchedule.Next() = 0;
        //SRBC-413 - End AM 29082025
        //SRBC-326 End

        //SRBC-325 Start
        _ACHPaymentList.Reset();
        _ACHPaymentList.SetRange("Agreement ID", Rec."Agreement ID");
        if _ACHPaymentList.FindSet() then
            repeat
                if (_ACHPaymentList."Current Agreement Start Date" = 0D) and (_ACHPaymentList."Current Agreement End Date" = 0D) then begin
                    if not _ACHPaymentList."Epayment Schedule Created" then begin
                        _ACHPaymentList.Validate("Current Agreement Start Date", Rec."Current Agreement Start Date");
                        _ACHPaymentList.Validate("Current Agreement End Date", Rec."Current Agreement End Date");
                        _ACHPaymentList.Modify();
                    end;
                end;
            until _ACHPaymentList.Next() = 0;
        //SRBC-325 End
        if Rec.sr_Licensee <> '' then
            SplitLicenseeJsonArray(Rec);
        if Rec.sr_Studio <> '' then
            SplitStudioJsonArray(Rec);
        if (Format((Rec.sr_salonlocationid)) <> '') and (Format((Rec."Studio 1")) <> '') then
            UpdateDimensionValuesonAgreement(Rec);

        //SRBC-470 Start
        // Rec.Validate(Inactive, UpdateInactiveStatus(Rec));
        // if Rec.Inactive then begin
        //     MakeRecurringChargesInactive(Rec);
        //     MakeEpaymentScheduleInactive(Rec);
        // end;
        //SRBC-470 End
        //SRBC-326 Start
        _SRSetup_lRec.Get();
        if _SRSetup_lRec."Create Customer from Agreement" then
            Rec.Validate("Customer Code", CreateCustomerOnAgreementInsert(Rec));
        //SRBC-326 End
        Rec.Modify(true);
        UpdateCustomerDimension(Rec);
        CDSAgreement_lPg.Activate();
        CDSAgreement_lPg.Update(true);
        cdssrageement.Reset();
        if cdssrageement.Get(Rec."Agreement ID") then begin
            cdssrageement.sr_BCAccountNo := Rec."Customer Code";
            cdssrageement.Modify();
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::Agreements, 'OnBeforeModifyEvent', '', true, true)]
    local procedure T50011_OnBeforeModifyEvent(var Rec: Record Agreements; RunTrigger: Boolean)
    var
    begin
        //SRBC-475 Start
        if Rec.sr_Licensee <> '' then
            SplitLicenseeJsonArray(Rec);
        if Rec.sr_Studio <> '' then
            SplitStudioJsonArray(Rec);
        //SRBC-475 End
        //LA Security
        // if ((rec.sr_docusignintegrastatus_la = rec.sr_docusignintegrastatus_la::Completed) AND (rec.sr_LASecurityDepositAmount > 0) AND (NOT Rec.LASecurity)) then
        //     Recmgmnt.CreateRecurringChargesLASecurity(Rec);

        UpdateStaggeredEndDateAndCreateRecurringCharges(Rec); //IF Staggered end date is blank on agreement schedule for last row
    end;

    [EventSubscriber(ObjectType::Table, Database::Agreements, 'OnAfterModifyEvent', '', true, true)]
    local procedure T50011_OnAfterModifyEvent(var Rec: Record Agreements; RunTrigger: Boolean)
    var
        RecurringMgmt: Codeunit "Recurring Charges Mgt.";
        CDSsragreement: Record "CDS sr_agreement";
        Customer: Record Customer;
        CDSAgreement_lPge: Page "Agreement - Dataverse";
        _AgreementSchedule: Record "Agreement Schedule";//SRBC-326
        _ACHPaymentList: Record "ACH Payment List";//SRBC-325
        IsHandled_ModifyAgreementSchedule: Boolean;//SRBC-348
        IsHandled_ModifyACHPaymentList: Boolean;//SRBC-348
        AgreementSchedule: Record "Agreement Schedule";//SRBC-413
        CalcCurrAgreementStartDate: Date;//SRBC-413
    begin
        Clear(CalcCurrAgreementStartDate);//SRBC-413
        //SRBC-326 Start
        //SRBC-413 Start
        if Customer.get(Rec."Customer Code") then; //SRBC-348
        if (Rec."Current Agreement Start Date" <> 0D) or (Rec."Current Agreement End Date" <> 0D) then begin
            _AgreementSchedule.Reset();
            _AgreementSchedule.SetRange(sr_agreementid, Rec."Agreement ID");
            if _AgreementSchedule.FindSet() then
                repeat
                    //SRBC-413 Start
                    Clear(IsHandled_ModifyAgreementSchedule);
                    if AgreementSchedule.sr_name <> Customer.Name then begin
                        AgreementSchedule.Validate(sr_name, Customer.Name);
                        IsHandled_ModifyAgreementSchedule := true;
                    end;
                    //SRBC-348 - Start
                    //SRBC-413 Start AM 29082025
                    AgreementSchedule.Reset();
                    AgreementSchedule.SetCurrentKey(sr_feeduedate);
                    AgreementSchedule.SetRange(sr_agreementid, _AgreementSchedule.sr_agreementid);
                    AgreementSchedule.SetRange(sr_agreementscheduleId, _AgreementSchedule.sr_agreementscheduleId);
                    AgreementSchedule.SetRange(Sequence, _AgreementSchedule.Sequence);
                    if AgreementSchedule.FindFirst() then begin
                        //SRBC-387 - Start
                        if (AgreementSchedule."Current Agrement Start Date" = 0D) or (AgreementSchedule."Current Agrement End Date" = 0D) then begin
                            IsHandled_ModifyAgreementSchedule := false;
                            if AgreementSchedule."Recurring Entry No." = 0 then begin
                                if (Rec."Current Agreement Start Date" >= AgreementSchedule.sr_feeduedate) and (Rec."Current Agreement End Date" >= AgreementSchedule.sr_feeduedate) then begin
                                    if Rec."Current Agreement End Date" > Rec."Current Agreement Start Date" then begin
                                        AgreementSchedule.Validate("Current Agrement Start Date", Rec."Current Agreement Start Date");
                                        AgreementSchedule.Validate("Current Agrement End Date", Rec."Current Agreement End Date");
                                        IsHandled_ModifyAgreementSchedule := true;
                                    end;
                                end else begin
                                    if (AgreementSchedule."No. of Days for Disc" <> 0) and (AgreementSchedule.new_abatementfee <> 0) then begin //SRBC-413 AM 29082025
                                        Clear(CalcCurrAgreementStartDate);
                                        CalcCurrAgreementStartDate := (AgreementSchedule.sr_feeduedate - AgreementSchedule."No. of Days for Disc") + 1;
                                        if (CalcCurrAgreementStartDate = Rec."Current Agreement Start Date") and
                                            (Rec."Current Agreement End Date" > Rec."Current Agreement Start Date") then begin
                                            AgreementSchedule.Validate("Current Agrement Start Date", Rec."Current Agreement Start Date");
                                            AgreementSchedule.Validate("Current Agrement End Date", Rec."Current Agreement End Date");
                                            IsHandled_ModifyAgreementSchedule := true;
                                        end;
                                    end else begin
                                        if (AgreementSchedule."No. of Days for Disc" = 0) and (AgreementSchedule.new_abatementfee = 0) then begin //SRBC-413 AM 29082025
                                            Clear(CalcCurrAgreementStartDate);
                                            CalcCurrAgreementStartDate := (AgreementSchedule.sr_feeduedate - ((AgreementSchedule.sr_from - 1) * 7)) + 1;
                                            if (Rec."Current Agreement Start Date" = CalcCurrAgreementStartDate) and (Rec."Current Agreement End Date" >= AgreementSchedule.sr_feeduedate) then //SRBC-413 JSG 09092025
                                                if Rec."Current Agreement End Date" > Rec."Current Agreement Start Date" then begin
                                                    AgreementSchedule.Validate("Current Agrement Start Date", Rec."Current Agreement Start Date");
                                                    AgreementSchedule.Validate("Current Agrement End Date", Rec."Current Agreement End Date");
                                                    IsHandled_ModifyAgreementSchedule := true;
                                                end;
                                        end;
                                    end;
                                end;
                                // end;
                                //SRBC-413 - Start AM 29082025
                                if (AgreementSchedule.new_abatementfee <> 0) AND (AgreementSchedule.sr_weeklylicensefee <> 0) then begin
                                    if AgreementSchedule."Current Agrement Start Date" <> 0D then begin
                                        AgreementSchedule."Discount Start Date" := AgreementSchedule."Current Agrement Start Date" - 1;
                                        AgreementSchedule."Discount End Date" := AgreementSchedule."Discount Start Date" + AgreementSchedule."No. of Days for Disc" - 1;
                                        IsHandled_ModifyAgreementSchedule := true;
                                    end;
                                end;
                                //SRBC-413 - End AM 29082025
                            end;
                        end;
                        //SRBC-413 AM - Start - 29082025
                    end;
                    if IsHandled_ModifyAgreementSchedule then//SRBC-348
                        AgreementSchedule.Modify();//SRBC-348
                                                   //SRBC-413 End
                until _AgreementSchedule.Next() = 0;
        end;
        //SRBC-326 End
        //SRBC-387 End

        //SRBC-325 Start
        _ACHPaymentList.Reset();
        _ACHPaymentList.SetRange("Agreement ID", Rec."Agreement ID");
        if _ACHPaymentList.FindSet() then
            repeat
                //SRBC-348 - Start
                Clear(IsHandled_ModifyACHPaymentList);
                if (_ACHPaymentList."Customer No." <> Customer."No.") or (_ACHPaymentList."Customer Name" <> Customer.Name) then begin
                    _ACHPaymentList.Validate("Customer No.", Customer."No.");
                    _ACHPaymentList.Validate("Customer Name", Customer.Name);
                    IsHandled_ModifyACHPaymentList := true;
                end;
                //SRBC-348 - End
                if (_ACHPaymentList."Current Agreement Start Date" = 0D) or (_ACHPaymentList."Current Agreement End Date" = 0D) then begin//SRBC-348
                    if not _ACHPaymentList."Epayment Schedule Created" then begin
                        _ACHPaymentList.Validate("Current Agreement Start Date", Rec."Current Agreement Start Date");
                        _ACHPaymentList.Validate("Current Agreement End Date", Rec."Current Agreement End Date");
                        IsHandled_ModifyACHPaymentList := true;//SRBC-348
                    end;
                end;
                if IsHandled_ModifyACHPaymentList then//SRBC-348
                    _ACHPaymentList.Modify();//SRBC-348
            until _ACHPaymentList.Next() = 0;
        //SRBC-325 End
        if Rec.sr_AdditionalSecurityDepAmt <> 0 then begin
            if NOT Rec."Additional Security Charge" then begin
                if Rec."Current Agreement Start Date" <> 0D then
                    if Rec.sr_docusignintegrastatus_la = Rec.sr_docusignintegrastatus_la::Completed then  //SRBC-330
                        RecurringMgmt.CreateAdditionalSecurityDepositLines(Rec);
            end;
        end;
        //SRBC-470 Start
        // Rec.Validate(Inactive, UpdateInactiveStatus(Rec));
        // if Rec.Inactive then begin
        //     MakeRecurringChargesInactive(Rec);
        //     MakeEpaymentScheduleInactive(Rec);
        // end;
        //SRBC-470 End
        //CDSsragreement.Reset();
        CDSAgreement_lPge.Activate();
        CDSAgreement_lPge.Update(true);
        if CDSsragreement.Get(Rec."Agreement ID") then begin
            Customer.Reset;
            if Customer.get(Rec."Customer Code") then begin
                Customer.CalcFields("Salon Balance");
                CDSsragreement.sr_LatestBalanceAccountLedger := Customer."Salon Balance";
                CDSsragreement.Modify();
            end;
        end;
    end;

    local procedure InsertCustomerAfterAgreement(var Agreements: Record Agreements)
    var
    begin
    end;

    local procedure UpdateInactiveStatus(var Agreements: Record Agreements): Boolean

    begin
        case Agreements."Agreement Status Reason" of
            AgreementStatusReason::Terminated:
                exit(true);
            AgreementStatusReason::"Terminated-Eviction":
                exit(true);
            AgreementStatusReason::"Terminated-Withdrew":
                exit(true);
        end;
    end;

    local procedure MakeRecurringChargesInactive(var Agreement_iRec: Record Agreements)
    var
        RecurringCharges: Record "Recurring Charges";
        MODRecCharges: Record "Recurring Charges";
    begin
        RecurringCharges.Reset();
        RecurringCharges.SetRange("Agreement ID", Agreement_iRec."Agreement ID");
        RecurringCharges.SetRange(Inactive, false);
        if RecurringCharges.FindSet() then begin
            repeat
                MODRecCharges.Get(RecurringCharges."Entry No.");
                MODRecCharges.Validate(Inactive, true);
                MODRecCharges.Modify();
            until RecurringCharges.Next() = 0;
        end;
    end;

    local procedure MakeEpaymentScheduleInactive(var Agreement_iRec: Record Agreements)
    var
        EpaySche: Record "E Payment Schedule";
        MODEpaySche: Record "E Payment Schedule";
    begin
        EpaySche.Reset();
        EpaySche.SetRange("Agreement ID", Agreement_iRec."Agreement ID");
        EpaySche.SetRange(Inactive, false);
        if EpaySche.FindSet() then begin
            repeat
                MODEpaySche.Get(EpaySche."Entry No.");
                MODEpaySche.Validate(Inactive, true);
                MODEpaySche.Modify();
            until EpaySche.Next() = 0;
        end;
    end;
    //Create Customer From CRM Contact Card Insertion -End

    //Insert CLE 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', false, false)]
    local procedure C12_OnBeforeCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    var
        SRsetup: Record "Salon Republic Setup";
    begin
        //SRBC-480 AM 13042026 Start
        if (not CustLedgerEntry."Edit Charge") and (not CustLedgerEntry."Edit Payment") and (not CustLedgerEntry."Edit Discount") and (not CustLedgerEntry."Delete Charge") and (not CustLedgerEntry."Delete Payment") and (not CustLedgerEntry."Delete Discount") then begin
            SRsetup.Get();
            if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice then
                CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::Charge);//SRBC-428
            if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment) AND (CustLedgerEntry.Reversed = false) then
                CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::Payment);//SRBC-428
            if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) AND (CustLedgerEntry."Charge/Payment Type" = 'DISCOUNT') then
                CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::"Returned Fee");//SRBC-428
            if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Refund) OR (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment) AND (CustLedgerEntry.Reversed = true) AND (CustLedgerEntry."Reversed Entry No." <> 0) then
                CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::"Returned Payment");//SRBC-428
            if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo") AND (CustLedgerEntry."Charge/Payment Type" = SRsetup."LICENSE FEE CONCESSION") then
                CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::Discount);//SRBC-428
            if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Refund) then
                CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::Refund);//SRBC-428
        end;
        //SR..BKP --09/01/2024 - NS
        //SRBC-346 - AM - Start 08072025
        // if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) OR
        //    (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Finance Charge Memo") OR
        //    (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo") AND (CustLedgerEntry.Open = true) then begin
        //     CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::Unpaid;
        // end;
        // if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) AND (CustLedgerEntry.Open = true) AND (CustLedgerEntry."Original Amount" <> CustLedgerEntry."Remaining Amount") then
        //     CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::"Partial Payment";

        // if (CustLedgerEntry."Payment Method Code" = 'CHECK') OR (CustLedgerEntry."Payment Method Code" = 'CASHIERS C') OR (CustLedgerEntry."Payment Method Code" = 'MONEY ORDE') then begin
        //     if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment) then
        //         CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::Undeposited;
        // end else begin
        //     if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment) AND (CustLedgerEntry.Open = true) AND (CustLedgerEntry.Reversed = true) AND (CustLedgerEntry."Reversed by Entry No." <> 0) then
        //         CustLedgerEntry."Payment Status" := CustLedgerEntry."Payment Status"::"Returned Payment";
        // end;
        //SR..BKP --09/01/2024 - NE
        //SRBC-346 - AM - End
    end;



    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterAccountNoOnValidateGetCustomerAccount, '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetCustomerAccount(var GenJournalLine: Record "Gen. Journal Line"; var Customer: Record Customer; CallingFieldNo: Integer);
    var
        SourceCodeSetup: Record "Source Code Setup";
    begin
        SourceCodeSetup.Get();
        IF GenJournalLine."Source Code" = SourceCodeSetup."Sales Journal" then
            If Customer."CRM Contact ID" <> '' then
                Evaluate(GenJournalLine.License, Customer."CRM Contact ID");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Error Handler", OnAfterLogError, '', false, false)]
    local procedure "Job Queue Error Handler_OnAfterLogError"(var JobQueueEntry: Record "Job Queue Entry"; var JobQueueLogEntry: Record "Job Queue Log Entry")
    var
        SRSetup: Record "Salon Republic Setup";
    begin

        SRSetup.Get();
        if SRSetup."Activate Job Queue Restarter" then begin
            if JobQueueLogEntry."Object ID to Run" = 54000 then begin
                if JobQueueLogEntry.Status = JobQueueLogEntry.Status::"In Process" then begin
                    JobQueueLogEntry.MarkAsError();
                end;
            end;
            if JobQueueEntry."Object Type to Run" = JobQueueEntry."Object Type to Run"::Codeunit then begin
                if JobQueueEntry."Object ID to Run" = 54000 then
                    if ((JobQueueEntry.Status = JobQueueEntry.Status::Error) OR (JobQueueEntry.Status = JobQueueEntry.Status::"In Process")) then
                        JobQueueEntry.Restart();
            end;
        end;
    end;

    //Split JsonArray For License
    procedure SplitLicenseeJsonArray(var Agreements: Record Agreements);
    var
        JsonText: Text;
        JsonArray: JsonArray;
        i: Integer;
        license1: Guid;
        //SRBC-475 - Start
        license2: Guid;
        license3: Guid;
        license4: Guid;
        license5: Guid;
        license6: Guid;
        license7: Guid;
        license8: Guid;
        license9: Guid;
        license10: Guid;
    //SRBC-475 - End
    begin
        //SRBC-475
        Clear(Agreements."Licensee 1");
        Clear(Agreements."Licensee 2");
        Clear(Agreements."Licensee 3");
        Clear(Agreements."Licensee 4");
        Clear(Agreements."Licensee 5");
        Clear(Agreements."Licensee 6");
        Clear(Agreements."Licensee 7");
        Clear(Agreements."Licensee 8");
        Clear(Agreements."Licensee 9");
        Clear(Agreements."Licensee 10");
        //SRBC-475
        // Your JSON string
        JsonText := Agreements.sr_Licensee;
        // Parse the JSON string into a JsonArray
        if JsonArray.ReadFrom(JsonText) then begin
            foreach JsonTokenValue in JsonArray do begin
                i := i + 1;
                JsonObject := JsonTokenValue.AsObject();
                JsonObject.Get('id', JsonTokenType);
                JsonString := DelChr(Format(JsonTokenType), '<>', '"');
                JsonString := '{' + JsonString + '}';
                if i = 1 then begin
                    Evaluate(license1, JsonString);
                    Agreements.Validate("Licensee 1", license1);

                end;
                //SRBC-475 Start
                if i = 2 then begin
                    //Evaluate(Agreements."Licensee 2", JsonString);
                    Evaluate(license2, JsonString);
                    Agreements.Validate("Licensee 2", license2);
                end;
                if i = 3 then begin
                    //Evaluate(Agreements."Licensee 3", JsonString);
                    Evaluate(license3, JsonString);
                    Agreements.Validate("Licensee 3", license3);
                end;
                if i = 4 then begin
                    //Evaluate(Agreements."Licensee 4", JsonString);
                    Evaluate(license4, JsonString);
                    Agreements.Validate("Licensee 4", license4);
                end;
                if i = 5 then begin
                    //Evaluate(Agreements."Licensee 5", JsonString);
                    Evaluate(license5, JsonString);
                    Agreements.Validate("Licensee 5", license5);
                end;
                if i = 6 then begin
                    //Evaluate(Agreements."Licensee 6", JsonString);
                    Evaluate(license6, JsonString);
                    Agreements.Validate("Licensee 6", license6);
                end;
                if i = 7 then begin
                    //Evaluate(Agreements."Licensee 7", JsonString);
                    Evaluate(license7, JsonString);
                    Agreements.Validate("Licensee 7", license7);
                end;
                if i = 8 then begin
                    //Evaluate(Agreements."Licensee 8", JsonString);
                    Evaluate(license8, JsonString);
                    Agreements.Validate("Licensee 8", license8);
                end;
                if i = 9 then begin
                    //Evaluate(Agreements."Licensee 9", JsonString);
                    Evaluate(license9, JsonString);
                    Agreements.Validate("Licensee 9", license9);
                end;
                if i = 10 then begin
                    //Evaluate(Agreements."Licensee 10", JsonString);
                    Evaluate(license10, JsonString);//SRBC-475
                    Agreements.Validate("Licensee 10", license10);//SRBC-475
                end;
                //SRBC-475 End
            end;

        end;
    end;

    //Split Json Array for Studio
    local procedure SplitStudioJsonArray(var Agreements: Record Agreements);
    var
        JsonText: Text;
        i: Integer;
        //SRBC-475 - Start
        studio1: Guid;
        studio2: Guid;
        studio3: Guid;
        studio4: Guid;
        studio5: Guid;
        studio6: Guid;
        studio7: Guid;
        studio8: Guid;
        studio9: Guid;
        studio10: Guid;
    //SRBC-475 - End
    begin
        //SRBC-475 - Start
        Clear(Agreements."Studio 1");
        Clear(Agreements."Studio 2");
        Clear(Agreements."Studio 3");
        Clear(Agreements."Studio 4");
        Clear(Agreements."Studio 5");
        Clear(Agreements."Studio 6");
        Clear(Agreements."Studio 7");
        Clear(Agreements."Studio 8");
        Clear(Agreements."Studio 9");
        Clear(Agreements."Studio 10");
        //SRBC-475 - End
        // Your JSON string
        JsonText := Agreements.sr_Studio;
        // Parse the JSON string into a JsonArray
        if JsonArray.ReadFrom(JsonText) then begin
            foreach JsonTokenValue in JsonArray do begin
                i := i + 1;
                JsonObject := JsonTokenValue.AsObject();
                JsonObject.Get('id', JsonTokenType);
                JsonString := DelChr(Format(JsonTokenType), '<>', '"');
                JsonString := '{' + JsonString + '}';
                //SRBC-475 Start
                if i = 1 then begin
                    //Evaluate(Agreements."Studio 1", JsonString);
                    Evaluate(studio1, JsonString);
                    Agreements.Validate("Studio 1", studio1);

                end;
                if i = 2 then begin
                    //Evaluate(Agreements."Studio 2", JsonString);
                    Evaluate(studio2, JsonString);
                    Agreements.Validate("Studio 2", studio2);

                end;
                if i = 3 then begin
                    // Evaluate(Agreements."Studio 3", JsonString);
                    Evaluate(studio3, JsonString);
                    Agreements.Validate("Studio 3", studio3);

                end;
                if i = 4 then begin
                    //Evaluate(Agreements."Studio 4", JsonString);
                    Evaluate(studio4, JsonString);
                    Agreements.Validate("Studio 4", studio4);

                end;
                if i = 5 then begin
                    //Evaluate(Agreements."Studio 5", JsonString);
                    Evaluate(studio5, JsonString);
                    Agreements.Validate("Studio 5", studio5);

                end;
                if i = 6 then begin
                    //Evaluate(Agreements."Studio 6", JsonString);
                    Evaluate(studio6, JsonString);
                    Agreements.Validate("Studio 6", studio6);

                end;
                if i = 7 then begin
                    //Evaluate(Agreements."Studio 7", JsonString);
                    Evaluate(studio7, JsonString);
                    Agreements.Validate("Studio 7", studio7);

                end;
                if i = 8 then begin
                    //Evaluate(Agreements."Studio 8", JsonString);
                    Evaluate(studio8, JsonString);
                    Agreements.Validate("Studio 8", studio8);

                end;
                if i = 9 then begin
                    //Evaluate(Agreements."Studio 9", JsonString);
                    Evaluate(studio9, JsonString);
                    Agreements.Validate("Studio 9", studio9);

                end;
                if i = 10 then begin
                    //Evaluate(Agreements."Studio 10", JsonString);
                    Evaluate(studio10, JsonString);
                    Agreements.Validate("Studio 10", studio10);

                end;
                //SRBC-475 End
            end;
        end;
    end;


    //Update Dimension on Customer Card
    procedure UpdateDimensionValuesonAgreement(var AgreementRec: Record Agreements)
    var
        salon_lRec: Record "Salon Building";
        DimValue_lRec: Record "Dimension Value";
        DimValue2_lRec: Record "Dimension Value";
        Studio_iRec: Record Studio;
        StudioName: Text[100];
    begin
        StudioName := '';

        salon_lRec.Reset();
        salon_lRec.SetRange(sr_CRMSalonPK, AgreementRec.sr_salonlocationid);
        if salon_lRec.FindFirst() then begin
            DimValue_lRec.Reset();
            DimValue_lRec.SetRange("Dimension Code", 'LOC');  //Salon in CRM is LOC in BC
            DimValue_lRec.SetRange(Name, salon_lRec.sr_Name);
            if DimValue_lRec.FindFirst() then begin
                AgreementRec."BC Location Code" := DimValue_lRec.Code;
                Studio_iRec.Reset();
                Studio_iRec.SetRange(sr_StudioId, AgreementRec."Studio 1");
                if Studio_iRec.FindFirst() then begin
                    //SRBC-353 Start
                    //AM No need of the studioName because it is taking wrong name
                    // StudioName := salon_lRec.sr_Name + '-' + Format(Studio_iRec.sr_studio_number);
                    //studioName= kaif test 0.2_500
                    if AgreementRec."BC Location Code" <> '' then begin
                        DimValue2_lRec.Reset();
                        DimValue2_lRec.SetRange("Dimension Code", 'STUDIO');
                        //DimValue2_lRec.SetRange(Name, studioName);

                        // DimValue2_lRec.SetRange(Name, Studio_iRec.sr_Name); // SRBC-353
                        DimValue2_lRec.SetRange(Code, Studio_iRec."BC Studio Code");
                        if DimValue2_lRec.FindFirst() then begin
                            AgreementRec."BC studio Code" := DimValue2_lRec.Code;
                            AgreementRec.Modify();
                        end;


                        //AM 20250422
                        // AgreementRec.Modify();
                        //SRBC-353 End
                    end;

                end;

            end;
        end;
    end;
    //end;
    procedure UpdateCustomerDimension(Var Rec: Record Agreements)
    var

        DefaulatDimensionValue_rec: Record "Default Dimension";
        Customer_Rec: Record Customer;
    begin

        if (Rec."BC Studio Code" <> '') AND (Rec."BC Location Code" <> '') then begin
            Customer_Rec.Reset();
            Customer_Rec.SetRange("No.", Rec."Customer Code");
            Customer_Rec.SetRange("CRM Agreement ID", Rec."Agreement ID");
            if Customer_Rec.FindFirst() then begin
                DefaulatDimensionValue_rec.Reset();
                DefaulatDimensionValue_rec.SetRange("No.", Customer_Rec."No.");
                DefaulatDimensionValue_rec.SetRange("Table ID", 18);
                DefaulatDimensionValue_rec.SetRange("Parent Type", DefaulatDimensionValue_rec."Parent Type"::Customer);
                DefaulatDimensionValue_rec.SetRange("Dimension Code", 'LOC');
                if not DefaulatDimensionValue_rec.FindFirst() then begin

                    DefaulatDimensionValue_rec.Init();
                    DefaulatDimensionValue_rec.Validate("Parent Type", DefaulatDimensionValue_rec."Parent Type"::Customer);
                    DefaulatDimensionValue_rec.Validate("Table ID", 18);
                    DefaulatDimensionValue_rec.Validate("No.", Customer_Rec."No.");
                    DefaulatDimensionValue_rec.Validate("Dimension Code", 'LOC');
                    DefaulatDimensionValue_rec.Validate("Dimension Value Code", Rec."BC Location Code");
                    DefaulatDimensionValue_rec.Insert(true);

                    DefaulatDimensionValue_rec.Init();
                    DefaulatDimensionValue_rec.Validate("Parent Type", DefaulatDimensionValue_rec."Parent Type"::Customer);
                    DefaulatDimensionValue_rec.Validate("Table ID", 18);
                    DefaulatDimensionValue_rec.Validate("No.", Customer_Rec."No.");
                    DefaulatDimensionValue_rec.Validate("Dimension Code", 'STUDIO');
                    DefaulatDimensionValue_rec.Validate("Dimension Value Code", Rec."BC studio Code");
                    DefaulatDimensionValue_rec.Insert(true);
                end;
            end;
        end;
    end;

    local procedure InsertGenJnlPaymentEntryAfterInvoiceInsertion(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
    begin
        if GenJournalLine."Document Type" <> GenJournalLine."Document Type"::Invoice then
            exit;
        if GenJournalLine."Journal Template Name" = '' then
            exit;
        if GenJournalLine."Journal Batch Name" = '' then
            exit;
        PaymentMethod.Get(GenJournalLine."Payment Method Code");
        if PaymentMethod."Bal. Account No." = '' then
            exit;
        LineNo := 0;
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        IF GenJnlLine.FindLast() then
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000
        else
            GenJnlLine."Line No." := 10000;
        GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");

        CreateSalesJournalLines(GenJnlLine, GenJournalLine);

    end;


    [TryFunction]
    local procedure CreateSalesJournalLines(var GJLines: Record "Gen. Journal Line"; var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        InvAmt: Decimal;
    begin

        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := GJLines."Journal Template Name";
        GenJnlLine."Journal Batch Name" := GJLines."Journal Batch Name";
        GenJnlLine."Line No." := GJLines."Line No.";

        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

        GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
        GenJnlLine."Document No." := GenJournalLine."Document No.";
        GenJnlLine."Posting Date" := GenJournalLine."Posting Date";
        GenJnlLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJnlLine.VALIDATE("Account No.", GenJournalLine."Account No.");
        // Customer.GET(RecurringCharges."Customer No.");
        // GenJnlLine.Description := RecurringCharges."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(InvAmt, 0.01, '='));

        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::"Bank Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account"
        else
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";

        GenJnlLine.VALIDATE("Bal. Account No.", PaymentMethod."Bal. Account No.");
        GenJnlLine.Validate("Shortcut Dimension 1 Code", GenJournalLine."Shortcut Dimension 1 Code");
        GenJnlLine.Validate("Shortcut Dimension 2 Code", GenJournalLine."Shortcut Dimension 2 Code");
        GenJnlLine.Validate("Applies-to Doc. Type", GenJournalLine."Applies-to Doc. Type"::Invoice);
        GenJnlLine.Validate("Applies-to Doc. No.", GenJournalLine."Document No.");
        GenJnlLine."Source Code" := GenJournalLine."Source Code";
        GenJnlLine."Reason Code" := GenJournalLine."Reason Code";

        InvAmt := GenJournalLine.Amount;
        GenJnlLine.VALIDATE(Amount, -InvAmt);
        GenJnlLine.Validate("Charge Payment Type", GenJournalLine."Charge Payment Type"); //22 Jan
        GenJnlLine.Validate("Payment Method Code", GenJournalLine."Payment Method Code");
        //GenJnlLine.Validate(License, RecurringCharges.Licensee);
        GenJnlLine.Validate("Agreement ID", GenJournalLine."Agreement ID");
        GenJnlLine.Validate("AutoCharge ID", GenJournalLine."AutoCharge ID");
        GenJnlLine.Insert(true);
    end;

    local procedure InsertGenJnlRefundEntryAfterCreditMemoInsertion(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
    begin
        if GenJournalLine."Document Type" <> GenJournalLine."Document Type"::"Credit Memo" then
            exit;
        if GenJournalLine."Journal Template Name" = '' then
            exit;
        if GenJournalLine."Journal Batch Name" = '' then
            exit;
        PaymentMethod.Get(GenJournalLine."Payment Method Code");
        if PaymentMethod."Bal. Account No." = '' then
            exit;
        LineNo := 0;
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        IF GenJnlLine.FindLast() then
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000
        else
            GenJnlLine."Line No." := 10000;
        GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");

        CreateRefundSalesJournalLines(GenJnlLine, GenJournalLine);

    end;

    [TryFunction]
    local procedure CreateRefundSalesJournalLines(var GJLines: Record "Gen. Journal Line"; var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        InvAmt: Decimal;
    begin

        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := GJLines."Journal Template Name";
        GenJnlLine."Journal Batch Name" := GJLines."Journal Batch Name";
        GenJnlLine."Line No." := GJLines."Line No.";

        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;

        GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
        GenJnlLine."Document No." := GenJournalLine."Document No.";
        GenJnlLine."Posting Date" := GenJournalLine."Posting Date";
        GenJnlLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJnlLine.VALIDATE("Account No.", GenJournalLine."Account No.");
        // Customer.GET(RecurringCharges."Customer No.");
        // GenJnlLine.Description := RecurringCharges."Auto Charge Type" + ' ' + AmtLbl + ' ' + Format(Round(InvAmt, 0.01, '='));

        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::"Bank Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account"
        else
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";

        GenJnlLine.VALIDATE("Bal. Account No.", PaymentMethod."Bal. Account No.");
        GenJnlLine.Validate("Shortcut Dimension 1 Code", GenJournalLine."Shortcut Dimension 1 Code");
        GenJnlLine.Validate("Shortcut Dimension 2 Code", GenJournalLine."Shortcut Dimension 2 Code");
        GenJnlLine.Validate("Applies-to Doc. Type", GenJournalLine."Applies-to Doc. Type"::"Credit Memo");
        GenJnlLine.Validate("Applies-to Doc. No.", GenJournalLine."Document No.");
        GenJnlLine."Source Code" := GenJournalLine."Source Code";
        GenJnlLine."Reason Code" := GenJournalLine."Reason Code";

        InvAmt := GenJournalLine.Amount;
        GenJnlLine.VALIDATE(Amount, InvAmt);
        GenJnlLine.Validate("Charge Payment Type", GenJournalLine."Charge Payment Type"); //22 Jan
        GenJnlLine.Validate("Payment Method Code", GenJournalLine."Payment Method Code");
        //GenJnlLine.Validate(License, RecurringCharges.Licensee);
        GenJnlLine.Validate("Agreement ID", GenJournalLine."Agreement ID");
        GenJnlLine.Validate("AutoCharge ID", GenJournalLine."AutoCharge ID");
        GenJnlLine.Insert(true);
    end;

    procedure UpdateCustomerCodeOnAgreement(Agreements_iRec: Record Agreements)
    var
        MODAgreement: Record Agreements;
        cust: Record Customer;
    begin
        cust.Reset();
        cust.SetRange("CRM Agreement ID", Agreements_iRec."Agreement ID");
        if cust.FindFirst() then begin
            MODAgreement.Reset();
            MODAgreement.Get(cust."CRM Agreement ID");
            MODAgreement.Validate("Customer Code", cust."No.");
            MODAgreement.Modify(true);
        end;
    end;

    procedure CreateCustomerOnAgreementInsert(var Rec: Record Agreements): Code[20]
    var
        Customer: Record Customer;
        ModCustomer: Record Customer;
        SalonSetup: Record "Salon Republic Setup";
        CustTemplate: Record "Customer Templ.";
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
        isHandled: Boolean;
    begin
        SalonSetup.Get();
        SalonSetup.TestField("Customer Template");
        Customer.Reset();
        Customer.SetRange("CRM Agreement ID", Rec."Agreement ID");
        if Customer.FindFirst() then
            exit;
        CustTemplate.Get(SalonSetup."Customer Template");
        CustomerTemplMgt.CreateCustomerFromTemplate(Customer, isHandled, CustTemplate.Code);
        ModCustomer.get(Customer."No.");
        ModCustomer.validate(Name, CopyStr(Rec.sr_name, 1, 100));
        ModCustomer.Validate("Search Name", CopyStr(Rec.sr_name, 1, 100));
        ModCustomer."CRM Agreement ID" := Rec."Agreement ID";
        ModCustomer.Validate("Current Rent Rate", Rec."Current Rent Rate");
        ModCustomer.Modify(true);
        exit(ModCustomer."No.");
    end;


    local procedure UpdateStaggeredEndDateAndCreateRecurringCharges(var agreement_iRec: Record Agreements)
    var
        AgreementSchedule: Record "Agreement Schedule";
    begin
        if agreement_iRec."Current Agreement End Date" = 0D then
            exit;
        AgreementSchedule.Reset();
        AgreementSchedule.SetRange(sr_agreementid, agreement_iRec."Agreement ID");
        AgreementSchedule.SetRange("Staggered End Due Date", 0D);
        AgreementSchedule.SetRange(sr_IsLastRow, true);
        IF AgreementSchedule.FindFirst() then begin
            AgreementSchedule.Validate("Staggered End Due Date", agreement_iRec."Current Agreement End Date");
            AgreementSchedule.Modify();
            // Variant := AgreementSchedule;
            // if AgreementSchedule."Recurring Entry No." = 0 then
            //     RecurringMgmt.InsertRecurringLicenseFeeCharges(Variant);

        end;
    end;

    //SRBC-185 - START
    local procedure UpdateReciepientBankAccDuplicatePortal(var CLE_vRec: Record "Cust. Ledger Entry")
    var
        CustBankAcc: Record "Customer Bank Account";
    begin
        if CLE_vRec."Recipient Bank Account" = '' then begin
            CustBankAcc.Reset();
            CustBankAcc.SetRange("License ID", CLE_vRec.License);
            CustBankAcc.SetRange("Bank Account Info", CLE_vRec."Banking Account Info");
            //CustBankAcc.SetRange(IsCRM, TRUE);
            IF CustBankAcc.FindFirst() then begin
                CLE_vRec."Recipient Bank Account Portal" := CustBankAcc.Code;
            end;
        end;
    end;
    //SRBC-185 - END


    //SRBC-353
    [EventSubscriber(ObjectType::Table, Database::Studio, 'OnAfterInsertEvent', '', true, true)]
    local procedure T50007_OnAfterInsertEvent(var Rec: Record Studio; RunTrigger: Boolean)
    var
        SalonBuilding: Record "Salon Building";
        DimensionValue: Record "Dimension Value";
    begin
        // Fetch Salon Building Name
        SalonBuilding.Reset();
        SalonBuilding.SetRange(sr_CRMSalonPK, Rec.sr_building);
        if SalonBuilding.FindFirst() then begin
            // Fetch Dimension Value for 'LOC'
            DimensionValue.Reset();
            DimensionValue.SetRange("Dimension Code", 'LOC');
            DimensionValue.SetRange(Name, SalonBuilding.sr_Name);
            if DimensionValue.FindFirst() then begin
                Rec.Validate("BC Location Code", DimensionValue.Code);
                Rec.Validate("BC Studio Code", Rec."BC Location Code" + '-' + format(Rec.sr_studio_number));
                Rec.Modify();
            end;
        end;
    end;
    //SRBC-353
    //SRBC-393 - Start
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPrepareTempCustLedgEntryOnAfterSetFiltersByAppliesToId, '', false, false)]
    // local procedure "Gen. Jnl.-Post Line_OnPrepareTempCustLedgEntryOnAfterSetFiltersByAppliesToId"(var OldCustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    // begin
    //     // if (OldCustLedgerEntry."Charge Payment Type" in ['ADDITIONAL SECURITY DEPOSIT', 'CHAIR DEPOSIT', 'LICENSE FEE SECURITY DEPOSIT', 'PAINT DEPOSIT', 'PET DEPOSIT', 'STUDIO MODIFICATION DEPOSIT']) then
    //     //     IsHandled := true;
    //     if OldCustLedgerEntry.Findfirst() then begin
    //         if GenJournalLine."Document Type" = GenJournalLine."Document Type"::"Credit Memo" then
    //             if OldCustLedgerEntry."Document Type" = OldCustLedgerEntry."Document Type"::Invoice then begin
    //                 // OldCustLedgerEntry.SetFilter("Charge/Payment Type", '<>%1|<>%2|<>%3|<>%4|<>%5', 'ADDITIONAL SECURITY DEPOSIT', 'CHAIR DEPOSIT', 'LICENSE FEE SECURITY DEPOSIT', 'PAINT DEPOSIT', 'PET DEPOSIT', 'STUDIO MODIFICATION DEPOSIT');
    //                 case OldCustLedgerEntry."Charge/Payment Type" of
    //                     'ADDITIONAL SECURITY DEPOSIT':
    //                         OldCustLedgerEntry.SetFilter("Charge/Payment Type", '<>%1', 'ADDITIONAL SECURITY DEPOSIT');
    //                     'CHAIR DEPOSIT':
    //                         OldCustLedgerEntry.SetFilter("Charge/Payment Type", '<>%1', 'CHAIR DEPOSIT');
    //                     'LICENSE FEE SECURITY DEPOSIT':
    //                         OldCustLedgerEntry.SetFilter("Charge/Payment Type", '<>%1', 'LICENSE FEE SECURITY DEPOSIT');
    //                     'PAINT DEPOSIT':
    //                         OldCustLedgerEntry.SetFilter("Charge/Payment Type", '<>%1', 'PAINT DEPOSIT');
    //                     'PET DEPOSIT':
    //                         OldCustLedgerEntry.SetFilter("Charge/Payment Type", '<>%1', 'PET DEPOSIT');
    //                     'STUDIO MODIFICATION DEPOSIT':
    //                         OldCustLedgerEntry.SetFilter("Charge/Payment Type", '<>%1', 'STUDIO MODIFICATION DEPOSIT');
    //                 end;
    //             end;
    //         if (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice) and (GenJournalLine."Charge Payment Type" in ['ADDITIONAL SECURITY DEPOSIT', 'CHAIR DEPOSIT', 'LICENSE FEE SECURITY DEPOSIT', 'PAINT DEPOSIT', 'PET DEPOSIT', 'STUDIO MODIFICATION DEPOSIT']) then
    //             OldCustLedgerEntry.SetFilter("Document Type", '<>%1', OldCustLedgerEntry."Document Type"::"Credit Memo");
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePrepareTempCustledgEntry, '', false, false)]
    // local procedure "Gen. Jnl.-Post Line_OnBeforePrepareTempCustledgEntry"(var GenJnlLine: Record "Gen. Journal Line"; var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; Customer: Record Customer; var ApplyingDate: Date; var Result: Boolean; var IsHandled: Boolean; var TempOldCustLedgEntry: Record "Cust. Ledger Entry" temporary)
    // var
    //     OldCustLedgEntry: Record "Cust. Ledger Entry";
    //     SalesSetup: Record "Sales & Receivables Setup";
    //     GenJnlApply: Codeunit "Gen. Jnl.-Apply";
    //     RemainingAmount: Decimal;
    //     PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
    //     OldAndNewInvoice: Boolean;
    // begin
    //     isHandled := true;
    //     if GenJnlLine."Applies-to Doc. No." <> '' then begin
    //         // Find the entry to be applied to
    //         OldCustLedgEntry.Reset();
    //         OldCustLedgEntry.SetLoadFields(Positive, "Posting Date", "Currency Code");
    //         OldCustLedgEntry.SetCurrentKey("Document No.");
    //         OldCustLedgEntry.SetRange("Document No.", GenJnlLine."Applies-to Doc. No.");
    //         OldCustLedgEntry.SetRange("Document Type", GenJnlLine."Applies-to Doc. Type");
    //         OldCustLedgEntry.SetRange("Customer No.", CVLedgerEntryBuffer."CV No.");
    //         OldCustLedgEntry.SetRange(Open, true);
    //         // OnPrepareTempCustLedgEntryOnAfterSetFilters(OldCustLedgEntry, GenJnlLine, CVLedgerEntryBuffer, NextEntryNo);
    //         OldCustLedgEntry.FindFirst();
    //         // OnPrepareTempCustLedgEntryOnBeforeTestPositive(GenJnlLine, IsHandled);
    //         if not IsHandled then
    //             if not ((GenJnlLine.Amount < 0) and
    //                     (GenJnlLine."Document Type" = GenJnlLine."Document Type"::" ") and
    //                     (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) and
    //                     (GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Finance Charge Memo") and
    //                     (GenJnlLine."Applies-to Doc. No." <> '')) then
    //                 OldCustLedgEntry.TestField(Positive, not CVLedgerEntryBuffer.Positive);

    //         if OldCustLedgEntry."Posting Date" > ApplyingDate then
    //             ApplyingDate := OldCustLedgEntry."Posting Date";
    //         // OnPrepareTempCustLedgEntryOnBeforeCheckAgainstApplnCurrencyWithAppliesToDocNo(GenJnlLine, CVLedgerEntryBuffer, OldCustLedgEntry);
    //         GenJnlApply.CheckAgainstApplnCurrency(
    //           CVLedgerEntryBuffer."Currency Code", OldCustLedgEntry."Currency Code", GenJnlLine."Account Type"::Customer, true);
    //         TempOldCustLedgEntry := OldCustLedgEntry;
    //         // OnPrepareTempCustLedgEntryOnBeforeTempOldCustLedgEntryInsert(TempOldCustLedgEntry, GenJnlLine);
    //         TempOldCustLedgEntry.Insert();
    //     end else begin
    //         // Find the first old entry (Invoice) which the new entry (Payment) should apply to
    //         OldCustLedgEntry.Reset();
    //         OldCustLedgEntry.SetLoadFields("Posting Date", "Currency Code", "Applies-to ID");
    //         OldCustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
    //         TempOldCustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
    //         OldCustLedgEntry.SetRange("Customer No.", CVLedgerEntryBuffer."CV No.");
    //         OldCustLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
    //         OldCustLedgEntry.SetRange(Open, true);
    //         OldCustLedgEntry.SetFilter("Entry No.", '<>%1', CVLedgerEntryBuffer."Entry No.");
    //         if not (Customer."Application Method" = Customer."Application Method"::"Apply to Oldest") then
    //             OldCustLedgEntry.SetFilter("Amount to Apply", '<>%1', 0);

    //         if Customer."Application Method" = Customer."Application Method"::"Apply to Oldest" then
    //             OldCustLedgEntry.SetFilter("Posting Date", '..%1', GenJnlLine."Posting Date");

    //         // Check Cust Ledger Entry and add to Temp.
    //         SalesSetup.Get();
    //         if SalesSetup."Appln. between Currencies" = SalesSetup."Appln. between Currencies"::None then
    //             OldCustLedgEntry.SetRange("Currency Code", CVLedgerEntryBuffer."Currency Code");
    //         // OnPrepareTempCustLedgEntryOnAfterSetFiltersByAppliesToId(OldCustLedgEntry, GenJnlLine, CVLedgerEntryBuffer, Cust);
    //         if OldCustLedgEntry.FindSet(false) then
    //             repeat
    //                 Clear(OldAndNewInvoice);
    //                 // OnPrepareTempCustLedgEntryOnBeforeCheckAgainstApplnCurrency(GenJnlLine, CVLedgerEntryBuffer, OldCustLedgEntry);
    //                 if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) then begin
    //                     if (GenJnlLine."Charge Payment Type" in ['ADDITIONAL SECURITY DEPOSIT', 'CHAIR DEPOSIT', 'LICENSE FEE SECURITY DEPOSIT', 'PAINT DEPOSIT', 'PET DEPOSIT', 'STUDIO MODIFICATION DEPOSIT']) then begin
    //                         if (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::"Credit Memo") or (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Invoice) then
    //                             // exit;
    //                             OldAndNewInvoice := true;
    //                     end
    //                     else if (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Invoice) and not (OldCustLedgEntry."Charge/Payment Type" in ['ADDITIONAL SECURITY DEPOSIT', 'CHAIR DEPOSIT', 'LICENSE FEE SECURITY DEPOSIT', 'PAINT DEPOSIT', 'PET DEPOSIT', 'STUDIO MODIFICATION DEPOSIT']) then begin
    //                         OldAndNewInvoice := true;
    //                     end;
    //                 end;
    //                 if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo") and (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Invoice) then begin
    //                     if (OldCustLedgEntry."Charge/Payment Type" in ['ADDITIONAL SECURITY DEPOSIT', 'CHAIR DEPOSIT', 'LICENSE FEE SECURITY DEPOSIT', 'PAINT DEPOSIT', 'PET DEPOSIT', 'STUDIO MODIFICATION DEPOSIT']) then
    //                         OldAndNewInvoice := true;
    //                 end;

    //                 if not OldAndNewInvoice then begin
    //                     if GenJnlApply.CheckAgainstApplnCurrency(
    //              CVLedgerEntryBuffer."Currency Code", OldCustLedgEntry."Currency Code", GenJnlLine."Account Type"::Customer, false) then begin
    //                         if (OldCustLedgEntry."Posting Date" > ApplyingDate) and (OldCustLedgEntry."Applies-to ID" <> '') then
    //                             ApplyingDate := OldCustLedgEntry."Posting Date";
    //                         TempOldCustLedgEntry := OldCustLedgEntry;
    //                         // OnPrepareTempCustLedgEntryOnBeforeTempOldCustLedgEntryInsert(TempOldCustLedgEntry, GenJnlLine);
    //                         TempOldCustLedgEntry.Insert();
    //                     end;
    //                 end;
    //             until OldCustLedgEntry.Next() = 0;

    //         TempOldCustLedgEntry.SetRange(Positive, CVLedgerEntryBuffer."Remaining Amount" > 0);

    //         if TempOldCustLedgEntry.Find('-') then begin
    //             RemainingAmount := CVLedgerEntryBuffer."Remaining Amount";
    //             TempOldCustLedgEntry.SetRange(Positive);
    //             TempOldCustLedgEntry.Find('-');
    //             repeat
    //                 // if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) then begin
    //                 //     if (GenJnlLine.Custom2 in ['TEST', 'TEST2']) then begin
    //                 //         if OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::"Credit Memo" then
    //                 //             exit;
    //                 //     end;
    //                 //     // else if (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Invoice) then
    //                 //     //     exit;
    //                 // end;
    //                 TempOldCustLedgEntry.CalcFields("Remaining Amount");
    //                 TempOldCustLedgEntry.RecalculateAmounts(
    //                   TempOldCustLedgEntry."Currency Code", CVLedgerEntryBuffer."Currency Code", CVLedgerEntryBuffer."Posting Date");
    //                 if PaymentToleranceMgt.CheckCalcPmtDiscCVCust(CVLedgerEntryBuffer, TempOldCustLedgEntry, 0, false, false) then
    //                     TempOldCustLedgEntry."Remaining Amount" -= TempOldCustLedgEntry.GetRemainingPmtDiscPossible(CVLedgerEntryBuffer."Posting Date");
    //                 RemainingAmount += TempOldCustLedgEntry."Remaining Amount";
    //             until TempOldCustLedgEntry.Next() = 0;
    //             TempOldCustLedgEntry.SetRange(Positive, RemainingAmount < 0);
    //         end else
    //             TempOldCustLedgEntry.SetRange(Positive);

    //         // OnPrepareTempCustLedgEntryOnBeforeExit(GenJnlLine, CVLedgerEntryBuffer, TempOldCustLedgEntry);
    //         // exit(TempOldCustLedgEntry.Find('-'));
    //         Result := TempOldCustLedgEntry.Find('-');
    //         exit;  //Added extra line of code 13082025
    //     end;
    //     // exit(true);
    //     Result := true;
    // end;
    //SRBC-393 - End

    // Start -->PS_16102026
    //SRBC-416 - Start
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseCustLedgEntryOnBeforeModifyCustLedgerEntry, '', false, false)]
    // local procedure "Gen. Jnl.-Post Reverse_OnReverseCustLedgEntryOnBeforeModifyCustLedgerEntry"(NewCustLedgerEntry: Record "Cust. Ledger Entry"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    // var
    //     EditDeleteTransactionQueue: Record "Edit Delete Transactions Queue";//SRBC-480
    //     SICU: Codeunit "Single Instance Mgt.";//SRBC-480
    // begin
    //     if (CustLedgerEntry.Reversed) then begin
    //         CustLedgerEntry.CalcFields("Original Amount");
    //         CustLedgerEntry."Amount Paid" := (CustLedgerEntry."Original Amount");
    //         CustLedgerEntry.Validate("Amount Deposited", CustLedgerEntry."Amount Paid");
    //     end;
    //     //SRBC-480 Start
    //     if SICU.CheckUpdateOriginalOrReversalCLE() then begin
    //         EditDeleteTransactionQueue.Reset();
    //         EditDeleteTransactionQueue.SetRange("CLE Entry No.", CustLedgerEntry."Entry No.");
    //         EditDeleteTransactionQueue.SetRange(Exclude, false);
    //         if EditDeleteTransactionQueue.FindFirst() then begin
    //             if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo" then begin
    //                 if EditDeleteTransactionQueue."Edit Transaction" then
    //                     CustLedgerEntry."Edit Discount" := true;
    //                 if EditDeleteTransactionQueue."Delete Transaction" then
    //                     CustLedgerEntry."Delete Discount" := true;
    //             end;
    //             if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment then begin
    //                 if EditDeleteTransactionQueue."Edit Transaction" then
    //                     CustLedgerEntry."Edit Payment" := true;
    //                 if EditDeleteTransactionQueue."Delete Transaction" then
    //                     CustLedgerEntry."Delete Payment" := true;
    //             end;
    //             if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice then begin
    //                 if EditDeleteTransactionQueue."Edit Transaction" then
    //                     CustLedgerEntry."Edit Charge" := true;
    //                 if EditDeleteTransactionQueue."Delete Transaction" then
    //                     CustLedgerEntry."Delete Charge" := true;
    //             end;
    //             if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Refund then begin
    //                 if EditDeleteTransactionQueue."Edit Transaction" then
    //                     CustLedgerEntry."Edit Payment" := true;
    //                 if EditDeleteTransactionQueue."Delete Transaction" then
    //                     CustLedgerEntry."Delete Payment" := true;
    //             end;
    //             CustLedgerEntry.Validate("Transaction Type", CustLedgerEntry."Transaction Type"::Adjustment);
    //             CustLedgerEntry.Validate("Payment Status", CustLedgerEntry."Payment Status"::Adjustment);
    //             CustLedgerEntry.Validate(Status, CustLedgerEntry.Status::Processed);
    //             CustLedgerEntry.Validate("Processing Status", CustLedgerEntry."Processing Status"::Processed);
    //         end;
    //     end;
    //     //SRBC-480 End
    // end;
    // <-- End

    // Start -->PS_16102026
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry, '', false, false)]
    // local procedure "Gen. Jnl.-Post Reverse_OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry"(var NewCustLedgerEntry: Record "Cust. Ledger Entry"; CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    // var
    //     CLE: Record "Cust. Ledger Entry";
    //     EditDeleteTransactionQueue: Record "Edit Delete Transactions Queue";//SRBC-480 
    //     SICU: Codeunit "Single Instance Mgt.";//SRBC-480
    //     CustLedEnty: Record "Cust. Ledger Entry";//SRBC-480
    //     FrequencyMappingSetup: Record "Frequency Mapping Setup";//SRBC-352 20052026
    // begin
    //     //SRBC-352 20052026 Start
    //     if CLE.Get(NewCustLedgerEntry."Reversed Entry No.") then begin
    //         if CLE.Frequency = CLE.Frequency::" " then
    //             if FrequencyMappingSetup.Get(CLE."Journal Templ. Name", CLE."Journal Batch Name") then
    //                 NewCustLedgerEntry.Validate(Frequency, FrequencyMappingSetup.Frequency);
    //     end;
    //     //SRBC-352 20052026 End
    //     if (NewCustLedgerEntry.Reversed) then begin
    //         if CLE.Get(NewCustLedgerEntry."Reversed Entry No.") then begin
    //             CLE.CalcFields("Original Amount");
    //             if CLE."Original Amount" < 0 then
    //                 NewCustLedgerEntry."Amount Paid" := Abs(CLE."Original Amount")
    //             else
    //                 NewCustLedgerEntry."Amount Paid" := -CLE."Original Amount";
    //             NewCustLedgerEntry.Validate("Amount Deposited", NewCustLedgerEntry."Amount Paid");
    //         end;
    //     end;
    //     //SRBC-480 Start
    //     if SICU.CheckUpdateOriginalOrReversalCLE() then begin
    //         if CustLedEnty.Get(NewCustLedgerEntry."Reversed Entry No.") then begin
    //             EditDeleteTransactionQueue.Reset();
    //             EditDeleteTransactionQueue.SetRange("CLE Entry No.", CustLedEnty."Entry No.");
    //             EditDeleteTransactionQueue.SetRange(Exclude, false);
    //             if EditDeleteTransactionQueue.FindFirst() then begin
    //                 if NewCustLedgerEntry."Document Type" = NewCustLedgerEntry."Document Type"::"Credit Memo" then begin
    //                     if EditDeleteTransactionQueue."Edit Transaction" then
    //                         NewCustLedgerEntry."Edit Discount" := true;
    //                     if EditDeleteTransactionQueue."Delete Transaction" then
    //                         NewCustLedgerEntry."Delete Discount" := true;
    //                 end;
    //                 if NewCustLedgerEntry."Document Type" = NewCustLedgerEntry."Document Type"::Payment then begin
    //                     if EditDeleteTransactionQueue."Edit Transaction" then
    //                         NewCustLedgerEntry."Edit Payment" := true;
    //                     if EditDeleteTransactionQueue."Delete Transaction" then
    //                         NewCustLedgerEntry."Delete Payment" := true;
    //                 end;
    //                 if NewCustLedgerEntry."Document Type" = NewCustLedgerEntry."Document Type"::Invoice then begin
    //                     if EditDeleteTransactionQueue."Edit Transaction" then
    //                         NewCustLedgerEntry."Edit Charge" := true;
    //                     if EditDeleteTransactionQueue."Delete Transaction" then
    //                         NewCustLedgerEntry."Delete Charge" := true;
    //                 end;
    //                 //SRBC-480 AM 13042026 Start
    //                 if NewCustLedgerEntry."Document Type" = NewCustLedgerEntry."Document Type"::Refund then begin
    //                     if EditDeleteTransactionQueue."Edit Transaction" then
    //                         NewCustLedgerEntry."Edit Charge" := true;
    //                     if EditDeleteTransactionQueue."Delete Transaction" then
    //                         NewCustLedgerEntry."Delete Charge" := true;
    //                 end;
    //                 //SRBC-480 AM 13042026 End
    //                 NewCustLedgerEntry.Validate("Transaction Type", NewCustLedgerEntry."Transaction Type"::Adjustment);
    //                 NewCustLedgerEntry.Validate("Payment Status", NewCustLedgerEntry."Payment Status"::Adjustment);
    //                 NewCustLedgerEntry.Validate(Status, NewCustLedgerEntry.Status::Processed);
    //                 NewCustLedgerEntry.Validate("Processing Status", NewCustLedgerEntry."Processing Status"::Processed);
    //             end;
    //         end;
    //     end;
    //     //SRBC-480 End
    // end;
    // //SRBC-416 End
    // <-- End

    //SRBC-352 Start 28042026

    // Start -->PS_16102026
    // [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnBeforeInsertEvent, '', false, false)]
    // local procedure "Gen. Journal Line_OnBeforeInsertEvent"(var Rec: Record "Gen. Journal Line")
    // var
    //     CustLedgerEntryStatusHander: Codeunit CustLedgerEntryStatusHandler;
    // begin
    //     CustLedgerEntryStatusHander.UpdateFreqOnJournalOnBeforeInsert(Rec);
    // end;
    //SRBC-352 End 28042026
    // <-- End

    var
        JsonString: Text;
        JsonArray: JsonArray;
        JsonObject: JsonObject;
        JsonTokenType: JsonToken;
        JsonTokenValue: JsonToken;
        GenJnlBatch: Record "Gen. Journal Batch";
        PaymentMethod: Record "Payment Method";
        MarkGenJnlLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        AutoTriggerReverseEntry_gBln: Boolean;
    // CustLedgStatusHandler_gCU: Codeunit CustLedgerEntryStatusHandler; //SRBC-480 //PS_16102026 not used any where

}
