//SRBC-375 - SY - 22062025 - Did changes in existing fields & added some more fields
//SRBC-429 - AM - 17062025 - Did changes in field(27; statuscode; Option) and added values , "AgreementCompleted–FutureCommencement", "Terminated–StudioTransfer", "Terminated–PaymentPlan", "Terminated–NotApproved", Abandoned
//                           and , 468690003, 468690004, 468690005, 468690006, 468690007 and added space in each values
table 90111 "CDS sr_agreement"
{
    ExternalName = 'sr_agreement';
    TableType = CDS;
    Description = 'Agreement';
    DrillDownPageId = "Agreement - Dataverse";
    LookupPageId = "Agreement - Dataverse";
    fields
    {
        field(1; sr_agreementId; GUID)
        {
            ExternalName = 'sr_agreementid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Agreement';
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
            //TableRelation = "CRM Systemuser".SystemUserId;
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
            //TableRelation = "CRM Systemuser".SystemUserId;
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
            Description = 'Status of the Agreement';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Agreement';
            Caption = 'Status Reason';
            InitValue = " ";
            //SRBC-375 Start
            //OptionMembers = " ",Draft,Active,Terminated,"NoticeReceived-60DaysNotice(byLicensee)","NoticeReceived-BreakOfAgreement(byLicensee)","NoticeServed-Non-Renewal(60Days)",Evicted,"Terminated-Eviction","DelinquencyNoticeServed-3DayNoticeToPayRentOrQuit","DelinquencyNoticeServed-48HourNoticeToRemitPayment","EvictionNoticeServed-FinalNoticeOfEviction","Terminated-Withdrew",Inactive;
            // OptionMembers = " ",Draft,Active,Terminated,"NoticeReceived-60DaysNotice(byLicensee)","NoticeReceived-BreakOfAgreement(byLicensee)","NoticeServed-Non-Renewal(60Days)",Evicted,"Terminated-Eviction","DelinquencyNoticeServed-3DayNoticeToPayRentOrQuit","DelinquencyNoticeServed-48HourNoticeToRemitPayment","EvictionNoticeServed-FinalNoticeOfEviction","Terminated-Withdrew","Notice–StudioTransfer","Terminated-ResetPending",Inactive;
            //SRBC-429 Start
            OptionMembers = " ",Draft,Active,Terminated,"Notice Received-60 Days Notice(by Licensee)","Notice Received-Break Of Agreement(by Licensee)","Notice Served-Non-Renewal(60 Days)",Evicted,"Terminated-Eviction","Delinquency Notice Served-3 Day Notice To Pay Rent Or Quit","Delinquency Notice Served-48 Hour Notice To Remit Payment","Eviction Notice Served-Final Notice Of Eviction","Terminated-Withdrew","Notice–StudioTransfer","Terminated-ResetPending",Inactive,"Agreement Completed-Future Commencement","Terminated-Studio Transfer","Terminated-Payment Plan","Terminated-Not Approved",Abandoned;
            // OptionOrdinalValues = -1, 874900000, 1, 874900006, 874900001, 874900002, 874900003, 874900004, 874900005, 874900007, 874900008, 874900009, 874900010, 468690001, 468690002, 2;
            OptionOrdinalValues = -1, 874900000, 1, 874900006, 874900001, 874900002, 874900003, 874900004, 874900005, 874900007, 874900008, 874900009, 874900010, 468690001, 468690002, 2, 468690003, 468690004, 468690005, 468690006, 468690007;
            //SRBC-429 End
            //SRBC-375 End
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
        //field(34; sr_name; Text[500])//SRBC-375
        field(34; sr_name; Text[850])//SRBC-375
        {
            ExternalName = 'sr_name';
            ExternalType = 'String';
            Description = 'The name of the Agreement entity.';
            Caption = 'Quick link to Agreement/ Ledger';
        }
        field(35; sr_noticereceiveddate; Date)
        {
            ExternalName = 'sr_noticereceiveddate';
            ExternalType = 'DateTime';
            Description = 'Notice Received Date';
            Caption = 'Notice Received Date';
        }
        field(36; sr_noticeexpirationdate; Date)
        {
            ExternalName = 'sr_noticeexpirationdate';
            ExternalType = 'DateTime';
            Description = 'Notice Expiration Date';
            Caption = 'Notice Expiration Date';
        }
        field(37; sr_paymentcommitmentenddate; Date)
        {
            ExternalName = 'sr_paymentcommitmentenddate';
            ExternalType = 'DateTime';
            Description = 'Payment Commitment End Date';
            Caption = 'Payment Commitment End Date';
        }
        field(38; sr_noticeserveddate; Date)
        {
            ExternalName = 'sr_noticeserveddate';
            ExternalType = 'DateTime';
            Description = 'Notice Served Date';
            Caption = 'Notice Served Date';
        }
        field(39; sr_evicteddate; Date)
        {
            ExternalName = 'sr_evicteddate';
            ExternalType = 'DateTime';
            Description = 'Evicted Date';
            Caption = 'Evicted Date';
        }
        field(40; sr_moveindate; Date)
        {
            ExternalName = 'sr_moveindate';
            ExternalType = 'DateTime';
            Description = 'Move In Date (Actual)';
            Caption = 'Move In Date (Actual)';
        }
        field(41; sr_currentagreementstartdate; Date)
        {
            ExternalName = 'sr_currentagreementstartdate';
            ExternalType = 'DateTime';
            Description = 'Current Agreement Start Date';
            Caption = 'Current Agreement Start Date';
        }
        field(42; sr_currentagreementenddate; Date)
        {
            ExternalName = 'sr_currentagreementenddate';
            ExternalType = 'DateTime';
            Description = 'Current Agreement End Date';
            Caption = 'Current Agreement End Date';
        }
        field(43; sr_termofagreement; Option)
        {
            ExternalName = 'sr_termofagreement';
            ExternalType = 'Picklist';
            Description = 'Term of Agreement';
            Caption = 'Term of Agreement';
            InitValue = " ";
            OptionMembers = " ","Month-to-Month",MultipleMonths;
            OptionOrdinalValues = -1, 874900000, 874900001;
        }
        field(45; sr_rentagreementtype; Option)
        {
            ExternalName = 'sr_rentagreementtype';
            ExternalType = 'Picklist';
            Description = 'Rent Agreement Type';
            Caption = 'Rent Agreement Type';
            InitValue = " ";
            OptionMembers = " ",Standard,Staggered;
            OptionOrdinalValues = -1, 874900000, 874900001;
        }
        field(47; sr_currentagreementsigneddate; Date)
        {
            ExternalName = 'sr_currentagreementsigneddate';
            ExternalType = 'DateTime';
            Description = 'Current Agreement Signed Date';
            Caption = 'Current Agreement Signed Date';
        }
        field(48; sr_additionalnotes; BLOB)
        {
            ExternalName = 'sr_additionalnotes';
            ExternalType = 'Memo';
            Description = 'Additional Notes';
            Caption = 'Additional Notes';
            Subtype = Memo;
        }
        field(49; sr_reasonforterminating; Option)
        {
            ExternalName = 'sr_reasonforterminating';
            ExternalType = 'Picklist';
            Description = 'Reason For Terminating';
            Caption = 'Reason For Terminating';
            InitValue = " ";
            OptionMembers = " ","AbandonedStudio/Agreement",ChangingProfession,Deceased,Evicted,Health,LossOfClientele,"LostSub-Licensee",MovingToCompetitor,MovingToOwnStoreFront,MovingToTraditionalSalon,"Non-RenewalNoticeServed",PersonalReasons,"Profession/LicenseNotApprove","Relocating(City/State)",RenewalIncreaseNotAccepted,Retiring,StartingMobileBusiness,StudioTransfer,TooExpensive,TransferToDifferentSR,UnhappyWithFacilities,UnhappyWithService,Unknown;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 874900007, 874900008, 874900009, 874900010, 874900011, 874900012, 874900013, 874900014, 874900015, 874900016, 874900017, 874900018, 874900019, 874900020, 874900021, 874900022;
        }
        field(51; sr_terminationtype; Option)
        {
            ExternalName = 'sr_terminationtype';
            ExternalType = 'Picklist';
            Description = 'Termination Type';
            Caption = 'Termination Type';
            InitValue = " ";
            OptionMembers = " ","NoticeReceived-60DaysNotice","NoticeReceived-BreakOfAgreement",Evicted,"NoticeOfNon-RenewalServed";
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003;
        }
        field(53; sr_noticegivendate; Date)
        {
            ExternalName = 'sr_noticegivendate';
            ExternalType = 'DateTime';
            Description = 'Notice Given Date';
            Caption = 'Notice Given Date';
        }
        field(54; sr_scheduledmoveoutdate; Date)
        {
            ExternalName = 'sr_scheduledmoveoutdate';
            ExternalType = 'DateTime';
            Description = 'Scheduled Move-Out Date';
            Caption = 'Scheduled Move-Out Date';
        }
        field(55; sr_vacateddate; Date)
        {
            ExternalName = 'sr_vacateddate';
            ExternalType = 'DateTime';
            Description = 'Vacated Date';
            Caption = 'Vacated Date';
        }
        field(56; sr_hasanattemptbeenmadetoretainlicensee; Option)
        {
            ExternalName = 'sr_hasanattemptbeenmadetoretainlicensee';
            ExternalType = 'Picklist';
            Description = 'Has an attempt been made to retain Licensee?';
            Caption = 'Has an attempt been made to retain Licensee?';
            InitValue = " ";
            OptionMembers = " ",InProgress,Yes,No;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002;
        }
        field(58; sr_whichsolutionswereofferedinattempttoretai; BLOB)
        {
            ExternalName = 'sr_whichsolutionswereofferedinattempttoretai';
            ExternalType = 'Memo';
            Description = 'Which solutions were offered in attempt to retain Licensee';
            Caption = 'Which solutions were offered in attempt to retain';
            Subtype = Memo;
        }
        field(59; sr_salonlocationid; GUID)
        {
            ExternalName = 'sr_salonlocationid';
            ExternalType = 'Lookup';
            Description = 'Salon Location';
            Caption = 'Salon Location';
            TableRelation = "CDS sr_Building".sr_BuildingId;
        }
        field(61; sr_licenseeid; GUID)
        {
            ExternalName = 'sr_licenseeid';
            ExternalType = 'Lookup';
            Description = 'Licensee';
            Caption = '(DO NOT USE)Licensee';
            TableRelation = "CRM Contact".ContactId;
        }
        field(64; sr_renewalletterduedate; Date)
        {
            ExternalName = 'sr_renewalletterduedate';
            ExternalType = 'DateTime';
            Description = 'Renewal Letter Due Date';
            Caption = 'Renewal Letter Due Date';
        }
        field(65; sr_renewallettersenton; Date)
        {
            ExternalName = 'sr_renewallettersenton';
            ExternalType = 'DateTime';
            Description = 'Renewal Letter Sent On';
            Caption = 'Renewal Letter Sent On';
        }
        field(66; sr_renewalconfirmationduedate; Date)
        {
            ExternalName = 'sr_renewalconfirmationduedate';
            ExternalType = 'DateTime';
            Description = 'Renewal Confirmation Due Date (Licensee)';
            Caption = 'Renewal Confirmation Due Date (Licensee)';
        }
        field(69; sr_rentratemonthtomonth; Decimal)
        {
            ExternalName = 'sr_rentratemonthtomonth';
            ExternalType = 'Money';
            Description = 'Rent Rate (Month-to-Month)';
            Caption = 'Rent Rate (Month-to-Month)';
        }
        field(70; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(72; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(73; sr_rentratemonthtomonth_Base; Decimal)
        {
            ExternalName = 'sr_rentratemonthtomonth_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Month-to-Month) in base currency.';
            Caption = 'Rent Rate (Month-to-Month) (Base)';
        }
        field(74; sr_rentrateannual; Decimal)
        {
            ExternalName = 'sr_rentrateannual';
            ExternalType = 'Money';
            Description = 'Rent Rate (Annual)';
            Caption = 'Rent Rate (Annual)';
        }
        field(75; sr_rentrateannual_Base; Decimal)
        {
            ExternalName = 'sr_rentrateannual_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Annual) in base currency.';
            Caption = 'Rent Rate (Annual) (Base)';
        }
        field(76; sr_rentrate6month; Decimal)
        {
            ExternalName = 'sr_rentrate6month';
            ExternalType = 'Money';
            Description = 'Rent Rate (6 Month)';
            Caption = 'Rent Rate (6 Month)';
        }
        field(77; sr_rentrate6month_Base; Decimal)
        {
            ExternalName = 'sr_rentrate6month_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (6 Month) in base currency.';
            Caption = 'Rent Rate (6 Month) (Base)';
        }
        field(78; sr_rentrateyear1; Decimal)
        {
            ExternalName = 'sr_rentrateyear1';
            ExternalType = 'Money';
            Description = 'Rent Rate (Year 1)';
            Caption = 'Rent Rate (Year 1)';
        }
        field(79; sr_rentrateyear1_Base; Decimal)
        {
            ExternalName = 'sr_rentrateyear1_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Year 1) in base currency.';
            Caption = 'Rent Rate (Year 1) (Base)';
        }
        field(80; sr_rentrateyear2; Decimal)
        {
            ExternalName = 'sr_rentrateyear2';
            ExternalType = 'Money';
            Description = 'Rent Rate (Year 2)';
            Caption = 'Rent Rate (Year 2)';
        }
        field(81; sr_rentrateyear2_Base; Decimal)
        {
            ExternalName = 'sr_rentrateyear2_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Year 2) in base currency.';
            Caption = 'Rent Rate (Year 2) (Base)';
        }
        field(82; sr_rentrateyear3; Decimal)
        {
            ExternalName = 'sr_rentrateyear3';
            ExternalType = 'Money';
            Description = 'Rent Rate (Year 3)';
            Caption = 'Rent Rate (Year 3)';
        }
        field(83; sr_rentrateyear3_Base; Decimal)
        {
            ExternalName = 'sr_rentrateyear3_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Year 3) in base currency.';
            Caption = 'Rent Rate (Year 3) (Base)';
        }
        field(84; sr_rentrateweek1; Decimal)
        {
            ExternalName = 'sr_rentrateweek1';
            ExternalType = 'Money';
            Description = 'Rent Rate (Week 1)';
            Caption = 'Rent Rate (Week 1)';
        }
        field(85; sr_rentrateweek1_Base; Decimal)
        {
            ExternalName = 'sr_rentrateweek1_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Week 1) in base currency.';
            Caption = 'Rent Rate (Week 1) (Base)';
        }
        field(86; sr_rentrateweek2; Decimal)
        {
            ExternalName = 'sr_rentrateweek2';
            ExternalType = 'Money';
            Description = 'Rent Rate (Week 2)';
            Caption = 'Rent Rate (Week 2)';
        }
        field(87; sr_rentrateweek2_Base; Decimal)
        {
            ExternalName = 'sr_rentrateweek2_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Week 2) in base currency.';
            Caption = 'Rent Rate (Week 2) (Base)';
        }
        field(88; sr_rentrateweek3; Decimal)
        {
            ExternalName = 'sr_rentrateweek3';
            ExternalType = 'Money';
            Description = 'Rent Rate (Week 3)';
            Caption = 'Rent Rate (Week 3)';
        }
        field(89; sr_rentrateweek3_Base; Decimal)
        {
            ExternalName = 'sr_rentrateweek3_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Week 3) in base currency.';
            Caption = 'Rent Rate (Week 3) (Base)';
        }
        field(90; sr_rentrateweek4; Decimal)
        {
            ExternalName = 'sr_rentrateweek4';
            ExternalType = 'Money';
            Description = 'Rent Rate (Week 4)';
            Caption = 'Rent Rate (Week 4)';
        }
        field(91; sr_rentrateweek4_Base; Decimal)
        {
            ExternalName = 'sr_rentrateweek4_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Rate (Week 4) in base currency.';
            Caption = 'Rent Rate (Week 4) (Base)';
        }
        field(92; sr_finalrentincreaseamountperweek; Decimal)
        {
            ExternalName = 'sr_finalrentincreaseamountperweek';
            ExternalType = 'Money';
            Description = 'Final Rent Increase Amount (per week)';
            Caption = 'Final Rent Increase Amount (per week)';
        }
        field(93; sr_finalrentincreaseamountperweek_Base; Decimal)
        {
            ExternalName = 'sr_finalrentincreaseamountperweek_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Final Rent Increase Amount (per week) in base currency.';
            Caption = 'Final Rent Increase Amount (per week) (Base)';
        }
        field(94; sr_newrentamountperweek; Decimal)
        {
            ExternalName = 'sr_newrentamountperweek';
            ExternalType = 'Money';
            Description = 'New Rent Amount (per week)';
            Caption = 'New Rent Amount (per week)';
        }
        field(95; sr_newrentamountperweek_Base; Decimal)
        {
            ExternalName = 'sr_newrentamountperweek_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the New Rent Amount (per week) in base currency.';
            Caption = 'New Rent Amount (per week) (Base)';
        }
        field(96; sr_newstartdate; Date)
        {
            ExternalName = 'sr_newstartdate';
            ExternalType = 'DateTime';
            Description = 'New Start Date';
            Caption = 'New Start Date';
        }
        field(97; sr_newenddate; Date)
        {
            ExternalName = 'sr_newenddate';
            ExternalType = 'DateTime';
            Description = 'New End Date';
            Caption = 'New End Date';
        }
        field(98; sr_priorrentrate; Decimal)
        {
            ExternalName = 'sr_priorrentrate';
            ExternalType = 'Money';
            Description = 'Prior Rent Rate';
            Caption = 'Prior Rent Rate';
        }
        field(99; sr_priorrentrate_Base; Decimal)
        {
            ExternalName = 'sr_priorrentrate_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Prior Rent Rate in base currency.';
            Caption = 'Prior Rent Rate (Base)';
        }
        field(100; sr_newagreementsigneddate; Date)
        {
            ExternalName = 'sr_newagreementsigneddate';
            ExternalType = 'DateTime';
            Description = 'New Agreement Signed Date';
            Caption = 'New Agreement Signed Date';
        }
        field(101; sr_newagreementterm; Option)
        {
            ExternalName = 'sr_newagreementterm';
            ExternalType = 'Picklist';
            Description = 'New Agreement Term';
            Caption = 'New Agreement Term';
            InitValue = " ";
            OptionMembers = " ","Month-to-Month",Annual,"6Month","Multi-Year",StaggeredRentTerm;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004;
        }
        field(111; sr_studioid; GUID)
        {
            ExternalName = 'sr_studioid';
            ExternalType = 'Lookup';
            Description = 'Studio #';
            Caption = 'Studio #';
            TableRelation = "CDS sr_Studio".sr_StudioId;
        }
        field(113; sr_currentrentrate; Decimal)
        {
            ExternalName = 'sr_currentrentrate';
            ExternalType = 'Money';
            Description = 'Current Rent Rate';
            Caption = 'Current Rent Rate';
        }
        field(114; sr_currentrentrate_Base; Decimal)
        {
            ExternalName = 'sr_currentrentrate_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Current Rent Rate in base currency.';
            Caption = 'Current Rent Rate (Base)';
        }
        field(117; sr_numberofweeks; Integer)
        {
            ExternalName = 'sr_numberofweeks';
            ExternalType = 'Integer';
            Description = 'Number of weeks';
            Caption = 'Number of weeks';
        }
        field(120; sr_ratediscountweeklyrentrate; Boolean)
        {
            ExternalName = 'sr_ratediscountweeklyrentrate';
            ExternalType = 'Boolean';
            Description = 'Rate Discount (weekly rent rate)';
            Caption = 'Rate Discount (weekly rent rate)';
        }
        field(122; sr_ratereductionamountperweek; Decimal)
        {
            ExternalName = 'sr_ratereductionamountperweek';
            ExternalType = 'Money';
            Description = 'Rate Reduction Amount (per week)';
            Caption = 'Rate Reduction Amount (per week)';
        }
        field(123; sr_ratereductionamountperweek_Base; Decimal)
        {
            ExternalName = 'sr_ratereductionamountperweek_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rate Reduction Amount (per week) in base currency.';
            Caption = 'Rate Reduction Amount (per week) (Base)';
        }
        field(124; sr_valueofincentiverentconcession; Decimal)
        {
            ExternalName = 'sr_valueofincentiverentconcession';
            ExternalType = 'Money';
            Description = 'Value of Incentive (Rent Concession)';
            Caption = 'Value of Incentive (Rent Concession)';
        }
        field(125; sr_valueofincentiverentconcession_Base; Decimal)
        {
            ExternalName = 'sr_valueofincentiverentconcession_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Value of Incentive (Rent Concession) in base currency.';
            Caption = 'Value of Incentive (Rent Concession) (Base)';
        }
        field(129; sr_valueofincentiveotherindicate; Decimal)
        {
            ExternalName = 'sr_valueofincentiveotherindicate';
            ExternalType = 'Money';
            Description = 'Value of Incentive(Other-Indicate)';
            Caption = 'Value of Incentive(Other-Indicate)';
        }
        field(130; sr_valueofincentiveotherindicate_Base; Decimal)
        {
            ExternalName = 'sr_valueofincentiveotherindicate_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Value of Incentive(Other-Indicate) in base currency.';
            Caption = 'Value of Incentive(Other-Indicate) (Base)';
        }
        field(133; sr_valueofincentiveproductcredit; Decimal)
        {
            ExternalName = 'sr_valueofincentiveproductcredit';
            ExternalType = 'Money';
            Description = 'Value of Incentive (Product Credit)';
            Caption = 'Value of Incentive (Product Credit)';
        }
        field(134; sr_valueofincentiveproductcredit_Base; Decimal)
        {
            ExternalName = 'sr_valueofincentiveproductcredit_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Value of Incentive (Product Credit) in base currency.';
            Caption = 'Value of Incentive (Product Credit) (Base)';
        }
        field(135; sr_totalvalueofincentives; Decimal)
        {
            ExternalName = 'sr_totalvalueofincentives';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Total Value of Incentives';
            Caption = 'Total Value of Incentives';
        }
        field(136; sr_totalvalueofincentives_Base; Decimal)
        {
            ExternalName = 'sr_totalvalueofincentives_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Value of Incentives in base currency.';
            Caption = 'Total Value of Incentives (Base)';
        }
        field(137; sr_valueofincentivedesigncredit; Decimal)
        {
            ExternalName = 'sr_valueofincentivedesigncredit';
            ExternalType = 'Money';
            Description = 'Value of Incentive (Design Credit)';
            Caption = 'Value of Incentive (Design Credit)';
        }
        field(138; sr_valueofincentivedesigncredit_Base; Decimal)
        {
            ExternalName = 'sr_valueofincentivedesigncredit_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Value of Incentive (Design Credit) in base currency.';
            Caption = 'Value of Incentive (Design Credit) (Base)';
        }
        field(141; sr_combinationmodificationexecuted; Boolean)
        {
            ExternalName = 'sr_combinationmodificationexecuted';
            ExternalType = 'Boolean';
            Description = 'Combination/Modification Executed';
            Caption = 'Combination/Modification Executed';
        }
        field(143; sr_constructionagreementexecuted; Boolean)
        {
            ExternalName = 'sr_constructionagreementexecuted';
            ExternalType = 'Boolean';
            Description = 'Construction Agreement Executed';
            Caption = 'Construction Agreement Executed';
        }
        field(145; sr_modificationcostagreement; Option)
        {
            ExternalName = 'sr_modificationcostagreement';
            ExternalType = 'Picklist';
            Description = 'Modification Cost Agreement';
            Caption = 'Modification Cost Agreement';
            InitValue = " ";
            OptionMembers = " ","1Year(Licensee-100%Cost)","2Years(Licensee-50%Cost/SR50%Cost)","3Years+(SR100%Cost/Licensee-50%Deposit)","Other-Specify";
            OptionOrdinalValues = -1, 742440000, 742440001, 742440002, 742440003;
        }
        field(147; sr_studiomodificationpaymentreceivedlicensee; Boolean)
        {
            ExternalName = 'sr_studiomodificationpaymentreceivedlicensee';
            ExternalType = 'Boolean';
            Description = 'Studio Modification Payment Received (Licensee)?';
            Caption = 'Studio Modification Payment Received (Licensee)?';
        }
        field(149; sr_studiomodificationcoststolicensee; Decimal)
        {
            ExternalName = 'sr_studiomodificationcoststolicensee';
            ExternalType = 'Money';
            Description = 'Studio Modification Costs to Licensee';
            Caption = 'Studio Modification Costs to Licensee';
        }
        field(150; sr_studiomodificationcoststolicensee_Base; Decimal)
        {
            ExternalName = 'sr_studiomodificationcoststolicensee_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Studio Modification Costs to Licensee in base currency.';
            Caption = 'Studio Modification Costs to Licensee (Base)';
        }
        field(151; sr_studiomodificationcoststosr; Decimal)
        {
            ExternalName = 'sr_studiomodificationcoststosr';
            ExternalType = 'Money';
            Description = 'Studio Modification Costs to SR';
            Caption = 'Studio Modification Costs to SR';
        }
        field(152; sr_studiomodificationcoststosr_Base; Decimal)
        {
            ExternalName = 'sr_studiomodificationcoststosr_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Studio Modification Costs to SR in base currency.';
            Caption = 'Studio Modification Costs to SR (Base)';
        }
        field(153; sr_studiomodificationsecuritydeposittolicens; Decimal)
        {
            ExternalName = 'sr_studiomodificationsecuritydeposittolicens';
            ExternalType = 'Money';
            Description = 'Studio Modification Security Deposit to Licensee';
            Caption = 'Studio Modification Security Deposit to Licensee';
        }
        field(154; sr_studiomodificationsecuritydeposittolicens_Base; Decimal)
        {
            ExternalName = 'sr_studiomodificationsecuritydeposittolicens_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Studio Modification Security Deposit to Licensee in base currency.';
            Caption = 'Studio Modification Security Deposit to Licensee (Base)';
        }
        field(155; sr_pleasespecify; Decimal)
        {
            ExternalName = 'sr_pleasespecify';
            ExternalType = 'Money';
            Description = 'Please specify';
            Caption = 'Please specify';
        }
        field(156; sr_pleasespecify_Base; Decimal)
        {
            ExternalName = 'sr_pleasespecify_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Please specify in base currency.';
            Caption = 'Please specify (Base)';
        }
        field(157; sr_occupiedsincedate; Date)
        {
            ExternalName = 'sr_occupiedsincedate';
            ExternalType = 'DateTime';
            Description = 'Occupied Since Date';
            Caption = 'Occupied Since Date';
        }
        field(158; sr_terminateddate; Date)
        {
            ExternalName = 'sr_terminateddate';
            ExternalType = 'DateTime';
            Description = 'Terminated Date';
            Caption = 'Terminated Date';
        }
        field(159; sr_totalsecuritydeposit; Decimal)
        {
            ExternalName = 'sr_totalsecuritydeposit';
            ExternalType = 'Money';
            Description = 'Total Security Deposit';
            Caption = 'Total Security Deposit';
        }
        field(160; sr_totalsecuritydeposit_Base; Decimal)
        {
            ExternalName = 'sr_totalsecuritydeposit_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Security Deposit in base currency.';
            Caption = 'Total Security Deposit (Base)';
        }
        field(161; sr_securitydepositamount; Decimal)
        {
            ExternalName = 'sr_securitydepositamount';
            ExternalType = 'Money';
            Description = 'Security Deposit Amount';
            Caption = 'Security Deposit Amount';
        }
        field(162; sr_securitydepositamount_Base; Decimal)
        {
            ExternalName = 'sr_securitydepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Security Deposit Amount in base currency.';
            Caption = 'Security Deposit Amount (Base)';
        }
        field(163; sr_petdepositamount; Decimal)
        {
            ExternalName = 'sr_petdepositamount';
            ExternalType = 'Money';
            Description = 'Pet Deposit Amount';
            Caption = 'Pet Deposit Amount';
        }
        field(164; sr_petdepositamount_Base; Decimal)
        {
            ExternalName = 'sr_petdepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Pet Deposit Amount in base currency.';
            Caption = 'Pet Deposit Amount (Base)';
        }
        field(165; sr_stylingchairdepositamount; Decimal)
        {
            ExternalName = 'sr_stylingchairdepositamount';
            ExternalType = 'Money';
            Description = 'Styling Chair Deposit Amount';
            Caption = 'Styling Chair Deposit Amount';
        }
        field(166; sr_stylingchairdepositamount_Base; Decimal)
        {
            ExternalName = 'sr_stylingchairdepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Styling Chair Deposit Amount in base currency.';
            Caption = 'Styling Chair Deposit Amount (Base)';
        }
        field(167; sr_constructionmodificationdepositamount; Decimal)
        {
            ExternalName = 'sr_constructionmodificationdepositamount';
            ExternalType = 'Money';
            Description = 'Construction/Modification Deposit Amount';
            Caption = 'Construction/Modification Deposit Amount';
        }
        field(168; sr_constructionmodificationdepositamount_Base; Decimal)
        {
            ExternalName = 'sr_constructionmodificationdepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Construction/Modification Deposit Amount in base currency.';
            Caption = 'Construction/Modification Deposit Amount (Base)';
        }
        field(171; sr_paintwallpaperdepositamount; Decimal)
        {
            ExternalName = 'sr_paintwallpaperdepositamount';
            ExternalType = 'Money';
            Description = 'Paint/Wallpaper Deposit Amount';
            Caption = 'Paint/Wallpaper Deposit Amount';
        }
        field(172; sr_paintwallpaperdepositamount_Base; Decimal)
        {
            ExternalName = 'sr_paintwallpaperdepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Paint/Wallpaper Deposit Amount in base currency.';
            Caption = 'Paint/Wallpaper Deposit Amount (Base)';
        }
        field(173; sr_docusignintegrationstatus_la; Option)
        {
            ExternalName = 'sr_docusignintegrationstatus_la';
            ExternalType = 'Picklist';
            Description = 'Docusign Integration Status LA';
            Caption = 'Agreement Status';
            InitValue = Draft;
            //SRBC-375 Start
            //OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            OptionOrdinalValues = 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011, 468690012, 468690013, 468690014, 468690015, 468690016, 468690017;
            //SRBC-375 End
        }
        field(175; sr_docusignintegrationstatus_transfer; Option)
        {
            ExternalName = 'sr_docusignintegrationstatus_transfer';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Docusign Integration Status Transfer';
            InitValue = Draft;
            //SRBC-375 Start
            //OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            OptionOrdinalValues = 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011, 468690012, 468690013, 468690014, 468690015, 468690016, 468690017;
            //SRBC-375 End
        }
        field(177; sr_docusigntemplatetype; Option)//Not available in BC Table
        {
            ExternalName = 'sr_docusigntemplatetype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Document Template Type';
            InitValue = " ";
            //SRBC-375 Start
            // OptionMembers = " ","DocuSignHoldDeposit-InPreson" - Old
            // " ","DocuSignHoldDeposit-InPerson"
            OptionMembers = " ","DocuSignHoldDeposit-InPerson","DocuSignHoldDeposit-Remote","DocuSign-Resend","DocuSignLA-InPerson","DocuSignLA-Remote","DocusignHoldDepositTransfer-InPerson","DocusignHoldDepositTransfer-Remote",DocusignACH,"MoveOutHDA-InPerson","MoveOutHDA-Remote","AddStudioHDA-InPerson","AddStudioHDA-Remote","RenewalLA-InPerson","RenewalLA-Remote","PaymentPlan-Remote","ConstructionAgreement-Remote";
            //SRBC-375 End
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690000, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008;
        }
        field(180; sr_quantityofmonths; Option)
        {
            ExternalName = 'sr_quantityofmonths';
            ExternalType = 'Picklist';
            Description = 'Quantity of Months';
            Caption = 'Quantity of Months';
            InitValue = " ";
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100";
            OptionOrdinalValues = -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100;
        }
        //field(182; sr_Studio; Text[2000]//SRBC-375
        field(182; sr_Studio; Text[2048])//SRBC-375
        {
            ExternalName = 'sr_studio';
            ExternalType = 'String';
            Description = '';
            Caption = 'Studio';
        }
        field(183; sr_transferredstudio; Text[2048])//SRBC-375 Not available in BC Table //Not found in Map 
        {
            ExternalName = 'sr_transferredstudio';
            ExternalType = 'String';
            Description = '';
            Caption = 'Transferred Studio #';
        }
        field(184; sr_newdepositamount; Decimal)
        {
            ExternalName = 'sr_newdepositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'New Deposit Amount $';
        }
        field(185; sr_newdepositamount_Base; Decimal)
        {
            ExternalName = 'sr_newdepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the New Deposit Amount $ in base currency.';
            Caption = 'New Deposit Amount $ (Base)';
        }
        field(186; sr_holddepositstudio; Text[2048])//SRBC-375 //Not available in BC Table //Not maped in BC
        {
            ExternalName = 'sr_holddepositstudio';
            ExternalType = 'String';
            Description = 'Copied from the Prospect';
            Caption = 'Studio #[Hold Deposit]';
        }
        field(187; sr_holddepositamount; Decimal)
        {
            ExternalName = 'sr_holddepositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Hold Deposit Amount';
        }
        field(188; sr_holddepositamount_Base; Decimal)
        {
            ExternalName = 'sr_holddepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Hold Deposit Amount in base currency.';
            Caption = 'Hold Deposit Amount (Base)';
        }
        field(189; sr_holddeposittransferrequested; Boolean)
        {
            ExternalName = 'sr_holddeposittransferrequested';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Hold Deposit Transfer Requested';
        }
        field(191; sr_docusign_voidlatime; Datetime)
        {
            ExternalName = 'sr_docusign_voidlatime';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Docusign Void LA Time';
        }
        field(192; sr_achdocusignintegrationstatus; Option)
        {
            ExternalName = 'sr_achdocusignintegrationstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'ACH Docusign Integration Status';
            InitValue = " ";
            //SRBC-375 Start
            //OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011, 468690012, 468690013, 468690014, 468690015, 468690016, 468690017;
            //SRBC-375 End
        }
        field(194; sr_achagreementenvelopid; Text[1000])
        {
            ExternalName = 'sr_achagreementenvelopid';
            ExternalType = 'String';
            Description = '';
            Caption = 'ACH Agreement Envelop Id';
        }
        field(195; sr_achagreementlinksenton; Datetime)
        {
            ExternalName = 'sr_achagreementlinksenton';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'ACH Agreement Link Sent On';
        }
        field(196; sr_achisagreementlinksent; Boolean)
        {
            ExternalName = 'sr_achisagreementlinksent';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'ACH is Agreement Link Sent';
        }
        field(198; sr_achlicenseebank; Text[100])
        {
            ExternalName = 'sr_achlicenseebank';
            ExternalType = 'String';
            Description = '';
            Caption = 'ACH Licensee_Bank';
        }
        field(199; sr_achlicenseeachbankaddress; Text[100])
        {
            ExternalName = 'sr_achlicenseeachbankaddress';
            ExternalType = 'String';
            Description = '';
            Caption = 'ACH Licensee_ACH_Bank_Address';
        }
        field(200; sr_achlicenseebankaccount; Text[100])
        {
            ExternalName = 'sr_achlicenseebankaccount';
            ExternalType = 'String';
            Description = '';
            Caption = 'ACH Licensee_Bank_Account';
        }
        field(201; sr_achlicenseessn; Text[100])
        {
            ExternalName = 'sr_achlicenseessn';
            ExternalType = 'String';
            Description = '';
            Caption = 'ACH Licensee_SSN';
        }
        field(202; sr_achlicenseerouting; Text[100])
        {
            ExternalName = 'sr_achlicenseerouting';
            ExternalType = 'String';
            Description = '';
            Caption = 'ACH Licensee_Routing';
        }
        //field(203; sr_Licensee; Text[2000])
        field(203; sr_Licensee; Text[2048])//SRBC-375
        {
            ExternalName = 'sr_licensee';
            ExternalType = 'String';
            Description = '';
            Caption = 'Licensee';
        }
        field(208; sr_StartDate; Date)
        {
            ExternalName = 'sr_startdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Start Date';
        }
        field(209; sr_EndDate; Date)
        {
            ExternalName = 'sr_enddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'End Date';
        }
        field(222; sr_terminationnoticereceived; Boolean)
        {
            ExternalName = 'sr_terminationnoticereceived';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Termination Notice Received';
        }
        field(226; sr_licenseeresponse; BLOB)
        {
            ExternalName = 'sr_licenseeresponse';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Licensee Response';
            Subtype = Memo;
        }
        field(227; sr_anticipatedmoveoutdate; Date)
        {
            ExternalName = 'sr_anticipatedmoveoutdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Anticipated Move Out Date';
        }
        field(228; sr_noticeofnonrenewalgivendate; Date)
        {
            ExternalName = 'sr_noticeofnonrenewalgivendate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Notice of Non-Renewal Given Date';
        }
        field(230; sr_premoveoutinspection; Date)
        {
            ExternalName = 'sr_premoveoutinspection';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Pre Move-Out Inspection';
        }
        field(231; sr_premoveoutinspectioncompleted; Boolean)
        {
            ExternalName = 'sr_premoveoutinspectioncompleted';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Pre Move-Out Inspection Completed';
        }
        field(233; sr_postmoveoutinspection; Date)
        {
            ExternalName = 'sr_postmoveoutinspection';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Post Move-Out Inspection';
        }
        field(234; sr_postmoveoutinspectioncompleted; Boolean)
        {
            ExternalName = 'sr_postmoveoutinspectioncompleted';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Post Move-Out Inspection Completed';
        }
        field(236; sr_TestLookup; Text[2048])
        {
            ExternalName = 'sr_testlookup';
            ExternalType = 'String';
            Description = '';
            Caption = 'Test Lookup';
        }
        field(239; sr_datekeywasreturned; Date)
        {
            ExternalName = 'sr_datekeywasreturned';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Date Key Was Returned';
        }
        field(240; sr_resetcompleted; Boolean)
        {
            ExternalName = 'sr_resetcompleted';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Reset Completed?';
        }
        field(242; sr_didlicenseereturnkey; Option)
        {
            ExternalName = 'sr_didlicenseereturnkey';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Did Licensee Return Key';
            InitValue = " ";
            OptionMembers = " ",No,Yes;
            OptionOrdinalValues = -1, 468690000, 468690001;
        }
        field(244; sr_noticeofnonrenewalexpirationdate; Date)
        {
            ExternalName = 'sr_noticeofnonrenewalexpirationdate';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Notice Of Non-renewal Expiration Date';
        }
        field(245; sr_deposit; Option)
        {
            ExternalName = 'sr_deposit';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Deposit';
            InitValue = " ";
            OptionMembers = " ",Refund,Forfeit;
            OptionOrdinalValues = -1, 468690000, 468690001;
        }
        field(251; sr_licenseeselectionmonthtomonth; Boolean)
        {
            ExternalName = 'sr_licenseeselectionmonthtomonth';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Licensee Selection (Month-to-Month)';
        }
        field(253; sr_licenseeselectionannual; Boolean)
        {
            ExternalName = 'sr_licenseeselectionannual';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Licensee Selection (Annual)';
        }
        field(255; sr_licenseeselection6month; Boolean)
        {
            ExternalName = 'sr_licenseeselection6month';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Licensee Selection (6 Months)';
        }
        field(257; sr_licenseeselectionmultiyear; Boolean)
        {
            ExternalName = 'sr_licenseeselectionmultiyear';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Licensee Selection (Multi-Year)';
        }
        field(259; sr_licenseeselectionstaggered; Boolean)
        {
            ExternalName = 'sr_licenseeselectionstaggered';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Licensee Selection (Staggered Rent Term)';
        }
        field(261; sr_LastDocusignLAResendTime; Datetime)
        {
            ExternalName = 'sr_lastdocusignlaresendtime';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Last Docusign LA Resend Time';
        }
        field(262; sr_noticeofreceiptconfirmed; Boolean)
        {
            ExternalName = 'sr_noticeofreceiptconfirmed';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Notice of Receipt Confirmed';
        }
        field(264; sr_Quicklinktoagreementtoinfoid; GUID)
        {
            ExternalName = 'sr_quicklinktoagreementtoinfoid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier for Studio Occupant associated with Agreement.';
            Caption = 'Quick link to agreement info/ledger';
            //TableRelation = "CDS sr_studiooccupant".sr_studiooccupantId;
        }
        field(266; sr_nameoflicensee; Text[100])
        {
            ExternalName = 'sr_nameoflicensee';
            ExternalType = 'String';
            Description = '';
            Caption = 'Licensee Name';
        }
        field(267; sr_LAEnvelopID; Text[100])
        {
            ExternalName = 'sr_laenvelopid';
            ExternalType = 'String';
            Description = '';
            Caption = 'LA Envelop ID';
        }
        field(268; sr_qtyofmonths; Decimal)
        {
            ExternalName = 'sr_qtyofmonths';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Qty Of Months';
        }
        field(269; sr_newrentratemonthtomonth; Decimal)
        {
            ExternalName = 'sr_newrentratemonthtomonth';
            ExternalType = 'Money';
            Description = 'New Rent Rate (Month to month)';
            Caption = 'New Rent Rate';
        }
        field(270; sr_newrentratemonthtomonth_Base; Decimal)
        {
            ExternalName = 'sr_newrentratemonthtomonth_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the New Rent Rate in base currency.';
            Caption = 'New Rent Rate (Base)';
        }
        field(271; sr_rentincreaseamount_monthtomonth; Decimal)
        {
            ExternalName = 'sr_rentincreaseamount_monthtomonth';
            ExternalType = 'Money';
            Description = 'Rent Increase Amount (Month to month)';
            Caption = 'Rent Increase Amount';
        }
        field(272; sr_rentincreaseamount_monthtomonth_Base; Decimal)
        {
            ExternalName = 'sr_rentincreaseamount_monthtomonth_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Increase Amount in base currency.';
            Caption = 'Rent Increase Amount (Base)';
        }
        field(275; sr_newrentrateannual; Decimal)
        {
            ExternalName = 'sr_newrentrateannual';
            ExternalType = 'Money';
            Description = 'New Rent Rate (Annual)';
            Caption = 'New Rent Rate';
        }
        field(276; sr_newrentrateannual_Base; Decimal)
        {
            ExternalName = 'sr_newrentrateannual_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the New Rent Rate in base currency.';
            Caption = 'New Rent Rate (Base)';
        }
        field(277; sr_newrentrate6month; Decimal)
        {
            ExternalName = 'sr_newrentrate6month';
            ExternalType = 'Money';
            Description = '';
            Caption = 'New Rent Rate';
        }
        field(278; sr_newrentrate6month_Base; Decimal)
        {
            ExternalName = 'sr_newrentrate6month_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the New Rent Rate in base currency.';
            Caption = 'New Rent Rate (Base)';
        }
        field(279; sr_rentincreaseamount_annual; Decimal)
        {
            ExternalName = 'sr_rentincreaseamount_annual';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Rent Increase Amount';
        }
        field(280; sr_rentincreaseamount_annual_Base; Decimal)
        {
            ExternalName = 'sr_rentincreaseamount_annual_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Increase Amount in base currency.';
            Caption = 'Rent Increase Amount (Base)';
        }
        field(281; sr_rentincreaseamount_6month; Decimal)
        {
            ExternalName = 'sr_rentincreaseamount_6month';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Rent Increase Amount';
        }
        field(282; sr_rentincreaseamount_6month_Base; Decimal)
        {
            ExternalName = 'sr_rentincreaseamount_6month_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Rent Increase Amount in base currency.';
            Caption = 'Rent Increase Amount (Base)';
        }
        field(288; sr_withdrawalaccepted; Option)
        {
            ExternalName = 'sr_withdrawalaccepted';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Withdrawal Accepted?';
            InitValue = " ";
            OptionMembers = " ",No,Yes;
            OptionOrdinalValues = -1, 468690000, 468690001;
        }
        field(290; sr_licenseewithdrew; Option)
        {
            ExternalName = 'sr_licenseewithdrew';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Licensee Withdrew?';
            InitValue = " ";
            OptionMembers = " ",No,Yes;
            OptionOrdinalValues = -1, 468690000, 468690001;
        }
        field(292; sr_rentincreasepercentage_monthtomonth; Decimal)
        {
            ExternalName = 'sr_rentincreasepercentage_monthtomonth';
            ExternalType = 'Decimal';
            Description = 'Rent Increase % (Month to month)';
            Caption = 'Rent Increase %';
        }
        field(293; sr_rentincreasepercentage_annual; Decimal)
        {
            ExternalName = 'sr_rentincreasepercentage_annual';
            ExternalType = 'Decimal';
            Description = 'Rent increase % (Annual)';
            Caption = 'Rent Increase %';
        }
        field(294; sr_rentincreasepercentage_6month; Decimal)
        {
            ExternalName = 'sr_rentincreasepercentage_6month';
            ExternalType = 'Decimal';
            Description = 'Rent increase % (6 month)';
            Caption = 'Rent Increase %';
        }
        field(297; sr_RenewalLAStatus; Option)
        {
            ExternalName = 'sr_renewallastatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Renewal LA Status';
            InitValue = Draft;
            //SRBC-375 Start
            //OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            OptionOrdinalValues = 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011, 468690012, 468690013, 468690014, 468690015, 468690016, 468690017;
            //SRBC-375 End
        }
        field(299; sr_RenewalDocumentType; Option)//Not available in BC Table
        {
            ExternalName = 'sr_renewaldocumenttype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Renewal Document Type';
            InitValue = " ";
            //SRBC-375 Start
            OptionMembers = " ","DocuSignHoldDeposit-InPerson","DocuSignHoldDeposit-Remote","DocuSign-Resend","DocuSignLA-InPerson","DocuSignLA-Remote","DocusignHoldDepositTransfer-InPerson","DocusignHoldDepositTransfer-Remote",DocusignACH,"MoveOutHDA-InPerson","MoveOutHDA-Remote","AddStudioHDA-InPerson","AddStudioHDA-Remote","RenewalLA-InPerson","RenewalLA-Remote","PaymentPlan-Remote","ConstructionAgreement-Remote";
            //SRBC-375 End
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690000, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008;
        }
        field(301; sr_RenewalResendTime; Datetime)
        {
            ExternalName = 'sr_renewalresendtime';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Renewal Resend Time';
        }
        field(302; sr_RenewalEnvelope; Text[100])
        {
            ExternalName = 'sr_renewalenvelope';
            ExternalType = 'String';
            Description = '';
            Caption = 'Renewal Envelope ID';
        }
        field(307; sr_CurrentDate; Date)
        {
            ExternalName = 'sr_currentdate';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Current Date';
        }
        field(308; sr_DocumentGeneratingUser; GUID)
        {
            ExternalName = 'sr_documentgeneratinguser';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Document Generating User';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(311; sr_weeklyadditionalpaymentamount; Decimal)
        {
            ExternalName = 'sr_weeklyadditionalpaymentamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Weekly Additional Payment Amount:';
        }
        field(312; sr_weeklyadditionalpaymentamount_Base; Decimal)
        {
            ExternalName = 'sr_weeklyadditionalpaymentamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Weekly Additional Payment Amount: in base currency.';
            Caption = 'Weekly Additional Payment Amount: (Base)';
        }
        field(313; sr_planstartdate; Date)
        {
            ExternalName = 'sr_planstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Plan Start Date';
        }
        field(314; sr_estimatedplancompletiondate; Date)
        {
            ExternalName = 'sr_estimatedplancompletiondate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Estimated Plan Completion Date';
        }
        field(315; sr_totalweeklypaymentplan; Decimal)
        {
            ExternalName = 'sr_totalweeklypaymentplan';
            ExternalType = 'Money';
            Description = '';
            Caption = 'TOTAL Weekly Payment Plan';
        }
        field(316; sr_totalweeklypaymentplan_Base; Decimal)
        {
            ExternalName = 'sr_totalweeklypaymentplan_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the TOTAL Weekly Payment Plan in base currency.';
            Caption = 'TOTAL Weekly Payment Plan (Base)';
        }
        field(317; sr_Renewal_LA_Status; Option)//BC field -  field(201; sr_RenewalLAStatus; Option)
        {
            ExternalName = 'sr_renewal_la_status';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Old Renewal_LA_Status';
            InitValue = " ";
            //SRBC-375 Start
            //OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011, 468690012, 468690013, 468690014, 468690015, 468690016, 468690017;
            //SRBC-375 End
        }
        field(319; sr_renewalinfosubmitted; Boolean)
        {
            ExternalName = 'sr_renewalinfosubmitted';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'RenewalInfoSubmitted';
        }
        field(321; sr_PaymentPlanLicensee; GUID)
        {
            ExternalName = 'sr_paymentplanlicensee';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Payment Plan Licensee';
            TableRelation = "CRM Contact".ContactId;
        }
        field(326; sr_PaymentPlanStatus; Option)
        {
            ExternalName = 'sr_paymentplanstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Payment Plan Status';
            InitValue = " ";
            //SRBC-375 Start
            //OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011, 468690012, 468690013, 468690014, 468690015, 468690016, 468690017;
            //SRBC-375 End
        }
        field(328; sr_BCAccountNo; Text[20])
        {
            ExternalName = 'sr_bcaccountno';
            ExternalType = 'String';
            Description = '';
            Caption = 'BC Account No';
        }
        field(329; sr_PaymentPlanEnvelopeID; Text[100])
        {
            ExternalName = 'sr_paymentplanenvelopeid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Envelope ID';
        }
        field(330; sr_remainingamount; Decimal)
        {
            ExternalName = 'sr_remainingamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Balance';
        }
        field(331; sr_remainingamount_Base; Decimal)
        {
            ExternalName = 'sr_remainingamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Balance in base currency.';
            Caption = 'Balance (Base)';
        }
        field(332; sr_licensee_name; Text[100])
        {
            ExternalName = 'sr_licensee_name';
            ExternalType = 'String';
            Description = '';
            Caption = 'Licensee Name';
        }
        field(333; sr_studio_name; Text[100])
        {
            ExternalName = 'sr_studio_name';
            ExternalType = 'String';
            Description = '';
            Caption = 'Studio Name';
        }
        field(334; sr_LatestBalanceAccountLedger; Decimal)
        {
            ExternalName = 'sr_latestbalanceaccountledger';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Balance Owing';
        }
        field(335; sr_latestbalanceaccountledger_Base; Decimal)
        {
            ExternalName = 'sr_latestbalanceaccountledger_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Latest Balance Account Ledger in base currency.';
            Caption = 'Latest Balance Account Ledger (Base)';
        }
        field(337; sr_DueDateCurrentDate1; Date)
        {
            ExternalName = 'sr_duedatecurrentdate1';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Due Date (Current Date + 1)';
        }
        field(343; new_BalanceDue; Decimal)
        {
            ExternalName = 'new_balancedue';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'BalanceDue';
        }
        field(344; new_balancedue_Base; Decimal)
        {
            ExternalName = 'new_balancedue_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the BalanceDue in base currency.';
            Caption = 'BalanceDue (Base)';
        }
        field(345; new_BalanceDue_Date; Datetime)
        {
            ExternalName = 'new_balancedue_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field BalanceDue.';
            Caption = 'BalanceDue (Last Updated On)';
        }
        field(346; new_BalanceDue_State; Integer)
        {
            ExternalName = 'new_balancedue_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field BalanceDue.';
            Caption = 'BalanceDue (State)';
        }
        field(347; sr_StudioCombinationStatus; Option)
        {
            ExternalName = 'sr_studiocombinationstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Status';
            InitValue = " ";
            //SRBC-375 Start
            //OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed;
            OptionMembers = " ",Draft,ReadyToSend,ReadyToReSend,PendingSend,Sent,ErrorWhileSending,Completed,Voided,Delete,Decline,Resend,Sent1,PendingWith,Signed,Declined,Opened,DeliveryFailed,Removed,Corrected,PaymentFailed,"SMSEnvelopeDeliveryDeclined/Rejected",RecipientFinishLater,RecipientResent,RecipientDecline;
            OptionOrdinalValues = -1, 874900000, 874900001, 874900002, 874900003, 874900004, 874900005, 874900006, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007, 468690008, 468690009, 468690010, 468690011, 468690012, 468690013, 468690014, 468690015, 468690016, 468690017;
            //SRBC-375 End
        }
        field(349; sr_StudioCombinationEnvelopID; Text[100])
        {
            ExternalName = 'sr_studiocombinationenvelopid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Envelop ID';
        }
        field(350; sr_TransferringtoStudio; Text[100])
        {
            ExternalName = 'sr_transferringtostudio';
            ExternalType = 'String';
            Description = '';
            Caption = 'Transferring to Studio#';
        }
        field(351; sr_DepositAmountforStudiotransferringto; Decimal)
        {
            ExternalName = 'sr_depositamountforstudiotransferringto';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Deposit Amount for Studio transferring to';
        }
        field(352; sr_depositamountforstudiotransferringto_Base; Decimal)
        {
            ExternalName = 'sr_depositamountforstudiotransferringto_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Deposit Amount for Studio transferring to in base currency.';
            Caption = 'Deposit Amount for Studio transferring to (Base)';
        }
        field(353; sr_AdditionalSecurityDepositAmountrequired; Decimal)
        {
            ExternalName = 'sr_additionalsecuritydepositamountrequired';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Additional Security Deposit Amount required';
        }
        field(354; sr_additionalsecuritydepositamountrequired_Base; Decimal)
        {
            ExternalName = 'sr_additionalsecuritydepositamountrequired_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Additional Security Deposit Amount required in base currency.';
            Caption = 'Additional Security Deposit Amount required (Base)';
        }
        field(355; sr_dmcreatedon; Date)
        {
            ExternalName = 'sr_dmcreatedon';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'dmcreatedon';
        }
        field(356; sr_dmmodifiedon; Date)
        {
            ExternalName = 'sr_dmmodifiedon';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'dmmodifiedon';
        }
        field(357; sr_oldowner; Text[500])
        {
            ExternalName = 'sr_oldowner';
            ExternalType = 'String';
            Description = '';
            Caption = 'Old Owner';
        }
        field(358; sr_uniquekey; Text[500])
        {
            ExternalName = 'sr_uniquekey';
            ExternalType = 'String';
            Description = '';
            Caption = 'Unique Key';
        }
        field(359; sr_RenewalQuantityOfMonths; Option)
        {
            ExternalName = 'sr_renewalquantityofmonths';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Renewal Quantity Of Months';
            InitValue = " ";
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100";
            OptionOrdinalValues = -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100;
        }
        field(361; sr_RenewalNewStartDate; Date)
        {
            ExternalName = 'sr_renewalnewstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Renewal New Start Date';
        }
        field(362; sr_RenewalNewEndDate; Date)
        {
            ExternalName = 'sr_renewalnewenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Renewal New End Date';
        }
        field(363; sr_RenewalNewSecurityDepositAmount; Decimal)
        {
            ExternalName = 'sr_renewalnewsecuritydepositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Renewal New Security Deposit Amount';
        }
        field(364; sr_renewalnewsecuritydepositamount_Base; Decimal)
        {
            ExternalName = 'sr_renewalnewsecuritydepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Renewal New Security Deposit Amount in base currency.';
            Caption = 'Renewal New Security Deposit Amount (Base)';
        }
        field(369; sr_paymenttypecode; Text[2000])
        {
            ExternalName = 'sr_paymenttypecode';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payments';
        }
        field(370; sr_chargetypecode; Text[2000])
        {
            ExternalName = 'sr_chargetypecode';
            ExternalType = 'String';
            Description = '';
            Caption = 'Charge';
        }
        field(371; sr_LicenseeFilter; Text[2000])
        {
            ExternalName = 'sr_licenseefilter';
            ExternalType = 'String';
            Description = '';
            Caption = 'Licensee Filter ';
        }
        field(372; sr_NewAgreement; GUID)
        {
            ExternalName = 'sr_newagreement';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'New Agreement';
            TableRelation = "CDS sr_agreement".sr_agreementId;
        }
        //SRBC-375 Start New added
        // field(373; sr_NewAgreementName; Text[850])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("CDS sr_agreement".sr_name where(sr_agreementId = field(sr_NewAgreement)));
        //     ExternalName = 'sr_newagreementname';
        //     ExternalType = 'String';
        //     ExternalAccess = Read;
        // }
        //SRBC-375 End
        field(374; sr_AdditionalSecurityDepositAmount; Decimal)
        {
            ExternalName = 'sr_additionalsecuritydepositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Additional Security Deposit Amount';
        }
        field(375; sr_additionalsecuritydepositamount_Base; Decimal)
        {
            ExternalName = 'sr_additionalsecuritydepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Additional Security Deposit Amount in base currency.';
            Caption = 'Additional Security Deposit Amount (Base)';
        }
        field(376; sr_LASecurityDepositAmount; Decimal)
        {
            ExternalName = 'sr_lasecuritydepositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'LA Security Deposit Amount';
        }
        field(377; sr_lasecuritydepositamount_Base; Decimal)
        {
            ExternalName = 'sr_lasecuritydepositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the LA Security Deposit Amount in base currency.';
            Caption = 'LA Security Deposit Amount (Base)';
        }
        field(378; sr_StudiosText; Text[500])
        {
            ExternalName = 'sr_studiostext';
            ExternalType = 'String';
            Description = 'Capture the studio numbers comma separated';
            Caption = 'Studio #';
        }
        field(379; sr_TransferEnvelopID; Text[100])
        {
            ExternalName = 'sr_transferenvelopid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Transfer Envelop ID';
        }
        field(382; sr_noticeactionresponse; BLOB)
        {
            ExternalName = 'sr_noticeactionresponse';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Notice Action Response';
            Subtype = Memo;
        }
        field(383; sr_noticeactionstatus; Option)
        {
            ExternalName = 'sr_noticeactionstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Notice Action Status';
            InitValue = " ";
            OptionMembers = " ",Approved,Rejected;
            OptionOrdinalValues = -1, 468690000, 468690001;
        }
        field(385; sr_noticeactiontype; Option)
        {
            ExternalName = 'sr_noticeactiontype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Notice Action Type';
            InitValue = " ";
            OptionMembers = " ","3-DayPayNotice","48-HourNotice",FinalNotice;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002;
        }
        field(387; sr_defaultagreementtermoption; Text[2048])
        {
            ExternalName = 'sr_defaultagreementtermoption';
            ExternalType = 'String';
            Description = '';
            Caption = 'Default Agreement Term Option';
        }
        field(390; sr_PaymentPlanrequested; Boolean)
        {
            ExternalName = 'sr_paymentplanrequested';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Payment Plan requested';
        }
        //SRBC-375 Start Added new field
        field(392; sr_BalanceSyncNow; Boolean)
        {
            ExternalName = 'sr_balancesyncnow';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Balance Sync Now?';
        }
        field(395; sr_AccountLedgerSyncNow; Boolean)
        {
            ExternalName = 'sr_accountledgersyncnow';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Account Ledger Sync Now?';
        }
        field(398; sr_TransactionProcessingStatus; Text[100])
        {
            ExternalName = 'sr_transactionprocessingstatus';
            ExternalType = 'String';
            Description = '';
            Caption = 'Transaction Processing Status';
        }
        field(403; sr_AgreementBalance; Decimal)
        {
            ExternalName = 'sr_agreementbalance';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Agreement Balance';
        }
        field(404; sr_agreementbalance_Base; Decimal)
        {
            ExternalName = 'sr_agreementbalance_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Agreement Balance in base currency.';
            Caption = 'Agreement Balance (Base)';
        }
        field(405; sr_AgreementBalance_Date; Datetime)
        {
            ExternalName = 'sr_agreementbalance_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Agreement Balance.';
            Caption = 'Agreement Balance (Last Updated On)';
        }
        field(406; sr_AgreementBalance_State; Integer)
        {
            ExternalName = 'sr_agreementbalance_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Agreement Balance.';
            Caption = 'Agreement Balance (State)';
        }
        field(407; sr_mon_poc_balance; Decimal)
        {
            ExternalName = 'sr_mon_poc_balance';
            ExternalType = 'Money';
            Description = '';
            Caption = 'POC Balance';
        }
        field(408; sr_mon_poc_balance_Base; Decimal)
        {
            ExternalName = 'sr_mon_poc_balance_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the POC Balance in base currency.';
            Caption = 'POC Balance (Base)';
        }
        field(409; sr_BalanceAPI; Decimal)
        {
            ExternalName = 'sr_balanceapi';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Balance (API)';
        }
        field(410; sr_balanceapi_Base; Decimal)
        {
            ExternalName = 'sr_balanceapi_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Balance (API) in base currency.';
            Caption = 'Balance (API) (Base)';
        }
        field(411; sr_RenewalStatus; Option)
        {
            ExternalName = 'sr_renewalstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Renewal Status';
            InitValue = " ";
            OptionMembers = " ",AwaitingLicenseeResponse,ReceivedLicenseeResponse,ManualRenewalTriggered;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002;
        }
        field(413; sr_RenewalType; Option)
        {
            ExternalName = 'sr_renewaltype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Renewal Type';
            InitValue = ViaLicenseePortal;
            OptionMembers = ViaLicenseePortal,ManualRenewal;
            OptionOrdinalValues = 468690000, 468690001;
        }
        field(415; sr_UpdateAgreementNameTrigger; Text[100])
        {
            ExternalName = 'sr_updateagreementnametrigger';
            ExternalType = 'String';
            Description = 'Do Not Modify/Delete.. Used for backend plugin to trigger agreeement update logic';
            Caption = '[Do Not Use]Update Agreement  Name Trigger';
        }
        //SRBC-375 End
    }
    keys
    {
        key(PK; sr_agreementId)
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