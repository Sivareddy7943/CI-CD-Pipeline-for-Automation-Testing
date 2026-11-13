//SRBC-207 - 03012025 - SY - Added field - "Epayment Schedule Created" for reference against this entry Epayment Schedule is created or not.
//           07012025 - SY - Added field - Salon, Studio, "Customer No.", "Customer Name","BC Cust. Bank Account",sr_accountname, "Current Agreement Start Date", "Current Agreement End Date", "Epayment Schedule Created Date", "Epayment Schedule Created Time"
//         - 13012025 - SY - Added action buttoin "Create Epayment Schedule" for create epayment schedule 
//SRBC-307 - 10032025 - SY - Added field "Stripe Payment Method Status" for update status from Customer Bank Account
//         - 18032025 - SY - On action button - "Create Epayment Schedule" if Stripe Bank Account Status isn't active will not create epayment schedule
//SRBC-463 - 18122025 - ST - On action button - "Create Epayment Schedule" not to Create E-Pay Schedules from ACH Payments for the Frequency type "Others"
//SRBC-473 - 30012026 - SY - Added field "Payment For" 
//         - 29042026 - AM - Added field Payment For Id 
page 90101 "ACH Payment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ACH Payment List";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("ACH Payments"; Rec."ACH Payments ID")
                {
                    ToolTip = 'Specifies the value of the ACH Payments field.', Comment = '%';
                }
                field("Bank Account"; Rec."Bank Account Info ID")
                {
                    ToolTip = 'Specifies the value of the Bank Account field.', Comment = '%';
                }
                field("License ID"; Rec."License ID")
                {
                    ToolTip = 'Specifies the value of the License ID field.', Comment = '%';
                }
                field(Agreement; Rec."Agreement ID")
                {
                    ToolTip = 'Specifies the value of the Agreement field.', Comment = '%';
                }
                //SRBC-207 Start
                field(Salon; Rec.Salon)
                {
                    ToolTip = 'Specifies the value of the Salon field.', Comment = '%';
                }
                field(Studio; Rec.Studio)
                {
                    ToolTip = 'Specifies the value of the Studio field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("BC Cust. Bank Account"; Rec."BC Cust. Bank Account")
                {
                    ToolTip = 'Specifies the value of the BC Cust. Bank Account field.', Comment = '%';
                }
                field(sr_accountname; Rec.sr_accountname)
                {
                    ToolTip = 'Specifies the value of the Account Name field.', Comment = '%';
                }
                field("Current Agreement Start Date"; Rec."Current Agreement Start Date")
                {
                    ToolTip = 'Specifies the value of the Current Agreement Start Date field.', Comment = '%';
                }
                field("Current Agreement End Date"; Rec."Current Agreement End Date")
                {
                    ToolTip = 'Specifies the value of the Current Agreement End Date field.', Comment = '%';
                }
                //SRBC-307 Start
                field("Stripe Payment Method Status"; Rec."Stripe Payment Method Status")
                {
                    ToolTip = 'Specifies the value of the Stripe Payment Method Status field.', Comment = '%';
                }
                //SRBC-307 End

                //SRBC-207 End
                field(sr_authorizedepaymentstartdate; Rec.sr_authorizedepaymentstartdate)
                {
                    ToolTip = 'Specifies the value of the sr_authorizedepaymentstartdate field.', Comment = '%';
                }
                field("Authorized E-Payment Amount"; Rec."Authorized E-Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Authorized E-Payment Amount field.', Comment = '%';
                }
                field("Authorized E-Payment Frequency"; Rec."Authorized E-Payment Frequency")
                {
                    ToolTip = 'Specifies the value of the Authorized E-Payment Frequency field.', Comment = '%';
                }
                //SRBC-473 Start 18042026
                field("Payment For"; Rec."Payment For")
                {
                    ToolTip = 'Specifies the value of the Payment For field.', Comment = '%';
                }
                field("Payment For Id"; Rec."Payment For Id")
                {
                    ToolTip = 'Specifies the value of the Payment For field.', Comment = '%';
                }
                //SRBC-473 End 29042026
                //SRBC-207 Start 
                field("Epayment Schedule Created"; Rec."Epayment Schedule Created")
                {
                    ToolTip = 'Specifies the value of the Epayment Schedule Created field.', Comment = '%';
                }
                field("Epayment Schedule Created Date"; Rec."Epayment Schedule Created Date")
                {
                    ToolTip = 'Specifies the value of the Epayment Schedule Created Date field.', Comment = '%';
                }
                field("Epayment Schedule Created Time"; Rec."Epayment Schedule Created Time")
                {
                    ToolTip = 'Specifies the value of the Epayment Schedule Created Time field.', Comment = '%';
                }
                //SRBC-207 End
            }
        }
        area(Factboxes) { }
    }

    actions
    {
        area(Processing)
        {
            group(ActionGroupCDS)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;
                action(GotoACHPayments)
                {
                    Caption = 'ACH Payments';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse ACH Payments.';
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
                        ToolTip = 'Create or modify the coupling to a Microsoft Dataverse ACH Payments.';

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
                        ToolTip = 'Delete the coupling to a Microsoft Dataverse ACH Payments.';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                        end;

                    }
                    //SRBC-207 Start
                    //     action("Create Epayment Schedule")
                    //     {
                    //         // Promoted = true;
                    //         // PromotedCategory = Process;
                    //         // PromotedIsBig = true;
                    //         // PromotedOnly = true;
                    //         ApplicationArea = all;
                    //         Visible = true;
                    //         Caption = 'Create Epay Schedule';
                    //         trigger OnAction()
                    //         var
                    //             EpaymentScheduleMgmt: Codeunit "Epayment Management";
                    //             Variant_lRec: Variant;
                    //             SRSETUP: Record "Salon Republic Setup";
                    //             BankAccInfo: Record "Banking Account Info";//SRBC-307
                    //         begin
                    //             SRSETUP.Get();
                    //             SRSETUP.TestField("Create Epay From Bank Info");
                    //             Rec.TestField("Bank Account Info ID");
                    //             Rec.TestField("Epayment Schedule Created", false);
                    //             rec.TestField("Agreement ID");
                    //             Rec.TestField("Authorized E-Payment Amount");
                    //             Rec.TestField("License ID");
                    //             if Rec."Stripe Payment Method Status" <> 'active' then begin//SRBC-307
                    //                 Message('Stripe Payment Method status must be active');//SRBC-307
                    //                 exit;//SRBC-307
                    //             end;//SRBC-307
                    //             if Rec."Epayment Schedule Created" then
                    //                 exit;
                    //             if IsNullGuid(Rec."Agreement ID") then
                    //                 exit;
                    //             if not BankAccInfo.Get(Rec."Bank Account Info ID") then//SRBC-307
                    //                 exit;//SRBC-307
                    //             if not SRSETUP."Create Epay From Bank Info" then
                    //                 exit;
                    //             // if Rec."Payment For" = Rec."Payment For"::" " then//SRBC-473 AM 29042026
                    //             if Rec."Payment For" = '' then //SRBC-473 AM 29042026
                    //                 exit;//SRBC-473
                    //             //SRBC-463 Start    
                    //             if Rec."Authorized E-Payment Frequency" = Rec."Authorized E-Payment Frequency"::Other then
                    //                 exit;
                    //             //SRBC-463 End
                    //             Variant_lRec := Rec;
                    //             EpaymentScheduleMgmt.CreateEpaymentFromACHPayments(Rec."Agreement ID", Variant_lRec);
                    //         end;
                    //     }
                    //     //SRBC-207 End

                    //     //17022025 - Start
                    //     action("Update ACH Payment List")
                    //     {
                    //         // Promoted = true;
                    //         // PromotedCategory = Process;
                    //         // PromotedIsBig = true;
                    //         // PromotedOnly = true;
                    //         ApplicationArea = all;
                    //         trigger OnAction()
                    //         var
                    //             BankingAccInfo: Record "Banking Account Info";
                    //         begin
                    //             if BankingAccInfo.Get(Rec."Bank Account Info ID") then begin
                    //                 Rec.Validate("BC Cust. Bank Account", BankingAccInfo."BC Cust. Bank Account");
                    //                 Rec.Validate(sr_accountname, BankingAccInfo.sr_accountname);
                    //                 Rec.Modify();
                    //             end;
                    //         end;
                    //     }
                    //     // 17022025 - End
                }
            }
            group(ACHPaymentActions)
            {
                Caption = 'ACH Payment Actions';
                Image = Process;

                action("Create Epayment Schedule")
                {
                    ApplicationArea = All;
                    Caption = 'Create Epay Schedule';
                    Image = Create;

                    ToolTip = 'Create an E-Payment schedule for the selected ACH payment.';

                    trigger OnAction()
                    var
                        EpaymentScheduleMgmt: Codeunit "Epayment Management";
                        Variant_lRec: Variant;
                        SRSETUP: Record "Salon Republic Setup";
                        BankAccInfo: Record "Banking Account Info";
                    begin
                        SRSETUP.Get();
                        SRSETUP.TestField("Create Epay From Bank Info");
                        Rec.TestField("Bank Account Info ID");
                        Rec.TestField("Epayment Schedule Created", false);
                        Rec.TestField("Agreement ID");
                        Rec.TestField("Authorized E-Payment Amount");
                        Rec.TestField("License ID");

                        if Rec."Stripe Payment Method Status" <> 'active' then begin
                            Message('Stripe Payment Method status must be active');
                            exit;
                        end;

                        if IsNullGuid(Rec."Agreement ID") then
                            exit;

                        if not BankAccInfo.Get(Rec."Bank Account Info ID") then
                            exit;

                        if not SRSETUP."Create Epay From Bank Info" then
                            exit;

                        if Rec."Payment For" = '' then
                            exit;

                        if Rec."Authorized E-Payment Frequency" =
                           Rec."Authorized E-Payment Frequency"::Other
                        then
                            exit;

                        Variant_lRec := Rec;
                        EpaymentScheduleMgmt.CreateEpaymentFromACHPayments(
                            Rec."Agreement ID", Variant_lRec);
                    end;
                }

                action("Update ACH Payment List")
                {
                    ApplicationArea = All;
                    Caption = 'Update ACH Payment List';
                    Image = Refresh;
                    ToolTip = 'Update bank account details on the selected ACH payment.';

                    trigger OnAction()
                    var
                        BankingAccInfo: Record "Banking Account Info";
                    begin
                        if BankingAccInfo.Get(Rec."Bank Account Info ID") then begin
                            Rec.Validate(
                                "BC Cust. Bank Account",
                                BankingAccInfo."BC Cust. Bank Account");
                            Rec.Validate(
                                sr_accountname,
                                BankingAccInfo.sr_accountname);
                            Rec.Modify(true);
                        end else
                            Error('Bank Account Info record was not found.');
                    end;
                }
            }
        }
        area(Promoted)
        {
            actionref(CreateEpaymentSchedule; "Create Epayment Schedule")
            {
            }

            actionref(UpdateEpayList; "Update ACH Payment List")
            {
            }
        }
    }
    trigger OnOpenPage()
    begin
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

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