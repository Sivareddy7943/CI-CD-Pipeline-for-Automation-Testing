//Summary -New AL Table "Salon Building" in Business Central.
//D365 Dataverse Integration with 50003 "CDS sr_Building".
table 90119 "Salon Building"
{
    Caption = 'Salon Building';
    DataClassification = ToBeClassified;
    LookupPageId = "Salon Building List";
    DrillDownPageId = "Salon Building List";

    fields
    {
        field(1; sr_buildingcode; Text[100])
        {
            Description = '';
            Caption = 'Building Code';
        }
        field(2; CreatedOn; Datetime)
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
            Description = 'Status of the Building';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
        }
        field(27; statuscode; Option)
        {
            Description = 'Reason for the status of the Building';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
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
        field(34; sr_Name; Text[100])
        {
            Description = '';
            Caption = 'Name';
        }
        field(37; sr_salonphone; Text[100])
        {
            Description = '';
            Caption = 'Salon Phone #';
        }
        field(38; sr_doorkingphone; Text[100])
        {
            Description = 'Doorking Phone';
            Caption = 'Doorking Phone';
        }
        field(39; sr_salonemailaddress; Text[100])
        {
            Description = '';
            Caption = 'Salon E-mail Address';
        }
        field(40; sr_loc_onpremises; Text[2000])
        {
            Description = '';
            Caption = 'Mailbox Location on Premises';
        }
        field(41; sr_add_access_info; Text[1000])
        {
            Description = 'Additional Access Information';
            Caption = 'Additional Mailbox Access Info';
        }

        field(45; sr_totalarea; Decimal)
        {
            Description = '';
            Caption = 'Total Area (sqft)';
        }
        field(46; sr_nooffloor; Integer)
        {
            Description = '';
            Caption = 'No Of Floor';
        }
        field(51; sr_propertymanagement_ofc_loc; Text[2000])
        {
            Description = '';
            Caption = '[Do not use]Property Management Office Location';
        }
        field(54; sr_sec_off_loc_onprem; Text[500])
        {
            Description = '';
            Caption = 'Security Office Location on premises';
        }
        field(55; sr_add_sec_info; Text[500])
        {
            Description = '';
            Caption = 'Additional Security Info';
        }
        field(56; sr_num_of_studio; Integer)
        {
            Description = '';
            Caption = 'Number of Studio';
        }
        field(57; sr_loc_onprem; Text[500])
        {
            Description = '';
            Caption = 'Property Manager Office Location on Premises';
        }
        field(58; sr_parkmgmt_company; Text[200])
        {
            Description = '';
            Caption = 'Parking Management Company';
        }
        field(61; sr_park_ofc_loc_onprem; Text[2000])
        {
            Description = '';
            Caption = 'Parking Office Location on premises';
        }
        field(62; sr_parkingfee; Decimal)
        {
            Description = '';
            Caption = 'Parking Pass Fee/Cost';
        }
        field(65; ExchangeRate; Decimal)
        {
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(66; sr_parkingfee_Base; Decimal)
        {
            Description = 'Value of the Parking Pass Fee/Cost in base currency.';
            Caption = 'Parking Pass Fee/Cost (Base)';
        }
        //SY
        //sr_PassAppPaymentLicenseeManagedBy
        field(67; sr_PassAppliPaymLicenManagedBy; Option)
        {
            Description = '';
            Caption = 'Pass Application & Payment (Licensee) Managed By?';
            InitValue = SalonRepublic;
            OptionMembers = SalonRepublic,Landlord,ParkingManagementCompany;
        }
        field(69; sr_applicationprocess; Text[2000])
        {
            Description = '';
            Caption = 'Application Process';
        }
        field(70; sr_client_parkingfee; Decimal)
        {
            Description = '';
            Caption = 'Parking Fee/Cost';
        }
        field(71; sr_client_parkingfee_Base; Decimal)
        {
            Description = 'Value of the Parking Fee/Cost in base currency.';
            Caption = 'Parking Fee/Cost (Base)';
        }
        field(72; sr_client_validationprovided; Boolean)
        {
            Description = '';
            Caption = 'Validation Provided(Clients)';
        }
        //SY
        //sr_DesignatedParkingforEmployeesLicensees
        field(74; sr_DesigParkforEmploLicensees; Boolean)
        {
            Description = '';
            Caption = 'Designated  Parking for Employees/Licensees';
        }
        //SY
        //sr_AdditionalParkingInformation
        field(76; sr_AdditionalParkingInformatio; Text[2048])
        {
            Description = '';
            Caption = 'Additional Parking Information';
        }
        field(77; sr_sec_cam_url; Text[500])
        {
            Description = '';
            Caption = 'Security Camera URL';
        }
        field(78; sr_sec_cam_ip; Text[100])
        {
            Description = '';
            Caption = 'Security Camera IP';
        }
        field(79; sr_sec_cam_user; Text[100])
        {
            Description = '';
            Caption = 'Security Camera User Name';
        }
        field(80; sr_sec_cam_password; Text[40])
        {
            Description = '';
            Caption = 'Security Camera Password';
        }
        field(81; sr_prptymgmtofccoc; Text[2000])
        {
            Description = '';
            Caption = 'Property Management Office Location';
        }
        field(82; sr_numberofstudio; Integer)
        {
            Description = '';
            Caption = 'Number of Studio';
        }
        field(83; sr_numberofstudio_Date; Datetime)
        {
            Description = 'Last Updated time of rollup field Number of Studio.';
            Caption = 'Number of Studio (Last Updated On)';
        }
        field(84; sr_numberofstudio_State; Integer)
        {
            Description = 'State of rollup field Number of Studio.';
            Caption = 'Number of Studio (State)';
        }
        field(85; sr_locationofwaterheaters; Text[100])
        {
            Description = '';
            Caption = 'Location of Water Heaters/Boiler';
        }
        field(86; sr_specialaccessneeded; Boolean)
        {
            Description = '';
            Caption = 'Special Access needed?';
        }
        //SY
        //sr_specialaccessinformationinstructions
        field(88; sr_specialaccessinfoinstructio; Text[2000])
        {
            Description = '';
            Caption = 'Special Access Info/Instructions';
        }
        field(89; sr_laundryfacilitytype; Option)
        {
            Description = '';
            Caption = 'Laundry Machine Ownership';
            InitValue = " ";
            OptionMembers = " ",Rental,OwnedBySR;
        }
        field(91; sr_rentalcompanyname; Text[100])
        {
            Description = '';
            Caption = 'Rental Company Name';
        }
        field(92; sr_rentalcompcontactnumber; Text[100])
        {
            Description = '';
            Caption = 'Rental Company Contact Number';
        }
        field(93; sr_laundrymachineuse; Option)
        {
            Description = '';
            Caption = 'Laundry Machine Use';
            InitValue = " ";
            OptionMembers = " ",PaidUse,FreeLaundryMachines;
        }
        field(95; sr_paymentppplicationlink; Text[100])
        {
            Description = '';
            Caption = 'Payment Application Link';
        }
        field(96; sr_laundrymachinefee; Decimal)
        {
            Description = '';
            Caption = 'Laundry Machine Fee';
        }
        field(97; sr_laundrymachinefee_Base; Decimal)
        {
            Description = 'Value of the Laundry Machine Fee in base currency.';
            Caption = 'Laundry Machine Fee (Base)';
        }
        field(98; sr_fulltimeavailablemachines; Text[2000])
        {
            Description = '';
            Caption = 'Full-Time Availability (Licensee)';
        }
        field(99; sr_machinesforjanitorialonly; Text[2000])
        {
            Description = '';
            Caption = 'Janitorial Use Only Machines (Janitor Hours)';
        }
        field(100; sr_maincontrollocation; Text[2000])
        {
            Description = '';
            Caption = '[Do not use]Location of Main Control';
        }
        //SY
        //sr_dampenercontrolinindividualstudios
        field(101; sr_dampenercontrolinindivistud; Boolean)
        {
            Description = '';
            Caption = 'Dampener Control in individual studios';
        }
        field(103; sr_managementcompany; Text[100])
        {
            Description = '';
            Caption = 'Management Company';
        }
        field(104; sr_janitorialcontactperson; Text[100])
        {
            Description = '';
            Caption = 'Janitorial Contact Person';
        }
        field(105; sr_janitorialcontactnumber; Text[100])
        {
            Description = '';
            Caption = 'Janitorial Contact Number';
        }
        field(106; sr_onsitejanitorname; Text[100])
        {
            Description = '';
            Caption = 'On-Site Janitor Name';
        }
        field(107; sr_janitorialsupplystorageloc; Text[2000])
        {
            Description = '';
            Caption = 'Janitorial Supply Storage Location';
        }
        field(108; sr_trashcompactorlocation; Text[2000])
        {
            Description = '';
            Caption = 'Trash Compactor Location';
        }
        field(109; sr_largeitemstrashcandispoloca; Text[2000])
        {
            Description = '';
            Caption = 'Large items trash can disposal location';
        }
        field(110; sr_recycleonlytrashcandisploca; Text[2000])
        {
            Description = '';
            Caption = 'Recycle only trash can disposal location';
        }
        field(111; sr_otherRequiredtrashdisposalc; Text[2000])
        {
            Description = '';
            Caption = ' Other Required trash disposal cans';
        }
        field(112; sr_finesfordisposingoftrashinc; Text[1000])
        {
            Description = '';
            Caption = 'Fines for disposing of trash incorrectly';
        }
        field(113; sr_othertypesoftrashdisposal; Text[1000])
        {
            Description = '';
            Caption = ' Other types of trash disposal';
        }
        field(116; sr_createreferencedata; Boolean)
        {
            Description = '';
            Caption = 'Create Reference Data';
        }
        field(121; sr_salonn_address; Text[1000])
        {
            Description = 'Salon Address will be used for data import';
            Caption = 'Salon Address';
        }
        field(122; sr_salon_amenities; Text[2000])
        {
            Description = 'Salon Amenities will be used for data import';
            Caption = 'Salon Amenities';
        }
        field(123; sr_BuildingPermittedServices; Text[2048])
        {
            Description = 'Building Permitted Services - will be used for data import';
            Caption = 'Building Permitted Services';
        }
        field(124; sr_licenseparkingper; Option)
        {
            Description = '';
            Caption = 'License Parking Per';
            InitValue = " ";
            OptionMembers = " ",Day,Week,Month,Year;
        }
        field(129; sr_othermanagement_name; Text[100])
        {
            Description = '';
            Caption = 'Other Management Name';
        }
        field(130; sr_othermanagement_title; Text[100])
        {
            Description = '';
            Caption = 'Other Management Title';
        }
        field(131; sr_othermanagement_contactinfo; Text[200])
        {
            Description = '';
            Caption = 'Other Management Contact Info';
        }
        field(132; sr_Prospects; GUID)
        {
            Description = '';
            Caption = 'Prospects';
            //TableRelation = "CDS Lead".LeadId;
        }
        field(135; sr_additionalvalidationinfo; Text[2048])
        {
            Description = '';
            Caption = 'Additional Validation Info';
        }
        field(138; sr_CalendlyBookingURL; Text[200])
        {
            Description = '';
            Caption = 'Calendly Booking URL';
        }
        field(139; sr_SalonEmail; Text[100])
        {
            Description = '';
            Caption = 'Salon Email';
        }
        field(140; "Created By"; Guid)
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(141; "Modified By"; Guid)
        {
            Caption = 'Modified By';
            Editable = false;
        }
        field(142; sr_CRMSalonPK; Guid)
        {
            Caption = 'CRM Salon PK GUID';
            Editable = false;
        }
    }
    keys
    {
        key(PK; sr_buildingcode)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; sr_Name)
        {
        }
    }
}
