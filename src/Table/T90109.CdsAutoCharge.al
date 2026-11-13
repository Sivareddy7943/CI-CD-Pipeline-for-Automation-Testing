table 90109 "CDS sr_autocharge"
{
    ExternalName = 'sr_autocharge';
    TableType = CDS;
    Description = 'Charge';
    DrillDownPageId = "AutoCharge - Dataverse";
    LookupPageId = "AutoCharge - Dataverse";
    fields
    {
        field(1; sr_autochargeId; GUID)
        {
            ExternalName = 'sr_autochargeid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Auto Charge';
        }
        field(2; CreatedOn; Datetime)
        {
            ExternalName = 'createdon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Date and time when the record was created.';
            Caption = 'Created On';
        }
        field(3; CreatedBy; GUID)
        {
            ExternalName = 'createdby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the user who created the record.';
            Caption = 'Created By';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(4; ModifiedOn; Datetime)
        {
            ExternalName = 'modifiedon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Date and time when the record was modified.';
            Caption = 'Modified On';
        }
        field(5; ModifiedBy; GUID)
        {
            ExternalName = 'modifiedby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the user who modified the record.';
            Caption = 'Modified By';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(6; CreatedOnBehalfBy; GUID)
        {
            ExternalName = 'createdonbehalfby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the delegate user who created the record.';
            Caption = 'Created By (Delegate)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(7; ModifiedOnBehalfBy; GUID)
        {
            ExternalName = 'modifiedonbehalfby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the delegate user who modified the record.';
            Caption = 'Modified By (Delegate)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(16; OwnerId; GUID)
        {
            ExternalName = 'ownerid';
            ExternalType = 'Owner';
            Description = 'Owner Id';
            Caption = 'Owner';
        }
        field(21; OwningBusinessUnit; GUID)
        {
            ExternalName = 'owningbusinessunit';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier for the business unit that owns the record';
            Caption = 'Owning Business Unit';
            TableRelation = "CRM Businessunit".BusinessUnitId;
        }
        field(22; OwningUser; GUID)
        {
            ExternalName = 'owninguser';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier for the user that owns the record.';
            Caption = 'Owning User';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(23; OwningTeam; GUID)
        {
            ExternalName = 'owningteam';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier for the team that owns the record.';
            Caption = 'Owning Team';
            TableRelation = "CRM Team".TeamId;
        }
        field(25; statecode; Option)
        {
            ExternalName = 'statecode';
            ExternalType = 'State';
            ExternalAccess = Modify;
            Description = 'Status of the Auto Charge';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Auto Charge';
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
        field(34; sr_name; Text[100])
        {
            ExternalName = 'sr_name';
            ExternalType = 'String';
            Description = 'The name of the custom entity.';
            Caption = 'Auto Charge Name';
        }
        field(35; sr_chargetype; Option)
        {
            ExternalName = 'sr_chargetype';
            ExternalType = 'Picklist';
            Description = '[DO NOT USE] Charge Type';
            Caption = '[DO NOT USE] Charge Type';
            InitValue = " ";
            OptionMembers = " ",AbatementFee,"LicenseFee(Row1)";
            OptionOrdinalValues = -1, 742440000, 742440001;
        }
        field(37; sr_amount; Decimal)
        {
            ExternalName = 'sr_amount';
            ExternalType = 'Money';
            Description = 'Amount';
            Caption = 'Amount';
        }
        field(38; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(40; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(41; sr_amount_Base; Decimal)
        {
            ExternalName = 'sr_amount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount in base currency.';
            Caption = 'Amount (Base)';
        }
        field(44; sr_chargestartdate; Date)
        {
            ExternalName = 'sr_chargestartdate';
            ExternalType = 'DateTime';
            Description = 'Charge Start Date';
            Caption = 'Start Date';
        }
        field(45; sr_chargeanticipatedenddate; Date)
        {
            ExternalName = 'sr_chargeanticipatedenddate';
            ExternalType = 'DateTime';
            Description = 'Charge Anticipated End Date';
            Caption = 'Anticipated End Date';
        }
        field(46; sr_chargeenddate; Date)
        {
            ExternalName = 'sr_chargeenddate';
            ExternalType = 'DateTime';
            Description = 'Charge End Date';
            Caption = 'End Date';
        }
        field(47; sr_dueday; Option)
        {
            ExternalName = 'sr_dueday';
            ExternalType = 'Picklist';
            Description = 'Due Day';
            Caption = 'Due Day';
            InitValue = " ";
            OptionMembers = " ",Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
            OptionOrdinalValues = -1, 742440000, 742440001, 742440002, 742440003, 742440004, 742440005, 742440006;
        }
        field(49; sr_discountamount; Decimal)
        {
            ExternalName = 'sr_discountamount';
            ExternalType = 'Money';
            Description = 'Discount Amount';
            Caption = 'Discount Amount';
        }
        field(50; sr_discountamount_Base; Decimal)
        {
            ExternalName = 'sr_discountamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Discount Amount in base currency.';
            Caption = 'Discount Amount (Base)';
        }
        field(51; sr_abatementamount; Decimal)
        {
            ExternalName = 'sr_abatementamount';
            ExternalType = 'Money';
            Description = 'Abatement Amount';
            Caption = 'Abatement Amount';
        }
        field(52; sr_abatementamount_Base; Decimal)
        {
            ExternalName = 'sr_abatementamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Abatement Amount in base currency.';
            Caption = 'Abatement Amount (Base)';
        }
        field(53; sr_discounttype; Option)
        {
            ExternalName = 'sr_discounttype';
            ExternalType = 'Picklist';
            Description = 'Discount Type';
            Caption = 'Discount Type';
            InitValue = " ";
            OptionMembers = " ",TBC;
            OptionOrdinalValues = -1, 742440000;
        }
        field(55; sr_lastposteddate; Date)
        {
            ExternalName = 'sr_lastposteddate';
            ExternalType = 'DateTime';
            Description = 'Last Posted Date';
            Caption = 'Last Posted';
        }
        field(56; sr_description; Text[2000])
        {
            ExternalName = 'sr_description';
            ExternalType = 'String';
            Description = 'Description';
            Caption = 'Description';
        }
        field(57; sr_conveniencecharge; Decimal)
        {
            ExternalName = 'sr_conveniencecharge';
            ExternalType = 'Money';
            Description = 'Convenience Charge';
            Caption = 'Convenience Charge';
        }
        field(58; sr_conveniencecharge_Base; Decimal)
        {
            ExternalName = 'sr_conveniencecharge_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Convenience Charge in base currency.';
            Caption = 'Convenience Charge (Base)';
        }
        field(59; sr_agreementid; GUID)
        {
            ExternalName = 'sr_agreementid';
            ExternalType = 'Lookup';
            Description = 'Agreement';
            Caption = 'Agreement';
            TableRelation = "CDS sr_agreement".sr_agreementId;
        }
        field(61; new_SrBCEntryNo; Integer)
        {
            ExternalName = 'new_srbcentryno';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'BC Entry No.';
        }
        field(65; new_AgreementStartDate; Date)
        {
            ExternalName = 'new_agreementstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Agreement Start Date';
        }
        field(66; new_NextChargeDate; Date)
        {
            ExternalName = 'new_nextchargedate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Next Charge Date';
        }
        field(70; new_SalonCode; Text[100])
        {
            ExternalName = 'new_saloncode';
            ExternalType = 'String';
            Description = '';
            Caption = 'SalonCode';
        }
        field(71; new_StudioCode; Text[100])
        {
            ExternalName = 'new_studiocode';
            ExternalType = 'String';
            Description = '';
            Caption = 'StudioCode';
        }
        field(72; sr_autochargetypecode; GUID)
        {
            ExternalName = 'sr_autochargetypecode';
            ExternalType = 'Lookup';
            Description = 'Auto Charge Type';
            Caption = 'Charge  Type';
            TableRelation = "CDS sr_autochargetype".sr_autochargetypeId;
        }
        field(74; sr_frequency; Option)
        {
            ExternalName = 'sr_frequency';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Frequency';
            InitValue = Once;
            OptionMembers = Once,Daily,Weekly,Monthly,Quarterly,Yearly;
            OptionOrdinalValues = 742440004, 742440000, 742440001, 742440002, 742440005, 742440003;
        }
        field(76; sr_Lincenses; Text[2048])
        {
            ExternalName = 'sr_lincenses';
            ExternalType = 'String';
            Description = '';
            Caption = 'Charge to Licensee';
        }
        field(80; sr_ApprovalStatus; Option)
        {
            ExternalName = 'sr_approvalstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Approval Status';
            InitValue = " ";
            OptionMembers = " ",PendingRMApproval,RMApproved,RMRejected;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002;
        }
        field(84; sr_DeleteStatus; Option)
        {
            ExternalName = 'sr_deletestatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Delete Status';
            InitValue = " ";
            OptionMembers = " ",PendingRMApproval,RMApproved,RMRejected;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002;
        }
        field(86; sr_IsBCApproved; Boolean)
        {
            ExternalName = 'sr_isbcapproved';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'IsBCApproved';
        }
        field(88; EmailAddress; Text[100])
        {
            ExternalName = 'emailaddress';
            ExternalType = 'String';
            Description = 'The primary email address for the entity.';
            Caption = 'Email Address';
        }
        field(90; sr_Reference; Text[35])
        {
            ExternalName = 'sr_reference';
            ExternalType = 'String';
            Description = '';
            Caption = 'Reference';
        }
        field(91; sr_Notes; Text[2048])
        {
            ExternalName = 'sr_notes';
            ExternalType = 'String';
            Description = '';
            Caption = 'Notes';
        }
        field(92; sr_AgreementFilter; Text[2048])
        {
            ExternalName = 'sr_agreementfilter';
            ExternalType = 'String';
            Description = '';
            Caption = 'Agreement Filter';
        }
        field(93; sr_IsCRM; Boolean)
        {
            ExternalName = 'sr_iscrm';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'IsCRM';
        }
        field(95; sr_IsScheduleSetting; Boolean)
        {
            ExternalName = 'sr_isschedulesetting';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'IsScheduleSetting';
        }
        field(98; sr_SendMailNow; Boolean)
        {
            ExternalName = 'sr_sendmailnow';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Send Mail Now';
        }
        field(100; sr_NoofDays; Integer)
        {
            ExternalName = 'sr_noofdays';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'No. of Days';
        }
        field(101; sr_ChargeAmount; Decimal)
        {
            ExternalName = 'sr_chargeamount';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Charge Amount';
        }
        field(102; sr_ChargeDate; Date)
        {
            ExternalName = 'sr_chargedate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Charge Date';
        }
        field(103; sr_ChargeRepeatsEvery; Option)
        {
            ExternalName = 'sr_chargerepeatsevery';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Charge Repeats Every';
            InitValue = " ";
            OptionMembers = " ",Days,Weeks,Months,Quarters,Years;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002, 468690003, 468690004;
        }
        field(105; sr_ChargetoLicensee; Text[2048])
        {
            ExternalName = 'sr_chargetolicensee';
            ExternalType = 'String';
            Description = '';
            Caption = 'Charge to Licensee';
        }
        field(106; sr_DailyDataTriggerDate; Date)
        {
            ExternalName = 'sr_dailydatatriggerdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Daily Data Trigger Date';
        }
        field(107; sr_FrequencyofCharge; Option)
        {
            ExternalName = 'sr_frequencyofcharge';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Frequency of Charge';
            InitValue = " ";
            OptionMembers = " ",Once,Daily,Weekly,Monthly,Quarterly,Yearly;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002, 468690003, 468690004, 468690005;
        }
        field(109; sr_IsFrequencyOnce; Boolean)
        {
            ExternalName = 'sr_isfrequencyonce';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'IsFrequencyOnce';
        }
        field(111; sr_IsRecurring; Boolean)
        {
            ExternalName = 'sr_isrecurring';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Is Recurring';
        }
        field(114; sr_MonthDay; Option)
        {
            ExternalName = 'sr_monthday';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Month Day';
            InitValue = " ";
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31";
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011, 468690012, 468690013, 468690014, 468690015, 468690016, 468690017, 468690018, 468690019, 468690020, 468690021, 468690022, 468690023, 468690024, 468690025, 468690026, 468690027, 468690028, 468690029, 468690030;
        }
        field(116; sr_MonthlyLastDataInsertDate; Date)
        {
            ExternalName = 'sr_monthlylastdatainsertdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Monthly Last Data Insert Date';
        }
        field(117; sr_MonthName; Option)
        {
            ExternalName = 'sr_monthname';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Month Name';
            InitValue = " ";
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011;
        }
        field(119; sr_ProcessingDescription; Text[1000])
        {
            ExternalName = 'sr_processingdescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'Processing Description';
        }
        field(120; sr_ProcessingStatus; Text[10])
        {
            ExternalName = 'sr_processingstatus';
            ExternalType = 'String';
            Description = 'Processing Status - In progress, Success, Fail';
            Caption = 'Processing Status';
        }
        field(121; sr_Quarterly; Option)
        {
            ExternalName = 'sr_quarterly';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Quarterly';
            InitValue = " ";
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011;
        }
        field(123; sr_QuarterlyLastDataInsertDate; Date)
        {
            ExternalName = 'sr_quarterlylastdatainsertdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Quarterly Last Data Insert Date';
        }
        field(124; sr_WeeklyLastDatainsertDate; Date)
        {
            ExternalName = 'sr_weeklylastdatainsertdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Weekly Last Data Insert Date';
        }
        field(125; sr_YearlyLastDataInsertDate; Date)
        {
            ExternalName = 'sr_yearlylastdatainsertdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Yearly Last Data Insert Date';
        }
        field(126; sr_WeekDays; Option)
        {
            ExternalName = 'sr_weekdays';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Week Days';
            InitValue = " ";
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006;
        }
        field(128; sr_Inactive; Boolean)
        {
            ExternalName = 'sr_inactive';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Inactive';
        }
        field(134; sr_IsBC; Boolean)
        {
            ExternalName = 'sr_isbc';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'IsBC';
        }
    }
    keys
    {
        key(PK; sr_autochargeId)
        {
            Clustered = true;
        }
        key(Name; sr_name)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; sr_name)
        {
        }
    }
}