table 90113 "CDS sr_Studio"
{
    ExternalName = 'sr_studio';
    TableType = CDS;
    Description = 'Studio';

    fields
    {
        field(1; sr_StudioId; GUID)
        {
            ExternalName = 'sr_studioid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Studio';
        }
        field(2; CreatedOn; Datetime)
        {
            ExternalName = 'createdon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Date and time when the record was created.';
            Caption = 'Created On';
        }
        field(4; ModifiedOn; Datetime)
        {
            ExternalName = 'modifiedon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Date and time when the record was modified.';
            Caption = 'Modified On';
        }
        field(25; statecode; Option)
        {
            ExternalName = 'statecode';
            ExternalType = 'State';
            ExternalAccess = Modify;
            Description = 'Status of the Studio';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Studio';
            Caption = 'Studio Status';
            InitValue = " ";
            OptionMembers = " ",Vacant,Occupied,"Occupied-TerminationNotice",Inactive;
            OptionOrdinalValues = -1, 1, 100000000, 100000001, 2;
        }
        field(29; VersionNumber; BigInteger)
        {
            ExternalName = 'versionnumber';
            ExternalType = 'BigInt';
            ExternalAccess = Read;
            Description = 'Version Number';
            Caption = 'Version Number';
        }
        field(30; ImportSequenceNumber; Integer)
        {
            ExternalName = 'importsequencenumber';
            ExternalType = 'Integer';
            ExternalAccess = Insert;
            Description = 'Sequence number of the import that created this record.';
            Caption = 'Import Sequence Number';
        }
        field(31; OverriddenCreatedOn; Date)
        {
            ExternalName = 'overriddencreatedon';
            ExternalType = 'DateTime';
            ExternalAccess = Insert;
            Description = 'Date and time that the record was migrated.';
            Caption = 'Record Created On';
        }
        field(32; TimeZoneRuleVersionNumber; Integer)
        {
            ExternalName = 'timezoneruleversionnumber';
            ExternalType = 'Integer';
            Description = 'For internal use only.';
            Caption = 'Time Zone Rule Version Number';
        }
        field(33; UTCConversionTimeZoneCode; Integer)
        {
            ExternalName = 'utcconversiontimezonecode';
            ExternalType = 'Integer';
            Description = 'Time zone code that was in use when the record was created.';
            Caption = 'UTC Conversion Time Zone Code';
        }
        field(34; sr_Name; Text[500])
        {
            ExternalName = 'sr_name';
            ExternalType = 'String';
            Description = 'Name of the Studio record';
            Caption = 'Name';
        }
        field(35; sr_IsBalcony; Boolean)
        {
            ExternalName = 'sr_isbalcony';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Balcony';
        }
        field(37; sr_BookingStatus; Option)
        {
            ExternalName = 'sr_bookingstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Booking Status';
            InitValue = " ";
            OptionMembers = " ",Vacant,Occupied;
            OptionOrdinalValues = -1, 100000000, 100000001;
        }
        field(39; sr_PedestalSink; Boolean)
        {
            ExternalName = 'sr_pedestalsink';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Pedestal Sink';
        }
        field(41; sr_studio_number; Integer)
        {
            ExternalName = 'sr_studio_number';
            ExternalType = 'Integer';
            Description = 'Studio Number';
            Caption = 'Studio Number';
        }
        field(42; sr_floor_number; Integer)
        {
            ExternalName = 'sr_floor_number';
            ExternalType = 'Integer';
            Description = 'Floor Number';
            Caption = 'Floor Number';
        }
        field(43; sr_total_area; Decimal)
        {
            ExternalName = 'sr_total_area';
            ExternalType = 'Decimal';
            Description = 'Total Area (Sq Ft)';
            Caption = 'Total Area (Sq Ft)';
        }
        field(44; sr_target_rent; Decimal)
        {
            ExternalName = 'sr_target_rent';
            ExternalType = 'Money';
            Description = 'Target Rent (per week)';
            Caption = 'Target Rent (per week)';
        }
        field(47; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(48; sr_target_rent_Base; Decimal)
        {
            ExternalName = 'sr_target_rent_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Target Rent in base currency.';
            Caption = 'Target Rent (Base)';
        }
        field(49; sr_attached_building; Text[2000])
        {
            ExternalName = 'sr_attached_building';
            ExternalType = 'String';
            Description = 'Attached Building';
            Caption = '[Do not Use]Attached Building';
        }
        field(52; sr_building; GUID)
        {
            ExternalName = 'sr_building';
            ExternalType = 'Lookup';
            Description = 'Salon | Building';
            Caption = 'Salon';
            TableRelation = "CDS sr_Building".sr_BuildingId;
        }
        field(54; sr_studio_size; Option)
        {
            ExternalName = 'sr_studio_size';
            ExternalType = 'Picklist';
            Description = 'Studio Size';
            Caption = 'Studio Size';
            InitValue = " ";
            OptionMembers = " ","1Station(under114Sqft)","UpTo2Stations(115-155Sqft)","UpTo3Stations(156Sqft+)","CustomStudio/StudioCombination";
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003;
        }
        field(56; sr_studio_square_footage; Text[1000])
        {
            ExternalName = 'sr_studio_square_footage';
            ExternalType = 'String';
            Description = 'Studio Square Footage';
            Caption = 'Studio Square Footage';
        }
        field(57; sr_number_of_days_before_schmoveoutdate; Decimal)
        {
            ExternalName = 'sr_number_of_days_before_schmoveoutdate';
            ExternalType = 'Double';
            Description = 'Quantity of days before "Scheduled Move-Out Date"';
            Caption = 'Number of days before Scheduled Move-Out Date';
        }
        field(58; sr_number_of_days_vacant; Decimal)
        {
            ExternalName = 'sr_number_of_days_vacant';
            ExternalType = 'Double';
            Description = 'Quantity of days Vacant';
            Caption = 'Number of days Vacant';
        }
        field(63; sr_rate; Decimal)
        {
            ExternalName = 'sr_rate';
            ExternalType = 'Money';
            Description = 'Rate';
            Caption = 'Rate';
        }
        field(64; sr_rate_Base; Decimal)
        {
            ExternalName = 'sr_rate_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rate in base currency.';
            Caption = 'Rate (Base)';
        }
        field(65; sr_number_of_weeks_applicable; Integer)
        {
            ExternalName = 'sr_number_of_weeks_applicable';
            ExternalType = 'Integer';
            Description = 'Number of weeks applicable';
            Caption = 'Number of weeks applicable';
        }
        field(66; sr_current_rent_rate; Decimal)
        {
            ExternalName = 'sr_current_rent_rate';
            ExternalType = 'Money';
            Description = 'Current Rent Rate';
            Caption = 'Current Rent Rate';
        }
        field(67; sr_current_rent_rate_Base; Decimal)
        {
            ExternalName = 'sr_current_rent_rate_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Current Rent Rate in base currency.';
            Caption = 'Current Rent Rate (Base)';
        }
        field(68; sr_staggered_rent_pricing; Decimal)
        {
            ExternalName = 'sr_staggered_rent_pricing';
            ExternalType = 'Money';
            Description = '[DO NOT USE] Staggered Rent Pricing';
            Caption = '[DO NOT USE] Staggered Rent Pricing';
        }
        field(69; sr_staggered_rent_pricing_Base; Decimal)
        {
            ExternalName = 'sr_staggered_rent_pricing_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Staggered Rent Pricing in base currency.';
            Caption = '[DO NOT USE] Staggered Rent Pricing (Base)';
        }
        field(72; sr_height; Decimal)
        {
            ExternalName = 'sr_height';
            ExternalType = 'Double';
            Description = 'Window Height';
            Caption = '[DO NOT USE] Other Height';
        }
        field(73; sr_width; Decimal)
        {
            ExternalName = 'sr_width';
            ExternalType = 'Double';
            Description = 'Window width';
            Caption = '[DO NOT USE] Other Width';
        }
        field(75; sr_quantity; Integer)
        {
            ExternalName = 'sr_quantity';
            ExternalType = 'Integer';
            Description = 'Quantity of chairs';
            Caption = 'Quantity';
        }
        field(78; sr_door_window_height; Integer)
        {
            ExternalName = 'sr_door_window_height';
            ExternalType = 'Integer';
            Description = 'Door Window Height';
            Caption = '[DO NOT USE] Door Window Height';
        }
        field(79; sr_door_window_width; Integer)
        {
            ExternalName = 'sr_door_window_width';
            ExternalType = 'Integer';
            Description = 'Door Window Width';
            Caption = '[DO NOT USE] Door Window Width';
        }
        field(80; sr_sidelight_window_height; Integer)
        {
            ExternalName = 'sr_sidelight_window_height';
            ExternalType = 'Integer';
            Description = 'Sidelight Window Height';
            Caption = '[DO NOT USE] Sidelight Window Height';
        }
        field(81; sr_sidelight_window_width; Integer)
        {
            ExternalName = 'sr_sidelight_window_width';
            ExternalType = 'Integer';
            Description = 'Sidelight Window Width';
            Caption = '[DO NOT USE] Sidelight Window Width';
        }
        field(82; sr_corner_window_left_width; Integer)
        {
            ExternalName = 'sr_corner_window_left_width';
            ExternalType = 'Integer';
            Description = 'Corner Window (Left) Width';
            Caption = '[DO NOT USE] Corner Window (Left) Width';
        }
        field(83; sr_corner_window_left_height; Integer)
        {
            ExternalName = 'sr_corner_window_left_height';
            ExternalType = 'Integer';
            Description = 'Corner Window (Left) Height';
            Caption = '[DO NOT USE] Corner Window (Left) Height';
        }
        field(84; sr_corner_window_right_height; Integer)
        {
            ExternalName = 'sr_corner_window_right_height';
            ExternalType = 'Integer';
            Description = 'Corner Window (Right) Height';
            Caption = '[DO NOT USE] Corner Window (Right) Height';
        }
        field(85; sr_corner_window_right_width; Integer)
        {
            ExternalName = 'sr_corner_window_right_width';
            ExternalType = 'Integer';
            Description = 'Corner Window (Right) Width';
            Caption = '[DO NOT USE] Corner Window (Right) Width';
        }
        field(86; sr_transon_window_width; Integer)
        {
            ExternalName = 'sr_transon_window_width';
            ExternalType = 'Integer';
            Description = 'Transon Window Width';
            Caption = '[DO NOT USE] Transon Window Width';
        }
        field(87; sr_transon_window_height; Integer)
        {
            ExternalName = 'sr_transon_window_height';
            ExternalType = 'Integer';
            Description = 'Transon Window Height';
            Caption = '[DO NOT USE] Transon Window Height';
        }
        field(88; sr_exterior_window1_width; Integer)
        {
            ExternalName = 'sr_exterior_window1_width';
            ExternalType = 'Integer';
            Description = 'Exterior Window 1 Width';
            Caption = '[DO NOT USE] Exterior Window 1 Width';
        }
        field(89; sr_exterior_window1_height; Integer)
        {
            ExternalName = 'sr_exterior_window1_height';
            ExternalType = 'Integer';
            Description = 'Exterior Window 1 Height';
            Caption = '[DO NOT USE] Exterior Window 1 Height';
        }
        field(90; sr_exterior_window2_width; Integer)
        {
            ExternalName = 'sr_exterior_window2_width';
            ExternalType = 'Integer';
            Description = 'Exterior Window 2 Width';
            Caption = '[DO NOT USE] Exterior Window 2 Width';
        }
        field(91; sr_exterior_window2_height; Integer)
        {
            ExternalName = 'sr_exterior_window2_height';
            ExternalType = 'Integer';
            Description = 'Exterior Window 2 Height';
            Caption = '[DO NOT USE] Exterior Window 2 Height';
        }
        field(92; sr_exterior_window3_width; Integer)
        {
            ExternalName = 'sr_exterior_window3_width';
            ExternalType = 'Integer';
            Description = 'Exterior Window 3 Width';
            Caption = '[DO NOT USE] Exterior Window 3 Width';
        }
        field(93; sr_exterior_window3_height; Integer)
        {
            ExternalName = 'sr_exterior_window3_height';
            ExternalType = 'Integer';
            Description = 'Exterior Window 3 Height';
            Caption = '[DO NOT USE] Exterior Window 3 Height';
        }
        field(94; sr_exterior_window4_width; Integer)
        {
            ExternalName = 'sr_exterior_window4_width';
            ExternalType = 'Integer';
            Description = 'Exterior Window 4 Width';
            Caption = '[DO NOT USE] Exterior Window 4 Width';
        }
        field(95; sr_exterior_window4_height; Integer)
        {
            ExternalName = 'sr_exterior_window4_height';
            ExternalType = 'Integer';
            Description = 'Exterior Window 4 Height';
            Caption = '[DO NOT USE] Exterior Window 4 Height';
        }
        field(102; sr_is_staggered_rent_pricing; Boolean)
        {
            ExternalName = 'sr_is_staggered_rent_pricing';
            ExternalType = 'Boolean';
            Description = 'Staggered Rent Pricing';
            Caption = 'Staggered Rent Pricing';
        }
        field(104; sr_staggered_rent_pricing_data; Text[2000])
        {
            ExternalName = 'sr_staggered_rent_pricing_data';
            ExternalType = 'String';
            Description = 'Staggered Rent Pricing Data from Data Import using | separator.';
            Caption = 'Staggered Rent Pricing Data';
        }
        field(105; sr_is_combined_studio; Boolean)
        {
            ExternalName = 'sr_is_combined_studio';
            ExternalType = 'Boolean';
            Description = 'Combined Studio?';
            Caption = 'Combined Studio?';
        }
        field(107; sr_combined_with; GUID)
        {
            ExternalName = 'sr_combined_with';
            ExternalType = 'Lookup';
            Description = 'Attach Other studio in the same salon combined with';
            Caption = 'Combined With';
            TableRelation = "CDS sr_Studio".sr_StudioId;
        }
        field(109; sr_window_size; Option)
        {
            ExternalName = 'sr_window_size';
            ExternalType = 'Picklist';
            Description = 'Window Size';
            Caption = 'Window Size';
            InitValue = " ";
            OptionMembers = " ","Partial(upTo3/8)","Mid(1/2-5/8)","Full(3/4-Full)";
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002;
        }
        field(111; sr_studio_trait; Option)
        {
            ExternalName = 'sr_studio_trait';
            ExternalType = 'Picklist';
            Description = 'Studio Trait';
            Caption = 'Studio Trait';
            InitValue = " ";
            OptionMembers = " ",FrontOfSalon,BackOfSalon,Column,"RestroomFacing/Adjacent",BudgetFriendly;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004;
        }
        field(113; sr_anticipated_moveout_date; Date)
        {
            ExternalName = 'sr_anticipated_moveout_date';
            ExternalType = 'DateTime';
            Description = 'Anticipated Move-Out Date';
            Caption = 'Anticipated Move-Out Date';
        }
        field(114; sr_doorwindowwidth; Text[10])
        {
            ExternalName = 'sr_doorwindowwidth';
            ExternalType = 'String';
            Description = 'Door Window Width';
            Caption = 'Door Window Width';
        }
        field(115; sr_doorwindowheight; Text[10])
        {
            ExternalName = 'sr_doorwindowheight';
            ExternalType = 'String';
            Description = 'Door Window Height';
            Caption = 'Door Window Height';
        }
        field(116; sr_sidelightwindowwidth; Text[10])
        {
            ExternalName = 'sr_sidelightwindowwidth';
            ExternalType = 'String';
            Description = 'Sidelight Window Width';
            Caption = 'Sidelight Window Width';
        }
        field(117; sr_sidelightwindowheight; Text[10])
        {
            ExternalName = 'sr_sidelightwindowheight';
            ExternalType = 'String';
            Description = 'Sidelight Window Height';
            Caption = 'Sidelight Window Height';
        }
        field(118; sr_cornerwindowleftwidth; Text[10])
        {
            ExternalName = 'sr_cornerwindowleftwidth';
            ExternalType = 'String';
            Description = 'Corner Window (Left) Width';
            Caption = 'Corner Window (Left) Width';
        }
        field(119; sr_cornerwindowleftheight; Text[10])
        {
            ExternalName = 'sr_cornerwindowleftheight';
            ExternalType = 'String';
            Description = 'Corner Window (Left) Height';
            Caption = 'Corner Window (Left) Height';
        }
        field(120; sr_cornerwindowrightwidth; Text[10])
        {
            ExternalName = 'sr_cornerwindowrightwidth';
            ExternalType = 'String';
            Description = 'Corner Window (Right) Width';
            Caption = 'Corner Window (Right) Width';
        }
        field(121; sr_cornerwindowrightheight; Text[10])
        {
            ExternalName = 'sr_cornerwindowrightheight';
            ExternalType = 'String';
            Description = 'Corner Window (Right) Height';
            Caption = 'Corner Window (Right) Height';
        }
        field(122; sr_transonwindowwidth; Text[10])
        {
            ExternalName = 'sr_transonwindowwidth';
            ExternalType = 'String';
            Description = 'Transon Window Width';
            Caption = 'Transon Window Width';
        }
        field(123; sr_transonwindowheight; Text[10])
        {
            ExternalName = 'sr_transonwindowheight';
            ExternalType = 'String';
            Description = 'Transon Window Height';
            Caption = 'Transon Window Height';
        }
        field(124; sr_exteriorwindow1width; Text[10])
        {
            ExternalName = 'sr_exteriorwindow1width';
            ExternalType = 'String';
            Description = 'Exterior Window 1 Width';
            Caption = 'Exterior Window 1 Width';
        }
        field(125; sr_exteriorwindow2width; Text[10])
        {
            ExternalName = 'sr_exteriorwindow2width';
            ExternalType = 'String';
            Description = 'Exterior Window 2 Width';
            Caption = 'Exterior Window 2 Width';
        }
        field(126; sr_exteriorwindow3width; Text[10])
        {
            ExternalName = 'sr_exteriorwindow3width';
            ExternalType = 'String';
            Description = 'Exterior Window 3 Width';
            Caption = 'Exterior Window 3 Width';
        }
        field(127; sr_exteriorwindow4width; Text[10])
        {
            ExternalName = 'sr_exteriorwindow4width';
            ExternalType = 'String';
            Description = 'Exterior Window 4 Width';
            Caption = 'Exterior Window 4 Width';
        }
        field(128; sr_exteriorwindow1height; Text[10])
        {
            ExternalName = 'sr_exteriorwindow1height';
            ExternalType = 'String';
            Description = 'Exterior Window 1 Height';
            Caption = 'Exterior Window 1 Height';
        }
        field(129; sr_exteriorwindow2height; Text[10])
        {
            ExternalName = 'sr_exteriorwindow2height';
            ExternalType = 'String';
            Description = 'Exterior Window 2 Height';
            Caption = 'Exterior Window 2 Height';
        }
        field(130; sr_exteriorwindow3height; Text[10])
        {
            ExternalName = 'sr_exteriorwindow3height';
            ExternalType = 'String';
            Description = 'Exterior Window 3 Height';
            Caption = 'Exterior Window 3 Height';
        }
        field(131; sr_exteriorwindow4height; Text[10])
        {
            ExternalName = 'sr_exteriorwindow4height';
            ExternalType = 'String';
            Description = 'Exterior Window 4 Height';
            Caption = 'Exterior Window 4 Height';
        }
        field(132; sr_otherwindowwidth; Text[10])
        {
            ExternalName = 'sr_otherwindowwidth';
            ExternalType = 'String';
            Description = 'Other Window Width';
            Caption = 'Other Window Width';
        }
        field(133; sr_otherwindowheight; Text[10])
        {
            ExternalName = 'sr_otherwindowheight';
            ExternalType = 'String';
            Description = 'Other Window Height';
            Caption = 'Other Window Height';
        }
        field(136; sr_studio_type; Option)
        {
            ExternalName = 'sr_studio_type';
            ExternalType = 'Picklist';
            Description = 'Studio Type';
            Caption = 'Studio Type';
            InitValue = " ";
            OptionMembers = " ","Window-Exterior/OutdoorFacing","Window-Interior/IndoorFacing","Interior-CornerWindow","Interior-Transom/ClearstoryWindow(SunWindow)","Interior-Standard","InteriorWithPrivacy/quieterAreaOfSalon","BudgetFriendly/costEffective";
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003, 100000006, 100000004, 100000005;
        }
        field(138; sr_studiostatus; Option)
        {
            ExternalName = 'sr_studiostatus';
            ExternalType = 'Picklist';
            Description = 'Studio Status';
            Caption = 'Studio Status';
            InitValue = " ";
            OptionMembers = " ",Vacant,Occupied,"Occupied-TerminationNotice";
            OptionOrdinalValues = -1, 742440000, 742440001, 742440002;
        }
    }
    keys
    {
        key(PK; sr_StudioId)
        {
            Clustered = true;
        }
        key(Name; sr_Name)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; sr_Name)
        {
        }
    }
}