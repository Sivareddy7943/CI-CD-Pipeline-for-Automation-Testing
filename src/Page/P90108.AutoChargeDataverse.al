//SRBC-421 - Added fields from table
page 90108 "AutoCharge - Dataverse"
{
    ApplicationArea = All;
    Caption = 'AutoCharge - Dataverse';
    PageType = List;
    SourceTable = "CDS sr_autocharge";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(sr_autochargeId; Rec.sr_autochargeId)
                {
                    ToolTip = 'Specifies the value of the Auto Charge PK field.';
                }
                field(sr_autochargetypecode; Rec.sr_autochargetypecode)
                {
                    ToolTip = 'Specifies the value of the Table 50102 Auto Charge Type field.';
                }
                field(sr_agreementid; Rec.sr_agreementid)
                {
                    ToolTip = 'Specifies the value of the Agreement field.';
                }
                field(new_AgreementStartDate; Rec.new_AgreementStartDate)
                {
                    ToolTip = 'Specifies the value of the Agreement Start Date field.';
                }
                //SRBC-421 Start
                // field(new_NextChargeDate; Rec.new_NextChargeDate)
                // {
                //     ToolTip = 'Specifies the value of the Next Charge Date field.';
                // }
                //SRBC-421 End
                field(new_SrBCEntryNo; Rec.new_SrBCEntryNo)
                {
                    ToolTip = 'Specifies the value of the BC ENtry No. field.';
                }
                field(sr_frequency; Rec.sr_frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field(new_SalonCode; Rec.new_SalonCode)
                {
                    ToolTip = 'Specifies the value of the Salon Code field.';
                }
                field(new_StudioCode; Rec.new_StudioCode)
                {
                    ToolTip = 'Specifies the value of the Studio Code field.';
                }
                field(sr_abatementamount; Rec.sr_abatementamount)
                {
                    ToolTip = 'Specifies the value of the Abatement Amount field.';
                }
                field(sr_abatementamount_Base; Rec.sr_abatementamount_Base)
                {
                    ToolTip = 'Specifies the value of the Abatement Amount (Base) field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(sr_amount; Rec.sr_amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(sr_amount_Base; Rec.sr_amount_Base)
                {
                    ToolTip = 'Specifies the value of the Amount (Base) field.';
                }
                field(sr_chargeanticipatedenddate; Rec.sr_chargeanticipatedenddate)
                {
                    ToolTip = 'Specifies the value of the Charge Anticipated End Date field.';
                }
                field(sr_chargeenddate; Rec.sr_chargeenddate)
                {
                    ToolTip = 'Specifies the value of the Charge End Date field.';
                }
                field(sr_chargestartdate; Rec.sr_chargestartdate)
                {
                    ToolTip = 'Specifies the value of the Charge Start Date field.';
                }
                field(sr_chargetype; Rec.sr_chargetype)
                {
                    ToolTip = 'Specifies the value of the Charge Type field.';
                }
                field(sr_conveniencecharge; Rec.sr_conveniencecharge)
                {
                    ToolTip = 'Specifies the value of the Convenience Charge field.';
                }
                field(sr_conveniencecharge_Base; Rec.sr_conveniencecharge_Base)
                {
                    ToolTip = 'Specifies the value of the Convenience Charge (Base) field.';
                }
                field(sr_description; Rec.sr_description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(sr_discountamount; Rec.sr_discountamount)
                {
                    ToolTip = 'Specifies the value of the Discount Amount field.';
                }
                field(sr_discountamount_Base; Rec.sr_discountamount_Base)
                {
                    ToolTip = 'Specifies the value of the Discount Amount (Base) field.';
                }
                field(sr_discounttype; Rec.sr_discounttype)
                {
                    ToolTip = 'Specifies the value of the Discount Type field.';
                }
                field(sr_dueday; Rec.sr_dueday)
                {
                    ToolTip = 'Specifies the value of the Due Day field.';
                }
                //SRBC-421 Start
                field(sr_WeekDays; Rec.sr_WeekDays)
                {
                    ToolTip = 'Specifies the value of the Week Days field.', Comment = '%';
                }
                field(sr_MonthDay; Rec.sr_MonthDay)
                {
                    ToolTip = 'Specifies the value of the Month Day field.', Comment = '%';
                }
                field(sr_MonthName; Rec.sr_MonthName)
                {
                    ToolTip = 'Specifies the value of the Month Name field.', Comment = '%';
                }
                //SRBC-421 End
                field(sr_lastposteddate; Rec.sr_lastposteddate)
                {
                    ToolTip = 'Specifies the value of the Last Posted field.';
                }
                //SRBC-421 Start
                field(new_NextChargeDate; Rec.new_NextChargeDate)
                {
                    ToolTip = 'Specifies the value of the Next Charge Date field.';
                }
                //SRBC-421 End
                field(sr_name; Rec.sr_name)
                {
                    ToolTip = 'Specifies the value of the Auto Charge Name field.';
                }
                field(sr_Inactive; Rec.sr_Inactive)
                {
                    ToolTip = 'Specifies the value of the sr_Inactive field.';
                }
                //SRBC-421 Start
                field(sr_IsBC; Rec.sr_IsBC)
                {
                    ToolTip = 'Specifies the value of the IsBC field.', Comment = '%';
                }
                field(sr_IsCRM; Rec.sr_IsCRM)
                {
                    ToolTip = 'Specifies the value of the IsCRM field.', Comment = '%';
                }
                //SRBC-421 End
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ToolTip = 'Specifies the value of the Created On field.';
                }

                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'Specifies the value of the Modified By field.';
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ToolTip = 'Specifies the value of the Modified On field.';
                }

                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the Status Reason field.';
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
                    CdsAutocharge: Record "CDS sr_autocharge";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CurrPage.SetSelectionFilter(CdsAutocharge);
                    CRMIntegrationManagement.CreateNewRecordsFromCRM(CdsAutocharge);
                end;
            }
        }
    }
    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        Commit(); //MSFT
    end;

    procedure SetCurrentlyCoupledCDSAutoCharge(CdsAutoCharge: Record "CDS sr_autocharge")
    begin
        CurrentlyCoupledCDSPayment := CdsAutoCharge;
    end;

    var
        CurrentlyCoupledCDSPayment: Record "CDS sr_autocharge";
}
