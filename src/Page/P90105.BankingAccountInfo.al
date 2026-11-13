//SRBC-432 SY 24042026 Did changes on action-"Update Customer and Cust. Bank Account" for update Cust. Bank Account
//SRBC-493 SY 08062026 Added field "Stripe Verification Status", "Stripe Account Status", "Setup Intent Status", "Stripe Mandate Id", "Status Reason", "Status Description"
page 90105 "Banking Account Info"
{

    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Banking Account Info";
    Caption = 'Banking Account Info';
    PageType = List;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(sr_bankingaccountinfoId; Rec.sr_bankingaccountinfoId)
                {
                    ToolTip = 'Specifies the value of the Banking Account Info field.';
                }
                field("BC Customer Code"; Rec."BC Customer Code")
                {
                    ToolTip = 'Specifies the value of the BC Customer Code field.';
                }
                field("BC Cust. Bank Account"; Rec."BC Cust. Bank Account")
                {
                    ToolTip = 'Specifies the value of the BC Cust. Bank Account field.';
                }
                field(sr_agreement; Rec.sr_agreement)
                {
                    ToolTip = 'Specifies the value of the Agreement field.';
                }
                field(sr_AccountAddress; Rec.sr_AccountAddress)
                {
                    ToolTip = 'Specifies the value of the Account Address field.';
                }
                field(sr_accountname; Rec.sr_accountname)
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field(sr_accountnickname; Rec.sr_accountnickname)
                {
                    ToolTip = 'Specifies the value of the Account Nickname field.';
                }
                field(sr_accountnumber; Rec.sr_accountnumber)
                {
                    ToolTip = 'Specifies the value of the Account Number field.';
                }
                field(sr_accountnumbermasked; Rec.sr_accountnumbermasked)
                {
                    ToolTip = 'Specifies the value of the Account Number (Masked) field.';
                }
                field(sr_accounttype; Rec.sr_accounttype)
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(sr_achdocumentenvelopeid; Rec.sr_achdocumentenvelopeid)
                {
                    ToolTip = 'Specifies the value of the ACH Document Envelope Id field.';
                }
                field(sr_achlicenseeguid; Rec.sr_achlicenseeguid)
                {
                    ToolTip = 'Specifies the value of the ACH Licensee Guid field.';
                }
                field(sr_achsalonandpropertymanager; Rec.sr_achsalonandpropertymanager)
                {
                    ToolTip = 'Specifies the value of the ACH Salon and Property Manager Guid field.';
                }
                field(sr_address2; Rec.sr_address2)
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }

                field(sr_authorizedepaymentamount; Rec.sr_authorizedepaymentamount)
                {
                    ToolTip = 'Specifies the value of the Authorized E-Payment Amount field.';
                }
                field(sr_authorizedepaymentamt_Base; Rec.sr_authorizedepaymentamt_Base)
                {
                    ToolTip = 'Specifies the value of the Authorized E-Payment Amount (Base) field.';
                }
                field(sr_authorizedepaymentfrequency; Rec.sr_authorizedepaymentfrequency)
                {
                    ToolTip = 'Specifies the value of the Authorized E-Payment Frequency field.';
                }
                field("Current Agreement Start Date"; Rec."Current Agreement Start Date")
                {
                    ToolTip = 'Specifies the value of the Current Agreement Start Date field.', Comment = '%';
                }
                field("Current Agreement End Date "; Rec."Current Agreement End Date ")
                {
                    ToolTip = 'Specifies the value of the Current Agreement End Date field.', Comment = '%';
                }
                field(sr_authorizedepaymentstartdate; Rec.sr_authorizedepaymentstartdate)
                {
                    ToolTip = 'Specifies the value of the Authorized E-Payment Start Date field.';
                }

                field(sr_bankname; Rec.sr_bankname)
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(sr_billingaddress; Rec.sr_billingaddress)
                {
                    ToolTip = 'Specifies the value of the Billing Address field.';
                }
                field(sr_billingemail; Rec.sr_billingemail)
                {
                    ToolTip = 'Specifies the value of the Billing Email field.';
                }
                field(sr_birthdate; Rec.sr_birthdate)
                {
                    ToolTip = 'Specifies the value of the Birth Date field.';
                }
                field(sr_city; Rec.sr_city)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(sr_currentparticipation; Rec.sr_currentparticipation)
                {
                    ToolTip = 'Specifies the value of the Current Participation field.';
                }
                field(sr_drivinglicensenumber; Rec.sr_drivinglicensenumber)
                {
                    ToolTip = 'Specifies the value of the Driving License # field.';
                }
                field(sr_drivinglicensestateprovince; Rec.sr_drivinglicensestateprovince)
                {
                    ToolTip = 'Specifies the value of the Driving License State/Province field.';
                }
                field(sr_expirydate; Rec.sr_expirydate)
                {
                    ToolTip = 'Specifies the value of the Expiry Date field.';
                }
                field(sr_firstname; Rec.sr_firstname)
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field(sr_frequencyother; Rec.sr_frequencyother)
                {
                    ToolTip = 'Specifies the value of the Frequency Other field.';
                }
                field(sr_keepitsecret; Rec.sr_keepitsecret)
                {
                    ToolTip = 'Specifies the value of the Keep It Secret field.';
                }
                field(sr_lastname; Rec.sr_lastname)
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(sr_licenseeid; Rec.sr_licenseeid)
                {
                    ToolTip = 'Specifies the value of the Licensee field.';
                }
                field(sr_phonenumber; Rec.sr_phonenumber)
                {
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(sr_routingnumber; Rec.sr_routingnumber)
                {
                    ToolTip = 'Specifies the value of the Routing Number field.';
                }
                field(sr_salonid; Rec.sr_salonid)
                {
                    ToolTip = 'Specifies the value of the Salon field.';
                }
                field(sr_socialsecuritynumber; Rec.sr_socialsecuritynumber)
                {
                    ToolTip = 'Specifies the value of the Social Security # field.';
                }
                field(sr_stateprovince; Rec.sr_stateprovince)
                {
                    ToolTip = 'Specifies the value of the State/Province field.';
                }
                field(sr_studioid; Rec.sr_studioid)
                {
                    ToolTip = 'Specifies the value of the Studio field.';
                }
                field(sr_zippostalcode; Rec.sr_zippostalcode)
                {
                    ToolTip = 'Specifies the value of the Zip/Postal Code field.';
                }
                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Epayment Create"; Rec."Epayment Created")
                {
                    ToolTip = 'Specifies the value of the Epayment Created field.';
                }
                field(sr_StripePaymentMethodId; Rec.sr_StripePaymentMethodId)
                {
                    ToolTip = 'Specifies the value of the sr_StripePaymentMethodId field.';
                }
                field(sr_StripeCustomerId; Rec.sr_StripeCustomerId)
                {
                    ToolTip = 'Specifies the value of the sr_StripeCustomerId field.';
                }
                field(sr_StripeSetupIntentId; Rec.sr_StripeSetupIntentId)
                {
                    ToolTip = 'Specifies the value of the sr_StripeSetupIntentId field.';
                }
                //SRBC-493 Start
                field("Stripe Verification Status"; Rec."Stripe Verification Status")
                {
                    ToolTip = 'Specifies the value of the Stripe Verification Status field.';
                }
                field("Stripe Mandate Status"; Rec."Stripe Mandate Status")
                {
                    ToolTip = 'Specifies the value of the Stripe Mandate Status field.';
                }
                field("Setup Intent Status"; Rec."Setup Intent Status")
                {
                    ToolTip = 'Specifies the value of the Setup Intent Status field.';
                }
                field("Stripe Mandate Id"; Rec."Stripe Mandate Id")
                {
                    ToolTip = 'Specifies the value of the Stripe Mandate Id field.';
                }
                field("Status Reason"; Rec."Status Reason")
                {
                    ToolTip = 'Specifies the value of the Status Reason field.';
                }
                field("Status Description"; Rec."Status Description")
                {
                    ToolTip = 'Specifies the value of the Status Description field.';
                }
                field("Stripe Account Status"; Rec."Stripe Account Status")
                {
                    ToolTip = 'Specifies the value of the Stripe Account Status field.';
                }
                field("Stripe Finger Print ID"; Rec."Stripe Finger Print ID")
                {
                    ToolTip = 'Specifies the value of the Stripe Finger Print ID field.';
                }
                //SRBC-493 End
                field(sr_StripeSecret; Rec.sr_StripeSecret)
                {
                    ToolTip = 'Specifies the value of the sr_StripeSecret field.';
                }
                field(IsStripeVerified; Rec.IsStripeVerified)
                {
                    ToolTip = 'Specifies the value of the IsStripeVerified field.';
                }
                field(sr_OneTimePayment; Rec.sr_OneTimePayment)
                {
                    ToolTip = 'Specifies the value of the sr_OneTimePayment field.';
                }
                field(sr_SyncedToBC; Rec.sr_SyncedToBC)
                {
                    ToolTip = 'Specifies the value of the sr_SyncedToBC field.';
                }
                field(Duplicate; Rec.Duplicate)
                {
                    ToolTip = 'Specifies the value of the Duplicate field.';
                }
                field(TransactionCurrencyId; Rec.TransactionCurrencyId)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
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
        area(Factboxes) { }
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
                    Caption = 'Banking Account Info';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Banking Account Info.';
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
                ToolTip = 'View integration synchronization jobs for the Banking Account Info table.';

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
                    ToolTip = 'Create or modify the coupling to a Microsoft Dataverse Banking Account Info.';

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
                    ToolTip = 'Delete the coupling to a Microsoft Dataverse Banking Account Info.';

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
                action("Update Customer and Cust. Bank Account")
                {
                    Caption = 'Update Customer and Cust. Bank Account';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Update Customer and Cust. Bank Account action.';
                    trigger OnAction()
                    var
                        Variant: Variant;
                        EpaymentSchedule: Codeunit "Epayment Management";
                        CustBankAccPar: Code[20];
                        CustBankAcc: Record "Customer Bank Account";//SRBC-432
                    begin
                        //SRBC-432 Start
                        // Variant := Rec;
                        // EpaymentSchedule.InsertCustBankAccount(CustBankAccPar, Rec."BC Customer Code", Rec.sr_agreement, Variant);
                        if NOT Rec.sr_OneTimePayment then begin
                            EpaymentSchedule.InsertCustBankAccount(CustBankAccPar, Rec."BC Customer Code", Rec.sr_agreement, Rec);
                            Rec.Validate("BC Cust. Bank Account", CustBankAccPar);
                            CustBankAcc.Reset();
                            CustBankAcc.SetRange(Code, Rec."BC Cust. Bank Account");
                            CustBankAcc.SetRange("Bank Account Info", Rec.sr_bankingaccountinfoId);
                            CustBankAcc.SetRange("License ID", Rec.sr_licenseeid);
                            if CustBankAcc.FindFirst() then begin
                                Rec.Validate(sr_StripePaymentMethodId, CustBankAcc."Payment Method ID2");
                                Rec.Validate(sr_StripeCustomerId, CustBankAcc."Stripe Customer ID2");
                                Rec.Validate(sr_StripeSetupIntentId, CustBankAcc."Setup Intent ID2");
                                Rec.Validate(sr_StripeSecret, CustBankAcc."Card URL2");
                                Rec.Validate(IsStripeVerified, true);
                            end;
                            Rec.Validate(sr_SyncedToBC, true);
                            Rec.Modify();
                        end;
                        //SRBC-432 End
                    end;
                }
                action("Update Stripe Details")
                {
                    Caption = 'Update Stripe Details';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Update Stripe Details action.';
                    trigger OnAction()
                    var
                        Variant: Variant;
                        EpaymentSchedule: Codeunit "Epayment Management";
                        CustBankAccPar: Code[20];
                        CustBankAcc: Record "Customer Bank Account";
                    begin
                        CustBankAcc.Reset();
                        CustBankAcc.SetRange("Customer No.", Rec."BC Customer Code");
                        CustBankAcc.SetRange("Bank Account Info", Rec.sr_bankingaccountinfoId);
                        CustBankAcc.SetRange("Agreement ID", Rec.sr_agreement);
                        if CustBankAcc.FindFirst() then begin
                            Rec.Validate(sr_StripePaymentMethodId, CustBankAcc."Payment Method ID2");
                            Rec.Validate(sr_StripeCustomerId, CustBankAcc."Stripe Customer ID2");
                            Rec.Validate(sr_StripeSetupIntentId, CustBankAcc."Setup Intent ID2");
                            Rec.Validate(sr_StripeSecret, CustBankAcc."Card URL2");
                        end;
                        //SRBC-232
                        Rec.Validate(sr_SyncedToBC, true);
                        Rec.Modify();
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