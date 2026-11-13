/// <summary>
/// Page Agreement Schedule List (ID 50018).
/// </summary>
//SRBC-326 - 22032025 - SY - Added fields - "Recurring Charge Created", "Recurring Charge Created Date", "Recurring Charge Created Time" for update recurring charge created details
//SRBC-349 - 13062025 - SY - Did changes on action button - "Create Epay Schedule For Renewal"
//SRBC-405 - 20082025 - SY - Added new field - sr_renewalLADocuSign
//SRBC-471 - 12012025 - SY - Did changes on action - "Create Epay Schedule For Renewal" Added filter of "Current Agrement Start Date", "Current Agrement End Date"
page 90106 "Agreement Schedule List"
{
    ApplicationArea = All;
    Caption = 'Agreement Schedule List';
    PageType = List;
    SourceTable = "Agreement Schedule";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(sr_agreementid; Rec.sr_agreementid)
                {
                    ToolTip = 'Specifies the value of the Agreement field.';
                }
                field(sr_agreementscheduleId; Rec.sr_agreementscheduleId)
                {
                    ToolTip = 'Specifies the value of the Agreement Schedule field.';
                }
                field("Recurring Entry No."; Rec."Recurring Entry No.")
                {
                    ToolTip = 'Specifies the value of the Recurring Entry No. field.';
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
                field(sr_feeduedate; Rec.sr_feeduedate)
                {
                    ToolTip = 'Specifies the value of the Fee Due Date field.';
                }
                field("Current Agrement Start Date"; Rec."Current Agrement Start Date")
                {
                    ToolTip = 'Specifies the value of the Current Agrement Start Date field.';
                }
                field("Current Agrement End Date"; Rec."Current Agrement End Date")
                {
                    ToolTip = 'Specifies the value of the Current Agrement End Date field.';
                }
                field("Staggered End Due Date"; Rec."Staggered End Due Date")
                {
                    ToolTip = 'Specifies the value of the Staggered End Due Date field.';
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
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ToolTip = 'Specifies the value of the No. of Weeks field.';
                }
                field(sr_from; Rec.sr_from)
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field(sr_to; Rec.sr_to)
                {
                    ToolTip = 'Specifies the value of the To field.';
                }
                field(sr_name; Rec.sr_name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(sr_weeklylicensefee; Rec.sr_weeklylicensefee)
                {
                    ToolTip = 'Specifies the value of the Weekly License Fee field.';
                }
                field(sr_weeklylicensefee_Base; Rec.sr_weeklylicensefee_Base)
                {
                    ToolTip = 'Specifies the value of the Weekly License Fee (Base) field.';
                }
                field(new_abatementfee; Rec.new_abatementfee)
                {
                    ToolTip = 'Specifies the value of the Abatment Fee field.';
                }
                field(new_abatementfee_Base; Rec.new_abatementfee_Base)
                {
                    ToolTip = 'Specifies the value of the Abatment Fee Base field.';
                }
                field("Highest Amount"; Rec."Highest Amount")
                {
                    ToolTip = 'Specifies the value of the Highest Amount field.';
                }
                field(sr_IsLastRow; Rec.sr_IsLastRow)
                {
                    ToolTip = 'Specifies the value of the sr_IsLastRow field.';
                }
                field("CRM Renewal"; Rec."CRM Renewal")
                {
                    ToolTip = 'Specifies the value of the CRM Renewal field.';
                }
                //SRBC-405 Start
                field(sr_renewalLADocuSign; Rec.sr_renewalLADocuSign)
                {
                    ToolTip = 'Specifies the value of the sr_renewalLADocuSign field.', Comment = '%';
                }
                //SRBC-405 End
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    ToolTip = 'Specifies the value of the Security Deposit Amount field.';
                }
                field("New End Date"; Rec."New End Date")
                {
                    ToolTip = 'Specifies the value of the New End Date field.';
                }
                field("New Start Date"; Rec."New Start Date")
                {
                    ToolTip = 'Specifies the value of the New Start Date field.';
                }
                //SRBC-326 Start
                field("Recurring Charge Created"; Rec."Recurring Charge Created")
                {
                    ToolTip = 'Specifies the value of the Recurring Charge Created field.', Comment = '%';
                }
                field("Recurring Charge Created Date"; Rec."Recurring Charge Created Date")
                {
                    ToolTip = 'Specifies the value of the Recurring Charge Created Date field.', Comment = '%';
                }
                field("Recurring Charge Created Time"; Rec."Recurring Charge Created Time")
                {
                    ToolTip = 'Specifies the value of the Recurring Charge Created Time field.', Comment = '%';
                }
                //SRBC-326 End
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(Sequence; Rec.Sequence)
                {
                    ToolTip = 'Specifies the value of the Sequence field.';
                }
            }
        }
    }
    actions
    //All Page actions are related to D365 Dataverse sync. 
    {
        area(Processing)
        {
            group(Function)
            {
                //SRBC-175
                action("Create Recurring Charge")
                {
                    Caption = 'Create Recurring Charge';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create Recurring Charge action.';
                    trigger OnAction()
                    var
                        Variant: Variant;
                    begin
                        Variant := Rec;
                        RecurringChargesMgt.InsertRecurringLicenseFeeCharges(Variant);
                    end;
                }
                action("Create Discount Abatement Charges")
                {
                    Caption = 'Create Discount Abatement Charges';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create Discount Abatement Charges.';
                    trigger OnAction()
                    var
                        Variant_lRec: Variant;
                    begin
                        // if Rec.new_abatementfee <> 0 then begin
                        //     Variant_lRec := Rec;
                        //     RecurringChargesMgt.InsertDiscountAbatmentCharges(Variant_lRec);
                        // end else begin
                        //     Error('Field Abatement fee must have value');
                        // end;
                    end;
                }
                action("Update Staggered Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the Update Staggered Date action.';
                    trigger OnAction()
                    var
                        AgreementScheduleRec: Record "Agreement Schedule";
                        ModAgreementScheduleRec: Record "Agreement Schedule";
                    begin
                        AgreementScheduleRec.Reset();
                        AgreementScheduleRec.SetRange(sr_agreementid, Rec.sr_agreementid);
                        AgreementScheduleRec.SetCurrentKey(sr_from);
                        // AgreementScheduleRec.SetRange("Staggered End Due Date", 0D);
                        IF AgreementScheduleRec.FindSet() then
                            repeat
                                //SY
                                //AgreementScheduleRec.CalcFields("Current Agrement Start Date", "Current Agrement End Date");
                                ModAgreementScheduleRec.Get(AgreementScheduleRec.sr_agreementscheduleId);
                                ModAgreementScheduleRec."No. of Weeks" := (ModAgreementScheduleRec.sr_to - ModAgreementScheduleRec.sr_from) + 1;
                                If not ModAgreementScheduleRec.sr_IsLastRow then
                                    ModAgreementScheduleRec."Staggered End Due Date" := CalcDate(Format(ModAgreementScheduleRec."No. of Weeks") + 'W', ModAgreementScheduleRec.sr_feeduedate)
                                else
                                    ModAgreementScheduleRec."Staggered End Due Date" := AgreementScheduleRec."Current Agrement End Date";
                                ModAgreementScheduleRec.Modify();
                            until AgreementScheduleRec.Next() = 0;
                    end;
                }
                action("Create Epay Schedule For Renewal")
                {
                    Caption = 'Create Epay Schedule For Renewal';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create Epay Schedule For Renewal action.';
                    trigger OnAction()
                    var
                        Variant: Variant;
                        EPaymentManagement: Codeunit "Epayment Management";
                        RecurringCharge: Record "Recurring Charges";
                    // TESTCU: Codeunit "TEST CU"; //PS_16102026
                    begin
                        if not Rec."Epayment Schedule Created" then begin//SRBC-349
                            Variant := Rec;
                            // if Rec."CRM Renewal" = true then begin//SRBC-349 //SRBC-405 20082025
                            if (Rec."CRM Renewal") or (Rec.sr_renewalLADocuSign) then begin//SRBC-349 //SRBC-405 20082025
                                if (Rec."Current Agrement Start Date" <> 0D) and (Rec."Current Agrement End Date" <> 0D) then//SRBC-471 JSG 12012026
                                    EPaymentManagement.InsertEpaymentScheduleFromCRMRenewal(Variant, RecurringCharge);//SRBC-349
                                if GuiAllowed() then//SRBC-349
                                    Message('Epayment Schedule Created Successfully');//SRBC-349
                            end else
                                if GuiAllowed() then
                                    //Message('CRM Renewal must be true');//SRBC-471 JSG 12012026 Old              
                                    Message('CRM Renewal/Renewal LA Docusign must be true.');//SRBC-471 JSG 12012026 New
                        end else//SRBC-349 
                            if GuiAllowed() then//SRBC-349
                                Message('Epayment Schedle already created.');//SRBC-349
                        //TESTCU.InserAS();
                    end;
                }
            }
            group(ActionGroupCDS)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;
                action(GotoAgreements)
                {
                    Caption = 'Agreement Schedule';
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
            }
        }
    }
    var
        RecurringChargesMgt: Codeunit "Recurring Charges Mgt.";
        EpaymentSchedule: Codeunit "Epayment Management";
        RecCharges: Record "Recurring Charges";

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
