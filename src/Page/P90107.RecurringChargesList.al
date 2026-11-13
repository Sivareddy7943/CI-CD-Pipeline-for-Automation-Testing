//SRBC-405 - 20082025 - SY - Added new field - sr_renewalLADocuSign
//SRBC-421 - 03092025 - SY - Added field - Week Day, Month Day, Month Name, IsBC and created action button - "Update Week/Month Day"
page 90107 "Recurring Charges List"
{
    ApplicationArea = All;
    Caption = 'Recurring Charges List';
    PageType = List;
    SourceTable = "Recurring Charges";
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
                field(Licensee; Rec.Licensee)
                {
                    ToolTip = 'Specifies the value of the Licensee field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(sr_from; Rec.sr_from)
                {
                    ToolTip = 'Specifies the value of the sr_from field.';
                }
                field(sr_to; Rec.sr_to)
                {
                    ToolTip = 'Specifies the value of the sr_to field.';
                }
                field("Discount Start Date"; Rec."Discount Start Date")
                {
                    ToolTip = 'Specifies the value of the Discount Start Date field.';
                }
                field("Discount End Date"; Rec."Discount End Date")
                {
                    ToolTip = 'Specifies the value of the Discount End Date field.';
                }
                field("No. of Days for Disc"; Rec."No. of Days for Disc")
                {
                    ToolTip = 'Specifies the value of the No. of Days for Disc field.';
                }
                field("No. of Weeks for Disc"; Rec."No. of Weeks for Disc")
                {
                    ToolTip = 'Specifies the value of the No. of Weeks for Disc field.';
                }
                field("Due Day"; Rec."Due Day")
                {
                    ToolTip = 'Specifies the value of the Due Day field.';
                }
                //SRBC-421 Start
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
                field("Agreement Start Date"; Rec."Agreement Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agreement Start Date field.';
                }
                field("Agreement Start Day"; Rec."Agreement Start Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agreement Start Day field.';
                }
                field("Charge Anticipated End Date"; Rec."Charge Anticipated End Date")
                {
                    ToolTip = 'Specifies the value of the Charge Anticipated End Date field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Last Charged Date"; Rec."Last Charged Date")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Last Charged Date field.';
                }
                field("Next Charge Date"; Rec."Next Charge Date")
                {
                    //Editable = false;
                    ToolTip = 'Specifies the value of the Next Charged Date field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(sr_AmountShare; Rec.sr_AmountShare)
                {
                    ToolTip = 'Specifies the value of the Amount Share field.';
                }
                field(sr_DocusignPaymentType; Rec.sr_DocusignPaymentType)
                {
                    ToolTip = 'Specifies the value of the Docusign Payment Type field.';
                }
                field(IsLastRow; Rec.IsLastRow)
                {
                    ToolTip = 'Specifies the value of the IsLastRow field.';
                }
                field("Auto Charge Type"; Rec."Auto Charge Type")
                {
                    ToolTip = 'Specifies the value of the Auto Charge Type field.';
                }
                field("GL Account"; Rec."GL Account")
                {
                    ToolTip = 'Specifies the value of the GL Account field.';
                }
                field("CRM Contact Code"; Rec."CRM Contact Code")
                {
                    ToolTip = 'Specifies the value of the CRM Contact Code field.';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Studio Code field.';

                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Salon Code field.';

                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field(sr_chargeid; Rec.sr_chargeid)
                {
                    ToolTip = 'Specifies the value of the Charge Id field.';
                }
                field("Agreement ID"; Rec."Agreement ID")
                {
                    ToolTip = 'Specifies the value of the AgreementID field.';
                }
                field("Agreement Schedule ID"; Rec."Agreement Schedule ID")
                {
                    ToolTip = 'Specifies the value of the Agreement Schedule ID field.';
                }
                field("Payment SR BC"; Rec."Payment SR BC")
                {
                    ToolTip = 'Specifies the value of the Payment SR BC field.';
                }
                field("AutoCharge ID"; Rec."AutoCharge ID")
                {
                    ToolTip = 'Specifies the value of the AutoCharge ID field.';
                }
                field(sr_autochargetypecode; Rec.sr_autochargetypecode)
                {
                    ToolTip = 'Specifies the value of the AutoChargeType GUID field.';
                }
                // SR..BKP -- 12/01/2024 NS
                field("Charge Category"; Rec."Charge Category")
                {
                    ToolTip = 'Specifies the value of the Charge Category field.';
                }
                field(Inactive; Rec.Inactive)
                {
                    ToolTip = 'Specifies the value of the Inactive field.';
                }
                field("MultiSigner Hold Deposit"; Rec."MultiSigner Hold Deposit")
                {
                    ToolTip = 'Specifies the value of the MultiSigner Hold Deposit field.';
                }
                field("Additional Security Charge"; Rec."Additional Security Charge")
                {
                    ToolTip = 'Specifies the value of the Additional Security Charge field.';
                }
                field("LA Security Deposit"; Rec."LA Security Deposit")
                {
                    ToolTip = 'Specifies the value of the LA Security Deposit field.';
                }
                field("Construction Agreement"; Rec."Construction Agreement")
                {
                    ToolTip = 'Specifies the value of the Construction Agreement field.';
                }
                //SRBC-421 Start
                field(IsBC; Rec.IsBC)
                {
                    ToolTip = 'Specifies the value of the IsBC field.', Comment = '%';
                }
                //SRBC-421 End
                field(sr_IsCRM; Rec.sr_IsCRM)
                {
                    ToolTip = 'Specifies the value of the sr_IsCRM field.';
                }
                field("CRM Renewal"; Rec."CRM Renewal")
                {
                    ToolTip = 'Specifies the value of the CRM Renewal field.', Comment = '%';
                }
                //SRBC-405 Start
                field(sr_renewalLADocuSign; Rec.sr_renewalLADocuSign)
                {
                    ToolTip = 'Specifies the value of the Renewal LA DocuSign field.', Comment = '%';
                }
                //SRBC-405 End
                field(Sequence; Rec.Sequence)
                {
                    ToolTip = 'Specifies the value of the Sequence field.';
                }
                // SR..BKP -- 12/01/2024 NE
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Auto Create Recurring Journal")
            {
                ApplicationArea = All;
                RunObject = report "Auto Create Recurring Charges";
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Auto Create Recurring Journal action.';
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
            group(ActionGroupPRecurring)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;
                action(GotoRecurring)
                {
                    Caption = 'Recurring';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Recurring.';
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
                ToolTip = 'View integration synchronization jobs for the Recurring table.';

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
                    ToolTip = 'Create or modify the coupling to a Microsoft Dataverse Payments.';

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
                    ToolTip = 'Delete the coupling to a Microsoft Dataverse Payments.';

                    trigger OnAction()
                    var
                        CRMCouplingManagement: Codeunit "CRM Coupling Management";
                    begin
                        CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                    end;

                }
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
