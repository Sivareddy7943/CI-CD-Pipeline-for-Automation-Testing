page 90111 "Agreement Lists"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Agreement Lists';
    PageType = List;
    SourceTable = Agreements;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Agreement ID"; Rec."Agreement ID")
                {
                    ToolTip = 'Specifies the value of the Agreement ID field.';
                }
                field("New Agreement"; Rec."New Agreement")
                {
                    ToolTip = 'Specifies the value of the New Agreement ID field.';
                }
                field(sr_Licensee; Rec.sr_Licensee)
                {
                    ToolTip = 'Specifies the value of the Licensee String field.';
                }
                field("Licensee 1"; Rec."Licensee 1")
                {
                    ToolTip = 'Specifies the value of the Licensee 1 field.';
                }
                field("Licensee 2"; Rec."Licensee 2")
                {
                    ToolTip = 'Specifies the value of the Licensee 2 field.';
                }
                field(sr_name; Rec.sr_name)
                {
                    ToolTip = 'Specifies the value of the Quick Link to Agreement Ledger field.';
                }
                field(sr_salonlocationid; Rec.sr_salonlocationid)
                {
                    ToolTip = 'Specifies the value of the Salon GUID field.';
                }
                // field(sr_studioid; Rec.sr_studioid)
                // {
                //     ToolTip = 'Specifies the value of the Studio GUID field.';
                // }
                field(sr_Studio; Rec.sr_Studio)
                {
                    ToolTip = 'Specifies the value of the Studio Json field.';
                }
                field("Studio 1"; Rec."Studio 1")
                {
                    ToolTip = 'Specifies the value of the Studio 1 field.';
                }
                field("Studio 2"; Rec."Studio 2")
                {
                    ToolTip = 'Specifies the value of the Studio 2 field.';
                }
                field("BC Location Code"; Rec."BC Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the BC Location Code field.';
                }
                field("BC studio Code"; Rec."BC studio Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the BC studio Code field.';
                }
                field(AutoChargeCode; Rec.AutoChargeCode)
                {
                    ToolTip = 'Specifies the value of the AutoChargeCode field.';
                }
                field("GL Account"; Rec."GL Account")
                {
                    ToolTip = 'Specifies the value of the GL Account field.';
                }
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    ToolTip = 'Specifies the value of the Security Deposit Amount field.';
                }
                field("Current Agreement Start Date"; Rec."Current Agreement Start Date")
                {
                    ToolTip = 'Specifies the value of the Current Agreement Date field.';
                }
                field("Current Agreement End Date"; Rec."Current Agreement End Date")
                {
                    ToolTip = 'Specifies the value of the Current Agreement End Date field.';
                }
                field("New End Date"; Rec."New End Date")
                {
                    ToolTip = 'Specifies the value of the New End Date field.';
                }
                field("New Start Date"; Rec."New Start Date")
                {
                    ToolTip = 'Specifies the value of the New Start Date field.';
                }
                field("Agreement Status"; Rec."Agreement Status")
                {
                    ToolTip = 'Specifies the value of the Agreement Status field.';
                }
                field("Agreement Status Reason"; Rec."Agreement Status Reason")
                {
                    ToolTip = 'Specifies the value of the Agreement Status Reason field.';
                }
                field(Inactive; Rec.Inactive)
                {
                    ToolTip = 'Specifies the value of the Inactive field.';
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ToolTip = 'Specifies the value of the Customer Code field.';
                }
                field("Balance As Due"; Rec."Balance As Due")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Balance As Due field.';
                    Visible = true;
                }
                field("Balance As Due 2"; Rec."Balance As Due 2")
                {
                    ToolTip = 'Specifies the value of the Balance As Due 2 field.';
                }
                field("Current Rent Rate"; Rec."Current Rent Rate")
                {
                    ApplicationArea = All;
                }
                field(sr_AdditionalSecurityDepAmt; Rec.sr_AdditionalSecurityDepAmt)
                {
                    ApplicationArea = all;
                }
                field(sr_AdditionalSecDepAmtrequired; Rec.sr_AdditionalSecDepAmtrequired)
                {
                    ApplicationArea = all;
                }
                field(sr_securitydepositamount; Rec.sr_securitydepositamount)
                {
                    ApplicationArea = All;
                }
                field(sr_holddepositamount; Rec.sr_holddepositamount)
                {
                    ApplicationArea = All;
                }
                field(sr_holddeposittransferreq; Rec.sr_holddeposittransferreq)
                {
                    ApplicationArea = all;
                }
                field(sr_DepositAmtforStudiotransto; Rec.sr_DepositAmtforStudiotransto)
                {
                    ApplicationArea = all;
                }
                field(sr_docusignintegstatustransfer; Rec.sr_docusignintegstatustransfer)
                {
                    ApplicationArea = all;
                }

                field(sr_constrmoddepositamount; Rec.sr_constrmoddepositamount)
                {
                    ApplicationArea = all;
                }
                field(sr_petdepositamount; Rec.sr_petdepositamount)
                {
                    ApplicationArea = all;
                }
                field(sr_paintwallpaperdepositamount; Rec.sr_paintwallpaperdepositamount)
                {
                    ApplicationArea = All;
                }
                field(sr_stylingchairdepositamount; Rec.sr_stylingchairdepositamount)
                {
                    ApplicationArea = all;
                }
                field(sr_studiomodcoststolicensee; Rec.sr_studiomodcoststolicensee)
                {
                    ApplicationArea = all;
                }
                field(sr_studiomodificationcoststosr; Rec.sr_studiomodificationcoststosr)
                {
                    ApplicationArea = all;
                }
                field(sr_studiomodsecdeptolicens; Rec.sr_studiomodsecdeptolicens)
                {
                    ApplicationArea = all;
                }
                field(sr_studiomodpaymentreclicensee; Rec.sr_studiomodpaymentreclicensee)
                {
                    ApplicationArea = all;
                }
                field(sr_constructionagreeexecuted; Rec.sr_constructionagreeexecuted)
                {
                    ApplicationArea = all;
                }
                field(sr_modificationcostagreement; Rec.sr_modificationcostagreement)
                {
                    ApplicationArea = all;
                }
                field(sr_combinationmodexecuted; Rec.sr_combinationmodexecuted)
                {
                    ApplicationArea = all;
                }
                field(sr_studiocombinationstatus; Rec.sr_studiocombinationstatus)
                {
                    ApplicationArea = all;
                }
                field(sr_PaymentPlanStatus; Rec.sr_PaymentPlanStatus)
                {
                    ApplicationArea = all;
                }
                field(sr_weeklyaddpaymentamount; Rec.sr_weeklyaddpaymentamount)
                {
                    ApplicationArea = all;
                }
                field(sr_estimatedplancompletiondate; Rec.sr_estimatedplancompletiondate)
                {
                    ApplicationArea = all;
                }
                field(sr_planstartdate; Rec.sr_planstartdate)
                {
                    ApplicationArea = all;
                }
                field(sr_PaymentPlanLicensee; Rec.sr_PaymentPlanLicensee)
                {
                    ApplicationArea = all;
                }
                field(sr_totalweeklypaymentplan; Rec.sr_totalweeklypaymentplan)
                {
                    ApplicationArea = all;
                }
                field(sr_RenewalNewStartDate; Rec.sr_RenewalNewStartDate)
                {
                    ApplicationArea = all;
                }
                field(sr_RenewalNewEndDate; Rec.sr_RenewalNewEndDate)
                {
                    ApplicationArea = all;
                }
                field(sr_RenewalLAStatus; Rec.sr_RenewalLAStatus)
                {
                    ApplicationArea = all;
                }
                field(sr_RenewalNewSecurityDepositAmount; Rec.sr_RenewalNewSecDepositAmount)
                {
                    ApplicationArea = all;
                }
                field(sr_docusignintegrastatus_la; Rec.sr_docusignintegrastatus_la)
                {
                    ApplicationArea = all;
                }
                field(sr_LASecurityDepositAmount; Rec.sr_LASecurityDepositAmount)
                {
                    ApplicationArea = all;
                }
                field("Payment Plan"; Rec."Payment Plan")
                {
                    ApplicationArea = all;
                }

                //

                field(sr_RenewalStatus; Rec.sr_RenewalStatus)
                {
                    ApplicationArea = all;
                }
                field(LASecurity; Rec.LASecurity)
                {
                    ApplicationArea = all;
                }
                field(sr_AgreementTransferStatus; Rec.sr_AgreementTransferStatus)
                {
                    ApplicationArea = all;
                }
                field(sr_BCconstructionExcexuted; Rec.sr_BCconstructionExcexuted)
                {
                    ApplicationArea = all;
                }
                field("Additional Security Charge"; Rec."Additional Security Charge")
                {
                    ApplicationArea = all;
                }
                field("Additional Security Entry No."; Rec."Additional Security Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Security Charge Created Date"; Rec."Security Charge Created Date")
                {
                    ApplicationArea = all;
                }
                field("Security Charge Created Time"; Rec."Security Charge Created Time")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
    actions
    //All Page actions are related to D365 Dataverse sync. 
    {
        area(Processing)
        {
            group(ActionGroupCDS)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;
                action(GotoAgreements)
                {
                    Caption = 'Agreements';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Agreements.';
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
                ToolTip = 'View integration synchronization jobs for the Agreements.';

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
                    ToolTip = 'Create or modify the coupling to a Microsoft Dataverse Agreements.';

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
                    ToolTip = 'Delete the coupling to a Microsoft Dataverse Agreements.';

                    trigger OnAction()
                    var
                        CRMCouplingManagement: Codeunit "CRM Coupling Management";
                    begin
                        CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                    end;

                }
                action(SplitLicense)
                {
                    Caption = 'updatedimension';
                    ApplicationArea = All;
                    Visible = true;
                    trigger OnAction()
                    var
                        Subs: Codeunit "Subscriber Codeunit";
                    begin
                        Subs.UpdateDimensionValuesonAgreement(Rec);
                    end;
                }
                action(UpdateCustomerCode)
                {
                    Caption = 'UpdateCustomerCode';
                    ApplicationArea = All;
                    Visible = true;
                    trigger OnAction()
                    var
                        Subs: Codeunit "Subscriber Codeunit";
                    begin
                        Subs.UpdateCustomerCodeOnAgreement(Rec);
                    end;
                }
                action(UpdateDimensionOnCustomerCard)
                {
                    Caption = 'UpdateDimensionOnCustomerCard';
                    ApplicationArea = All;
                    Visible = true;
                    trigger OnAction()
                    var
                        Subs: Codeunit "Subscriber Codeunit";
                    begin
                        Subs.UpdateCustomerDimension(Rec);
                    end;
                }
                action(CreatePaymentPlan)
                {
                    Caption = 'CreatePaymentPlan';
                    ApplicationArea = All;
                    Visible = true;
                    trigger OnAction()
                    var
                        Epay: Codeunit "Epayment Management";
                    begin
                        //SRBC-266 - 08012025 - SY
                        //Epay.CreatePaymentPlan(Rec."Agreement ID");
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();

        Rec.CalcFields("Balance As Due");
        CurrPage.Update(false);
        Rec.SetRange("Date Filter", 0D, today());
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.CalcFields("Balance As Due");
        CurrPage.Update(false);
        Rec.SetRange("Date Filter", 0D, today());
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if CDSIntegrationEnabled then
            CDSIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);

        Rec.CalcFields("Balance As Due");
        CurrPage.Update(false);
    end;

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CDSIntegrationEnabled: Boolean;
        CDSIsCoupledToRecord: Boolean;
}
