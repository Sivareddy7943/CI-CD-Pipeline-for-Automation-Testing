//SRBC-380 - SY - 10072025 - Added field in this page - "Studio Modification Deposit"
//SRBC-406 - SY - 07082025 - Added field sr_paidontext 
page 90114 "Sr Payments"
{
    ApplicationArea = All;
    Caption = 'Sr Payments';
    PageType = List;
    SourceTable = "Payments SR BC";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(sr_payment_id; Rec.sr_payment_id)
                {
                    ToolTip = 'Specifies the value of the Payment ID field.';
                }
                field("Recurring Entry No."; Rec."Recurring Entry No.")
                {
                    ToolTip = 'Specifies the value of the Recurring Entry No. field.';
                }
                //SRBC-406 Start
                field(sr_paidontext; Rec.sr_paidontext)
                {
                    ToolTip = 'Specifies the value of the Paid on Text field.', Comment = '%';
                }
                //SRBC-406 End
                field(sr_name; Rec.sr_name)
                {
                    ToolTip = 'Specifies the value of the name field.';
                }
                field(sr_studio; Rec.sr_studio)
                {
                    ToolTip = 'Specifies the value of the Studio # field.';
                }
                field("BC Location Code"; Rec."BC Location Code")
                {
                    ToolTip = 'Specifies the value of the BC Location Code field.';
                }
                field("BC Salon Code"; Rec."BC Salon Code")
                {
                    ToolTip = 'Specifies the value of the BC Salon Code field.';
                }
                field(sr_chargeid; Rec.sr_chargeid)
                {
                    ToolTip = 'Specifies the value of the Charge ID field.';
                }
                field(sr_paymentId; Rec.sr_paymentId)
                {
                    ToolTip = 'Specifies the value of the Payment field.';
                }
                field(sr_prospectid; Rec.sr_prospectid)
                {
                    ToolTip = 'Specifies the value of the Prospect field.';
                }
                //SRBC-380 Start
                field("Studio Modification Deposit"; Rec."Studio Modification Deposit")
                {
                    ToolTip = 'Specifies the value of the Studio Modification Deposit field.', Comment = '%';
                }
                field(sr_AmountShare; Rec.sr_AmountShare)
                {
                    ToolTip = 'Specifies the value of the sr_AmountShare field.';
                    Caption = 'Amount Share';
                }
                //SRBC-380 End
                field(sr_amount; Rec.sr_amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ToolTip = 'Specifies the value of the CreatedOn field.';
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ToolTip = 'Specifies the value of the ModifiedOn field.';
                }
                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the statecode field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the statuscode field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ToolTip = 'Specifies the value of the ExchangeRate field.';
                }
                field(sr_paidon; Rec.sr_paidon)
                {
                    ToolTip = 'Specifies the value of the sr_paidon field.';
                }
                field(sr_licenseID; Rec.sr_licenseID)
                {
                    ToolTip = 'Specifies the value of the sr_licenseID field.';
                    Caption = 'Licensee';
                }
                field(sr_agreementid; Rec.sr_agreementid)
                {
                    ToolTip = 'Specifies the value of the sr_agreementid field.';
                    Caption = 'AgreementID';
                }
                field(sr_DocusignPaymentType; Rec.sr_DocusignPaymentType)
                {
                    ToolTip = 'Specifies the value of the Docusign Payment Type field.';
                    Caption = 'Docusign Payment Type';
                }
                field(IsLastRow; Rec.IsLastRow)
                {
                    ToolTip = 'Specifies the value of the IsLastRow field.';
                    Caption = 'IsLastRow';
                }
                //SRBC-380 Start
                field(sr_amount_Base; Rec.sr_amount_Base)
                {
                    ToolTip = 'Specifies the value of the Amount (Base) field.';
                }
            }
        }
    }
    actions
    //All Page actions are related to D365 Dataverse sync. 
    {
        area(Processing)
        {
            group(Functions)
            {
                action("Create Recurring Charge")
                {
                    ApplicationArea = All;
                    Image = Line;
                    trigger OnAction()
                    var
                        Variant: Variant;
                        RecurrChargeMgt: Codeunit "Recurring Charges Mgt.";
                    begin
                        Variant := Rec;
                        if Rec."Recurring Entry No." = 0 then
                            RecurrChargeMgt.InsertRecurringLicenseFeeCharges(Variant);
                    end;
                }
                action("Update BC Location Code")
                {
                    ApplicationArea = All;
                    Image = Line;
                    trigger OnAction()
                    var
                        Variant: Variant;
                        RecurrChargeMgt: Codeunit "Recurring Charges Mgt.";
                    begin
                        RecurrChargeMgt.UpdateBCLocationSalonCode(Rec);
                    end;
                }
            }
            group(ActionGroupPayments)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;
                action(GotoPayments)
                {
                    Caption = 'Payments';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Payments.';
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
                ToolTip = 'View integration synchronization jobs for the payment table.';

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
