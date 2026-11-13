/// <summary>
/// Table Salon Republic Setup (ID 50002).
/// </summary>
//SRBC-185 - 20241126 - One Time Payment Method Changes - Portal.
//                    - Created new Field ID 119,120,121
//SRBC-279 - 20250131 - NU - Need Capabilities to Send Failure Email Notification
//                         - Added field "Send Alert Notification" for Enable/Disabled stripe failure email functionality
//SRBC-280 - SY - 30012025 - Created Codeunit for fail safe batch process 
//SRBC-323 - SY - 12032025 - Created field "Job Queue Alert Recipients" for add email to sent
//SRBC-326 - SY - 22032025 - Created boolean field "Create Customer from Agreement", if true then after create agreements will create customer in BC else not.
//SRBC-356 - AR - 29042025 - Change Caption Of "Return Fee Amount" to "Return Fee Amount-Check"
//                         - Created new Field ID 512("Return Fee - Bank Account"),513("Return Fee Amount - Bank Account"),514("Return Fee - Card"),515("Return Fee Amount - Card"), 516("Return Fee -Check")    
//SRBC-352 - SY - 13062025 - Created field "Update Late Fee - In Customer" for update customer from dimension
//SRBC-376 - SY - 23062025 - Created new fields - "Auto Post New Charge"(518), "New Charge Template"(519), "New Charge Batch"(520)
//SRBC-378 - SY - 26062025 - Created new field "Post Edit Delete Transaction" for post Journal  and "No. of attempts" field.
//SRBC-384 - AM - 18072025 - Added field "Schedule Charge Template", "Schedule Charge Batch", "Schedule Payment Template", "Schedule Payment Batch" to created journal from Edit delete Trans Table
//SRBC-436 - AM - 30092025 - Created new fields - "Auto Post New Discount", "New Discount Template", "New Discount Batch"
//SRBC-438 - AM - 27102025 - Created new fields - "Vendor Invoice Template" and Vendor Invoice Batch , Auto Post Purchase Invoice,"Create Purch. Inv Refund","Purch. Inv GL Acc No."
//SRBC-448 - NT&LB - 07112025 - Created new fields - Run PowerAutomate Flow, Grant Type, Client ID, Client Secret, Scope, Power Automate Token URL, Content-Type, Power Automate URL
//SRBC-457 JSG  Added new field Auto Calculate Running Balance 
//SRBC-461 - AM - 12122025 - Added a new field Check Refund. 
//SRBC-455 - LB&NT - 19012026 - Added Post Refund Transaction Boolean.
//SRBC-479 - SY - 20022026 - Created field - "Create Charge/Payemnt Journal" for create or skip Journal insertion when data inserted in Edit Delete Queue
//SRBC-481 - SY - 25022026 - Created field - "Minute for RUN Charge/Payment" for run job que after insert charge/payemnt entry in "Edit Delete Queue"
//SRBC-352 - SY - 19052026 - Created field - "Charge Payment Payload" for Insert Charge/Payment in "Charge Payment Payload List" or "Edit Delete Transaction Queue List" 
//SRBC-473 - SY - 16062026 - Created field - "Payment Plan"
//SRBC-538 - NU - 01102026 - Created field - "Notify CRM After Bulk Posting" to check before notifying CRM After Bulk posting
table 90104 "Salon Republic Setup"
{
    Caption = 'Salon Republic Setup';
    DataClassification = ToBeClassified;
    LookupPageId = "Salon Republic Setup";
    DrillDownPageId = "Salon Republic Setup";
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Rent Charge Template"; Code[20])
        {
            Caption = 'Rent Charge Template';
            TableRelation = "Gen. Journal Template";
        }
        field(3; "Rent Charge Batch"; Code[20])
        {
            Caption = 'Rent Charge Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Rent Charge Template"));
        }
        field(4; "Auto Create Recurring Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Auto Post Recurring Charge"; Boolean)
        {
            Caption = 'Auto Post Recurring Charge Lines';
            DataClassification = ToBeClassified;
        }

        field(6; "Late Fee Template"; Code[20])
        {
            Caption = 'Late Fee Template';
            TableRelation = "Gen. Journal Template";
        }
        field(7; "Late Fee Batch"; Code[20])
        {
            Caption = 'Late Fee Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Late Fee Template"));
        }
        field(8; "Auto Create Late Fee Journal"; Boolean)
        {
            Caption = 'Auto Create Late Fee Journal';
            DataClassification = ToBeClassified;
        }
        field(9; "Auto Post Late Fee"; Boolean)
        {
            Caption = 'Auto Post Late Fee';
            DataClassification = ToBeClassified;
        }
        field(10; "Late Fee Amount"; Decimal)
        {
            Caption = 'Late Fee Amount';
            DataClassification = ToBeClassified;
        }
        field(11; "Customer Template"; Code[20])
        {
            Caption = 'Customer Template';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Templ.";
        }
        field(12; "Convenience Fee"; Decimal)
        {
            Caption = 'Convenience Fee';
            DataClassification = ToBeClassified;
        }
        field(13; "Auto Create Epayment Jnl"; Boolean)
        {
            Caption = 'Auto Create Epayment Jnl';
            DataClassification = ToBeClassified;
        }
        field(14; "Auto Post Epayment Jnl"; Boolean)
        {
            Caption = 'Auto Post Epayment Jnl';
            DataClassification = ToBeClassified;
        }
        field(15; "Studio Transfer Template"; Code[20])
        {
            Caption = 'Studio Transfer Template';
            TableRelation = "Gen. Journal Template";
        }
        field(16; "Studio Transfer Batch"; Code[20])
        {
            Caption = 'Studio Transfer Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Studio Transfer Template"));
        }
        field(17; "Auto Post Studio Transfer"; Boolean)
        {
            Caption = 'Auto Post Studio Transfer';
            DataClassification = ToBeClassified;
        }
        field(18; "Epayment Template"; Code[20])
        {
            Caption = 'Epayment Template';
            TableRelation = "Gen. Journal Template";
        }
        field(19; "Epayment Batch"; Code[20])
        {
            Caption = 'Epayment Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Epayment Template"));
        }
        field(20; "New Payment Template"; Code[20])
        {
            Caption = 'New Payment Template';
            TableRelation = "Gen. Journal Template";
        }
        field(21; "New Payment Batch"; Code[20])
        {
            Caption = 'New Payment Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("New Payment Template"));
        }
        field(22; "Consolidate Studio Transfer"; Boolean)
        {
            Caption = 'Consolidate Studio Transfer';
            DataClassification = ToBeClassified;
        }
        field(23; "Studio Transfer Bal. Account"; Code[20])
        {
            Caption = 'Studio Transfer Bal. Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(24; "Auto Post New Payment"; Boolean)
        {
            Caption = 'Auto Post New Payment';
            DataClassification = ToBeClassified;
        }
        field(25; "Transfer Agreement Template"; Code[20])
        {
            Caption = 'Transfer Agreement Template';
            TableRelation = "Gen. Journal Template";
        }
        field(26; "Transfer Agreement Batch"; Code[20])
        {
            Caption = 'Transfer Agreement Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Transfer Agreement Template"));
        }
        field(27; "Auto Post Transfer Agreement"; Boolean)
        {
            Caption = 'Auto Post Transfer Agreement';
            DataClassification = ToBeClassified;
        }
        field(28; "Transfer Agree Bal. Account"; Code[20])
        {
            Caption = 'Transfer Agree Bal. Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(29; "E-Payment Return Fee"; Decimal)
        {
            Caption = 'E-Payment Return Fee';
            DataClassification = ToBeClassified;

        }
        field(30; "Undeposited Check Template"; Code[20])
        {
            Caption = 'Undeposited Check Template';
            TableRelation = "Gen. Journal Template";
        }
        field(31; "Undeposited Check Batch"; Code[20])
        {
            Caption = 'Undeposited Check Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Undeposited Check Template"));
        }
        field(32; "Auto Post Undeposited Check"; Boolean)
        {
            Caption = 'Auto Post Undeposited Check';
            DataClassification = ToBeClassified;
        }
        field(33; "Undeposited GL Account"; Code[20])
        {
            Caption = 'Undeposited GL Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(34; "Undeposited Bank Account"; Code[20])
        {
            Caption = 'Undeposited Bank Account';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }

        field(100; "Return Fee Template"; Code[20])
        {
            Caption = 'Return Fee Template';
            TableRelation = "Gen. Journal Template";
        }
        field(101; "Return Fee Batch"; Code[20])
        {
            Caption = 'Return Fee Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Return Fee Template"));
        }
        field(102; "Auto Post Return Fee"; Boolean)
        {
            Caption = 'Auto Post Return Fee';
            DataClassification = ToBeClassified;
        }
        field(103; "Return Fee Amount"; Decimal)
        {
            Caption = 'Return Fee Amount-Check';//SRBC-356 
            DataClassification = ToBeClassified;
        }
        field(104; "ConstrucAgreeSTUDMODICHARGE"; Code[50])
        {
            Caption = 'Construction STUDIO MODIFICATION CHARGE';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(105; "ConstrucAgreeSTUDMODIDIPOSIT"; Code[50])
        {
            Caption = 'Construction STUDIO MODIFICATION DEPOSIT';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(106; "LICENSE FEE SECURITY"; Code[50])
        {
            Caption = 'LICENSE FEE SECURITY';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(107; "LICENSE FEE"; Code[50])
        {
            Caption = 'LICENSE FEE';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(108; "BALTRAN"; Code[50])
        {
            Caption = 'BALTRAN';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
        }
        field(109; "LATE FEE"; Code[50])
        {
            Caption = 'LATE FEE';
            DataClassification = ToBeClassified;

            TableRelation = "Auto Charge".Code;

        }
        field(110; "LICENSE FEE CONCESSION"; Code[50])
        {
            Caption = 'LICENSE FEE CONCESSION';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(111; "CONVENIENCE FEE TYPE"; Code[50])
        {
            Caption = 'CONVENIENCE FEE TYPE';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(112; "RETURNED PAYMENT FEE"; Code[50])
        {
            Caption = 'RETURNED PAYMENT FEE';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(113; "ADDITIONAL SECURITY DEPOSIT"; Code[50])
        {
            Caption = 'Additional Security Deposit';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(114; "Activate Job Queue Restarter"; Boolean)
        {
            Caption = 'Activate Job Queue Restarter';
            DataClassification = ToBeClassified;
        }
        field(115; "Create Epay From Bank Info"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Create Epay From ACH Payment';
        }
        field(116; "Refund Template"; Code[20])
        {
            Caption = 'Refund Template';
            TableRelation = "Gen. Journal Template";
        }
        field(117; "Refund Batch"; Code[20])
        {
            Caption = 'Refund Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Refund Template"));
        }
        field(118; "Auto Post Refund"; Boolean)
        {
            Caption = 'Auto Post Refund';
            DataClassification = ToBeClassified;
        }
        //SRBC-185
        field(119; "Epay Conv. Fee Template"; Code[20])
        {
            Caption = 'Epay Conv. Fee Template';
            TableRelation = "Gen. Journal Template";
        }
        field(120; "Epay Conv. Fee Batch"; Code[20])
        {
            Caption = 'Epay Conv. Fee Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Epay Conv. Fee Template"));
        }
        field(121; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        //SRBC-279
        //No need to deploy in QA
        field(500; "Testing Entry No."; Integer)
        {
            Caption = 'Testing Entry No.';
            DataClassification = ToBeClassified;
        }
        field(501; EDITCHARGE; Boolean)
        {
            Caption = 'EDIT CHARGE';
            DataClassification = ToBeClassified;
        }
        field(502; DeleteCharge; Boolean)
        {
            Caption = 'Delete Charge';
            DataClassification = ToBeClassified;
        }
        //SRBC-279-280 Start
        field(503; "Alert Email Recipient"; Text[200]) { DataClassification = ToBeClassified; }
        field(504; "Send Alert Notification"; Boolean) { DataClassification = ToBeClassified; }
        field(505; "Batch Alert Receipients"; Text[200])
        {
            Caption = 'Batch Alert Receipients';
            DataClassification = ToBeClassified;
        }
        field(506; "Send Batch Error Alert Email"; Boolean)
        {
            Caption = 'Send Batch Error Alert Email';
            DataClassification = ToBeClassified;
        }
        field(507; "Handle Batch Posting Errors"; Boolean)
        {
            Caption = 'Handle Batch Posting Errors';
            DataClassification = ToBeClassified;
        }
        //SRBC-279 End
        field(508; "Balance Transfer CR"; Code[50])
        {
            Caption = 'Balance Transfer CR';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        field(509; "Balance Transfer DR"; Code[50])
        {
            Caption = 'Balance Transfer DR';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        //SRBC-323 Start
        field(510; "Job Queue Alert Recipients"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job Queue Alert Recipients';
        }
        //SRBC-323 End
        //SRBC-326 Start
        field(511; "Create Customer from Agreement"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Create Customer from Agreement';
        }
        //SRBC-326 End
        //SRBC-356 Start
        field(512; "Return Fee - Bank Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(513; "Return Fee Amt - Bank Account"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(514; "Return Fee - Card"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(515; "Return Fee Amount - Card"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(516; "Return Fee -Check"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-356 End
        //SRBC-352 Start
        field(517; "Update Late Fee - In Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Update Late Fee In Customer From Dimension';
        }
        //SRBC-352 End
        //SRBC-376 Start
        field(518; "Auto Post New Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(519; "New Charge Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(520; "New Charge Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("New Charge Template"));
        }
        //SRBC-376 End
        //SRBC-378 Start
        field(521; "Post Edit Delete Transaction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(522; "No. of attempts"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-378 End
        //SRBC-384 Start
        field(523; "Schedule Charge Template"; Code[20])
        {
            Caption = 'Schedule Charge Template';
            TableRelation = "Gen. Journal Template";
        }
        field(524; "Schedule Charge Batch"; Code[20])
        {
            Caption = 'Schedule Charge Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Schedule Charge Template"));
        }
        field(525; "Schedule Payment Template"; Code[20])
        {
            Caption = 'Schedule Payment Template';
            TableRelation = "Gen. Journal Template";
        }
        field(526; "Schedule Payment Batch"; Code[20])
        {
            Caption = 'Schedule Payment Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Schedule Payment Template"));
        }
        //SRBC-384 End
        //SRBC-436 Start
        field(527; "Auto Post New Discount"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(528; "New Discount Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(529; "New Discount Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("New Discount Template"));
        }
        //SRBC-436 End
        //SRBC-431 Start
        field(530; "Daily Posting Receipients"; Text[500])
        {
            Caption = 'Daily Posting Receipients';
        }
        //SRBC-431 End
        //SRBC-438 Start
        field(531; "Vendor Invoice Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(532; "Vendor Invoice Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Vendor Invoice Template"));
        }
        field(533; "Auto Post Purchase Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(534; "Purch. Inv GL Acc No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(535; "Create Purch. Inv Refund"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Create Ven-Purch. Inv Refund';//SRBC-438 - 0312025
            trigger OnValidate()
            begin
                if Rec."Create Purch. Inv Refund" then//SRBC-438 - 0312025
                    TestField("Purch. Inv GL Acc No.");
            end;
        }
        //SRBC-438 End
        //SRBC-448 Start
        field(536; "Run PowerAutomate Flow"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(537; "Grant Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(538; "Client ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(539; "Client Secret"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(540; Scope; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(541; "Power Automate Token URL"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(542; "Content-Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(543; "Power Automate URL"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-448 End 
        //SRBC-457 JSG Start 12112025 
        field(544; "Auto Calculate Running Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-457 JSG End 12112025
        //SRBC-461 Start
        field(545; "Check Refund"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Refund Template"));
        }
        //SRBC-461 End
        //SRBC-455 Start 19012026
        field(546; "Post Refund Transaction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(547; "Refun Bal. Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-455 End 19012026
        //SRBC-479 Start
        field(548; "Create Charge/Payemnt Journal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-479 End
        //SRBC-481 Start
        field(549; "Minute for RUN Charge/Payment"; Integer)
        {
            Caption = 'No. of Minutes for RUN Charge/Payment Job Que';
            DataClassification = ToBeClassified;
        }
        //SRBC-481 End
        //SRBC-352 Start
        field(550; "Charge Payment Payload"; Boolean)
        {
            Caption = 'Charge Payment Payload';
            DataClassification = ToBeClassified;
        }
        //SRBC-352 End
        //SRBC-473 16062026 Start
        field(551; "Payment Plan"; Code[50])
        {
            Caption = 'Payment Plan';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Charge".Code;
        }
        //SRBC-473 16062026 End
        //SRBC-538 
        field(552; "Notify CRM After Bulk Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SRBC-538 
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
