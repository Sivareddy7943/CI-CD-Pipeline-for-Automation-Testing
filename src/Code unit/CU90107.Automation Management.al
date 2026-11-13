//SRBC-279 - 20250131 - NU - Need Capabilities to Send Failure Email Notification
//SRBC-280 - SY - 30012025 - Created Codeunit for fail safe batch process
//                        - SendBactchErrorInTabularFormat.     
//SRBC-323 - SY - 12032025 - Did changes in JobQueueAlertEmail for email of Job Que failure - 54000
//SRBC-345 - SY - 23042025 - Commented procedure - SendStripeMandateEmail for change email format and 
//                         - Created procedure - AddEmailHeaderLine, SendStripeMandateEmail, AddEmailBodyForStripeInvoiceFailure  
//SRBC-448 - NT&LB - 10112025/14112025  - modified code in OnAfterModifyEvent of job queue entry table to run the power automate flow only after the successful run of EditDeleteTransaction procedure of codeunit 50120
codeunit 90107 "Automation Management"
{
    // Start -->PS_16102026
    // [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnAfterModifyEvent', '', false, false)]
    // local procedure OnAfterModifyEvent(var Rec: Record "Job Queue Entry")
    // var
    //     SRSETUP: Record "Salon Republic Setup";
    //     JQLogEntry: Record "Job Queue Log Entry";
    //     EditDeleteQueue: Record "Edit Delete Transactions Queue";
    //     PowerAutomateFlowCU: Codeunit "Power Automate Flow";
    //     APILogDetails: Record "API Log Details";
    // begin
    //     if (Rec.Status = Rec.Status::Error) AND (Rec."Object Type to Run" = Rec."Object Type to Run"::Codeunit) then begin
    //         if (Rec."Object ID to Run" = 54000) then begin
    //             JobQueueAlertEmail(Rec);

    //             SRSETUP.Reset();
    //             SRSETUP.Get();
    //             if SRSETUP."Activate Job Queue Restarter" then
    //                 Rec.Restart();
    //         end;
    //     end;
    //     //SRBC-448 - Start
    //     if (Rec.Status = Rec.Status::Finished) and (Rec."Object ID to Run" = Codeunit::PriorityJournalPosting) then begin
    //         if SRSETUP.Get() and SRSETUP."Run PowerAutomate Flow" then begin
    //             EditDeleteQueue.Reset();
    //             EditDeleteQueue.SetRange(Unapplied, true);
    //             EditDeleteQueue.SetRange(Reverse, true);
    //             if EditDeleteQueue.FindSet() then
    //                 repeat
    //                     APILogDetails.Reset();
    //                     APILogDetails.SetRange("CLE Entry No.", EditDeleteQueue."CLE Entry No.");
    //                     if not APILogDetails.FindFirst() then
    //                         PowerAutomateFlowCU.PowerAutomateFlow(EditDeleteQueue."CLE Entry No.");
    //                 until EditDeleteQueue.Next() = 0;
    //         end;
    //     end;
    //     //SRBC-448 - End
    // end;
    // //SRBC-323 Start
    // procedure JobQueueAlertEmail(var JobQueue_iRec: Record "Job Queue Entry")
    // var
    //     Email: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    //     Body: Text;
    //     Receipent: List of [Text];
    //     EmailScenario: Enum "Email Scenario";
    //     envoirmentinfor: Codeunit "Environment Information";
    //     JobQueEntries: Record "Job Queue Entry";
    //     SR_Setup: Record "Salon Republic Setup";
    // begin
    //     SR_Setup.Get();
    //     JobQueEntries.SetRange(ID, JobQueue_iRec.ID);
    //     if JobQueEntries.FindFirst() then begin
    //         // Receipent.Add('coreops_notification_svc@salonrepublic.com');
    //         // Receipent.Add('Chintan.Panchal@Gtrtek.com');
    //         // Receipent.Add('Nishant.upadhyay@Gtrtek.com');
    //         // Receipent.Add('jeyanth.sg@gtrtek.com');
    //         // Receipent.Add('harsh.panchal@gtrtek.com');

    //         Body := '<p class = "editor-paragraph" > Hi Team,</p >';
    //         Body += '</br>';
    //         // Body += '</br>';
    //         Body += '<p class = "editor-paragraph" > Job Queue Id : ' + Format(54000) + '</p >';
    //         Body += '<p class = "editor-paragraph" > Job Queue Name : ' + ('Job Queue Restarter') + '</p >';
    //         Body += '<p class = "editor-paragraph" > Database Name: ' + (envoirmentinfor.GetEnvironmentName()) + '</p >';
    //         Body += '<p class = "editor-paragraph" > Job Queue System Id : ' + (JobQueEntries.SystemId) + '</p >';
    //         Body += '</br>';
    //         // Body += '</br>';
    //         Body += '<p class = "editor-paragraph" > Job Queue 54000 - Job Queue Restarter is in Error State.' + '</p >';
    //         Body += '<p class = "editor-paragraph" > Kindly restart the job queue.' + '</p >';
    //         Body += '</br>';
    //         // Body += '</br>';
    //         body += '<p class = "editor-paragraph" > Regards' + '</p >';
    //         Body += '<p class = "editor-paragraph" >' + USERID + '</p >';
    //         EmailMessage.Create(SR_Setup."Job Queue Alert Recipients", 'Alert: ' + envoirmentinfor.GetEnvironmentName() + ' Job Queue 54000 Failed', '', TRUE);
    //         EmailMessage.AppendToBody(StrSubstNo(Body, UserId));
    //         Email.Send(EmailMessage);
    //     end;
    // end;
    // <-- End

    //SRBC-323 End

    //SRBC-279 - Start
    //SRBC-345 Start

    // procedure SendStripeMandateEmail(var CLE_iRec: Record "Cust. Ledger Entry") //SRBC-279
    // var
    //     Email: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    //     envoirmentinfor: Codeunit "Environment Information";
    //     SalonSetup: Record "Salon Republic Setup";
    // begin
    //     SalonSetup.Get();
    //     if SalonSetup."Send Alert Notification" then begin
    //         if SalonSetup."Alert Email Recipient" <> '' then begin
    //             EmailMessage.Create(SalonSetup."Alert Email Recipient", ' Stripe Payment Status Failed ', EmailMessage.GetBody(), true);
    //             EmailMessage.AppendToBody('Hi Team,' + '</br>');
    //             EmailMessage.AppendToBody('      Stripe Payment Failed for Below Record, Kindly Check' + '</br>');
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('BC Entry No : ' + Format(CLE_iRec."Entry No."));//
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('Customer Code : ' + (CLE_iRec."Customer No."));
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('Customer Name : ' + (CLE_iRec."Customer Name"));
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('Payment Failure Code : ' + (CLE_iRec."Payment Status Failure Code"));
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('Payment Failure Reason : ' + (CLE_iRec."Payment Status Failure Reason"));
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('Database Name: ' + (envoirmentinfor.GetEnvironmentName()));
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('</br>');
    //             EmailMessage.AppendToBody('Regards' + '</br>');
    //             EmailMessage.AppendToBody(USERID);
    //             Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    //             CLE_iRec."Email Sent" := true;
    //             CLE_iRec.modify;
    //         end;
    //     end;
    // end;
    //SRBC-345 End
    //SRBC-279 - End


    //SRBC-280 START
    procedure SendBactchErrorInTabularFormat(var GJLINE: Record "Gen. Journal Line") EmailBody: Text
    var
        TempEmailItem: Record "Email Item";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Receipent: List of [Text];
        EmailScenario: Enum "Email Scenario";
        SRSETUP: Record "Salon Republic Setup";
    begin
        SRSETUP.Get();
        AddEmailHeaderLine(GJLINE, EmailBody);
        AddEmailBodyLines(GJLINE, EmailBody);
        AddEmailFooterLines(GJLINE, EmailBody);
        EmailMessage.Create(SRSETUP."Batch Alert Receipients", 'Alert: Journal Posting Failed  ' + ' - ' + GJLINE."Journal Batch Name", EmailMessage.GetBody(), TRUE);
        EmailMessage.AppendToBody(StrSubstNo(EmailBody, UserId));
        Email.Send(EmailMessage);
    end;

    local procedure AddEmailHeaderLine(var GJLINE: Record "Gen. Journal Line"; var EmailBody: Text)
    var
        myInt: Integer;
    begin
        EmailBody := 'Dear User<b>' + '<b>,</br></br>';
    end;

    local procedure AddEmailBodyLines(var GJLINE: Record "Gen. Journal Line"; var EmailBody: Text)
    var
        GJLINE_lRec: Record "Gen. Journal Line";
        SrNo_lInt: Integer;
        envoirmentinfor: Codeunit "Environment Information";
        Cust: Record Customer;
    begin
        SrNo_lInt := 0;
        GJLINE_lRec.SetRange("Journal Template Name", GJLINE."Journal Template Name");
        GJLINE_lRec.SetRange("Journal Batch Name", GJLINE."Journal Batch Name");
        if GJLINE_lRec.FindSet() then begin
            EmailBody += '<table border ="1">';
            EmailBody += '<tr>';
            EmailBody += '<th> Sr No. </th>';
            EmailBody += '<th> Doc No. </th>';
            EmailBody += '<th> Line No. </th>';
            EmailBody += '<th> Customer Name </th>';
            EmailBody += '<th> Description </th>';
            EmailBody += '<th> Error Message</th>';
            EmailBody += '<th> Database Name</th>';
            EmailBody += '</tr>';
            repeat
                SrNo_lInt += 1;
                EmailBody += '<tr>';
                EmailBody += '<td>' + FORMAT(SrNo_lInt) + '</td>';
                EmailBody += '<td>' + FORMAT(GJLINE_lRec."Document No.") + '</td>';
                EmailBody += '<td>' + FORMAT(GJLINE_lRec."Line No.") + '</td>';
                if GJLINE_lRec."Account Type" = GJLINE_lRec."Account Type"::Customer then begin
                    Cust.Reset();
                    if Cust.get(GJLINE_lRec."Account No.") then;
                end;
                EmailBody += '<td>' + FORMAT(Cust.Name) + '</td>';
                EmailBody += '<td>' + FORMAT(GJLINE_lRec.Description) + '</td>';
                EmailBody += '<td>' + Format(GJLINE_lRec."Error Message") + '</td>';
                EmailBody += '<td>' + (envoirmentinfor.GetEnvironmentName()) + '</td>';
                EmailBody += '</tr>';
            until GJLINE_lRec.Next() = 0;
            EmailBody += '</table>';
            EmailBody += '</br>';
        end;
    end;

    local procedure AddEmailFooterLines(var GJLINE: Record "Gen. Journal Line"; var EmailBody: Text)
    var
        myInt: Integer;
    begin
        EmailBody += 'Regards' + '</br>';
        EmailBody += USERID;
    end;
    //SRBC-280 START

    //SRBC-345 Start
    local procedure AddEmailHeaderLine(var EmailBody: Text; SalonSetup: Record "Salon Republic Setup"; Subject: Text)
    var
        myInt: Integer;
    begin
        EmailBody += 'Hi Team<b>' + '<b>,</br></br>';
        // EmailBody += '<tr style="font-weight: normal;">';
        // EmailBody += '<tr>';
        // EmailBody += '<th> ' + 'Stripe Payment Failed for Below Record, Kindly Check' + ' </th>';
        // EmailBody += 'Please find the details about payment failure and take appropriate action' + '</br></br>';

        EmailBody += '<tr>';
        EmailBody += '<th> ' + '' + ' </th>';
        EmailBody += '</tr>';

        // EmailBody += '<tr>';
        // EmailBody += '<th> ' + 'Stripe Payment Failed for Below Record, Kindly Check' + ' </th>';
        // EmailBody += '</tr>';
    end;

    procedure SendStripeMandateEmail(var CLE_lRec: Record "Cust. Ledger Entry")
    var
        TempEmailItem: Record "Email Item";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Receipent: List of [Text];
        EmailScenario: Enum "Email Scenario";
        SRSETUP: Record "Salon Republic Setup";
        EmailBody: Text;
        Subject: Text;
    begin
        SRSETUP.Get();
        AddEmailHeaderLine(EmailBody, SRSETUP, Subject);
        AddEmailBodyForStripeInvoiceFailure(CLE_lRec, EmailBody);
        EmailMessage.Create(SRSETUP."Alert Email Recipient", ' Stripe Payment Status Failed ' + '', EmailMessage.GetBody(), TRUE);
        EmailMessage.AppendToBody(StrSubstNo(EmailBody, UserId));
        Email.Send(EmailMessage);
    end;

    local procedure AddEmailBodyForStripeInvoiceFailure(CLE: Record "Cust. Ledger Entry"; var EmailBody: Text)
    var
        envoirmentinfor: Codeunit "Environment Information";
        Cust: Record Customer;
        StrLength: Integer;
        Contacts: Record Contact;
    begin
        Contacts.Reset();
        Contacts.SetRange("CRM Contact ID", CLE.License);
        if Contacts.FindFirst() then;
        EmailBody += '<table border ="1" style="border-collapse: collapse;" >';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> BC Entry No.</th>';
        EmailBody += '<td style="font-weight: normal;">' + Format(CLE."Entry No.") + '</td>';
        EmailBody += '</tr>';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> Agreement Name</th>';
        EmailBody += '<td style="font-weight: normal;">' + CLE."Customer Name" + '</td>';
        EmailBody += '</tr>';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> Strip Customer ID</th>';
        EmailBody += '<td style="font-weight: normal;">' + Contacts."Stripe Customer ID" + '</td>';
        EmailBody += '</tr>';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> License ID</th>';
        EmailBody += '<td style="font-weight: normal;">' + CLE.License + '</td>';
        EmailBody += '</tr>';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> License Name</th>';
        EmailBody += '<td style="font-weight: normal;">' + Contacts.Name + '</td>';
        EmailBody += '</tr>';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> Payment Method#</th>';
        EmailBody += '<td style="font-weight: normal;">' + CLE."Payment Method Code" + '</td>';
        EmailBody += '</tr>';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> Payment Failure Code</th>';
        EmailBody += '<td style="white-space: nowrap; font-weight: normal;">' + CLE."Payment Status Failure Code" + '</td>';
        EmailBody += '</tr>';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> Payment Failure Reason</th>';
        EmailBody += '<td style="white-space: nowrap; font-weight: normal;">' + CLE."Payment Status Failure Reason" + '</td>';
        EmailBody += '</tr>';
        EmailBody += '<tr>';
        EmailBody += '<th style="text-align: left;"> Environment</th>';
        EmailBody += '<td style="font-weight: normal;">' + envoirmentinfor.GetEnvironmentName() + '</td>';
        EmailBody += '</tr>';
        EmailBody += '</table>';
        EmailBody += '</br>';
        // EmailBody += '<table border ="1" style="border-collapse: collapse;" >';
        // EmailBody += '<tr>';
        // EmailBody += '<th style="text-align: left;"> BC Entry No.</th>';
        // EmailBody += '<td style="font-weight: normal;">' + Format(CLE."Entry No.") + '</td>';
        // EmailBody += '</tr>';
        // EmailBody += '<tr>';
        // EmailBody += '<th style="text-align: left;"> Agreement Name</th>';
        // EmailBody += '<td style="font-weight: normal;">' + CLE."Customer Name" + '</td>';
        // EmailBody += '</tr>';
        // EmailBody += '<tr>';
        // EmailBody += '<th style="text-align: left;"> Payment Failure Code</th>';
        // EmailBody += '<td style="white-space: nowrap; font-weight: normal;">' + CLE."Payment Status Failure Code" + '</td>';
        // EmailBody += '</tr>';
        // EmailBody += '<tr>';
        // EmailBody += '<th style="text-align: left;"> Payment Failure Reason</th>';
        // EmailBody += '<td style="white-space: nowrap; font-weight: normal;">' + CLE."Payment Status Failure Reason" + '</td>';
        // EmailBody += '</tr>';
        // EmailBody += '<tr>';
        // EmailBody += '<th style="text-align: left;"> Environment</th>';
        // EmailBody += '<td style="font-weight: normal;">' + envoirmentinfor.GetEnvironmentName() + '</td>';
        // EmailBody += '</tr>';
        // EmailBody += '</table>';
        // EmailBody += '</br>';
        CLE."Email Sent" := true;
        CLE.modify;
    end;
    //SRBC-345 End
}
