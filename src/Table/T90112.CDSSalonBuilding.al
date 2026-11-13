table 90112 "CDS sr_Building"
{
    ExternalName = 'sr_building';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; sr_BuildingId; GUID)
        {
            ExternalName = 'sr_buildingid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Building';
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
            Description = 'Status of the Building';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Building';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 1, 2;
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
        field(34; sr_Name; Text[100])
        {
            ExternalName = 'sr_name';
            ExternalType = 'String';
            Description = '';
            Caption = 'Name';
        }
        field(37; sr_salonphone; Text[100])
        {
            ExternalName = 'sr_salonphone';
            ExternalType = 'String';
            Description = '';
            Caption = 'Salon Phone #';
        }
        field(38; sr_doorkingphone; Text[100])
        {
            ExternalName = 'sr_doorkingphone';
            ExternalType = 'String';
            Description = 'Doorking Phone';
            Caption = 'Doorking Phone';
        }
        field(39; sr_salonemailaddress; Text[100])
        {
            ExternalName = 'sr_salonemailaddress';
            ExternalType = 'String';
            Description = '';
            Caption = 'Salon E-mail Address';
        }
        field(40; sr_loc_onpremises; Text[2000])
        {
            ExternalName = 'sr_loc_onpremises';
            ExternalType = 'String';
            Description = '';
            Caption = 'Mailbox Location on Premises';
        }
        field(41; sr_add_access_info; Text[1000])
        {
            ExternalName = 'sr_add_access_info';
            ExternalType = 'String';
            Description = 'Additional Access Information';
            Caption = 'Additional Mailbox Access Info';
        }
        field(42; sr_buildingcode; Text[100])
        {
            ExternalName = 'sr_buildingcode';
            ExternalType = 'String';
            Description = '';
            Caption = 'Building Code';
        }
        field(45; sr_totalarea; Decimal)
        {
            ExternalName = 'sr_totalarea';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Total Area (sqft)';
        }
        field(46; sr_nooffloor; Integer)
        {
            ExternalName = 'sr_nooffloor';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'No Of Floor';
        }
        field(51; sr_propertymanagement_ofc_loc; Text[2000])
        {
            ExternalName = 'sr_propertymanagement_ofc_loc';
            ExternalType = 'String';
            Description = '';
            Caption = '[Do not use]Property Management Office Location';
        }
        field(54; sr_sec_off_loc_onprem; Text[500])
        {
            ExternalName = 'sr_sec_off_loc_onprem';
            ExternalType = 'String';
            Description = '';
            Caption = 'Security Office Location on premises';
        }
        field(55; sr_add_sec_info; Text[500])
        {
            ExternalName = 'sr_add_sec_info';
            ExternalType = 'String';
            Description = '';
            Caption = 'Additional Security Info';
        }
        field(56; sr_num_of_studio; Integer)
        {
            ExternalName = 'sr_num_of_studio';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Number of Studio';
        }
        field(57; sr_loc_onprem; Text[500])
        {
            ExternalName = 'sr_loc_onprem';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property Manager Office Location on Premises';
        }
        field(58; sr_parkmgmt_company; Text[200])
        {
            ExternalName = 'sr_parkmgmt_company';
            ExternalType = 'String';
            Description = '';
            Caption = 'Parking Management Company';
        }
        field(61; sr_park_ofc_loc_onprem; Text[2000])
        {
            ExternalName = 'sr_park_ofc_loc_onprem';
            ExternalType = 'String';
            Description = '';
            Caption = 'Parking Office Location on premises';
        }
        field(62; sr_parkingfee; Decimal)
        {
            ExternalName = 'sr_parkingfee';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Parking Pass Fee/Cost';
        }
        field(65; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(66; sr_parkingfee_Base; Decimal)
        {
            ExternalName = 'sr_parkingfee_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Parking Pass Fee/Cost in base currency.';
            Caption = 'Parking Pass Fee/Cost (Base)';
        }
        field(67; sr_PassApplicationPaymentLicenseeManagedBy; Option)
        {
            ExternalName = 'sr_passapplicationpaymentlicenseemanagedby';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Pass Application & Payment (Licensee) Managed By?';
            InitValue = SalonRepublic;
            OptionMembers = SalonRepublic,Landlord,ParkingManagementCompany;
            OptionOrdinalValues = 100000000, 100000001, 100000002;
        }
        field(69; sr_applicationprocess; Text[2000])
        {
            ExternalName = 'sr_applicationprocess';
            ExternalType = 'String';
            Description = '';
            Caption = 'Application Process';
        }
        field(70; sr_client_parkingfee; Decimal)
        {
            ExternalName = 'sr_client_parkingfee';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Parking Fee/Cost';
        }
        field(71; sr_client_parkingfee_Base; Decimal)
        {
            ExternalName = 'sr_client_parkingfee_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Parking Fee/Cost in base currency.';
            Caption = 'Parking Fee/Cost (Base)';
        }
        field(72; sr_client_validationprovided; Boolean)
        {
            ExternalName = 'sr_client_validationprovided';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Validation Provided(Clients)';
        }
        field(74; sr_DesignatedParkingforEmployeesLicensees; Boolean)
        {
            ExternalName = 'sr_designatedparkingforemployeeslicensees';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Designated  Parking for Employees/Licensees';
        }
        field(76; sr_AdditionalParkingInformation; Text[2048])
        {
            ExternalName = 'sr_additionalparkinginformation';
            ExternalType = 'String';
            Description = '';
            Caption = 'Additional Parking Information';
        }
        field(77; sr_sec_cam_url; Text[500])
        {
            ExternalName = 'sr_sec_cam_url';
            ExternalType = 'String';
            Description = '';
            Caption = 'Security Camera URL';
        }
        field(78; sr_sec_cam_ip; Text[100])
        {
            ExternalName = 'sr_sec_cam_ip';
            ExternalType = 'String';
            Description = '';
            Caption = 'Security Camera IP';
        }
        field(79; sr_sec_cam_user; Text[100])
        {
            ExternalName = 'sr_sec_cam_user';
            ExternalType = 'String';
            Description = '';
            Caption = 'Security Camera User Name';
        }
        field(80; sr_sec_cam_password; Text[40])
        {
            ExternalName = 'sr_sec_cam_password';
            ExternalType = 'String';
            Description = '';
            Caption = 'Security Camera Password';
        }
        field(81; sr_prptymgmtofccoc; Text[2000])
        {
            ExternalName = 'sr_prptymgmtofccoc';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property Management Office Location';
        }
        field(82; sr_numberofstudio; Integer)
        {
            ExternalName = 'sr_numberofstudio';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Number of Studio';
        }
        field(83; sr_numberofstudio_Date; Datetime)
        {
            ExternalName = 'sr_numberofstudio_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Number of Studio.';
            Caption = 'Number of Studio (Last Updated On)';
        }
        field(84; sr_numberofstudio_State; Integer)
        {
            ExternalName = 'sr_numberofstudio_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Number of Studio.';
            Caption = 'Number of Studio (State)';
        }
        field(85; sr_locationofwaterheaters; Text[100])
        {
            ExternalName = 'sr_locationofwaterheaters';
            ExternalType = 'String';
            Description = '';
            Caption = 'Location of Water Heaters/Boiler';
        }
        field(86; sr_specialaccessneeded; Boolean)
        {
            ExternalName = 'sr_specialaccessneeded';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Special Access needed?';
        }
        field(88; sr_specialaccessinformationinstructions; Text[2000])
        {
            ExternalName = 'sr_specialaccessinformationinstructions';
            ExternalType = 'String';
            Description = '';
            Caption = 'Special Access Info/Instructions';
        }
        field(89; sr_laundryfacilitytype; Option)
        {
            ExternalName = 'sr_laundryfacilitytype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Laundry Machine Ownership';
            InitValue = " ";
            OptionMembers = " ",Rental,OwnedBySR;
            OptionOrdinalValues = -1, 100000000, 100000001;
        }
        field(91; sr_rentalcompanyname; Text[100])
        {
            ExternalName = 'sr_rentalcompanyname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Rental Company Name';
        }
        field(92; sr_rentalcompcontactnumber; Text[100])
        {
            ExternalName = 'sr_rentalcompcontactnumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'Rental Company Contact Number';
        }
        field(93; sr_laundrymachineuse; Option)
        {
            ExternalName = 'sr_laundrymachineuse';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Laundry Machine Use';
            InitValue = " ";
            OptionMembers = " ",PaidUse,FreeLaundryMachines;
            OptionOrdinalValues = -1, 100000000, 100000001;
        }
        field(95; sr_paymentppplicationlink; Text[100])
        {
            ExternalName = 'sr_paymentppplicationlink';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Application Link';
        }
        field(96; sr_laundrymachinefee; Decimal)
        {
            ExternalName = 'sr_laundrymachinefee';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Laundry Machine Fee';
        }
        field(97; sr_laundrymachinefee_Base; Decimal)
        {
            ExternalName = 'sr_laundrymachinefee_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Laundry Machine Fee in base currency.';
            Caption = 'Laundry Machine Fee (Base)';
        }
        field(98; sr_fulltimeavailablemachines; Text[2000])
        {
            ExternalName = 'sr_fulltimeavailablemachines';
            ExternalType = 'String';
            Description = '';
            Caption = 'Full-Time Availability (Licensee)';
        }
        field(99; sr_machinesforjanitorialonly; Text[2000])
        {
            ExternalName = 'sr_machinesforjanitorialonly';
            ExternalType = 'String';
            Description = '';
            Caption = 'Janitorial Use Only Machines (Janitor Hours)';
        }
        field(100; sr_maincontrollocation; Text[2000])
        {
            ExternalName = 'sr_maincontrollocation';
            ExternalType = 'String';
            Description = '';
            Caption = '[Do not use]Location of Main Control';
        }
        field(101; sr_dampenercontrolinindividualstudios; Boolean)
        {
            ExternalName = 'sr_dampenercontrolinindividualstudios';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Dampener Control in individual studios';
        }
        field(103; sr_managementcompany; Text[100])
        {
            ExternalName = 'sr_managementcompany';
            ExternalType = 'String';
            Description = '';
            Caption = 'Management Company';
        }
        field(104; sr_janitorialcontactperson; Text[100])
        {
            ExternalName = 'sr_janitorialcontactperson';
            ExternalType = 'String';
            Description = '';
            Caption = 'Janitorial Contact Person';
        }
        field(105; sr_janitorialcontactnumber; Text[100])
        {
            ExternalName = 'sr_janitorialcontactnumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'Janitorial Contact Number';
        }
        field(106; sr_onsitejanitorname; Text[100])
        {
            ExternalName = 'sr_onsitejanitorname';
            ExternalType = 'String';
            Description = '';
            Caption = 'On-Site Janitor Name';
        }
        field(107; sr_janitorialsupplystorageloc; Text[2000])
        {
            ExternalName = 'sr_janitorialsupplystorageloc';
            ExternalType = 'String';
            Description = '';
            Caption = 'Janitorial Supply Storage Location';
        }
        field(108; sr_trashcompactorlocation; Text[2000])
        {
            ExternalName = 'sr_trashcompactorlocation';
            ExternalType = 'String';
            Description = '';
            Caption = 'Trash Compactor Location';
        }
        field(109; sr_largeitemstrashcandisposallocation; Text[2000])
        {
            ExternalName = 'sr_largeitemstrashcandisposallocation';
            ExternalType = 'String';
            Description = '';
            Caption = 'Large items trash can disposal location';
        }
        field(110; sr_recycleonlytrashcandisposallocation; Text[2000])
        {
            ExternalName = 'sr_recycleonlytrashcandisposallocation';
            ExternalType = 'String';
            Description = '';
            Caption = 'Recycle only trash can disposal location';
        }
        field(111; sr_otherRequiredtrashdisposalcans; Text[2000])
        {
            ExternalName = 'sr_otherrequiredtrashdisposalcans';
            ExternalType = 'String';
            Description = '';
            Caption = ' Other Required trash disposal cans';
        }
        field(112; sr_finesfordisposingoftrashincorrectly; Text[1000])
        {
            ExternalName = 'sr_finesfordisposingoftrashincorrectly';
            ExternalType = 'String';
            Description = '';
            Caption = 'Fines for disposing of trash incorrectly';
        }
        field(113; sr_othertypesoftrashdisposal; Text[1000])
        {
            ExternalName = 'sr_othertypesoftrashdisposal';
            ExternalType = 'String';
            Description = '';
            Caption = ' Other types of trash disposal';
        }
        field(116; sr_createreferencedata; Boolean)
        {
            ExternalName = 'sr_createreferencedata';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Create Reference Data';
        }
        field(121; sr_salonn_address; Text[1000])
        {
            ExternalName = 'sr_salonn_address';
            ExternalType = 'String';
            Description = 'Salon Address will be used for data import';
            Caption = 'Salon Address';
        }
        field(122; sr_salon_amenities; Text[2000])
        {
            ExternalName = 'sr_salon_amenities';
            ExternalType = 'String';
            Description = 'Salon Amenities will be used for data import';
            Caption = 'Salon Amenities';
        }
        field(123; sr_BuildingPermittedServices; Text[2048])
        {
            ExternalName = 'sr_buildingpermittedservices';
            ExternalType = 'String';
            Description = 'Building Permitted Services - will be used for data import';
            Caption = 'Building Permitted Services';
        }
        field(124; sr_licenseparkingper; Option)
        {
            ExternalName = 'sr_licenseparkingper';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'License Parking Per';
            InitValue = " ";
            OptionMembers = " ",Day,Week,Month,Year;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003;
        }
        field(129; sr_othermanagement_name; Text[100])
        {
            ExternalName = 'sr_othermanagement_name';
            ExternalType = 'String';
            Description = '';
            Caption = 'Other Management Name';
        }
        field(130; sr_othermanagement_title; Text[100])
        {
            ExternalName = 'sr_othermanagement_title';
            ExternalType = 'String';
            Description = '';
            Caption = 'Other Management Title';
        }
        field(131; sr_othermanagement_contactinfo; Text[200])
        {
            ExternalName = 'sr_othermanagement_contactinfo';
            ExternalType = 'String';
            Description = '';
            Caption = 'Other Management Contact Info';
        }
        field(132; sr_Prospects; GUID)
        {
            ExternalName = 'sr_prospects';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Prospects';
            TableRelation = "CDS Lead".LeadId;
        }
        field(135; sr_additionalvalidationinfo; Text[2048])
        {
            ExternalName = 'sr_additionalvalidationinfo';
            ExternalType = 'String';
            Description = '';
            Caption = 'Additional Validation Info';
        }
        field(138; sr_CalendlyBookingURL; Text[200])
        {
            ExternalName = 'sr_calendlybookingurl';
            ExternalType = 'String';
            Description = '';
            Caption = 'Calendly Booking URL';
        }
        field(139; sr_SalonEmail; Text[100])
        {
            ExternalName = 'sr_salonemail';
            ExternalType = 'String';
            Description = '';
            Caption = 'Salon Email';
        }
    }
    keys
    {
        key(PK; sr_BuildingId)
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