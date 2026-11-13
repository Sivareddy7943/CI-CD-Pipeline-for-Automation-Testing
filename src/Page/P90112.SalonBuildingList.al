page 90112 "Salon Building List"
{
    ApplicationArea = All;
    Caption = 'Salon Building List';
    PageType = List;
    SourceTable = "Salon Building";
    UsageCategory = Lists;
    RefreshOnActivate = true;
    DelayedInsert = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(sr_buildingcode; Rec.sr_buildingcode)
                {
                    ToolTip = 'Specifies the value of the Building Code field.';
                }
                field(sr_Name; Rec.sr_Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(sr_CRMSalonPK; Rec.sr_CRMSalonPK)
                {
                    ToolTip = 'Specifies the value of the sr_CRMSalonPK field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ToolTip = 'Specifies the value of the Created On field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(ImportSequenceNumber; Rec.ImportSequenceNumber)
                {
                    ToolTip = 'Specifies the value of the Import Sequence Number field.';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ToolTip = 'Specifies the value of the Modified By field.';
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ToolTip = 'Specifies the value of the Modified On field.';
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                    ToolTip = 'Specifies the value of the Record Created On field.';
                }
                field(sr_add_access_info; Rec.sr_add_access_info)
                {
                    ToolTip = 'Specifies the value of the Additional Mailbox Access Info field.';
                }
                field(sr_add_sec_info; Rec.sr_add_sec_info)
                {
                    ToolTip = 'Specifies the value of the Additional Security Info field.';
                }
                field(sr_AdditionalParkingInformation; Rec.sr_AdditionalParkingInformatio)
                {
                    ToolTip = 'Specifies the value of the Additional Parking Information field.';
                }
                field(sr_additionalvalidationinfo; Rec.sr_additionalvalidationinfo)
                {
                    ToolTip = 'Specifies the value of the Additional Validation Info field.';
                }
                field(sr_applicationprocess; Rec.sr_applicationprocess)
                {
                    ToolTip = 'Specifies the value of the Application Process field.';
                }
                field(sr_BuildingPermittedServices; Rec.sr_BuildingPermittedServices)
                {
                    ToolTip = 'Specifies the value of the Building Permitted Services field.';
                }
                field(sr_CalendlyBookingURL; Rec.sr_CalendlyBookingURL)
                {
                    ToolTip = 'Specifies the value of the Calendly Booking URL field.';
                }
                field(sr_client_parkingfee; Rec.sr_client_parkingfee)
                {
                    ToolTip = 'Specifies the value of the Parking Fee/Cost field.';
                }
                field(sr_client_parkingfee_Base; Rec.sr_client_parkingfee_Base)
                {
                    ToolTip = 'Specifies the value of the Parking Fee/Cost (Base) field.';
                }
                field(sr_client_validationprovided; Rec.sr_client_validationprovided)
                {
                    ToolTip = 'Specifies the value of the Validation Provided(Clients) field.';
                }
                field(sr_createreferencedata; Rec.sr_createreferencedata)
                {
                    ToolTip = 'Specifies the value of the Create Reference Data field.';
                }
                field(sr_dampenercontrolinindividualstudios; Rec.sr_dampenercontrolinindivistud)
                {
                    ToolTip = 'Specifies the value of the Dampener Control in individual studios field.';
                }
                field(sr_DesignatedParkingforEmployeesLicensees; Rec.sr_DesigParkforEmploLicensees)
                {
                    ToolTip = 'Specifies the value of the Designated  Parking for Employees/Licensees field.';
                }
                field(sr_doorkingphone; Rec.sr_doorkingphone)
                {
                    ToolTip = 'Specifies the value of the Doorking Phone field.';
                }
                field(sr_finesfordisposingoftrashincorrectly; Rec.sr_finesfordisposingoftrashinc)
                {
                    ToolTip = 'Specifies the value of the Fines for disposing of trash incorrectly field.';
                }
                field(sr_fulltimeavailablemachines; Rec.sr_fulltimeavailablemachines)
                {
                    ToolTip = 'Specifies the value of the Full-Time Availability (Licensee) field.';
                }
                field(sr_janitorialcontactnumber; Rec.sr_janitorialcontactnumber)
                {
                    ToolTip = 'Specifies the value of the Janitorial Contact Number field.';
                }
                field(sr_janitorialcontactperson; Rec.sr_janitorialcontactperson)
                {
                    ToolTip = 'Specifies the value of the Janitorial Contact Person field.';
                }
                field(sr_janitorialsupplystorageloc; Rec.sr_janitorialsupplystorageloc)
                {
                    ToolTip = 'Specifies the value of the Janitorial Supply Storage Location field.';
                }
                field(sr_largeitemstrashcandisposallocation; Rec.sr_largeitemstrashcandispoloca)
                {
                    ToolTip = 'Specifies the value of the Large items trash can disposal location field.';
                }
                field(sr_laundryfacilitytype; Rec.sr_laundryfacilitytype)
                {
                    ToolTip = 'Specifies the value of the Laundry Machine Ownership field.';
                }
                field(sr_laundrymachinefee; Rec.sr_laundrymachinefee)
                {
                    ToolTip = 'Specifies the value of the Laundry Machine Fee field.';
                }
                field(sr_laundrymachinefee_Base; Rec.sr_laundrymachinefee_Base)
                {
                    ToolTip = 'Specifies the value of the Laundry Machine Fee (Base) field.';
                }
                field(sr_laundrymachineuse; Rec.sr_laundrymachineuse)
                {
                    ToolTip = 'Specifies the value of the Laundry Machine Use field.';
                }
                field(sr_licenseparkingper; Rec.sr_licenseparkingper)
                {
                    ToolTip = 'Specifies the value of the License Parking Per field.';
                }
                field(sr_loc_onprem; Rec.sr_loc_onprem)
                {
                    ToolTip = 'Specifies the value of the Property Manager Office Location on Premises field.';
                }
                field(sr_loc_onpremises; Rec.sr_loc_onpremises)
                {
                    ToolTip = 'Specifies the value of the Mailbox Location on Premises field.';
                }
                field(sr_locationofwaterheaters; Rec.sr_locationofwaterheaters)
                {
                    ToolTip = 'Specifies the value of the Location of Water Heaters/Boiler field.';
                }
                field(sr_machinesforjanitorialonly; Rec.sr_machinesforjanitorialonly)
                {
                    ToolTip = 'Specifies the value of the Janitorial Use Only Machines (Janitor Hours) field.';
                }
                field(sr_maincontrollocation; Rec.sr_maincontrollocation)
                {
                    ToolTip = 'Specifies the value of the [Do not use]Location of Main Control field.';
                }
                field(sr_managementcompany; Rec.sr_managementcompany)
                {
                    ToolTip = 'Specifies the value of the Management Company field.';
                }
                field(sr_nooffloor; Rec.sr_nooffloor)
                {
                    ToolTip = 'Specifies the value of the No Of Floor field.';
                }
                field(sr_num_of_studio; Rec.sr_num_of_studio)
                {
                    ToolTip = 'Specifies the value of the Number of Studio field.';
                }
                field(sr_numberofstudio; Rec.sr_numberofstudio)
                {
                    ToolTip = 'Specifies the value of the Number of Studio field.';
                }
                field(sr_numberofstudio_Date; Rec.sr_numberofstudio_Date)
                {
                    ToolTip = 'Specifies the value of the Number of Studio (Last Updated On) field.';
                }
                field(sr_numberofstudio_State; Rec.sr_numberofstudio_State)
                {
                    ToolTip = 'Specifies the value of the Number of Studio (State) field.';
                }
                field(sr_onsitejanitorname; Rec.sr_onsitejanitorname)
                {
                    ToolTip = 'Specifies the value of the On-Site Janitor Name field.';
                }
                field(sr_othermanagement_contactinfo; Rec.sr_othermanagement_contactinfo)
                {
                    ToolTip = 'Specifies the value of the Other Management Contact Info field.';
                }
                field(sr_othermanagement_name; Rec.sr_othermanagement_name)
                {
                    ToolTip = 'Specifies the value of the Other Management Name field.';
                }
                field(sr_othermanagement_title; Rec.sr_othermanagement_title)
                {
                    ToolTip = 'Specifies the value of the Other Management Title field.';
                }
                field(sr_otherRequiredtrashdisposalcans; Rec.sr_otherRequiredtrashdisposalc)
                {
                    ToolTip = 'Specifies the value of the  Other Required trash disposal cans field.';
                }
                field(sr_othertypesoftrashdisposal; Rec.sr_othertypesoftrashdisposal)
                {
                    ToolTip = 'Specifies the value of the  Other types of trash disposal field.';
                }
                field(sr_park_ofc_loc_onprem; Rec.sr_park_ofc_loc_onprem)
                {
                    ToolTip = 'Specifies the value of the Parking Office Location on premises field.';
                }
                field(sr_parkingfee; Rec.sr_parkingfee)
                {
                    ToolTip = 'Specifies the value of the Parking Pass Fee/Cost field.';
                }
                field(sr_parkingfee_Base; Rec.sr_parkingfee_Base)
                {
                    ToolTip = 'Specifies the value of the Parking Pass Fee/Cost (Base) field.';
                }
                field(sr_parkmgmt_company; Rec.sr_parkmgmt_company)
                {
                    ToolTip = 'Specifies the value of the Parking Management Company field.';
                }
                field(sr_PassApplicationPaymentLicenseeManagedBy; Rec.sr_PassAppliPaymLicenManagedBy)
                {
                    ToolTip = 'Specifies the value of the Pass Application & Payment (Licensee) Managed By? field.';
                }
                field(sr_paymentppplicationlink; Rec.sr_paymentppplicationlink)
                {
                    ToolTip = 'Specifies the value of the Payment Application Link field.';
                }
                field(sr_propertymanagement_ofc_loc; Rec.sr_propertymanagement_ofc_loc)
                {
                    ToolTip = 'Specifies the value of the [Do not use]Property Management Office Location field.';
                }
                field(sr_Prospects; Rec.sr_Prospects)
                {
                    ToolTip = 'Specifies the value of the Prospects field.';
                }
                field(sr_prptymgmtofccoc; Rec.sr_prptymgmtofccoc)
                {
                    ToolTip = 'Specifies the value of the Property Management Office Location field.';
                }
                field(sr_recycleonlytrashcandisposallocation; Rec.sr_recycleonlytrashcandisploca)
                {
                    ToolTip = 'Specifies the value of the Recycle only trash can disposal location field.';
                }
                field(sr_rentalcompanyname; Rec.sr_rentalcompanyname)
                {
                    ToolTip = 'Specifies the value of the Rental Company Name field.';
                }
                field(sr_rentalcompcontactnumber; Rec.sr_rentalcompcontactnumber)
                {
                    ToolTip = 'Specifies the value of the Rental Company Contact Number field.';
                }
                field(sr_salon_amenities; Rec.sr_salon_amenities)
                {
                    ToolTip = 'Specifies the value of the Salon Amenities field.';
                }
                field(sr_SalonEmail; Rec.sr_SalonEmail)
                {
                    ToolTip = 'Specifies the value of the Salon Email field.';
                }
                field(sr_salonemailaddress; Rec.sr_salonemailaddress)
                {
                    ToolTip = 'Specifies the value of the Salon E-mail Address field.';
                }
                field(sr_salonn_address; Rec.sr_salonn_address)
                {
                    ToolTip = 'Specifies the value of the Salon Address field.';
                }
                field(sr_salonphone; Rec.sr_salonphone)
                {
                    ToolTip = 'Specifies the value of the Salon Phone # field.';
                }
                field(sr_sec_cam_ip; Rec.sr_sec_cam_ip)
                {
                    ToolTip = 'Specifies the value of the Security Camera IP field.';
                }
                field(sr_sec_cam_password; Rec.sr_sec_cam_password)
                {
                    ToolTip = 'Specifies the value of the Security Camera Password field.';
                }
                field(sr_sec_cam_url; Rec.sr_sec_cam_url)
                {
                    ToolTip = 'Specifies the value of the Security Camera URL field.';
                }
                field(sr_sec_cam_user; Rec.sr_sec_cam_user)
                {
                    ToolTip = 'Specifies the value of the Security Camera User Name field.';
                }
                field(sr_sec_off_loc_onprem; Rec.sr_sec_off_loc_onprem)
                {
                    ToolTip = 'Specifies the value of the Security Office Location on premises field.';
                }
                field(sr_specialaccessinformationinstructions; Rec.sr_specialaccessinfoinstructio)
                {
                    ToolTip = 'Specifies the value of the Special Access Info/Instructions field.';
                }
                field(sr_specialaccessneeded; Rec.sr_specialaccessneeded)
                {
                    ToolTip = 'Specifies the value of the Special Access needed? field.';
                }
                field(sr_totalarea; Rec.sr_totalarea)
                {
                    ToolTip = 'Specifies the value of the Total Area (sqft) field.';
                }
                field(sr_trashcompactorlocation; Rec.sr_trashcompactorlocation)
                {
                    ToolTip = 'Specifies the value of the Trash Compactor Location field.';
                }
                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the Status Reason field.';
                }
                field(TimeZoneRuleVersionNumber; Rec.TimeZoneRuleVersionNumber)
                {
                    ToolTip = 'Specifies the value of the Time Zone Rule Version Number field.';
                }
                field(UTCConversionTimeZoneCode; Rec.UTCConversionTimeZoneCode)
                {
                    ToolTip = 'Specifies the value of the UTC Conversion Time Zone Code field.';
                }
                field(VersionNumber; Rec.VersionNumber)
                {
                    ToolTip = 'Specifies the value of the Version Number field.';
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
                action(CDSGotoSalonBuilding)
                {
                    Caption = 'CRM Salon Building';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Crm Salon Building.';
                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CDSSynchronizeNow)
                {
                    AccessByPermission = TableData "CRM Integration Record" = IM;
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
                ToolTip = 'View integration synchronization jobs for the customer table.';

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
                action(ManageCDSCoupling)
                {
                    Caption = 'Set Up Coupling';
                    ApplicationArea = All;
                    Visible = true;
                    Image = LinkAccount;
                    ToolTip = 'Create or modify the coupling to a Microsoft Dataverse lab book.';

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
                    ToolTip = 'Delete the coupling to a Microsoft Dataverse lab book.';

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
