//Exported at 28 Nov 2023
table 90116 "CDS Lead"
{
    ExternalName = 'lead';
    TableType = CDS;
    Description = 'Prospect or potential sales opportunity. Leads are converted into accounts, contacts, or opportunities when they are qualified. Otherwise, they are deleted or archived.';

    fields
    {
        field(10000; LeadId; GUID)
        {
            ExternalName = 'leadid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier of the lead.';
            Caption = 'Lead';
        }
        field(10001; CreatedOn; Datetime)
        {
            ExternalName = 'createdon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Date and time when the record was created.';
            Caption = 'Created On';
        }
        field(10003; ModifiedOn; Datetime)
        {
            ExternalName = 'modifiedon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Date and time when the record was modified.';
            Caption = 'Modified On';
        }
        field(10024; VersionNumber; BigInteger)
        {
            ExternalName = 'versionnumber';
            ExternalType = 'BigInt';
            ExternalAccess = Read;
            Description = 'Version Number';
            Caption = 'Version Number';
        }
        field(10025; ImportSequenceNumber; Integer)
        {
            ExternalName = 'importsequencenumber';
            ExternalType = 'Integer';
            ExternalAccess = Insert;
            Description = 'Sequence number of the import that created this record.';
            Caption = 'Import Sequence Number';
        }
        field(10026; OverriddenCreatedOn; Date)
        {
            ExternalName = 'overriddencreatedon';
            ExternalType = 'DateTime';
            ExternalAccess = Insert;
            Description = 'Date and time that the record was migrated.';
            Caption = 'Record Created On';
        }
        field(10027; TimeZoneRuleVersionNumber; Integer)
        {
            ExternalName = 'timezoneruleversionnumber';
            ExternalType = 'Integer';
            Description = 'For internal use only.';
            Caption = 'Time Zone Rule Version Number';
        }
        field(10028; UTCConversionTimeZoneCode; Integer)
        {
            ExternalName = 'utcconversiontimezonecode';
            ExternalType = 'Integer';
            Description = 'Time zone code that was in use when the record was created.';
            Caption = 'UTC Conversion Time Zone Code';
        }
        field(10029; FullName; Text[160])
        {
            ExternalName = 'fullname';
            ExternalType = 'String';
            ExternalAccess = Read;
            Description = 'Combines and shows the lead''s first and last names so the full name can be displayed in views and reports.';
            Caption = 'Name';
        }
        field(10030; ProcessId; GUID)
        {
            ExternalName = 'processid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Contains the id of the process associated with the entity.';
            Caption = 'Process Id';
        }
        field(10031; StageId; GUID)
        {
            ExternalName = 'stageid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Contains the id of the stage where the entity is located.';
            Caption = '(Deprecated) Stage Id';
        }
        field(10032; TraversedPath; Text[1250])
        {
            ExternalName = 'traversedpath';
            ExternalType = 'String';
            Description = 'A comma separated list of string values representing the unique identifiers of stages in a Business Process Flow Instance in the order that they occur.';
            Caption = '(Deprecated) Traversed Path';
        }
        field(10035; Address1_AddressId; GUID)
        {
            ExternalName = 'address1_addressid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Unique identifier for address 1.';
            Caption = 'Address 1: ID';
        }
        field(10036; Address1_AddressTypeCode; Option)
        {
            ExternalName = 'address1_addresstypecode';
            ExternalType = 'Picklist';
            Description = 'Select the primary address type.';
            Caption = 'Address 1: Address Type';
            InitValue = DefaultValue;
            OptionMembers = DefaultValue;
            OptionOrdinalValues = 1;
        }
        field(10038; Address1_City; Text[80])
        {
            ExternalName = 'address1_city';
            ExternalType = 'String';
            Description = 'Type the city for the primary address.';
            Caption = 'City';
        }
        field(10039; Address1_Composite; BLOB)
        {
            ExternalName = 'address1_composite';
            ExternalType = 'Memo';
            ExternalAccess = Read;
            Description = 'Shows the complete primary address.';
            Caption = 'Address 1';
            Subtype = Memo;
        }
        field(10040; Address1_Country; Text[80])
        {
            ExternalName = 'address1_country';
            ExternalType = 'String';
            Description = 'Type the country or region for the primary address.';
            Caption = 'Country/Region';
        }
        field(10041; Address1_County; Text[50])
        {
            ExternalName = 'address1_county';
            ExternalType = 'String';
            Description = 'Type the county for the primary address.';
            Caption = 'Address 1: County';
        }
        field(10042; Address1_Fax; Text[50])
        {
            ExternalName = 'address1_fax';
            ExternalType = 'String';
            Description = 'Type the fax number associated with the primary address.';
            Caption = 'Address 1: Fax';
        }
        field(10043; Address1_Latitude; Decimal)
        {
            ExternalName = 'address1_latitude';
            ExternalType = 'Double';
            Description = 'Type the latitude value for the primary address for use in mapping and other applications.';
            Caption = 'Address 1: Latitude';
        }
        field(10044; Address1_Line1; Text[250])
        {
            ExternalName = 'address1_line1';
            ExternalType = 'String';
            Description = 'Type the first line of the primary address.';
            Caption = 'Street 1';
        }
        field(10045; Address1_Line2; Text[250])
        {
            ExternalName = 'address1_line2';
            ExternalType = 'String';
            Description = 'Type the second line of the primary address.';
            Caption = 'Street 2';
        }
        field(10046; Address1_Line3; Text[250])
        {
            ExternalName = 'address1_line3';
            ExternalType = 'String';
            Description = 'Type the third line of the primary address.';
            Caption = 'Street 3';
        }
        field(10047; Address1_Longitude; Decimal)
        {
            ExternalName = 'address1_longitude';
            ExternalType = 'Double';
            Description = 'Type the longitude value for the primary address for use in mapping and other applications.';
            Caption = 'Address 1: Longitude';
        }
        field(10048; Address1_Name; Text[100])
        {
            ExternalName = 'address1_name';
            ExternalType = 'String';
            Description = 'Type a descriptive name for the primary address, such as Corporate Headquarters.';
            Caption = 'Address 1: Name';
        }
        field(10049; Address1_PostalCode; Text[20])
        {
            ExternalName = 'address1_postalcode';
            ExternalType = 'String';
            Description = 'Type the ZIP Code or postal code for the primary address.';
            Caption = 'Zip';
        }
        field(10050; Address1_PostOfficeBox; Text[20])
        {
            ExternalName = 'address1_postofficebox';
            ExternalType = 'String';
            Description = 'Type the post office box number of the primary address.';
            Caption = 'Address 1: Post Office Box';
        }
        field(10051; Address1_ShippingMethodCode; Option)
        {
            ExternalName = 'address1_shippingmethodcode';
            ExternalType = 'Picklist';
            Description = 'Select a shipping method for deliveries sent to this address.';
            Caption = 'Address 1: Shipping Method';
            InitValue = DefaultValue;
            OptionMembers = DefaultValue;
            OptionOrdinalValues = 1;
        }
        field(10053; Address1_StateOrProvince; Text[50])
        {
            ExternalName = 'address1_stateorprovince';
            ExternalType = 'String';
            Description = 'Type the state or province of the primary address.';
            Caption = 'State/Province';
        }
        field(10054; Address1_Telephone1; Text[50])
        {
            ExternalName = 'address1_telephone1';
            ExternalType = 'String';
            Description = 'Type the main phone number associated with the primary address.';
            Caption = 'Address 1: Telephone 1';
        }
        field(10055; Address1_Telephone2; Text[50])
        {
            ExternalName = 'address1_telephone2';
            ExternalType = 'String';
            Description = 'Type a second phone number associated with the primary address.';
            Caption = 'Address 1: Telephone 2';
        }
        field(10056; Address1_Telephone3; Text[50])
        {
            ExternalName = 'address1_telephone3';
            ExternalType = 'String';
            Description = 'Type a third phone number associated with the primary address.';
            Caption = 'Address 1: Telephone 3';
        }
        field(10057; Address1_UPSZone; Text[4])
        {
            ExternalName = 'address1_upszone';
            ExternalType = 'String';
            Description = 'Type the UPS zone of the primary address to make sure shipping charges are calculated correctly and deliveries are made promptly, if shipped by UPS.';
            Caption = 'Address 1: UPS Zone';
        }
        field(10058; Address1_UTCOffset; Integer)
        {
            ExternalName = 'address1_utcoffset';
            ExternalType = 'Integer';
            Description = 'Select the time zone, or UTC offset, for this address so that other people can reference it when they contact someone at this address.';
            Caption = 'Address 1: UTC Offset';
        }
        field(10059; Address2_AddressId; GUID)
        {
            ExternalName = 'address2_addressid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Unique identifier for address 2.';
            Caption = 'Address 2: ID';
        }
        field(10060; Address2_AddressTypeCode; Option)
        {
            ExternalName = 'address2_addresstypecode';
            ExternalType = 'Picklist';
            Description = 'Select the secondary address type.';
            Caption = 'Address 2: Address Type';
            InitValue = DefaultValue;
            OptionMembers = DefaultValue;
            OptionOrdinalValues = 1;
        }
        field(10062; Address2_City; Text[80])
        {
            ExternalName = 'address2_city';
            ExternalType = 'String';
            Description = 'Type the city for the secondary address.';
            Caption = 'City';
        }
        field(10063; Address2_Composite; BLOB)
        {
            ExternalName = 'address2_composite';
            ExternalType = 'Memo';
            ExternalAccess = Read;
            Description = 'Shows the complete secondary address.';
            Caption = 'Address 2';
            Subtype = Memo;
        }
        field(10064; Address2_Country; Text[80])
        {
            ExternalName = 'address2_country';
            ExternalType = 'String';
            Description = 'Type the country or region for the secondary address.';
            Caption = 'Address 2: Country/Region';
        }
        field(10065; Address2_County; Text[50])
        {
            ExternalName = 'address2_county';
            ExternalType = 'String';
            Description = 'Type the county for the secondary address.';
            Caption = 'Address 2: County';
        }
        field(10066; Address2_Fax; Text[50])
        {
            ExternalName = 'address2_fax';
            ExternalType = 'String';
            Description = 'Type the fax number associated with the secondary address.';
            Caption = 'Address 2: Fax';
        }
        field(10067; Address2_Latitude; Decimal)
        {
            ExternalName = 'address2_latitude';
            ExternalType = 'Double';
            Description = 'Type the latitude value for the secondary address for use in mapping and other applications.';
            Caption = 'Address 2: Latitude';
        }
        field(10068; Address2_Line1; Text[250])
        {
            ExternalName = 'address2_line1';
            ExternalType = 'String';
            Description = 'Type the first line of the secondary address.';
            Caption = 'Address 2: Street 1';
        }
        field(10069; Address2_Line2; Text[250])
        {
            ExternalName = 'address2_line2';
            ExternalType = 'String';
            Description = 'Type the second line of the secondary address.';
            Caption = 'Address 2: Street 2';
        }
        field(10070; Address2_Line3; Text[250])
        {
            ExternalName = 'address2_line3';
            ExternalType = 'String';
            Description = 'Type the third line of the secondary address.';
            Caption = 'Address 2: Street 3';
        }
        field(10071; Address2_Longitude; Decimal)
        {
            ExternalName = 'address2_longitude';
            ExternalType = 'Double';
            Description = 'Type the longitude value for the secondary address for use in mapping and other applications.';
            Caption = 'Address 2: Longitude';
        }
        field(10072; Address2_Name; Text[100])
        {
            ExternalName = 'address2_name';
            ExternalType = 'String';
            Description = 'Type a descriptive name for the secondary address, such as Corporate Headquarters.';
            Caption = 'Address 2: Name';
        }
        field(10073; Address2_PostalCode; Text[20])
        {
            ExternalName = 'address2_postalcode';
            ExternalType = 'String';
            Description = 'Type the ZIP Code or postal code for the secondary address.';
            Caption = 'Address 2: ZIP/Postal Code';
        }
        field(10074; Address2_PostOfficeBox; Text[20])
        {
            ExternalName = 'address2_postofficebox';
            ExternalType = 'String';
            Description = 'Type the post office box number of the secondary address.';
            Caption = 'Address 2: Post Office Box';
        }
        field(10075; Address2_ShippingMethodCode; Option)
        {
            ExternalName = 'address2_shippingmethodcode';
            ExternalType = 'Picklist';
            Description = 'Select a shipping method for deliveries sent to this address.';
            Caption = 'Address 2: Shipping Method';
            InitValue = DefaultValue;
            OptionMembers = DefaultValue;
            OptionOrdinalValues = 1;
        }
        field(10077; Address2_StateOrProvince; Text[50])
        {
            ExternalName = 'address2_stateorprovince';
            ExternalType = 'String';
            Description = 'Type the state or province of the secondary address.';
            Caption = 'Address 2: State/Province';
        }
        field(10078; Address2_Telephone1; Text[50])
        {
            ExternalName = 'address2_telephone1';
            ExternalType = 'String';
            Description = 'Type the main phone number associated with the secondary address.';
            Caption = 'Address 2: Telephone 1';
        }
        field(10079; Address2_Telephone2; Text[50])
        {
            ExternalName = 'address2_telephone2';
            ExternalType = 'String';
            Description = 'Type a second phone number associated with the secondary address.';
            Caption = 'Address 2: Telephone 2';
        }
        field(10080; Address2_Telephone3; Text[50])
        {
            ExternalName = 'address2_telephone3';
            ExternalType = 'String';
            Description = 'Type a third phone number associated with the secondary address.';
            Caption = 'Address 2: Telephone 3';
        }
        field(10081; Address2_UPSZone; Text[4])
        {
            ExternalName = 'address2_upszone';
            ExternalType = 'String';
            Description = 'Type the UPS zone of the secondary address to make sure shipping charges are calculated correctly and deliveries are made promptly, if shipped by UPS.';
            Caption = 'Address 2: UPS Zone';
        }
        field(10082; Address2_UTCOffset; Integer)
        {
            ExternalName = 'address2_utcoffset';
            ExternalType = 'Integer';
            Description = 'Select the time zone, or UTC offset, for this address so that other people can reference it when they contact someone at this address.';
            Caption = 'Address 2: UTC Offset';
        }
        field(10083; BudgetAmount; Decimal)
        {
            ExternalName = 'budgetamount';
            ExternalType = 'Money';
            Description = 'Information about the budget amount of the lead''s company or organization.';
            Caption = 'Budget Amount';
        }
        field(10086; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Shows the conversion rate of the record''s currency. The exchange rate is used to convert all money fields in the record from the local currency to the system''s default currency.';
            Caption = 'Exchange Rate';
        }
        field(10087; BudgetAmount_Base; Decimal)
        {
            ExternalName = 'budgetamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Budget Amount in base currency.';
            Caption = 'Budget Amount (Base)';
        }
        field(10088; BudgetStatus; Option)
        {
            ExternalName = 'budgetstatus';
            ExternalType = 'Picklist';
            Description = 'Information about the budget status of the lead''s company or organization.';
            Caption = 'Budget';
            InitValue = " ";
            OptionMembers = " ",NoCommittedBudget,MayBuy,CanBuy,WillBuy;
            OptionOrdinalValues = -1, 0, 1, 2, 3;
        }
        field(10090; CompanyName; Text[100])
        {
            ExternalName = 'companyname';
            ExternalType = 'String';
            Description = 'Type the name of the company associated with the lead. This becomes the account name when the lead is qualified and converted to a customer account.';
            Caption = 'Company Name';
        }
        field(10091; ConfirmInterest; Boolean)
        {
            ExternalName = 'confirminterest';
            ExternalType = 'Boolean';
            Description = 'Select whether the lead confirmed interest in your offerings. This helps in determining the lead quality.';
            Caption = 'Confirm Interest';
        }
        field(10094; DecisionMaker; Boolean)
        {
            ExternalName = 'decisionmaker';
            ExternalType = 'Boolean';
            Description = 'Select whether your notes include information about who makes the purchase decisions at the lead''s company.';
            Caption = 'Decision Maker?';
        }
        field(10096; Description; BLOB)
        {
            ExternalName = 'description';
            ExternalType = 'Memo';
            Description = 'Type additional information to describe the lead, such as an excerpt from the company''s website.';
            Caption = 'Description';
            Subtype = Memo;
        }
        field(10097; DoNotBulkEMail; Boolean)
        {
            ExternalName = 'donotbulkemail';
            ExternalType = 'Boolean';
            Description = 'Select whether the lead accepts bulk email sent through marketing campaigns or quick campaigns. If Do Not Allow is selected, the lead can be added to marketing lists, but will be excluded from the email.';
            Caption = 'Do not allow Bulk Emails';
        }
        field(10099; DoNotEMail; Boolean)
        {
            ExternalName = 'donotemail';
            ExternalType = 'Boolean';
            Description = 'Select whether the lead allows direct email sent from Microsoft Dynamics 365.';
            Caption = 'Do not allow Emails';
        }
        field(10101; DoNotFax; Boolean)
        {
            ExternalName = 'donotfax';
            ExternalType = 'Boolean';
            Description = 'Select whether the lead allows faxes.';
            Caption = 'Do not allow Faxes';
        }
        field(10103; DoNotPhone; Boolean)
        {
            ExternalName = 'donotphone';
            ExternalType = 'Boolean';
            Description = 'Select whether the lead allows phone calls.';
            Caption = 'Do not allow Phone Calls';
        }
        field(10105; DoNotPostalMail; Boolean)
        {
            ExternalName = 'donotpostalmail';
            ExternalType = 'Boolean';
            Description = 'Select whether the lead allows direct mail.';
            Caption = 'Do not allow Mails';
        }
        field(10107; DoNotSendMM; Boolean)
        {
            ExternalName = 'donotsendmm';
            ExternalType = 'Boolean';
            Description = 'Select whether the lead accepts marketing materials, such as brochures or catalogs. Leads that opt out can be excluded from marketing initiatives.';
            Caption = 'Marketing Material';
        }
        field(10109; EMailAddress1; Text[100])
        {
            ExternalName = 'emailaddress1';
            ExternalType = 'String';
            Description = 'Type the primary email address for the lead.';
            Caption = 'Email Address';
        }
        field(10110; EMailAddress2; Text[100])
        {
            ExternalName = 'emailaddress2';
            ExternalType = 'String';
            Description = 'Type the secondary email address for the lead.';
            Caption = 'Alternate Email';
        }
        field(10111; EMailAddress3; Text[100])
        {
            ExternalName = 'emailaddress3';
            ExternalType = 'String';
            Description = 'Type a third email address for the lead.';
            Caption = 'Email Address 3';
        }
        field(10112; EstimatedAmount; Decimal)
        {
            ExternalName = 'estimatedamount';
            ExternalType = 'Money';
            Description = 'Type the estimated revenue value that this lead will generate to assist in sales forecasting and planning.';
            Caption = 'Est. Value';
        }
        field(10113; EstimatedAmount_Base; Decimal)
        {
            ExternalName = 'estimatedamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Est. Value in base currency.';
            Caption = 'Est. Value (Base)';
        }
        field(10114; EstimatedCloseDate; Date)
        {
            ExternalName = 'estimatedclosedate';
            ExternalType = 'DateTime';
            Description = 'Enter the expected close date for the lead, so that the sales team can schedule timely follow-up meetings to move the prospect to the next sales stage.';
            Caption = 'Est. Close Date';
        }
        field(10115; EstimatedValue; Decimal)
        {
            ExternalName = 'estimatedvalue';
            ExternalType = 'Double';
            Description = 'Type a numeric value of the lead''s estimated value, such as a product quantity, if no revenue amount can be specified in the Est. Value field. This can be used for sales forecasting and planning.';
            Caption = 'Est. Value (deprecated)';
        }
        field(10116; EvaluateFit; Boolean)
        {
            ExternalName = 'evaluatefit';
            ExternalType = 'Boolean';
            Description = 'Select whether the fit between the lead''s requirements and your offerings was evaluated.';
            Caption = 'Evaluate Fit';
        }
        field(10118; Fax; Text[50])
        {
            ExternalName = 'fax';
            ExternalType = 'String';
            Description = 'Type the fax number for the primary contact for the lead.';
            Caption = 'Fax';
        }
        field(10119; FirstName; Text[50])
        {
            ExternalName = 'firstname';
            ExternalType = 'String';
            Description = 'Type the first name of the primary contact for the lead to make sure the prospect is addressed correctly in sales calls, email, and marketing campaigns.';
            Caption = 'First Name';
        }
        field(10120; IndustryCode; Option)
        {
            ExternalName = 'industrycode';
            ExternalType = 'Picklist';
            Description = 'Select the primary industry in which the lead''s business is focused, for use in marketing segmentation and demographic analysis.';
            Caption = 'Industry';
            InitValue = " ";
            OptionMembers = " ",Accounting,"AgricultureAndNon-petrolNaturalResourceExtraction",BroadcastingPrintingAndPublishing,Brokers,BuildingSupplyRetail,BusinessServices,Consulting,ConsumerServices,DesignDirectionAndCreativeManagement,DistributorsDispatchersAndProcessors,DoctorsOfficesAndClinics,DurableManufacturing,EatingAndDrinkingPlaces,EntertainmentRetail,EquipmentRentalAndLeasing,Financial,FoodAndTobaccoProcessing,InboundCapitalIntensiveProcessing,InboundRepairAndServices,Insurance,LegalServices,"Non-DurableMerchandiseRetail",OutboundConsumerService,PetrochemicalExtractionAndDistribution,ServiceRetail,SIGAffiliations,SocialServices,SpecialOutboundTradeContractors,SpecialtyRealty,Transportation,UtilityCreationAndDistribution,VehicleRetail,Wholesale;
            OptionOrdinalValues = -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33;
        }
        field(10122; InitialCommunication; Option)
        {
            ExternalName = 'initialcommunication';
            ExternalType = 'Picklist';
            Description = 'Choose whether someone from the sales team contacted this lead earlier.';
            Caption = 'Initial Communication';
            InitValue = " ";
            OptionMembers = " ",Contacted,NotContacted;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(10128; JobTitle; Text[100])
        {
            ExternalName = 'jobtitle';
            ExternalType = 'String';
            Description = 'Type the job title of the primary contact for this lead to make sure the prospect is addressed correctly in sales calls, email, and marketing campaigns.';
            Caption = 'Job Title';
        }
        field(10129; LastName; Text[50])
        {
            ExternalName = 'lastname';
            ExternalType = 'String';
            Description = 'Type the last name of the primary contact for the lead to make sure the prospect is addressed correctly in sales calls, email, and marketing campaigns.';
            Caption = 'Last Name';
        }
        field(10130; LastUsedInCampaign; Date)
        {
            ExternalName = 'lastusedincampaign';
            ExternalType = 'DateTime';
            ExternalAccess = Modify;
            Description = 'Shows the date when the lead was last included in a marketing campaign or quick campaign.';
            Caption = 'Last Campaign Date';
        }
        field(10131; LeadQualityCode; Option)
        {
            ExternalName = 'leadqualitycode';
            ExternalType = 'Picklist';
            Description = 'Select a rating value to indicate the lead''s potential to become a customer.';
            Caption = 'Rating';
            InitValue = Warm;
            OptionMembers = Hot,Warm,Cold;
            OptionOrdinalValues = 1, 2, 3;
        }
        field(10133; LeadSourceCode; Option)
        {
            ExternalName = 'leadsourcecode';
            ExternalType = 'Picklist';
            Description = 'Select the primary marketing source that prompted the lead to contact you.';
            Caption = 'Lead Source';
            InitValue = " ";
            OptionMembers = " ",Advertisement,EmployeeReferral,ExternalReferral,Partner,PublicRelations,Seminar,TradeShow,Web,WordOfMouth,Other;
            OptionOrdinalValues = -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10;
        }
        field(10135; MasterId; GUID)
        {
            ExternalName = 'masterid';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the master lead for merge.';
            Caption = 'Master ID';
            TableRelation = "CDS Lead".LeadId;
        }
        field(10136; Merged; Boolean)
        {
            ExternalName = 'merged';
            ExternalType = 'Boolean';
            ExternalAccess = Read;
            Description = 'Tells whether the lead has been merged with another lead.';
            Caption = 'Merged';
        }
        field(10138; MiddleName; Text[50])
        {
            ExternalName = 'middlename';
            ExternalType = 'String';
            Description = 'Type the middle name or initial of the primary contact for the lead to make sure the prospect is addressed correctly.';
            Caption = 'Middle Name';
        }
        field(10139; MobilePhone; Text[20])
        {
            ExternalName = 'mobilephone';
            ExternalType = 'String';
            Description = 'Type the mobile phone number for the primary contact for the lead.';
            Caption = 'Mobile Number';
        }
        field(10140; Need; Option)
        {
            ExternalName = 'need';
            ExternalType = 'Picklist';
            Description = 'Choose how high the level of need is for the lead''s company.';
            Caption = 'Need';
            InitValue = " ";
            OptionMembers = " ",MustHave,ShouldHave,GoodToHave,NoNeed;
            OptionOrdinalValues = -1, 0, 1, 2, 3;
        }
        field(10142; NumberOfEmployees; Integer)
        {
            ExternalName = 'numberofemployees';
            ExternalType = 'Integer';
            Description = 'Type the number of employees that work at the company associated with the lead, for use in marketing segmentation and demographic analysis.';
            Caption = 'No. of Employees';
        }
        field(10143; Pager; Text[20])
        {
            ExternalName = 'pager';
            ExternalType = 'String';
            Description = 'Type the pager number for the primary contact for the lead.';
            Caption = 'Pager';
        }
        field(10144; ParticipatesInWorkflow; Boolean)
        {
            ExternalName = 'participatesinworkflow';
            ExternalType = 'Boolean';
            Description = 'Shows whether the lead participates in workflow rules.';
            Caption = 'Participates in Workflow';
        }
        field(10146; PreferredContactMethodCode; Option)
        {
            ExternalName = 'preferredcontactmethodcode';
            ExternalType = 'Picklist';
            Description = 'Select the preferred method of contact.';
            Caption = 'Preferred Method of Contact';
            InitValue = Any;
            OptionMembers = Any,Email,Phone,Fax,Mail;
            OptionOrdinalValues = 1, 2, 3, 4, 5;
        }
        field(10148; PriorityCode; Option)
        {
            ExternalName = 'prioritycode';
            ExternalType = 'Picklist';
            Description = 'Select the priority so that preferred customers or critical issues are handled quickly.';
            Caption = 'Priority';
            InitValue = DefaultValue;
            OptionMembers = DefaultValue;
            OptionOrdinalValues = 1;
        }
        field(10150; PurchaseProcess; Option)
        {
            ExternalName = 'purchaseprocess';
            ExternalType = 'Picklist';
            Description = 'Choose whether an individual or a committee will be involved in the  purchase process for the lead.';
            Caption = 'Purchase Process';
            InitValue = " ";
            OptionMembers = " ",Individual,Committee,Unknown;
            OptionOrdinalValues = -1, 0, 1, 2;
        }
        field(10152; QualificationComments; BLOB)
        {
            ExternalName = 'qualificationcomments';
            ExternalType = 'Memo';
            Description = 'Type comments about the qualification or scoring of the lead.';
            Caption = 'Qualification Comments';
            Subtype = Memo;
        }
        field(10153; Revenue; Decimal)
        {
            ExternalName = 'revenue';
            ExternalType = 'Money';
            Description = 'Type the annual revenue of the company associated with the lead to provide an understanding of the prospect''s business.';
            Caption = 'Annual Revenue';
        }
        field(10154; Revenue_Base; Decimal)
        {
            ExternalName = 'revenue_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Annual Revenue in base currency.';
            Caption = 'Annual Revenue (Base)';
        }
        field(10155; SalesStage; Option)
        {
            ExternalName = 'salesstage';
            ExternalType = 'Picklist';
            Description = 'Select the sales stage of this lead to aid the sales team in their efforts to convert this lead to an opportunity.';
            Caption = 'Sales Stage';
            InitValue = " ";
            OptionMembers = " ",Qualify;
            OptionOrdinalValues = -1, 0;
        }
        field(10157; SalesStageCode; Option)
        {
            ExternalName = 'salesstagecode';
            ExternalType = 'Picklist';
            Description = 'Select the sales process stage for the lead to help determine the probability of the lead converting to an opportunity.';
            Caption = 'Sales Stage Code';
            InitValue = DefaultValue;
            OptionMembers = DefaultValue;
            OptionOrdinalValues = 1;
        }
        field(10159; Salutation; Text[100])
        {
            ExternalName = 'salutation';
            ExternalType = 'String';
            Description = 'Type the salutation of the primary contact for this lead to make sure the prospect is addressed correctly in sales calls, email messages, and marketing campaigns.';
            Caption = 'Salutation';
        }
        field(10160; ScheduleFollowUp_Prospect; Date)
        {
            ExternalName = 'schedulefollowup_prospect';
            ExternalType = 'DateTime';
            Description = 'Enter the date and time of the prospecting follow-up meeting with the lead.';
            Caption = 'Schedule Follow Up (Prospect)';
        }
        field(10161; ScheduleFollowUp_Qualify; Date)
        {
            ExternalName = 'schedulefollowup_qualify';
            ExternalType = 'DateTime';
            Description = 'Enter the date and time of the qualifying follow-up meeting with the lead.';
            Caption = 'Schedule Follow Up (Qualify)';
        }
        field(10162; SIC; Text[20])
        {
            ExternalName = 'sic';
            ExternalType = 'String';
            Description = 'Type the Standard Industrial Classification (SIC) code that indicates the lead''s primary industry of business for use in marketing segmentation and demographic analysis.';
            Caption = 'SIC Code';
        }
        field(10163; StateCode; Option)
        {
            ExternalName = 'statecode';
            ExternalType = 'State';
            ExternalAccess = Modify;
            Description = 'Shows whether the lead is open, qualified, or disqualified. Qualified and disqualified leads are read-only and can''t be edited unless they are reactivated.';
            Caption = 'Status';
            InitValue = Open;
            OptionMembers = Open,Qualified,Disqualified;
            OptionOrdinalValues = 0, 1, 2;
        }
        field(10165; StatusCode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Select the lead''s status.';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",New,Contacted,Qualified,Lost,CannotContact,NoLongerInterested,Canceled;
            OptionOrdinalValues = -1, 1, 2, 3, 4, 5, 6, 7;
        }
        field(10167; Subject; Text[300])
        {
            ExternalName = 'subject';
            ExternalType = 'String';
            Description = 'Type a subject or descriptive name, such as the expected order, company name, or marketing source list, to identify the lead.';
            Caption = 'Topic';
        }
        field(10168; Telephone1; Text[50])
        {
            ExternalName = 'telephone1';
            ExternalType = 'String';
            Description = 'Type the work phone number for the primary contact for the lead.';
            Caption = 'Business Phone';
        }
        field(10169; Telephone2; Text[50])
        {
            ExternalName = 'telephone2';
            ExternalType = 'String';
            Description = 'Type the home phone number for the primary contact for the lead.';
            Caption = 'Home Phone';
        }
        field(10170; Telephone3; Text[50])
        {
            ExternalName = 'telephone3';
            ExternalType = 'String';
            Description = 'Type an alternate phone number for the primary contact for the lead.';
            Caption = 'Alternate Phone Number';
        }
        field(10171; PurchaseTimeFrame; Option)
        {
            ExternalName = 'purchasetimeframe';
            ExternalType = 'Picklist';
            Description = 'Choose how long the lead will likely take to make the purchase, so the sales team will be aware.';
            Caption = 'Purchase Timeframe';
            InitValue = " ";
            OptionMembers = " ",Immediate,ThisQuarter,NextQuarter,ThisYear,Unknown;
            OptionOrdinalValues = -1, 0, 1, 2, 3, 4;
        }
        field(10173; WebSiteUrl; Text[200])
        {
            ExternalName = 'websiteurl';
            ExternalType = 'String';
            Description = 'Type the website URL for the company associated with this lead.';
            Caption = 'Website';
        }
        field(10176; OnHoldTime; Integer)
        {
            ExternalName = 'onholdtime';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'Shows how long, in minutes, that the record was on hold.';
            Caption = 'On Hold Time (Minutes)';
        }
        field(10177; LastOnHoldTime; Datetime)
        {
            ExternalName = 'lastonholdtime';
            ExternalType = 'DateTime';
            Description = 'Contains the date and time stamp of the last on hold time.';
            Caption = 'Last On Hold Time';
        }
        field(10178; FollowEmail; Boolean)
        {
            ExternalName = 'followemail';
            ExternalType = 'Boolean';
            Description = 'Information about whether to allow following email activity like opens, attachment views and link clicks for emails sent to the lead.';
            Caption = 'Follow Email Activity';
        }
        field(10180; TimeSpentByMeOnEmailAndMeetings; Text[1250])
        {
            ExternalName = 'timespentbymeonemailandmeetings';
            ExternalType = 'String';
            ExternalAccess = Read;
            Description = 'Total time spent for emails (read and write) and meetings by me in relation to the lead record.';
            Caption = 'Time Spent by me';
        }
        field(10181; EntityImageId; GUID)
        {
            ExternalName = 'entityimageid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Read;
        }
        field(10194; YomiCompanyName; Text[100])
        {
            ExternalName = 'yomicompanyname';
            ExternalType = 'String';
            Description = 'Type the phonetic spelling of the lead''s company name, if the name is specified in Japanese, to make sure the name is pronounced correctly in phone calls with the prospect.';
            Caption = 'Yomi Company Name';
        }
        field(10195; YomiFirstName; Text[150])
        {
            ExternalName = 'yomifirstname';
            ExternalType = 'String';
            Description = 'Type the phonetic spelling of the lead''s first name, if the name is specified in Japanese, to make sure the name is pronounced correctly in phone calls with the prospect.';
            Caption = 'Yomi First Name';
        }
        field(10196; YomiFullName; Text[450])
        {
            ExternalName = 'yomifullname';
            ExternalType = 'String';
            ExternalAccess = Read;
            Description = 'Combines and shows the lead''s Yomi first and last names so the full phonetic name can be displayed in views and reports.';
            Caption = 'Yomi Full Name';
        }
        field(10197; YomiLastName; Text[150])
        {
            ExternalName = 'yomilastname';
            ExternalType = 'String';
            Description = 'Type the phonetic spelling of the lead''s last name, if the name is specified in Japanese, to make sure the name is pronounced correctly in phone calls with the prospect.';
            Caption = 'Yomi Last Name';
        }
        field(10198; YomiMiddleName; Text[150])
        {
            ExternalName = 'yomimiddlename';
            ExternalType = 'String';
            Description = 'Type the phonetic spelling of the lead''s middle name, if the name is specified in Japanese, to make sure the name is pronounced correctly in phone calls with the prospect.';
            Caption = 'Yomi Middle Name';
        }
        field(10215; TeamsFollowed; Integer)
        {
            ExternalName = 'teamsfollowed';
            ExternalType = 'Integer';
            Description = 'Number of users or conversations followed the record';
            Caption = 'TeamsFollowed';
        }
        field(10216; BusinessCard; BLOB)
        {
            ExternalName = 'businesscard';
            ExternalType = 'Memo';
            Description = 'Stores Image of the Business Card';
            Caption = 'Business Card';
            Subtype = Memo;
        }
        field(10217; BusinessCardAttributes; Text[2048])
        {
            ExternalName = 'businesscardattributes';
            ExternalType = 'String';
            Description = 'Stores Business Card Control Properties.';
            Caption = 'BusinessCardAttributes';
        }
        field(10218; msdyn_gdproptout; Boolean)
        {
            ExternalName = 'msdyn_gdproptout';
            ExternalType = 'Boolean';
            Description = 'Describes whether lead is opted out or not';
            Caption = 'GDPR Optout';
        }
        field(10224; msdyn_LeadScore; Integer)
        {
            ExternalName = 'msdyn_leadscore';
            ExternalType = 'Integer';
            Description = '';
            Caption = '(Deprecated) Lead Score';
        }
        field(10225; msdyn_LeadGrade; Option)
        {
            ExternalName = 'msdyn_leadgrade';
            ExternalType = 'Picklist';
            Description = '';
            Caption = '(Deprecated) Lead Grade';
            InitValue = " ";
            OptionMembers = " ",GradeA,GradeB,GradeC,GradeD;
            OptionOrdinalValues = -1, 0, 1, 2, 3;
        }
        field(10227; msdyn_ScoreReasons; BLOB)
        {
            ExternalName = 'msdyn_scorereasons';
            ExternalType = 'Memo';
            Description = '';
            Caption = '(Deprecated) Score Reasons';
            Subtype = Memo;
        }
        field(10228; msdyn_ScoreHistory; BLOB)
        {
            ExternalName = 'msdyn_scorehistory';
            ExternalType = 'Memo';
            Description = '';
            Caption = '(Deprecated) Score History';
            Subtype = Memo;
        }
        field(10229; msdyn_LeadScoreTrend; Option)
        {
            ExternalName = 'msdyn_leadscoretrend';
            ExternalType = 'Picklist';
            Description = '';
            Caption = '(Deprecated) Lead Score Trend';
            InitValue = " ";
            OptionMembers = " ",Improving,Steady,Declining,NotEnoughInfo;
            OptionOrdinalValues = -1, 0, 1, 2, 3;
        }
        field(10233; msdyn_salesassignmentresult; Option)
        {
            ExternalName = 'msdyn_salesassignmentresult';
            ExternalType = 'Picklist';
            Description = 'Result of the assignment rule process';
            Caption = 'Assignment Rule Result';
            InitValue = " ";
            OptionMembers = " ",Succeeded,Failed;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(10235; sr_ApplicationApprovedDate; Date)
        {
            ExternalName = 'sr_applicationapproveddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Application Approved Date';
        }
        field(10236; sr_ApplicationLinkSentOn; Date)
        {
            ExternalName = 'sr_applicationlinksenton';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Application Link Sent On';
        }
        field(10237; sr_IsApplicationlinkSent; Boolean)
        {
            ExternalName = 'sr_isapplicationlinksent';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Application link Sent?';
        }
        field(10239; sr_ApplicationReceivedDate; Date)
        {
            ExternalName = 'sr_applicationreceiveddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Application Received Date';
        }
        field(10240; sr_IsApplicationReceived; Boolean)
        {
            ExternalName = 'sr_isapplicationreceived';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Application Received?';
        }
        field(10242; sr_IsApprovalReceived; Boolean)
        {
            ExternalName = 'sr_isapprovalreceived';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Approval Received?';
        }
        field(10246; sr_DateofBirth; Date)
        {
            ExternalName = 'sr_dateofbirth';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Date of Birth';
        }
        field(10247; sr_BusinessName; Text[100])
        {
            ExternalName = 'sr_businessname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Business Name';
        }
        field(10248; sr_InstagramHandle; Text[100])
        {
            ExternalName = 'sr_instagramhandle';
            ExternalType = 'String';
            Description = '';
            Caption = 'Instagram Handle';
        }
        field(10249; sr_LicenseCertificateNumber; Text[100])
        {
            ExternalName = 'sr_licensecertificatenumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'License/Certificate Number';
        }
        field(10250; sr_Doyouacceptnewclients; Boolean)
        {
            ExternalName = 'sr_doyouacceptnewclients';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Do you accept new clients?';
        }
        field(10256; sr_ApproximateofTotalClients; Integer)
        {
            ExternalName = 'sr_approximateoftotalclients';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Approximate # of Total Clients';
        }
        field(10260; sr_DoyouCurrentlyRetailProduct; Boolean)
        {
            ExternalName = 'sr_doyoucurrentlyretailproduct';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Do you Currently Retail Product?';
        }
        field(10262; sr_Commission; Decimal)
        {
            ExternalName = 'sr_commission';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Commission %';
        }
        field(10264; sr_AverageWeeklyRetailIncome; Integer)
        {
            ExternalName = 'sr_averageweeklyretailincome';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Average Weekly Retail Income';
        }
        field(10267; sr_Referrer; Text[100])
        {
            ExternalName = 'sr_referrer';
            ExternalType = 'String';
            Description = '';
            Caption = 'Referrer';
        }
        field(10268; sr_OtherServices; Text[100])
        {
            ExternalName = 'sr_otherservices';
            ExternalType = 'String';
            Description = '';
            Caption = 'Other(Services)';
        }
        field(10269; sr_OtherSources; Text[100])
        {
            ExternalName = 'sr_othersources';
            ExternalType = 'String';
            Description = '';
            Caption = 'Other(Sources)';
        }
        field(10270; sr_CWEStartDate; Date)
        {
            ExternalName = 'sr_cwestartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'CWE Start Date';
        }
        field(10271; sr_CWEEndDate; Date)
        {
            ExternalName = 'sr_cweenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'CWE End Date';
        }
        field(10272; sr_ReasonforChange; BLOB)
        {
            ExternalName = 'sr_reasonforchange';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Reason for Change';
            Subtype = Memo;
        }
        field(10275; sr_CurrentRentRate; Decimal)
        {
            ExternalName = 'sr_currentrentrate';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Current Rent Rate';
        }
        field(10276; sr_currentrentrate_Base; Decimal)
        {
            ExternalName = 'sr_currentrentrate_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Current Rent Rate in base currency.';
            Caption = 'Current Rent Rate (Base)';
        }
        field(10277; sr_NameofRentalSalonSuiteOther; Text[100])
        {
            ExternalName = 'sr_nameofrentalsalonsuiteother';
            ExternalType = 'String';
            Description = '';
            Caption = 'Name of Rental (Salon/Suite/Other)';
        }
        field(10278; sr_NameofSalonWorkplace; Text[100])
        {
            ExternalName = 'sr_nameofsalonworkplace';
            ExternalType = 'String';
            Description = '';
            Caption = 'Name of Salon/Workplace';
        }
        field(10279; sr_SalaryHourlyCompensation; Decimal)
        {
            ExternalName = 'sr_salaryhourlycompensation';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Salary/Hourly Compensation';
        }
        field(10280; sr_salaryhourlycompensation_Base; Decimal)
        {
            ExternalName = 'sr_salaryhourlycompensation_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Salary/Hourly Compensation in base currency.';
            Caption = 'Salary/Hourly Compensation (Base)';
        }
        field(10281; sr_Frequency; Option)
        {
            ExternalName = 'sr_frequency';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Frequency';
            InitValue = " ";
            OptionMembers = " ",Hour,Day,Week,Month;
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003;
        }
        field(10283; sr_CommissionSalonCurrent; Decimal)
        {
            ExternalName = 'sr_commissionsaloncurrent';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Commission Salon – Current %';
        }
        field(10284; sr_RetailproductOptions; Option)
        {
            ExternalName = 'sr_retailproductoptions';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Retail product Options';
            InitValue = " ";
            OptionMembers = " ",ReceiveCommission,PurchaseWholesaleAndResellAtRetailValue;
            OptionOrdinalValues = -1, 100000000, 100000001;
        }
        field(10288; sr_NextFollowUpDate; Datetime)
        {
            ExternalName = 'sr_nextfollowupdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Follow-Up Date';
        }
        field(10289; sr_TourScheduleDate; Datetime)
        {
            ExternalName = 'sr_tourscheduledate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Tour Schedule Date';
        }
        field(10290; sr_Role; Option)
        {
            ExternalName = 'sr_role';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Role';
            InitValue = " ";
            OptionMembers = " ",SingleLicensee,"Co-Licensee","Sub-Licensee",Employee,Assistant;
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003, 100000004;
        }
        field(10292; sr_DateofFirstinquiryfromProspect; Datetime)
        {
            ExternalName = 'sr_dateoffirstinquiryfromprospect';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Date of First inquiry from Prospect';
        }
        field(10301; sr_NoofProfessionalsthatwilloccupythestudio; Integer)
        {
            ExternalName = 'sr_noofprofessionalsthatwilloccupythestudio';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'No. of Professionals that will occupy the studio';
        }
        field(10304; sr_StudioTypeInterestedin; Option)
        {
            ExternalName = 'sr_studiotypeinterestedin';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Studio Type Interested in';
            InitValue = " ";
            OptionMembers = " ","Window-Exterior/OutdoorFacing","Window-Interior/IndoorFacing","Interior-CornerWindow","Interior-Transom/ClearstoryWindow(SunWindow)","Interior-Standard","InteriorWithPrivacy/quieterAreaOfSalon","BudgetFriendly/costEffective";
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003, 100000006, 100000004, 100000005;
        }
        field(10306; sr_QuantityofStationsDesired; Integer)
        {
            ExternalName = 'sr_quantityofstationsdesired';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity of Stations Desired';
        }
        field(10307; sr_AdditionalNotes; BLOB)
        {
            ExternalName = 'sr_additionalnotes';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Additional Notes';
            Subtype = Memo;
        }
        field(10312; sr_HoldDepositAgreementLinkSentOn; Datetime)
        {
            ExternalName = 'sr_holddepositagreementlinksenton';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Hold Deposit Agreement Link Sent On';
        }
        field(10313; sr_IsHoldDepositAgreementLinkSent; Boolean)
        {
            ExternalName = 'sr_isholddepositagreementlinksent';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Hold Deposit Agreement Link Sent?';
        }
        field(10315; sr_HoldDepositAgreementEnvelopId; Text[100])
        {
            ExternalName = 'sr_holddepositagreementenvelopid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Hold Deposit Agreement Envelop Id';
        }
        field(10316; sr_HoldDepositAgreementSignedOn; Datetime)
        {
            ExternalName = 'sr_holddepositagreementsignedon';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Hold Deposit Agreement Signed On';
        }
        field(10317; sr_IsHoldDepositAgreementSigned; Boolean)
        {
            ExternalName = 'sr_isholddepositagreementsigned';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Hold Deposit Agreement Signed?';
        }
        field(10319; sr_FollowUpNotes; BLOB)
        {
            ExternalName = 'sr_followupnotes';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Follow Up Notes';
            Subtype = Memo;
        }
        field(10320; sr_ServicesOffered; Text[100])
        {
            ExternalName = 'sr_servicesoffered';
            ExternalType = 'String';
            Description = '';
            Caption = 'Services Offered';
        }
        field(10321; sr_MinimumServiceChargePerClient; Decimal)
        {
            ExternalName = 'sr_minimumservicechargeperclient';
            ExternalType = 'Money';
            Description = '';
            Caption = ' Minimum Service Charge Per Client';
        }
        field(10322; sr_minimumservicechargeperclient_Base; Decimal)
        {
            ExternalName = 'sr_minimumservicechargeperclient_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the  Minimum Service Charge Per Client in base currency.';
            Caption = ' Minimum Service Charge Per Client (Base)';
        }
        field(10323; sr_MaximumServiceChargePerClient; Decimal)
        {
            ExternalName = 'sr_maximumservicechargeperclient';
            ExternalType = 'Money';
            Description = '';
            Caption = ' Maximum Service Charge Per Client';
        }
        field(10324; sr_maximumservicechargeperclient_Base; Decimal)
        {
            ExternalName = 'sr_maximumservicechargeperclient_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the  Maximum Service Charge Per Client in base currency.';
            Caption = ' Maximum Service Charge Per Client (Base)';
        }
        field(10331; sr_StudioApplicationReceived; Boolean)
        {
            ExternalName = 'sr_studioapplicationreceived';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Studio Application Received?';
        }
        field(10333; sr_ApprovalReceived; Boolean)
        {
            ExternalName = 'sr_approvalreceived';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Approval Received?';
        }
        field(10335; sr_StudiosforwhichHoldDepositReceived; Text[100])
        {
            ExternalName = 'sr_studiosforwhichholddepositreceived';
            ExternalType = 'String';
            Description = '';
            Caption = 'Studio/s for which Hold Deposit Received';
        }
        field(10336; sr_HoldDepositReceived; Boolean)
        {
            ExternalName = 'sr_holddepositreceived';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Hold Deposit Received';
        }
        field(10338; sr_HoldDepositReceivedOn; Date)
        {
            ExternalName = 'sr_holddepositreceivedon';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Hold Deposit Received On';
        }
        field(10339; sr_HoldDepositAmount; Decimal)
        {
            ExternalName = 'sr_holddepositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Hold Deposit Amount';
        }
        field(10340; sr_holddepositamount_Base; Decimal)
        {
            ExternalName = 'sr_holddepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Hold Deposit Amount in base currency.';
            Caption = 'Hold Deposit Amount (Base)';
        }
        field(10341; sr_HoldDepositAgreementSigned; Boolean)
        {
            ExternalName = 'sr_holddepositagreementsigned';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Hold Deposit Agreement Signed? ';
        }
        field(10343; sr_AdditionalSecurityDepositAmountrequired; Decimal)
        {
            ExternalName = 'sr_additionalsecuritydepositamountrequired';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Additional Security Deposit Amount required ';
        }
        field(10344; sr_additionalsecuritydepositamountrequired_Base; Decimal)
        {
            ExternalName = 'sr_additionalsecuritydepositamountrequired_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Additional Security Deposit Amount required  in base currency.';
            Caption = 'Additional Security Deposit Amount required  (Base)';
        }
        field(10345; sr_AnticipatedMoveInDate; Date)
        {
            ExternalName = 'sr_anticipatedmoveindate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Anticipated Move-In Date ';
        }
        field(10346; sr_DidProspectwithdrawdeposit; Option)
        {
            ExternalName = 'sr_didprospectwithdrawdeposit';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Did Prospect withdraw deposit';
            InitValue = " ";
            OptionMembers = " ",Refund,Forfeit;
            OptionOrdinalValues = -1, 100000000, 100000001;
        }
        field(10348; sr_DidProspectConvert; Boolean)
        {
            ExternalName = 'sr_didprospectconvert';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Did Prospect Convert?';
        }
        field(10350; sr_Reasonfornotconverting; Option)
        {
            ExternalName = 'sr_reasonfornotconverting';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Reason for not converting';
            InitValue = " ";
            OptionMembers = " ",LostToSuiteCompetitor,ApplicationDeclined,IndicatesTooExpensive,"CanNotAfford/NotEnoughClientele",DesiresDifferentSRLocation,NoDesiredStudioTypesStudios,FullSalonOccupancy,"NoResponseFromProspect/UnableToReachProspect","LandlordAtCurrentLocationCounter-offered",WithdrewDeposit,Other;
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003, 100000004, 100000005, 100000006, 100000007, 100000008, 100000009, 100000010;
        }
        field(10354; sr_TotalIncentiveAmount; Decimal)
        {
            ExternalName = 'sr_totalincentiveamount';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Incentive Amount';
        }
        field(10355; sr_totalincentiveamount_Base; Decimal)
        {
            ExternalName = 'sr_totalincentiveamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Incentive Amount in base currency.';
            Caption = 'Total Incentive Amount (Base)';
        }
        field(10356; sr_Incentivesoffered; Option)
        {
            ExternalName = 'sr_incentivesoffered';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Incentives offered';
            InitValue = " ";
            OptionMembers = " ","RateDiscount(reductionOfWeeklyRentRate)","RentConcession(FreeRentWeeks)",ProductCredit,DesignCredit,Other;
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003, 100000004;
        }
        field(10358; sr_ReferralCredit; Option)
        {
            ExternalName = 'sr_referralcredit';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Referral Credit';
            InitValue = " ";
            OptionMembers = " ",CreditAmountToExistingLicensee,CreditAmountToNewLicensee;
            OptionOrdinalValues = -1, 100000000, 100000001;
        }
        field(10360; sr_ReferralCreditAmount; Decimal)
        {
            ExternalName = 'sr_referralcreditamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Referral Credit Amount';
        }
        field(10361; sr_referralcreditamount_Base; Decimal)
        {
            ExternalName = 'sr_referralcreditamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Referral Credit Amount in base currency.';
            Caption = 'Referral Credit Amount (Base)';
        }
        field(10362; sr_StudioModificationsToBePerformed; Boolean)
        {
            ExternalName = 'sr_studiomodificationstobeperformed';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Studio Modifications To Be Performed?';
        }
        field(10364; sr_DetailedDescriptionofStudioModifications; BLOB)
        {
            ExternalName = 'sr_detaileddescriptionofstudiomodifications';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Detailed Description of Studio Modifications';
            Subtype = Memo;
        }
        field(10365; sr_ProspectwantstobeonExternalWaitList; Boolean)
        {
            ExternalName = 'sr_prospectwantstobeonexternalwaitlist';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Prospect wants to be on External Wait List';
        }
        field(10373; sr_IfOtherdescribe; BLOB)
        {
            ExternalName = 'sr_ifotherdescribe';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'If Other, describe';
            Subtype = Memo;
        }
        field(10376; sr_DateofFirstCorrespondencewithProspectLead; Date)
        {
            ExternalName = 'sr_dateoffirstcorrespondencewithprospectlead';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Date of First Correspondence with Prospect Lead';
        }
        field(10379; sr_StudioSizesInterestedInWaitingList; Option)
        {
            ExternalName = 'sr_studiosizesinterestedinwaitinglist';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Studio Sizes Interested In(Waiting List)';
            InitValue = " ";
            OptionMembers = " ","1Station(under114Sqft)","UpTo2Stations(115-155Sqft)","UpTo3Stations(156Sqft+)","CustomStudio/StudioCombination";
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003;
        }
        field(10381; sr_SalonLocation; GUID)
        {
            ExternalName = 'sr_salonlocation';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Salon Location';
            TableRelation = "CDS sr_Building".sr_BuildingId;
        }
        field(10386; sr_FrequencySalaryHourlyCompensation; Option)
        {
            ExternalName = 'sr_frequencysalaryhourlycompensation';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Frequency(Salary/Hourly Compensation)';
            InitValue = " ";
            OptionMembers = " ",Hour,Day,Week,Month;
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003;
        }
        field(10394; sr_AverageServiceIncomeperweekLowest; Decimal)
        {
            ExternalName = 'sr_averageserviceincomeperweeklowest';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Average Service Income per week (Lowest)';
        }
        field(10395; sr_averageserviceincomeperweeklowest_Base; Decimal)
        {
            ExternalName = 'sr_averageserviceincomeperweeklowest_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Average Service Income per week (Lowest) in base currency.';
            Caption = 'Average Service Income per week (Lowest) (Base)';
        }
        field(10396; sr_AverageServiceIncomeperweekHighest; Decimal)
        {
            ExternalName = 'sr_averageserviceincomeperweekhighest';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Average Service Income per week (Highest)';
        }
        field(10397; sr_averageserviceincomeperweekhighest_Base; Decimal)
        {
            ExternalName = 'sr_averageserviceincomeperweekhighest_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Average Service Income per week (Highest) in base currency.';
            Caption = 'Average Service Income per week (Highest) (Base)';
        }
        field(10398; sr_MinimumnumberofClientsservicedperweek; Integer)
        {
            ExternalName = 'sr_minimumnumberofclientsservicedperweek';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Minimum number of Clients serviced per week';
        }
        field(10399; sr_MaximumnumberofClientsservicedperweek; Integer)
        {
            ExternalName = 'sr_maximumnumberofclientsservicedperweek';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Maximum number of Clients serviced per week';
        }
        field(10400; sr_TotalWeeklyIncomeLowest; Decimal)
        {
            ExternalName = 'sr_totalweeklyincomelowest';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Weekly Income (Lowest)';
        }
        field(10401; sr_totalweeklyincomelowest_Base; Decimal)
        {
            ExternalName = 'sr_totalweeklyincomelowest_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Weekly Income (Lowest) in base currency.';
            Caption = 'Total Weekly Income (Lowest) (Base)';
        }
        field(10402; sr_TotalWeeklyIncomeHighest; Decimal)
        {
            ExternalName = 'sr_totalweeklyincomehighest';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Weekly Income (Highest)';
        }
        field(10403; sr_totalweeklyincomehighest_Base; Decimal)
        {
            ExternalName = 'sr_totalweeklyincomehighest_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Weekly Income (Highest) in base currency.';
            Caption = 'Total Weekly Income (Highest) (Base)';
        }
        field(10404; sr_Profession_prospect; Text[1000])
        {
            ExternalName = 'sr_profession_prospect';
            ExternalType = 'String';
            Description = '';
            Caption = 'Profession';
        }
        field(10405; sr_ProductBrandRetail; Text[1000])
        {
            ExternalName = 'sr_productbrandretail';
            ExternalType = 'String';
            Description = '';
            Caption = 'Product Brand (Retail)';
        }
        field(10406; sr_ProductBrandsProfessional; Text[1000])
        {
            ExternalName = 'sr_productbrandsprofessional';
            ExternalType = 'String';
            Description = '';
            Caption = 'Product Brands (Professional)';
        }
        field(10407; sr_docusignintegrationstatus; Option)
        {
            ExternalName = 'sr_docusignintegrationstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Docusign Integration Status';
            InitValue = Draft;
            OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionOrdinalValues = 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006;
        }
        field(10409; sr_SubBrands; Text[1000])
        {
            ExternalName = 'sr_subbrands';
            ExternalType = 'String';
            Description = '';
            Caption = 'Sub-Brands';
        }
        field(10410; sr_SkinCare; Text[1000])
        {
            ExternalName = 'sr_skincare';
            ExternalType = 'String';
            Description = '';
            Caption = 'SkinCare';
        }
        field(10411; sr_StudiosInterestedIn_lookup; Text[1000])
        {
            ExternalName = 'sr_studiosinterestedin_lookup';
            ExternalType = 'String';
            Description = '';
            Caption = 'Studios Interested In';
        }
        field(10412; sr_ReferrerStudio; GUID)
        {
            ExternalName = 'sr_referrerstudio';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Referrer Studio';
            TableRelation = "CDS sr_Studio".sr_StudioId;
        }
        field(10416; sr_ReferrerLocation; GUID)
        {
            ExternalName = 'sr_referrerlocation';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Referrer Location';
            TableRelation = "CDS sr_Building".sr_BuildingId;
        }
        field(10418; sr_have_partner; Boolean)
        {
            ExternalName = 'sr_have_partner';
            ExternalType = 'Boolean';
            Description = 'Do you have a partner ?';
            Caption = 'Do you have a partner?';
        }
        field(10420; sr_holddeposittransferrequested; Boolean)
        {
            ExternalName = 'sr_holddeposittransferrequested';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Hold Deposit Transfer Requested?';
        }
        field(10422; sr_transferredstudio; Text[500])
        {
            ExternalName = 'sr_transferredstudio';
            ExternalType = 'String';
            Description = '';
            Caption = 'Transferred Studio #';
        }
        field(10423; sr_newdepositamount; Decimal)
        {
            ExternalName = 'sr_newdepositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'New Deposit Amount $';
        }
        field(10424; sr_newdepositamount_Base; Decimal)
        {
            ExternalName = 'sr_newdepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the New Deposit Amount $ in base currency.';
            Caption = 'New Deposit Amount $ (Base)';
        }
        field(10425; sr_QuantityHairstylistStation; Integer)
        {
            ExternalName = 'sr_quantityhairstyliststation';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity(Hairstylist Station)';
        }
        field(10426; sr_QuantityBarberStationRecliningChair; Integer)
        {
            ExternalName = 'sr_quantitybarberstationrecliningchair';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity (Barber Station Reclining Chair)';
        }
        field(10427; sr_QuantityMassageBedTable; Integer)
        {
            ExternalName = 'sr_quantitymassagebedtable';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity (Massage Bed/Table)';
        }
        field(10428; sr_QuantityEstheticRecliningChair; Integer)
        {
            ExternalName = 'sr_quantityestheticrecliningchair';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity (Esthetic Reclining Chair)';
        }
        field(10429; sr_QuantityEstheticReclinerBed; Integer)
        {
            ExternalName = 'sr_quantityestheticreclinerbed';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity (Esthetic Recliner Bed)';
        }
        field(10430; sr_QuantityManicureTableStation; Integer)
        {
            ExternalName = 'sr_quantitymanicuretablestation';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity (Manicure Table/Station)';
        }
        field(10431; sr_QuantityPedicureChairFootBowl; Integer)
        {
            ExternalName = 'sr_quantitypedicurechairfootbowl';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity (Pedicure Chair + Foot Bowl)';
        }
        field(10432; sr_QuantityOther; Integer)
        {
            ExternalName = 'sr_quantityother';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity (Other)';
        }
        field(10441; sr_docusigntemplatetype; Option)
        {
            ExternalName = 'sr_docusigntemplatetype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = '(Deprecated)Docusign Template Type';
            InitValue = " ";
            OptionMembers = " ","SendHoldDeposit-InPerson","SendHoldDeposit-Remote";
            OptionOrdinalValues = -1, 874900000, 874900001;
        }
        field(10443; sr_FollowUpSequence; Integer)
        {
            ExternalName = 'sr_followupsequence';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Follow Up Sequence';
        }
        field(10444; sr_Location; Text[2048])
        {
            ExternalName = 'sr_location';
            ExternalType = 'String';
            Description = '';
            Caption = 'Location';
        }
        field(10445; sr_ProspectStatus; Option)
        {
            ExternalName = 'sr_prospectstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Prospect Status';
            InitValue = " ";
            OptionMembers = " ",ProspectGenerated,Inquiry,TourScheduled,TourCompleted,TourRescheduled,TourCanceled,ApplicationFormSent,ApplicationFormFilled,HoldDepositLinkSent,HoldDepositReceived,NotInterested,PostTourSchedule,ProspectConverted;
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003, 100000004, 100000005, 100000006, 100000007, 100000008, 100000009, 100000010, 100000011, 100000012;
        }
        field(10447; sr_docusigntemplatetype_global; Option)
        {
            ExternalName = 'sr_docusigntemplatetype_global';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Document Template Type';
            InitValue = " ";
            OptionMembers = " ","DocuSign-InPreson","DocuSign-Remote","Docusign-Resend";
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002;
        }
        field(10449; sr_blow_dryers; Boolean)
        {
            ExternalName = 'sr_blow_dryers';
            ExternalType = 'Boolean';
            Description = 'Blow Dryers';
            Caption = 'Blow Dryers';
        }
        field(10451; sr_blow_dryers_quantity; Integer)
        {
            ExternalName = 'sr_blow_dryers_quantity';
            ExternalType = 'Integer';
            Description = 'Blow Dryers Quantity';
            Caption = 'Blow Dryers Quantity';
        }
        field(10452; sr_flat_irons_curling_irons; Boolean)
        {
            ExternalName = 'sr_flat_irons_curling_irons';
            ExternalType = 'Boolean';
            Description = 'Flat Irons/Curling Irons';
            Caption = 'Flat Irons/Curling Irons';
        }
        field(10454; sr_flat_irons_curling_irons_quantity; Integer)
        {
            ExternalName = 'sr_flat_irons_curling_irons_quantity';
            ExternalType = 'Integer';
            Description = 'Flat Irons/Curling Irons Quantity';
            Caption = 'Flat Irons/Curling Irons Quantity';
        }
        field(10455; sr_hood_dryers; Boolean)
        {
            ExternalName = 'sr_hood_dryers';
            ExternalType = 'Boolean';
            Description = 'Hood Dryers';
            Caption = 'Hood Dryers';
        }
        field(10457; sr_hood_dryers_quantity; Integer)
        {
            ExternalName = 'sr_hood_dryers_quantity';
            ExternalType = 'Integer';
            Description = 'Hood Dryers Quantity';
            Caption = 'Hood Dryers Quantity';
        }
        field(10458; sr_wall_mounted_hair_dryers; Boolean)
        {
            ExternalName = 'sr_wall_mounted_hair_dryers';
            ExternalType = 'Boolean';
            Description = 'Wall Mounted Hair Dryers';
            Caption = 'Wall Mounted Hair Dryers';
        }
        field(10461; sr_wall_mounted_hair_dryers_quantity; Integer)
        {
            ExternalName = 'sr_wall_mounted_hair_dryers_quantity';
            ExternalType = 'Integer';
            Description = 'Wall Mounted Hair Dryers Quantity';
            Caption = 'Wall Mounted Hair Dryers Quantity';
        }
        field(10462; sr_heat_lamp_processors_steamers; Boolean)
        {
            ExternalName = 'sr_heat_lamp_processors_steamers';
            ExternalType = 'Boolean';
            Description = 'Heat Lamp Processors/Steamers';
            Caption = 'Heat Lamp Processors/Steamers';
        }
        field(10464; sr_heat_lamp_processors_steamers_quantity; Integer)
        {
            ExternalName = 'sr_heat_lamp_processors_steamers_quantity';
            ExternalType = 'Integer';
            Description = 'Heat Lamp Processors/Steamers Quantity';
            Caption = 'Heat Lamp Processors/Steamers Quantity';
        }
        field(10465; sr_stove_oven_for_hot_irons; Boolean)
        {
            ExternalName = 'sr_stove_oven_for_hot_irons';
            ExternalType = 'Boolean';
            Description = 'Stove (Oven for Hot Irons)';
            Caption = 'Stove (Oven for Hot Irons)';
        }
        field(10467; sr_stove_oven_for_hot_irons_quantity; Integer)
        {
            ExternalName = 'sr_stove_oven_for_hot_irons_quantity';
            ExternalType = 'Integer';
            Description = 'Stove (Oven for Hot Irons) Quantity';
            Caption = 'Stove (Oven for Hot Irons) Quantity';
        }
        field(10468; sr_air_purifiers; Boolean)
        {
            ExternalName = 'sr_air_purifiers';
            ExternalType = 'Boolean';
            Description = 'Air Purifiers';
            Caption = 'Air Purifiers';
        }
        field(10470; sr_air_purifiers_quantity; Integer)
        {
            ExternalName = 'sr_air_purifiers_quantity';
            ExternalType = 'Integer';
            Description = 'Air Purifiers Quantity';
            Caption = 'Air Purifiers Quantity';
        }
        field(10471; sr_pedicurechairsneedingelectricalplumbing; Boolean)
        {
            ExternalName = 'sr_pedicurechairsneedingelectricalplumbing';
            ExternalType = 'Boolean';
            Description = 'Pedicure Chairs needing electrical/Plumbing points';
            Caption = 'Pedicure Chairs needing electrical/Plumbing points';
        }
        field(10473; sr_pedicurechairsneedingelecplumbingquantity; Integer)
        {
            ExternalName = 'sr_pedicurechairsneedingelecplumbingquantity';
            ExternalType = 'Integer';
            Description = 'Pedicure Chairs needing electrical/Plumbing points Quantity';
            Caption = 'Pedicure Chairs needing elec/Plumbing-Quantity';
        }
        field(10474; sr_facial_steamers; Boolean)
        {
            ExternalName = 'sr_facial_steamers';
            ExternalType = 'Boolean';
            Description = 'Facial Steamers';
            Caption = 'Facial Steamers';
        }
        field(10476; sr_facial_steamers_quantity; Integer)
        {
            ExternalName = 'sr_facial_steamers_quantity';
            ExternalType = 'Integer';
            Description = 'Facial Steamers Quantity';
            Caption = 'Facial Steamers Quantity';
        }
        field(10477; sr_facial_machines; Boolean)
        {
            ExternalName = 'sr_facial_machines';
            ExternalType = 'Boolean';
            Description = 'Facial Machines';
            Caption = 'Facial Machines';
        }
        field(10479; sr_facial_machines_quantity; Integer)
        {
            ExternalName = 'sr_facial_machines_quantity';
            ExternalType = 'Integer';
            Description = 'Facial Machines Quantity';
            Caption = 'Facial Machines Quantity';
        }
        field(10480; sr_wax_pots; Boolean)
        {
            ExternalName = 'sr_wax_pots';
            ExternalType = 'Boolean';
            Description = 'Wax Pots';
            Caption = 'Wax Pots';
        }
        field(10482; sr_others; Boolean)
        {
            ExternalName = 'sr_others';
            ExternalType = 'Boolean';
            Description = 'Other (Please indicate)';
            Caption = 'Other (Please indicate)';
        }
        field(10484; sr_other_quantity; Integer)
        {
            ExternalName = 'sr_other_quantity';
            ExternalType = 'Integer';
            Description = 'Quantity (Others)';
            Caption = 'Quantity (Others)';
        }
        field(10485; sr_doyouofferchemicalstraighteningcurlingser; Boolean)
        {
            ExternalName = 'sr_doyouofferchemicalstraighteningcurlingser';
            ExternalType = 'Boolean';
            Description = 'Do you offer Chemical Straightening/Curling Services? (i.e. Keratin, Brazilian Blowout, Japanese Straightening, Perm, etc.)';
            Caption = 'Do you offer Chemical Straightening/Curling Servic';
        }
        field(10487; sr_Ifyeshowoften; Option)
        {
            ExternalName = 'sr_ifyeshowoften';
            ExternalType = 'Picklist';
            Description = 'If yes, how often?';
            Caption = 'If yes, how often?';
            InitValue = " ";
            OptionMembers = " ",Daily,Weekly,"Bi-Weekly",Monthly,Quarterly,Every6Months,Yearly;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006;
        }
        field(10489; sr_wax_pots_quantity; Integer)
        {
            ExternalName = 'sr_wax_pots_quantity';
            ExternalType = 'Integer';
            Description = 'Wax Pots Quantity';
            Caption = 'Wax Pots Quantity';
        }
        field(10490; sr_cloneid; Text[100])
        {
            ExternalName = 'sr_cloneid';
            ExternalType = 'String';
            Description = '';
            Caption = 'CloneID';
        }
        field(10491; sr_pleasespecify; Text[100])
        {
            ExternalName = 'sr_pleasespecify';
            ExternalType = 'String';
            Description = '';
            Caption = 'Please Specify';
        }
        field(10492; sr_NameofSalonWorkplaceSalaryHourly; Text[100])
        {
            ExternalName = 'sr_nameofsalonworkplacesalaryhourly';
            ExternalType = 'String';
            Description = '';
            Caption = 'Name of Salon/Workplace';
        }
        field(10495; sr_DateIssued; Date)
        {
            ExternalName = 'sr_dateissued';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Date Issued';
        }
        field(10496; sr_GraduatingSchoolName; Text[100])
        {
            ExternalName = 'sr_graduatingschoolname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Graduating School Name';
        }
        field(10497; sr_DateofGraduation; Date)
        {
            ExternalName = 'sr_dateofgraduation';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Date of Graduation';
        }
        field(10498; sr_SchoolCIty; Text[100])
        {
            ExternalName = 'sr_schoolcity';
            ExternalType = 'String';
            Description = '';
            Caption = 'School CIty';
        }
        field(10501; sr_pleasepecifysubbrand; Text[100])
        {
            ExternalName = 'sr_pleasepecifysubbrand';
            ExternalType = 'String';
            Description = '';
            Caption = 'Please Specify';
        }
        field(10502; sr_PleaseSpecifyProductBrandprofessional; Text[100])
        {
            ExternalName = 'sr_pleasespecifyproductbrandprofessional';
            ExternalType = 'String';
            Description = '';
            Caption = 'Please Specify Product Brands (Professional)';
        }
        field(10503; sr_pleasespecifyskincare; Text[100])
        {
            ExternalName = 'sr_pleasespecifyskincare';
            ExternalType = 'String';
            Description = '';
            Caption = 'Please Specify Skin Care';
        }
        field(10504; sr_iscloned; Boolean)
        {
            ExternalName = 'sr_iscloned';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Cloned?';
        }
        field(10506; sr_pleasespecifysubbrands; Text[100])
        {
            ExternalName = 'sr_pleasespecifysubbrands';
            ExternalType = 'String';
            Description = 'Please Specify (Sub- Brands)';
            Caption = 'Please Specify (Sub- Brands)';
        }
        field(10507; sr_docusign_resendtime; Datetime)
        {
            ExternalName = 'sr_docusign_resendtime';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Last Docusign Resend Time';
        }
        field(10508; sr_SMSConsentDenied; Boolean)
        {
            ExternalName = 'sr_smsconsentdenied';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'SMS Consent Denied';
        }
    }
    keys
    {
        key(PK; LeadId)
        {
            Clustered = true;
        }
        key(Name; FullName)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; FullName)
        {
        }
    }
}