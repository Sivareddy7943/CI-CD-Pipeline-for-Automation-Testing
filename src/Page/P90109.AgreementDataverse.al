/// <summary>
/// Page Agreement - Dataverse (ID 50012).
/// </summary>
page 90109 "Agreement - Dataverse"
{
    ApplicationArea = All;
    Caption = 'Agreement - Dataverse';
    PageType = List;
    SourceTable = "CDS sr_agreement";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(sr_agreementId; Rec.sr_agreementId)
                {
                    ToolTip = 'Specifies the value of the Agreement field.';
                }
                field(sr_licenseeid; Rec.sr_licenseeid)
                {
                    ToolTip = 'Specifies the value of the Licensee field.';
                }
                field(sr_Licensee; Rec.sr_Licensee)
                {
                    ToolTip = 'Specifies the value of the Licensee field.';
                }
                field(sr_name; Rec.sr_name)
                {
                    ToolTip = 'Specifies the value of the Quick link to Agreement/ Ledger field.';
                }
                field(sr_studioid; Rec.sr_studioid)
                {
                    ToolTip = 'Specifies the value of the Studio # field.';
                }
                field(sr_Studio; Rec.sr_Studio)
                {
                    ToolTip = 'Specifies the value of the Studio # field.';
                }
                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the statecode field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the statuscode field.';
                }
                field(sr_currentrentrate; Rec.sr_currentrentrate)
                {
                    ToolTip = 'Specifies the value of the sr_currentrentrate field.';
                }
                field(sr_totalsecuritydeposit; Rec.sr_totalsecuritydeposit)
                {
                    ToolTip = 'Specifies the value of the Total Security Deposit field.';
                }
                field(sr_totalsecuritydeposit_Base; Rec.sr_totalsecuritydeposit_Base)
                {
                    ToolTip = 'Specifies the value of the Total Security Deposit (Base) field.';
                }
                field(sr_currentagreementstartdate; Rec.sr_currentagreementstartdate)
                {
                    ToolTip = 'Specifies the value of the sr_currentagreementstartdate field.';
                }
                field(sr_currentagreementenddate; Rec.sr_currentagreementenddate)
                {
                    ToolTip = 'Specifies the value of the sr_currentagreementenddate field.';
                }
                field(sr_AdditionalSecurityDepositAmount; Rec.sr_AdditionalSecurityDepositAmount)
                {
                    ApplicationArea = all;

                }
                field(sr_AdditionalSecurityDepositAmountrequired; Rec.sr_AdditionalSecurityDepositAmountrequired)
                {
                    ApplicationArea = All;
                }
                field(sr_securitydepositamount; Rec.sr_securitydepositamount)
                {
                    ApplicationArea = All;
                }
                field(sr_holddepositamount; Rec.sr_holddepositamount)
                {
                    ApplicationArea = All;
                }
                field(sr_holddeposittransferrequested; Rec.sr_holddeposittransferrequested)
                {
                    ApplicationArea = all;
                }
                field(sr_DepositAmountforStudiotransferringto; Rec.sr_DepositAmountforStudiotransferringto)
                {
                    ApplicationArea = all;
                }
                field(sr_docusignintegrationstatus_transfer; Rec.sr_docusignintegrationstatus_transfer)
                {
                    ApplicationArea = all;
                }
                field(sr_constructionmodificationdepositamount; Rec.sr_constructionmodificationdepositamount)
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
                field(sr_BCAccountNo; Rec.sr_BCAccountNo)
                {
                    ApplicationArea = all;
                }
                field(sr_studiomodificationcoststolicensee; Rec.sr_studiomodificationcoststolicensee)
                {
                    ApplicationArea = all;
                }
                field(sr_studiomodificationcoststosr; Rec.sr_studiomodificationcoststosr)
                {
                    ApplicationArea = all;
                }
                field(sr_studiomodificationsecuritydeposittolicens; Rec.sr_studiomodificationsecuritydeposittolicens)
                {
                    ApplicationArea = all;
                }
                field(sr_studiomodificationpaymentreceivedlicensee; Rec.sr_studiomodificationpaymentreceivedlicensee)
                {
                    ApplicationArea = all;
                }
                field(sr_constructionagreementexecuted; Rec.sr_constructionagreementexecuted)
                {
                    ApplicationArea = all;
                }
                field(sr_modificationcostagreement; Rec.sr_modificationcostagreement)
                {
                    ApplicationArea = all;
                }
                field(sr_combinationmodificationexecuted; Rec.sr_combinationmodificationexecuted)
                {
                    ApplicationArea = all;
                }
                field(sr_studiocombinationstatus; Rec.sr_studiocombinationstatus)
                {
                    ApplicationArea = all;
                }
                field(sr_latestbalanceaccountledger_Base; Rec.sr_latestbalanceaccountledger_Base)
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
                field(sr_RenewalNewSecurityDepositAmount; Rec.sr_RenewalNewSecurityDepositAmount)
                {
                    ApplicationArea = all;
                }
                field(sr_docusignintegrationstatus_la; Rec.sr_docusignintegrationstatus_la)
                {
                    ApplicationArea = all;
                }
                field(sr_LASecurityDepositAmount; Rec.sr_LASecurityDepositAmount)
                {
                    ApplicationArea = all;
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ToolTip = 'Specifies the value of the Created On field.';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'Specifies the value of the Modified By field.';
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ToolTip = 'Specifies the value of the Modified On field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateInBusinessCentral)
            {
                ApplicationArea = all;
                Caption = 'Create In Business Central';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Generate the table from the AL Proxy Table';
                trigger OnAction()
                var
                    Cdsagreement: Record "CDS sr_agreement";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CurrPage.SetSelectionFilter(Cdsagreement);
                    CRMIntegrationManagement.CreateNewRecordsFromCRM(Cdsagreement);
                end;
            }
        }
    }
    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        //Commit(); //MSFT
    end;

    procedure SetCurrentlyCoupledCDSagreement(Cdsagreement: Record "CDS sr_agreement")
    begin
        CurrentlyCoupledCDSPayment := Cdsagreement;
    end;

    var
        CurrentlyCoupledCDSPayment: Record "CDS sr_agreement";
}
