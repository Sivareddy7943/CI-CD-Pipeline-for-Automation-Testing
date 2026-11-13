//SRBC-353 - SY - 02062025 - Added field "BC Location Code", "BC Studio Code"
page 90113 "Studio List"
{
    ApplicationArea = All;
    Caption = 'Studio List';
    PageType = List;
    SourceTable = Studio;
    UsageCategory = Lists;
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(sr_Name; Rec.sr_Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(sr_StudioId; Rec.sr_StudioId)
                {
                    ToolTip = 'Specifies the value of the CRM Studio GUID field.';
                }
                field(sr_studio_number; Rec.sr_studio_number)
                {
                    ToolTip = 'Specifies the value of the CRM Studio Number field.';
                }
                field(sr_building; Rec.sr_building)
                {
                    ToolTip = 'Specifies the value of the Salon field.';
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
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ToolTip = 'Specifies the value of the Modified On field.';
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                    ToolTip = 'Specifies the value of the Record Created On field.';
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
                field(sr_BookingStatus; Rec.sr_BookingStatus)
                {
                    ToolTip = 'Specifies the value of the Booking Status field.';
                }
                field(sr_IsBalcony; Rec.sr_IsBalcony)
                {
                    ToolTip = 'Specifies the value of the Is Balcony field.';
                }
                field(sr_PedestalSink; Rec.sr_PedestalSink)
                {
                    ToolTip = 'Specifies the value of the Is Pedestal Sink field.';
                }
                field(sr_anticipated_moveout_date; Rec.sr_anticipated_moveout_date)
                {
                    ToolTip = 'Specifies the value of the Anticipated Move-Out Date field.';
                }
                field(sr_attached_building; Rec.sr_attached_building)
                {
                    ToolTip = 'Specifies the value of the [Do not Use]Attached Building field.';
                }
                field(sr_combined_with; Rec.sr_combined_with)
                {
                    ToolTip = 'Specifies the value of the Combined With field.';
                }
                field(sr_corner_window_left_height; Rec.sr_corner_window_left_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Corner Window (Left) Height field.';
                }
                field(sr_corner_window_left_width; Rec.sr_corner_window_left_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Corner Window (Left) Width field.';
                }
                field(sr_corner_window_right_height; Rec.sr_corner_window_right_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Corner Window (Right) Height field.';
                }
                field(sr_corner_window_right_width; Rec.sr_corner_window_right_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Corner Window (Right) Width field.';
                }
                field(sr_cornerwindowleftheight; Rec.sr_cornerwindowleftheight)
                {
                    ToolTip = 'Specifies the value of the Corner Window (Left) Height field.';
                }
                field(sr_cornerwindowleftwidth; Rec.sr_cornerwindowleftwidth)
                {
                    ToolTip = 'Specifies the value of the Corner Window (Left) Width field.';
                }
                field(sr_cornerwindowrightheight; Rec.sr_cornerwindowrightheight)
                {
                    ToolTip = 'Specifies the value of the Corner Window (Right) Height field.';
                }
                field(sr_cornerwindowrightwidth; Rec.sr_cornerwindowrightwidth)
                {
                    ToolTip = 'Specifies the value of the Corner Window (Right) Width field.';
                }
                field(sr_current_rent_rate; Rec.sr_current_rent_rate)
                {
                    ToolTip = 'Specifies the value of the Current Rent Rate field.';
                }
                field(sr_current_rent_rate_Base; Rec.sr_current_rent_rate_Base)
                {
                    ToolTip = 'Specifies the value of the Current Rent Rate (Base) field.';
                }
                field(sr_door_window_height; Rec.sr_door_window_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Door Window Height field.';
                }
                field(sr_door_window_width; Rec.sr_door_window_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Door Window Width field.';
                }
                field(sr_doorwindowheight; Rec.sr_doorwindowheight)
                {
                    ToolTip = 'Specifies the value of the Door Window Height field.';
                }
                field(sr_doorwindowwidth; Rec.sr_doorwindowwidth)
                {
                    ToolTip = 'Specifies the value of the Door Window Width field.';
                }
                field(sr_exterior_window1_height; Rec.sr_exterior_window1_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Exterior Window 1 Height field.';
                }
                field(sr_exterior_window1_width; Rec.sr_exterior_window1_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Exterior Window 1 Width field.';
                }
                field(sr_exterior_window2_height; Rec.sr_exterior_window2_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Exterior Window 2 Height field.';
                }
                field(sr_exterior_window2_width; Rec.sr_exterior_window2_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Exterior Window 2 Width field.';
                }
                field(sr_exterior_window3_height; Rec.sr_exterior_window3_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Exterior Window 3 Height field.';
                }
                field(sr_exterior_window3_width; Rec.sr_exterior_window3_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Exterior Window 3 Width field.';
                }
                field(sr_exterior_window4_height; Rec.sr_exterior_window4_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Exterior Window 4 Height field.';
                }
                field(sr_exterior_window4_width; Rec.sr_exterior_window4_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Exterior Window 4 Width field.';
                }
                field(sr_exteriorwindow1height; Rec.sr_exteriorwindow1height)
                {
                    ToolTip = 'Specifies the value of the Exterior Window 1 Height field.';
                }
                field(sr_exteriorwindow1width; Rec.sr_exteriorwindow1width)
                {
                    ToolTip = 'Specifies the value of the Exterior Window 1 Width field.';
                }
                field(sr_exteriorwindow2height; Rec.sr_exteriorwindow2height)
                {
                    ToolTip = 'Specifies the value of the Exterior Window 2 Height field.';
                }
                field(sr_exteriorwindow2width; Rec.sr_exteriorwindow2width)
                {
                    ToolTip = 'Specifies the value of the Exterior Window 2 Width field.';
                }
                field(sr_exteriorwindow3height; Rec.sr_exteriorwindow3height)
                {
                    ToolTip = 'Specifies the value of the Exterior Window 3 Height field.';
                }
                field(sr_exteriorwindow3width; Rec.sr_exteriorwindow3width)
                {
                    ToolTip = 'Specifies the value of the Exterior Window 3 Width field.';
                }
                field(sr_exteriorwindow4height; Rec.sr_exteriorwindow4height)
                {
                    ToolTip = 'Specifies the value of the Exterior Window 4 Height field.';
                }
                field(sr_exteriorwindow4width; Rec.sr_exteriorwindow4width)
                {
                    ToolTip = 'Specifies the value of the Exterior Window 4 Width field.';
                }
                field(sr_floor_number; Rec.sr_floor_number)
                {
                    ToolTip = 'Specifies the value of the Floor Number field.';
                }
                field(sr_height; Rec.sr_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Other Height field.';
                }
                field(sr_is_combined_studio; Rec.sr_is_combined_studio)
                {
                    ToolTip = 'Specifies the value of the Combined Studio? field.';
                }
                field(sr_is_staggered_rent_pricing; Rec.sr_is_staggered_rent_pricing)
                {
                    ToolTip = 'Specifies the value of the Staggered Rent Pricing field.';
                }
                field(sr_number_of_days_before_schmoveoutdate; Rec.srnumberofdaybefschmoveoutdate)
                {
                    ToolTip = 'Specifies the value of the Number of days before Scheduled Move-Out Date field.';
                }
                field(sr_number_of_days_vacant; Rec.sr_number_of_days_vacant)
                {
                    ToolTip = 'Specifies the value of the Number of days Vacant field.';
                }
                field(sr_number_of_weeks_applicable; Rec.sr_number_of_weeks_applicable)
                {
                    ToolTip = 'Specifies the value of the Number of weeks applicable field.';
                }
                field(sr_otherwindowheight; Rec.sr_otherwindowheight)
                {
                    ToolTip = 'Specifies the value of the Other Window Height field.';
                }
                field(sr_otherwindowwidth; Rec.sr_otherwindowwidth)
                {
                    ToolTip = 'Specifies the value of the Other Window Width field.';
                }
                field(sr_quantity; Rec.sr_quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(sr_rate; Rec.sr_rate)
                {
                    ToolTip = 'Specifies the value of the Rate field.';
                }
                field(sr_rate_Base; Rec.sr_rate_Base)
                {
                    ToolTip = 'Specifies the value of the Rate (Base) field.';
                }
                field(sr_sidelight_window_height; Rec.sr_sidelight_window_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Sidelight Window Height field.';
                }
                field(sr_sidelight_window_width; Rec.sr_sidelight_window_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Sidelight Window Width field.';
                }
                field(sr_sidelightwindowheight; Rec.sr_sidelightwindowheight)
                {
                    ToolTip = 'Specifies the value of the Sidelight Window Height field.';
                }
                field(sr_sidelightwindowwidth; Rec.sr_sidelightwindowwidth)
                {
                    ToolTip = 'Specifies the value of the Sidelight Window Width field.';
                }
                field(sr_staggered_rent_pricing; Rec.sr_staggered_rent_pricing)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Staggered Rent Pricing field.';
                }
                field(sr_staggered_rent_pricing_Base; Rec.sr_staggered_rent_pricing_Base)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Staggered Rent Pricing (Base) field.';
                }
                field(sr_staggered_rent_pricing_data; Rec.sr_staggered_rent_pricing_data)
                {
                    ToolTip = 'Specifies the value of the Staggered Rent Pricing Data field.';
                }
                field(sr_studio_size; Rec.sr_studio_size)
                {
                    ToolTip = 'Specifies the value of the Studio Size field.';
                }
                field(sr_studio_square_footage; Rec.sr_studio_square_footage)
                {
                    ToolTip = 'Specifies the value of the Studio Square Footage field.';
                }
                field(sr_studio_trait; Rec.sr_studio_trait)
                {
                    ToolTip = 'Specifies the value of the Studio Trait field.';
                }
                field(sr_studio_type; Rec.sr_studio_type)
                {
                    ToolTip = 'Specifies the value of the Studio Type field.';
                }
                field(sr_studiostatus; Rec.sr_studiostatus)
                {
                    ToolTip = 'Specifies the value of the Studio Status field.';
                }
                field(sr_target_rent; Rec.sr_target_rent)
                {
                    ToolTip = 'Specifies the value of the Target Rent (per week) field.';
                }
                field(sr_target_rent_Base; Rec.sr_target_rent_Base)
                {
                    ToolTip = 'Specifies the value of the Target Rent (Base) field.';
                }
                field(sr_total_area; Rec.sr_total_area)
                {
                    ToolTip = 'Specifies the value of the Total Area (Sq Ft) field.';
                }
                field(sr_transon_window_height; Rec.sr_transon_window_height)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Transon Window Height field.';
                }
                field(sr_transon_window_width; Rec.sr_transon_window_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Transon Window Width field.';
                }
                field(sr_transonwindowheight; Rec.sr_transonwindowheight)
                {
                    ToolTip = 'Specifies the value of the Transon Window Height field.';
                }
                field(sr_transonwindowwidth; Rec.sr_transonwindowwidth)
                {
                    ToolTip = 'Specifies the value of the Transon Window Width field.';
                }
                field(sr_width; Rec.sr_width)
                {
                    ToolTip = 'Specifies the value of the [DO NOT USE] Other Width field.';
                }
                field(sr_window_size; Rec.sr_window_size)
                {
                    ToolTip = 'Specifies the value of the Window Size field.';
                }
                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the Studio Status field.';
                }
                //SRBC-353 Start
                field("BC Location Code"; Rec."BC Location Code")
                {
                    ToolTip = 'Specifies the value of the BC Location Code field.', Comment = '%';
                }
                field("BC Studio Code"; Rec."BC Studio Code")
                {
                    ToolTip = 'Specifies the value of the BC Studio Code field.', Comment = '%';
                }
                //SRBC-353 End
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
                action(CDSGotoStudios)
                {
                    Caption = 'Studios';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Crm Studio.';
                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CDSSynchronizeNow)
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
                ToolTip = 'View integration synchronization jobs for the Studio table.';

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
                    ToolTip = 'Create or modify the coupling to a Microsoft Dataverse Studio.';

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
                    ToolTip = 'Delete the coupling to a Microsoft Dataverse Studio.';

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
