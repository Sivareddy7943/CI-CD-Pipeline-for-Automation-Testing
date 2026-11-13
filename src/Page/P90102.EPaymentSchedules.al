//SRBC-175 - 20241128 - Creation of Recurring charge lines E-payment lines for Month to month renewal.
//                    - Created a new field ID 79,80,81
//SRBC-207 - 10012025 - Created new field "ACH Payment ID" for flow ACH Payment ID 
//SRBC-266 - 10012025 - Created new field "Payment Plan ID"
//SRBC-227 - 03032025 - SY - Added field "Stripe Payment Method Status" for update Stripe bank account status
//SRBC-405 - 20082025 - SY - Added new field - sr_renewalLADocuSign
//SRBC-421 - 03092025 - SY - Added fields - "Due Day", "Week Day", "Month Day", "Month Name" And created action button - "Update Week/Month Day"
//SRBC-473 - 30012026 - SY - Added field "Payment For" 
//         - 29042026 - AM - Added one more field Payment For Id 
page 90102 "EPayment Schedules"
{
    ApplicationArea = All;
    Caption = 'EPayment Schedules';
    PageType = List;
    SourceTable = "E Payment Schedule";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                //SRBC-207 Start
                field("ACH Payment ID"; Rec."ACH Payment ID")
                {
                    ToolTip = 'Specifies the value of the ACH Payment ID field.', Comment = '%';
                }
                //SRBC-207 End

                //SRBC-266 Start
                field("Payment Plan ID"; Rec."Payment Plan ID")
                {
                    ToolTip = 'Specifies the value of the Payment Plan ID field.', Comment = '%';
                }
                //SRBC-266 End
                field("Auto Epayment CRM ID"; Rec."Auto Epayment CRM ID")
                {
                    ToolTip = 'Specifies the value of the Auto Epayment CRM ID field.';
                }
                field("Agreement ID"; Rec."Agreement ID")
                {
                    ToolTip = 'Specifies the value of the Agreement ID field.';
                }
                field("Banking Account Info"; Rec."Banking Account Info")
                {
                    ToolTip = 'Specifies the value of the Banking Account Info field.';
                }
                field("License ID"; Rec."License ID")
                {
                    ToolTip = 'Specifies the value of the License ID field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("BC Cust. Bank Account"; Rec."BC Cust. Bank Account")
                {
                    ToolTip = 'Specifies the value of the BC Cust. Bank Account field.';
                }
                field(Account; Rec.Account)
                {
                    ToolTip = 'Specifies the value of the Account field.';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(EFrequency; Rec.EFrequency)
                {
                    ToolTip = 'Specifies the value of the Authorization EFrequency Banking Info field.';
                }
                //SRBC-473 Start
                field("Payment For"; Rec."Payment For")
                {
                    ToolTip = 'Specifies the value of the Payment For field.', Comment = '%';
                }
                //SRBC-473 End
                //SRBC-473 Start 2904206
                field("Payment For Id"; Rec."Payment For Id")
                {
                    ToolTip = 'Specifies the value of the Payment For field.', Comment = '%';
                }
                //SRBC-473 End 2904206
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                //SRBC-207
                //SRBC-421 Start
                field("Due Day"; Rec."Due Day")
                {
                    ToolTip = 'Specifies the value of the Due Day field.', Comment = '%';
                }
                field("Week Day"; Rec."Week Day")
                {
                    ToolTip = 'Specifies the value of the Week Day field.', Comment = '%';
                }
                field("Month Day"; Rec."Month Day")
                {
                    ToolTip = 'Specifies the value of the Month Day field.', Comment = '%';
                }
                field("Month Name"; Rec."Month Name")
                {
                    ToolTip = 'Specifies the value of the Month field.', Comment = '%';
                }
                //SRBC-421 End
                field(sr_from; Rec.sr_from)
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field(sr_to; Rec.sr_to)
                {
                    ToolTip = 'Specifies the value of the To field.';
                }
                field(sr_ConvenienceFee; Rec.sr_ConvenienceFee)
                {
                    ToolTip = 'Specifies the value of the sr_ConvenienceFee field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(sr_TotalAmount; Rec.sr_TotalAmount)
                {
                    ToolTip = 'Specifies the value of the sr_TotalAmount field.';
                }
                field("Share Percentage"; Rec."Share %") ///SRBC-175
                {
                    ToolTip = 'Specifies the value of the Share % field.';
                }
                field("Payment Anticipated End Date"; Rec."Payment Anticipated End Date")
                {
                    ToolTip = 'Specifies the value of the Payment Anticipated End Date field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Last Charged Date"; Rec."Last Charged Date")
                {
                    ToolTip = 'Specifies the value of Last Payment Date field.';
                }
                field("Next Payment date"; Rec."Next Charge Date")
                {
                    ToolTip = 'Specifies the value of the Next Payment date field.';
                }
                //SRBC-421 Start
                // field("Last Posted"; Rec."Last Posted")
                // {
                //     ToolTip = 'Specifies the value of the Last Posted field.';
                // }
                //SRBC-421 End
                field(Payer; Rec.Payer)
                {
                    ToolTip = 'Specifies the value of the Payer field.';
                }
                field("Recurring Entry No."; Rec."Recurring Entry No.")
                {
                    ToolTip = 'Specifies the value of the Recurring Entry No. field.';
                }
                field(Recurring; Rec.Recurring)
                {
                    ToolTip = 'Specifies the value of the Recurring field.';
                }
                field("Payment Plan"; Rec."Payment Plan")
                {
                    ToolTip = 'Specifies the value of the Payment Plan field.';
                }
                field(Inactive; Rec.Inactive)
                {
                    ToolTip = 'Specifies the value of the Inactive field.';
                }
                field(sr_IsBC; Rec.sr_IsBC)
                {
                    ToolTip = 'Specifies the value of the sr_IsBC field.';
                }
                field(sr_IsCRM; Rec.sr_IsCRM)
                {
                    ToolTip = 'Specifies the value of the sr_IsCRM field.';
                }
                field("CRM Renewal"; Rec."CRM Renewal") ///SRBC-175
                {
                    ToolTip = 'Specifies the value of the CRM Renewal field.';
                }
                //SRBC-405 Start
                field(sr_renewalLADocuSign; Rec.sr_renewalLADocuSign)
                {
                    ToolTip = 'Specifies the value of the Renewal LA DocuSign field.', Comment = '%';
                }
                //SRBC-405 End
                //SRBC-227
                field("Stripe Payment Method Status"; Rec."Stripe Payment Method Status")
                {
                    ToolTip = 'Specifies the value of the Stripe Payment Method Status field.', Comment = '%';
                }
                //SRBC-227
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("AS Sequence"; Rec."AS Sequence") ///SRBC-175
                {
                    ToolTip = 'Specifies the value of the AS Sequence field.';
                }
            }
        }
    }
    actions
    //All Page actions are related to D365 Dataverse sync. 
    {
        area(Processing)
        {
            group(ActionGroupEpayments)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;
                action(GotoEpayments)
                {
                    Caption = 'Epayment Schedules';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Epayment Schedules';
                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(SynchronizeNow)
                {
                    Caption = 'Synchronize';
                    ApplicationArea = All;
                    Visible = true;
                    Image = Refresh;
                    Enabled = CDSIsCoupledToRecord;
                    ToolTip = 'Send or get updated data to or from Microsoft Dataverse.';
                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.UpdateOneNow(Rec.RecordId);
                    end;
                }
            }
            action(ShowLog)
            {
                Caption = 'Synchronization Log';
                ApplicationArea = All;
                Visible = true;
                Image = Log;
                ToolTip = 'View integration synchronization jobs for the Epayment Schedules table.';

                trigger OnAction()
                var
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CRMIntegrationManagement.ShowLog(Rec.RecordId);
                end;

            }
            group(Coupling)
            {
                Caption = 'Coupling';
                Image = LinkAccount;
                ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Microsoft Dataverse row.';
                action(ManageCoupling)
                {
                    Caption = 'Set Up Coupling';
                    ApplicationArea = All;
                    Visible = true;
                    Image = LinkAccount;
                    ToolTip = 'Create or modify the coupling to a Microsoft Dataverse Epayment Schedules.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.DefineCoupling(Rec.RecordId);
                    end;

                }
                action(DeleteCoupling)
                {
                    Caption = 'Delete Coupling';
                    ApplicationArea = All;
                    Visible = true;
                    Image = UnLinkAccount;
                    Enabled = CDSIsCoupledToRecord;
                    ToolTip = 'Delete the coupling to a Microsoft Dataverse Epayment Schedules';

                    trigger OnAction()
                    var
                        CRMCouplingManagement: Codeunit "CRM Coupling Management";
                    begin
                        CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                    end;

                }
            }
            group(Function)
            {
                action("Auto Create Epayment Journal")
                {
                    ApplicationArea = All;
                    RunObject = report AutoCreateEpaymentJournals;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Auto Create Epayment Journal action.';
                    trigger OnAction()
                    var

                    begin

                    end;
                }
                //SRBC-421 Start
                action("Update Week/Month Day")
                {
                    ApplicationArea = All;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        RecurringChargeManagement: codeunit "Recurring Charges Mgt.";
                        Variant: Variant;
                    begin
                        Variant := Rec;
                        RecurringChargeManagement.UpdateEpaymentAndRecurringCharge(Variant);
                    end;
                }
                //SRBC-421 End
            }
        }
    }
    trigger OnOpenPage()
    begin
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if CDSIntegrationEnabled then
            CDSIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
    end;

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CDSIntegrationEnabled: Boolean;
        CDSIsCoupledToRecord: Boolean;

}
