//SRBC-185 - 20241126 - One Time Payment Method Changes - Portal.
//                    - Created new Field ID 119,120,121
//SRBC-279 - 02022025 - SY - Added field "Send Alert Notification" for Enable/Disable Stripe failure email functionality
//                         - Field "Alert Email Recipient" for send email too
//SRBC-323 - SY - 12032025 - Added field "Job Queue Alert Recipients" for add email to sent
//SRBC-326 - SY - 22032025 - Added boolean field "Create Customer from Agreement", if this boolean field will be  true then after create agreements we can create customer in BC.
//SRBC-356 - AR - 29042025 - Created new Field ID 512("Return Fee - Bank Account"),513("Return Fee Amount - Bank Account"),514("Return Fee - Card"),515("Return Fee Amount - Card")
//         - SY - 11062025 - Added field "Return Fee -Check"
//SRBC-352 - SY - 13062025 - Added field "Update Late Fee - In Customer"
//SRBC-376 - SY - 23062025 - Added field "Auto Post New Charge", "New Charge Template", "New Charge Batch"
//SRBC-378 - SY - 26062025 - Added field "Post Edit Delete Transaction" for post Journals and "No. of attempts" field.
//SRBC-384 - AM - 18072025 - Added field "Schedule Charge Template", "Schedule Charge Batch", "Schedule Payment Template", "Schedule Payment Batch" to created journal from Edit delete Trans Table
//SRBC-436 - AM - 30092025 - Created new fields - "Auto Post New Discount", "New Discount Template", "New Discount Batch"
//SRBC-438 - AM - 27102025 - Created new fields - "Vendor Invoice Template" and Vendor Invoice Batch 
//SRBC-448 - NT&LB - 07112025 - Added a group "Power Automate Flow" and added fields in the group "Power Automate Flow".
//SRBC-457 JSG  Added new field Auto Calculate Running Balance
//SRBC-461 - AM - 12122025 - Added a new field Check Refund. 
//SRBC-455 - LB&NT - 19012026 - Added Post Refund Transaction Boolean.
//SRBC-479 - SY - 20022026 Added field "Create Charge/Payemnt Journal" 
//SRBC-481 - SY - 25022026 - Added field-"No. of attempts"
//SRBC-352 - SY - 19052026 - Added field - "Charge Payment Payload" for Insert Charge/Payment in "Charge Payment Payload List" or "Edit Delete Transaction Queue List" 
//SRBC-473 - SY - 16062026 - Added field - "Payment Plan"
//SRBC-538 - NU - 01102026 - Created field - "Notify CRM After Bulk Posting" to check before notifying CRM After Bulk posting
page 90104 "Salon Republic Setup"
{
    ApplicationArea = All;
    Caption = 'Salon Republic Setup';
    PageType = Card;
    SourceTable = "Salon Republic Setup";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Activate Job Queue Restarter"; Rec."Activate Job Queue Restarter")
                {
                    ToolTip = 'Specifies the value of the Activate Job Queue Restarter field.';
                }
                //SRBC-326 Start
                field("Create Customer from Agreement"; Rec."Create Customer from Agreement")
                {
                    ToolTip = 'Specifies the value of the Create Customer from Agreement field.', Comment = '%';
                }
                //SRBC-326 End
                field("Create Epay From Bank Info"; Rec."Create Epay From Bank Info")
                {
                    ToolTip = 'Specifies the value of the Create Epay From Bank Info field.';
                }
                //SRBC-457 JSG Start 12112025
                field("Auto Calculate Running Balance"; Rec."Auto Calculate Running Balance")
                {
                    ToolTip = 'Specifies the value of the Auto Calculate Running Balance field.';
                }
                //SRBC-457 JSG End 12112025
                field("Rent Charge Template"; Rec."Rent Charge Template")
                {
                    ToolTip = 'Specifies the value of the Rent Charge Template field.';
                }
                field("Rent Charge Batch"; Rec."Rent Charge Batch")
                {
                    ToolTip = 'Specifies the value of the Rent Charge Batch field.';
                }
                field("Auto Create Recurring Charge"; Rec."Auto Create Recurring Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Create Recurring Charge field.';
                }
                field("Auto Post Recurring Charge"; Rec."Auto Post Recurring Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Post Recurring Charge Lines field.';
                }
                //SRBC-352 Start
                field("Update Late Fee - In Customer"; Rec."Update Late Fee - In Customer")
                {
                    ToolTip = 'Specifies the value of the Update Late Fee In Customer From Dimension field.', Comment = '%';
                }
                //SRBC-352 End
                field("Late Fee Template"; Rec."Late Fee Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Late Fee Template field.';
                }
                field("Late Fee Batch"; Rec."Late Fee Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Late Fee Batch field.';
                }
                field("Auto Create Late Fee Journal"; Rec."Auto Create Late Fee Journal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Create Late Fee Journal field.';
                }
                field("Auto Post Late Fee"; Rec."Auto Post Late Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Post Late Fee field.';
                }
                //SRBC-352 Start
                field("Charge Payment Payload"; Rec."Charge Payment Payload")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Payment Payload field.';
                }
                //SRBC-352 End
                field("Late Fee Amount"; Rec."Late Fee Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Late Fee Amount field.';
                }
                field("Convenience Fee"; Rec."Convenience Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Convenience Fee field.';
                }
                field("Customer Template"; Rec."Customer Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Template field.';
                }
                field("Epayment Template"; Rec."Epayment Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Epayment Template field.';
                }
                field("Epayment Batch"; Rec."Epayment Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Epayment Templatefield.';
                }
                field("Auto Create Epayment Jnl"; Rec."Auto Create Epayment Jnl")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Create Epayment Jnl field.';
                }
                field("Auto Post Epayment Jnl"; Rec."Auto Post Epayment Jnl")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Post Epayment Jnl field.';
                }
                field("Studio Transfer Template"; Rec."Studio Transfer Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Studio Transfer Template field.';
                }
                field("Studio Transfer Batch"; Rec."Studio Transfer Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Studio Transfer Batch Jnl field.';
                }
                field("Auto Post Studio Transfer"; Rec."Auto Post Studio Transfer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Post Studio Transfer field.';
                }

                field("Return Fee Template"; Rec."Return Fee Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Fee Template field.';
                }
                field("Return Fee Batch"; Rec."Return Fee Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Fee Batch field.';
                }
                field("Auto Post Return Fee"; Rec."Auto Post Return Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Post Return Fee field.';
                }
                //SRBC-356 Start
                field("Return Fee -Check"; Rec."Return Fee -Check")
                {
                    ToolTip = 'Specifies the value of the Return Fee -Check field.', Comment = '%';
                }
                //SRBC-356 End
                field("Return Fee Amount"; Rec."Return Fee Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Fee Amount field.';
                }
                //SRBC-356 Start
                field("Return Fee - Bank Account"; Rec."Return Fee - Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Return Fee - Bank Account field.', Comment = '%';
                }
                field("Return Fee Amt - Bank Account"; Rec."Return Fee Amt - Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Return Fee Amount - Bank Account field.', Comment = '%';
                }
                field("Return Fee - Card"; Rec."Return Fee - Card")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Return Fee - Card field.', Comment = '%';
                }
                field("Return Fee Amount - Card"; Rec."Return Fee Amount - Card")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Return Fee Amount - Card field.', Comment = '%';
                }
                //SRBC-356 End
                field("New Payment Template"; Rec."New Payment Template")
                {
                    ToolTip = 'Specifies the value of the New Payment Template field.';
                }
                field("New Payment Batch"; Rec."New Payment Batch")
                {
                    ToolTip = 'Specifies the value of the New Payment Batch field.';
                }
                field("Auto Post New Payment"; Rec."Auto Post New Payment")
                {
                    ToolTip = 'Specifies the value of the Auto Post New Payment field.';
                }
                field("Refund Template"; Rec."Refund Template")
                {
                    ToolTip = 'Specifies the value of the Refund Template field.';
                }
                field("Refund Batch"; Rec."Refund Batch")
                {
                    ToolTip = 'Specifies the value of the Refund Batch field.';
                }
                //SRBC-461 Start
                field("Check Refund"; Rec."Check Refund")
                {
                    ToolTip = 'Specifies the value of the Check Refund field.', Comment = '%';
                }
                //SRBC-461 End
                field("Auto Post Refund"; Rec."Auto Post Refund")
                {
                    ToolTip = 'Specifies the value of the Auto Post Refund field.';
                }
                //SRBC-376 Start
                field("Auto Post New Charge"; Rec."Auto Post New Charge")
                {
                    ToolTip = 'Specifies the value of the Auto Post New Charge field.', Comment = '%';
                }
                field("New Charge Template"; Rec."New Charge Template")
                {
                    ToolTip = 'Specifies the value of the New Charge Template field.', Comment = '%';
                }
                field("New Charge Batch"; Rec."New Charge Batch")
                {
                    ToolTip = 'Specifies the value of the New Charge Batch field.', Comment = '%';
                }
                //SRBC-376 End
                field("Consolidate Studio Transfer"; Rec."Consolidate Studio Transfer")
                {
                    ToolTip = 'Specifies the value of the Consolidate Studio Transfer.';
                }
                field("Studio Transfer Bal. Account"; Rec."Studio Transfer Bal. Account")
                {
                    ToolTip = 'Specifies the value of the Studio Transfer Bal. Account.';
                }
                field("Transfer Agree Bal. Account"; Rec."Transfer Agree Bal. Account")
                {
                    ToolTip = 'Specifies the value of the Transfer Agree Bal. Account.';
                }
                field("Transfer Agreement Template"; Rec."Transfer Agreement Template")
                {
                    ToolTip = 'Specifies the value of the Transfer Agreement Template.';
                }
                field("Transfer Agreement Batch"; Rec."Transfer Agreement Batch")
                {
                    ToolTip = 'Specifies the value of the Transfer Agreement Batch.';
                }
                field("Auto Post Transfer Agreement"; Rec."Auto Post Transfer Agreement")
                {
                    ToolTip = 'Specifies the value of the Auto Post Transfer Agreement.';
                }
                field("E-Payment Return Fee"; Rec."E-Payment Return Fee")
                {
                    ToolTip = 'Specifies the value of the E-Payment Return Fee.';
                }
                field("Undeposited Check Template"; Rec."Undeposited Check Template")
                {
                    ToolTip = 'Specifies the value of the Undeposited Check Template Fee.';
                }
                field("Undeposited Check Batch"; Rec."Undeposited Check Batch")
                {
                    ToolTip = 'Specifies the value of the Undeposited Check Batch Fee.';
                }
                field("Undeposited GL Account"; Rec."Undeposited GL Account")
                {
                    ToolTip = 'Specifies the value of the Undeposited GL Account Fee.';
                }
                field("Undeposited Bank Account"; Rec."Undeposited Bank Account")
                {
                    ToolTip = 'Specifies the value of the Undeposited Bank Account Fee.';
                }
                field("Auto Post Undeposited Check"; Rec."Auto Post Undeposited Check")
                {
                    ToolTip = 'Specifies the value of the Auto Post Undeposited Check Fee.';
                }
                field(ConstrucAgreeSTUDMODICHARGE; Rec.ConstrucAgreeSTUDMODICHARGE)
                {
                    ApplicationArea = all;
                }
                field(ConstrucAgreeSTUDMODIDIPOSIT; Rec.ConstrucAgreeSTUDMODIDIPOSIT)
                {
                    ApplicationArea = all;
                }
                field("LICENSE FEE SECURITY"; Rec."LICENSE FEE SECURITY")
                {
                    ApplicationArea = all;
                }
                field("LICENSE FEE"; Rec."LICENSE FEE")
                {
                    ApplicationArea = all;
                }
                field(BALTRAN; Rec.BALTRAN)
                {
                    ApplicationArea = all;
                }
                field("LATE FEE"; Rec."LATE FEE")
                {
                    ApplicationArea = all;
                }
                field("LICENSE FEE CONCESSION"; Rec."LICENSE FEE CONCESSION")
                {
                    ApplicationArea = all;
                }
                field("CONVENIENCE FEE TYPE"; Rec."CONVENIENCE FEE TYPE")
                {
                    ApplicationArea = all;
                }
                field("RETURNED PAYMENT FEE"; Rec."RETURNED PAYMENT FEE")
                {
                    ApplicationArea = all;
                }
                field("ADDITIONAL SECURITY DEPOSIT"; Rec."ADDITIONAL SECURITY DEPOSIT")
                {
                    ApplicationArea = all;
                }
                field("Balance Transfer CR"; Rec."Balance Transfer CR")
                {
                    ApplicationArea = all;
                }
                field("Balance Transfer DR"; Rec."Balance Transfer DR")
                {
                    ApplicationArea = all;
                }
                //SRBC-473 16062026 Start
                field("Payment Plan"; Rec."Payment Plan")
                {
                    ApplicationArea = all;
                }
                //SRBC-473 16062026 End
                field("Epay Conv. Fee Template"; Rec."Epay Conv. Fee Template")
                {
                    ApplicationArea = all;
                }
                field("Epay Conv. Fee Batch"; Rec."Epay Conv. Fee Batch")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                //SRBC-378 Start
                field("Post Edit Delete Transaction"; Rec."Post Edit Delete Transaction")
                {
                    ToolTip = 'Specifies the value of the Post Edit Delete Transaction field.', Comment = '%';
                }
                //SRBC-479 Start
                field("Create Charge/Payemnt Journal"; Rec."Create Charge/Payemnt Journal")
                {
                    ToolTip = 'Specifies the value of the Create Charge/Payemnt Journal field.', Comment = '%';
                }
                //SRBC-479 End
                //SRBC-481 Start
                field("Minute for RUN Charge/Payment"; Rec."Minute for RUN Charge/Payment")
                {
                    ToolTip = 'Specifies the value of the No. of Minutes for RUN Charge/Payment Job Que field.', Comment = '%';
                }
                //SRBC-481 End
                field("No. of attempts"; Rec."No. of attempts")
                {
                    ToolTip = 'Specifies the value of the No. of attempts field.', Comment = '%';
                }
                //SRBC-378 End
                //SRBC-279 Start
                field("Send Alert Notification"; Rec."Send Alert Notification")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Send Alert Notification field.', Comment = '%';
                }
                field("Alert Email Recipient"; Rec."Alert Email Recipient")
                {
                    ToolTip = 'Specifies the value of the Alert Email Recipient field.', Comment = '%';
                }
                field("Send Batch Error Alert Email"; Rec."Send Batch Error Alert Email")
                {
                    ApplicationArea = all;
                }
                field("Batch Alert Receipients"; Rec."Batch Alert Receipients")
                {
                    ApplicationArea = all;
                }
                field("Handle Batch Posting Errors"; Rec."Handle Batch Posting Errors")
                {
                    ApplicationArea = all;
                }
                //SRBC-323 Start
                field("Job Queue Alert Recipients"; Rec."Job Queue Alert Recipients")
                {
                    ToolTip = 'Specifies the value of the Job Queue Alert Recipients field.', Comment = '%';
                }
                //SRBC-323 End

                //SRBC-279  End
                //SRBC-384 Start
                field("Schedule Charge Template"; Rec."Schedule Charge Template")
                {
                    ToolTip = 'Specifies the value of the Schedule Charge Template field.', Comment = '%';
                }
                field("Schedule Charge Batch"; Rec."Schedule Charge Batch")
                {
                    ToolTip = 'Specifies the value of the Schedule Charge Batch field.', Comment = '%';
                }
                field("Schedule Payment Template"; Rec."Schedule Payment Template")
                {
                    ToolTip = 'Specifies the value of the Schedule Charge Template field.', Comment = '%';
                }
                field("Schedule Payment Batch"; Rec."Schedule Payment Batch")
                {
                    ToolTip = 'Specifies the value of the Schedule Payment Batch field.', Comment = '%';
                }
                //SRBC-384 End
                //SRBC-436 Start
                field("Auto Post New Discount"; Rec."Auto Post New Discount")
                {
                    ToolTip = 'Specifies the value of the Auto Post New Charge field.', Comment = '%';
                }
                field("New Discount Template"; Rec."New Discount Template")
                {
                    ToolTip = 'Specifies the value of the New Charge Template field.', Comment = '%';
                }
                field("New Discount Batch"; Rec."New Discount Batch")
                {
                    ToolTip = 'Specifies the value of the New Charge Batch field.', Comment = '%';
                }
                //SRBC-436 End
                //SRBC-431 Start
                field("Daily Posting Receipients"; Rec."Daily Posting Receipients")
                {
                    ToolTip = 'Specifies the value of the Daily Posting Receipients field.', Comment = '%';
                }
                //SRBC-431 End
                //SRBC-438 Start
                group("Purch Inv Refund")
                {
                    field("Purch. Inv Refund"; Rec."Create Purch. Inv Refund")
                    {
                        ToolTip = 'Specifies the value of the Purch. Inv Refund field.', Comment = '%';
                    }
                    field("Vendor Invoice Template"; Rec."Vendor Invoice Template")
                    {
                        ToolTip = 'Specifies the value of the Daily Posting Receipients field.', Comment = '%';
                    }
                    field("Vendor Invoice Batch"; Rec."Vendor Invoice Batch")
                    {
                        ToolTip = 'Specifies the value of the Daily Posting Receipients field.', Comment = '%';
                    }
                    field("Post Purchase Invoice"; Rec."Auto Post Purchase Invoice")
                    {
                        ToolTip = 'Specifies the value of the Daily Posting Receipients field.', Comment = '%';
                    }
                    field("Purch. Inv GL Acc No."; Rec."Purch. Inv GL Acc No.")
                    {
                        ToolTip = 'Specifies the value of the Purch. Inv GL Acc No. field.', Comment = '%';
                    }
                }
                //SRBC-438 End
                //SRBC-448 Start
                group("Power Automate Flow")
                {
                    field("Run PowerAutomate Flow"; Rec."Run PowerAutomate Flow")
                    {
                        ToolTip = 'Specifies the boolean to enable PowerAutomate flow', Comment = '%';
                    }
                    field("Power Automate Token URL"; Rec."Power Automate Token URL")
                    {
                        ToolTip = 'Specifies the URL to generate the access token', Comment = '%';
                    }
                    field("Grant Type"; Rec."Grant Type")
                    {
                        ToolTip = 'Specifies the Grant Type required to generate access token', Comment = '%';
                    }
                    field("Client ID"; Rec."Client ID")
                    {
                        ToolTip = 'Specifies the Client ID required to generate access token', Comment = '%';
                    }
                    field("Client Secret"; Rec."Client Secret")
                    {
                        ToolTip = 'Specifies the Client Secret required to generate access token', Comment = '%';
                    }
                    field(Scope; Rec.Scope)
                    {
                        ToolTip = 'Specifies the Scope required to generate access token', Comment = '%';
                    }
                    field("Content-Type"; Rec."Content-Type")
                    {
                        ToolTip = 'Specifies the Content-Type required to generate access token', Comment = '%';
                    }
                    field("Power Automate URL"; Rec."Power Automate URL")
                    {
                        ToolTip = 'Specifies the PowerAutomate URL', Comment = '%';
                    }
                    field("Notify CRM After Bulk Posting"; Rec."Notify CRM After Bulk Posting") //SRBC-538
                    {
                        ToolTip = 'Specifies the value of the Notify CRM After Bulk Posting field.', Comment = '%';
                    }
                }
                //SRBC-448 End
                //SRBC-455 Start
                group("Refund Transactions")
                {
                    field("Post Refund Transaction"; Rec."Post Refund Transaction")
                    {
                        ToolTip = 'Specifies the value of the Post Refund Transaction field.', Comment = '%';
                    }
                    field("Refun Bal. Account No."; Rec."Refun Bal. Account No.")
                    {
                        ToolTip = 'Specifies the value of the Refun Bal. Account No. field.', Comment = '%';
                    }
                }
                //SRBC-455 End
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;

    end;
}
