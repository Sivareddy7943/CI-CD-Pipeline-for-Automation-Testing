page 90103 "Auto Transaction Charge Types"
{
    ApplicationArea = All;
    Caption = 'Auto Transaction/Charge Type';
    PageType = List;
    SourceTable = "Auto Charge";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("GL Account No."; Rec."GL Account No.")
                {
                    ToolTip = 'Specifies the value of the GL Account No. field.';
                }
                field("Default Recurring Due Day"; Rec."Default Recurring Due Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Recurring Due Day field.';
                }
                field(sr_autochargetypeId; Rec.sr_autochargetypeId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AutoChargeTypeGUID field.';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CRM Created By field.';
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CRM Created On field.';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CRM Modified By field.';
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CRM Modified On field.';
                }
                // SR..BKP -- 12/01/2024 NS
                field("Charge Category"; Rec."Charge Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Category field.';
                }
                field("Incur late fee"; Rec."Incur late fee")
                {
                    ApplicationArea = all;
                }
                field(IsBC; Rec.IsBC)
                {
                    ApplicationArea = all;
                }
                // SR..BKP -- 12/01/2024 NE
            }
        }
    }
    actions
    //All Page actions are related to D365 Dataverse sync. 
    {
        area(Processing)
        {
            group(ActionGroupAutoChargeType)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;
                action(GotoAutoChargeType)
                {
                    Caption = 'Auto Charge Type';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Auto Charge Type.';
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
                ToolTip = 'View integration synchronization jobs for the Auto Charge Type table.';

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
                    ToolTip = 'Create or modify the coupling to a Microsoft Dataverse Auto Charge Type.';

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
                    ToolTip = 'Delete the coupling to a Microsoft Dataverse Auto Charge Type.';

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
