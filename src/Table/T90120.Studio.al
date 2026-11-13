//SRBC-353 - SY - 02062025 - Added field - "BC Location Code", "BC Studio Code"
table 90120 Studio
{
    Caption = 'Studio';
    DataClassification = ToBeClassified;
    LookupPageId = "Studio List";
    DrillDownPageId = "Studio List";
    fields
    {
        field(1; sr_StudioId; GUID)
        {
            Description = 'Unique identifier for entity instances';
            Caption = 'Studio';
            Editable = false;
        }
        field(2; sr_studio_number; Integer)
        {
            Description = 'Studio Number';
            Caption = 'Studio Number';
        }
        field(3; CreatedOn; Datetime)
        {
            Description = 'Date and time when the record was created.';
            Caption = 'Created On';
        }
        field(4; ModifiedOn; Datetime)
        {
            Description = 'Date and time when the record was modified.';
            Caption = 'Modified On';
        }
        field(25; statecode; Option)
        {
            Description = 'Status of the Studio';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
        }
        field(27; statuscode; Option)
        {
            Description = 'Reason for the status of the Studio';
            Caption = 'Studio Status';
            InitValue = " ";
            OptionMembers = " ",Vacant,Occupied,"Occupied-TerminationNotice",Inactive;
        }
        field(29; VersionNumber; BigInteger)
        {
            Description = 'Version Number';
            Caption = 'Version Number';
        }
        field(30; ImportSequenceNumber; Integer)
        {
            Description = 'Sequence number of the import that created this record.';
            Caption = 'Import Sequence Number';
        }
        field(31; OverriddenCreatedOn; Date)
        {
            Description = 'Date and time that the record was migrated.';
            Caption = 'Record Created On';
        }
        field(32; TimeZoneRuleVersionNumber; Integer)
        {
            Description = 'For internal use only.';
            Caption = 'Time Zone Rule Version Number';
        }
        field(33; UTCConversionTimeZoneCode; Integer)
        {
            Description = 'Time zone code that was in use when the record was created.';
            Caption = 'UTC Conversion Time Zone Code';
        }
        field(34; sr_Name; Text[500])
        {
            Description = 'Name of the Studio record';
            Caption = 'Name';
        }
        field(35; sr_IsBalcony; Boolean)
        {
            Description = '';
            Caption = 'Is Balcony';
        }
        field(37; sr_BookingStatus; Option)
        {
            Description = '';
            Caption = 'Booking Status';
            InitValue = " ";
            OptionMembers = " ",Vacant,Occupied;
        }
        field(39; sr_PedestalSink; Boolean)
        {
            Description = '';
            Caption = 'Is Pedestal Sink';
        }
        field(42; sr_floor_number; Integer)
        {
            Description = 'Floor Number';
            Caption = 'Floor Number';
        }
        field(43; sr_total_area; Decimal)
        {
            Description = 'Total Area (Sq Ft)';
            Caption = 'Total Area (Sq Ft)';
        }
        field(44; sr_target_rent; Decimal)
        {
            Description = 'Target Rent (per week)';
            Caption = 'Target Rent (per week)';
        }
        field(47; ExchangeRate; Decimal)
        {
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(48; sr_target_rent_Base; Decimal)
        {
            Description = 'Value of the Target Rent in base currency.';
            Caption = 'Target Rent (Base)';
        }
        field(49; sr_attached_building; Text[2000])
        {
            Description = 'Attached Building';
            Caption = '[Do not Use]Attached Building';
        }
        field(52; sr_building; GUID)
        {
            Description = 'Salon | Building';
            Caption = 'Salon';
            //TableRelation = "CDS sr_Building".sr_BuildingId;
        }
        field(54; sr_studio_size; Option)
        {
            Description = 'Studio Size';
            Caption = 'Studio Size';
            InitValue = " ";
            OptionMembers = " ","1Station(under114Sqft)","UpTo2Stations(115-155Sqft)","UpTo3Stations(156Sqft+)","CustomStudio/StudioCombination";
        }
        field(56; sr_studio_square_footage; Text[1000])
        {
            Description = 'Studio Square Footage';
            Caption = 'Studio Square Footage';
        }
        field(57; srnumberofdaybefschmoveoutdate; Decimal)
        {
            Description = 'Quantity of days before "Scheduled Move-Out Date"';
            Caption = 'Number of days before Scheduled Move-Out Date';
        }
        field(58; sr_number_of_days_vacant; Decimal)
        {
            Description = 'Quantity of days Vacant';
            Caption = 'Number of days Vacant';
        }
        field(63; sr_rate; Decimal)
        {
            Description = 'Rate';
            Caption = 'Rate';
        }
        field(64; sr_rate_Base; Decimal)
        {
            Description = 'Value of the Rate in base currency.';
            Caption = 'Rate (Base)';
        }
        field(65; sr_number_of_weeks_applicable; Integer)
        {
            Description = 'Number of weeks applicable';
            Caption = 'Number of weeks applicable';
        }
        field(66; sr_current_rent_rate; Decimal)
        {
            Description = 'Current Rent Rate';
            Caption = 'Current Rent Rate';
        }
        field(67; sr_current_rent_rate_Base; Decimal)
        {
            Description = 'Value of the Current Rent Rate in base currency.';
            Caption = 'Current Rent Rate (Base)';
        }
        field(68; sr_staggered_rent_pricing; Decimal)
        {
            Description = '[DO NOT USE] Staggered Rent Pricing';
            Caption = '[DO NOT USE] Staggered Rent Pricing';
        }
        field(69; sr_staggered_rent_pricing_Base; Decimal)
        {
            Description = 'Value of the Staggered Rent Pricing in base currency.';
            Caption = '[DO NOT USE] Staggered Rent Pricing (Base)';
        }
        field(72; sr_height; Decimal)
        {
            Description = 'Window Height';
            Caption = '[DO NOT USE] Other Height';
        }
        field(73; sr_width; Decimal)
        {
            Description = 'Window width';
            Caption = '[DO NOT USE] Other Width';
        }
        field(75; sr_quantity; Integer)
        {
            Description = 'Quantity of chairs';
            Caption = 'Quantity';
        }
        field(78; sr_door_window_height; Integer)
        {
            Description = 'Door Window Height';
            Caption = '[DO NOT USE] Door Window Height';
        }
        field(79; sr_door_window_width; Integer)
        {
            Description = 'Door Window Width';
            Caption = '[DO NOT USE] Door Window Width';
        }
        field(80; sr_sidelight_window_height; Integer)
        {
            Description = 'Sidelight Window Height';
            Caption = '[DO NOT USE] Sidelight Window Height';
        }
        field(81; sr_sidelight_window_width; Integer)
        {
            Description = 'Sidelight Window Width';
            Caption = '[DO NOT USE] Sidelight Window Width';
        }
        field(82; sr_corner_window_left_width; Integer)
        {
            Description = 'Corner Window (Left) Width';
            Caption = '[DO NOT USE] Corner Window (Left) Width';
        }
        field(83; sr_corner_window_left_height; Integer)
        {
            Description = 'Corner Window (Left) Height';
            Caption = '[DO NOT USE] Corner Window (Left) Height';
        }
        field(84; sr_corner_window_right_height; Integer)
        {
            Description = 'Corner Window (Right) Height';
            Caption = '[DO NOT USE] Corner Window (Right) Height';
        }
        field(85; sr_corner_window_right_width; Integer)
        {
            Description = 'Corner Window (Right) Width';
            Caption = '[DO NOT USE] Corner Window (Right) Width';
        }
        field(86; sr_transon_window_width; Integer)
        {
            Description = 'Transon Window Width';
            Caption = '[DO NOT USE] Transon Window Width';
        }
        field(87; sr_transon_window_height; Integer)
        {
            Description = 'Transon Window Height';
            Caption = '[DO NOT USE] Transon Window Height';
        }
        field(88; sr_exterior_window1_width; Integer)
        {
            Description = 'Exterior Window 1 Width';
            Caption = '[DO NOT USE] Exterior Window 1 Width';
        }
        field(89; sr_exterior_window1_height; Integer)
        {
            Description = 'Exterior Window 1 Height';
            Caption = '[DO NOT USE] Exterior Window 1 Height';
        }
        field(90; sr_exterior_window2_width; Integer)
        {
            Description = 'Exterior Window 2 Width';
            Caption = '[DO NOT USE] Exterior Window 2 Width';
        }
        field(91; sr_exterior_window2_height; Integer)
        {
            Description = 'Exterior Window 2 Height';
            Caption = '[DO NOT USE] Exterior Window 2 Height';
        }
        field(92; sr_exterior_window3_width; Integer)
        {
            Description = 'Exterior Window 3 Width';
            Caption = '[DO NOT USE] Exterior Window 3 Width';
        }
        field(93; sr_exterior_window3_height; Integer)
        {
            Description = 'Exterior Window 3 Height';
            Caption = '[DO NOT USE] Exterior Window 3 Height';
        }
        field(94; sr_exterior_window4_width; Integer)
        {
            Description = 'Exterior Window 4 Width';
            Caption = '[DO NOT USE] Exterior Window 4 Width';
        }
        field(95; sr_exterior_window4_height; Integer)
        {
            Description = 'Exterior Window 4 Height';
            Caption = '[DO NOT USE] Exterior Window 4 Height';
        }
        field(102; sr_is_staggered_rent_pricing; Boolean)
        {
            Description = 'Staggered Rent Pricing';
            Caption = 'Staggered Rent Pricing';
        }
        field(104; sr_staggered_rent_pricing_data; Text[2000])
        {
            Description = 'Staggered Rent Pricing Data from Data Import using | separator.';
            Caption = 'Staggered Rent Pricing Data';
        }
        field(105; sr_is_combined_studio; Boolean)
        {
            Description = 'Combined Studio?';
            Caption = 'Combined Studio?';
        }
        field(107; sr_combined_with; GUID)
        {
            Description = 'Attach Other studio in the same salon combined with';
            Caption = 'Combined With';
            //TableRelation = "CDS sr_Studio".sr_StudioId;
        }
        field(109; sr_window_size; Option)
        {
            Description = 'Window Size';
            Caption = 'Window Size';
            InitValue = " ";
            OptionMembers = " ","Partial(upTo3/8)","Mid(1/2-5/8)","Full(3/4-Full)";
        }
        field(111; sr_studio_trait; Option)
        {
            Description = 'Studio Trait';
            Caption = 'Studio Trait';
            InitValue = " ";
            OptionMembers = " ",FrontOfSalon,BackOfSalon,Column,"RestroomFacing/Adjacent",BudgetFriendly;
        }
        field(113; sr_anticipated_moveout_date; Date)
        {
            Description = 'Anticipated Move-Out Date';
            Caption = 'Anticipated Move-Out Date';
        }
        field(114; sr_doorwindowwidth; Text[10])
        {
            Description = 'Door Window Width';
            Caption = 'Door Window Width';
        }
        field(115; sr_doorwindowheight; Text[10])
        {
            Description = 'Door Window Height';
            Caption = 'Door Window Height';
        }
        field(116; sr_sidelightwindowwidth; Text[10])
        {
            Description = 'Sidelight Window Width';
            Caption = 'Sidelight Window Width';
        }
        field(117; sr_sidelightwindowheight; Text[10])
        {
            Description = 'Sidelight Window Height';
            Caption = 'Sidelight Window Height';
        }
        field(118; sr_cornerwindowleftwidth; Text[10])
        {
            Description = 'Corner Window (Left) Width';
            Caption = 'Corner Window (Left) Width';
        }
        field(119; sr_cornerwindowleftheight; Text[10])
        {
            Description = 'Corner Window (Left) Height';
            Caption = 'Corner Window (Left) Height';
        }
        field(120; sr_cornerwindowrightwidth; Text[10])
        {
            Description = 'Corner Window (Right) Width';
            Caption = 'Corner Window (Right) Width';
        }
        field(121; sr_cornerwindowrightheight; Text[10])
        {
            Description = 'Corner Window (Right) Height';
            Caption = 'Corner Window (Right) Height';
        }
        field(122; sr_transonwindowwidth; Text[10])
        {
            Description = 'Transon Window Width';
            Caption = 'Transon Window Width';
        }
        field(123; sr_transonwindowheight; Text[10])
        {
            Description = 'Transon Window Height';
            Caption = 'Transon Window Height';
        }
        field(124; sr_exteriorwindow1width; Text[10])
        {
            Description = 'Exterior Window 1 Width';
            Caption = 'Exterior Window 1 Width';
        }
        field(125; sr_exteriorwindow2width; Text[10])
        {
            Description = 'Exterior Window 2 Width';
            Caption = 'Exterior Window 2 Width';
        }
        field(126; sr_exteriorwindow3width; Text[10])
        {
            Description = 'Exterior Window 3 Width';
            Caption = 'Exterior Window 3 Width';
        }
        field(127; sr_exteriorwindow4width; Text[10])
        {
            Description = 'Exterior Window 4 Width';
            Caption = 'Exterior Window 4 Width';
        }
        field(128; sr_exteriorwindow1height; Text[10])
        {
            Description = 'Exterior Window 1 Height';
            Caption = 'Exterior Window 1 Height';
        }
        field(129; sr_exteriorwindow2height; Text[10])
        {
            Description = 'Exterior Window 2 Height';
            Caption = 'Exterior Window 2 Height';
        }
        field(130; sr_exteriorwindow3height; Text[10])
        {
            Description = 'Exterior Window 3 Height';
            Caption = 'Exterior Window 3 Height';
        }
        field(131; sr_exteriorwindow4height; Text[10])
        {
            Description = 'Exterior Window 4 Height';
            Caption = 'Exterior Window 4 Height';
        }
        field(132; sr_otherwindowwidth; Text[10])
        {
            Description = 'Other Window Width';
            Caption = 'Other Window Width';
        }
        field(133; sr_otherwindowheight; Text[10])
        {
            Description = 'Other Window Height';
            Caption = 'Other Window Height';
        }
        field(136; sr_studio_type; Option)
        {
            Description = 'Studio Type';
            Caption = 'Studio Type';
            InitValue = " ";
            OptionMembers = " ","Window-Exterior/OutdoorFacing","Window-Interior/IndoorFacing","Interior-CornerWindow","Interior-Transom/ClearstoryWindow(SunWindow)","Interior-Standard","InteriorWithPrivacy/quieterAreaOfSalon","BudgetFriendly/costEffective";
        }
        field(138; sr_studiostatus; Option)
        {
            Description = 'Studio Status';
            Caption = 'Studio Status';
            InitValue = " ";
            OptionMembers = " ",Vacant,Occupied,"Occupied-TerminationNotice";
        }
        //SRBC-353 start
        field(150; "BC Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'BC Location Code';
        }

        field(151; "BC Studio Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'BC Studio Code';
        }
        //SRBC-353 end
    }
    keys
    {
        key(PK; sr_StudioId)
        {
            Clustered = true;
        }
    }
}
