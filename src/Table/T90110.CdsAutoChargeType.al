//SRBC-473 SY 16062026 Added options-CreditMemo,Adjustment,Refund,PaymentFor in field-sr_TransactionType 
table 90110 "CDS sr_autochargetype"
{
    ExternalName = 'sr_autochargetype';
    TableType = CDS;
    Description = 'Charge Type';

    fields
    {
        field(1; sr_autochargetypeId; GUID)
        {
            ExternalName = 'sr_autochargetypeid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Auto Charge Type';
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
            Description = 'Status of the Auto Charge Type';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Auto Charge Type';
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
        field(34; sr_autochargecode; Text[100])
        {
            ExternalName = 'sr_autochargecode';
            ExternalType = 'String';
            Description = 'The name of the custom entity.';
            Caption = 'Auto Charge Code';
        }
        field(35; sr_description; Text[500])
        {
            ExternalName = 'sr_description';
            ExternalType = 'String';
            Description = 'Description';
            Caption = 'Description';
        }
        field(36; sr_TransactionType; Option)
        {
            ExternalName = 'sr_transactiontype';
            ExternalType = 'Picklist';
            Description = 'Transaction Type';
            Caption = 'Transaction Type';
            InitValue = " ";
            //SRBC-473 16062026 Start
            // OptionMembers = " ",Charge,Payment,Discount,ReturnedPayment,ReturnedFee;
            // OptionOrdinalValues = -1, 742440000, 742440001, 742440002, 742440003, 742440004;
            OptionMembers = " ",Charge,Payment,Discount,ReturnedPayment,ReturnedFee,CreditMemo,Adjustment,Refund,PaymentFor;
            OptionOrdinalValues = -1, 742440000, 742440001, 742440002, 742440003, 742440004, 742440005, 742440006, 742440007, 742440008;
            //SRBC-473 16062026 End
        }
        field(38; sr_LinkedGLAccount; Text[100])
        {
            ExternalName = 'sr_linkedglaccount';
            ExternalType = 'String';
            Description = '';
            Caption = 'Linked G/L Account';
        }
        field(39; sr_ChargesCategory; Option)
        {
            ExternalName = 'sr_chargescategory';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Charges Category';
            InitValue = " ";
            OptionMembers = " ",Bank,AR,SecurityDeposit,Refunds,Charge,Discount,RepairCharge,ResetCharge;
            OptionOrdinalValues = -1, 468690000, 468690001, 468690002, 468690003, 468690004, 468690005, 468690006, 468690007;
        }
    }
    keys
    {
        key(PK; sr_autochargetypeId)
        {
            Clustered = true;
        }
        key(Name; sr_autochargecode)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; sr_autochargecode)
        {
        }
    }
}