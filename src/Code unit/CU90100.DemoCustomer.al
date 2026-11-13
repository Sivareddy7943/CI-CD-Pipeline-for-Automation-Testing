
codeunit 90100 "Top Ten Customer Import"
{
    procedure ImportExcelToJson()
    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        CustomerRec: Record "Top Ten Customers";
        TempBlob: Codeunit "Temp Blob";
        ExcelStream: InStream;
        JsonStream: InStream;
        JsonOutStream: OutStream;
        JsonArr: JsonArray;
        JsonObj: JsonObject;
        FileName: Text;
        JsonFileName: Text;
        SheetName: Text;
        ErrorText: Text;
        JsonText: Text;
        RowNo: Integer;
        MaxRowNo: Integer;
        EntryNo: Integer;
        ImportedCount: Integer;
        UpdatedCount: Integer;
        CustomerNo: Text;
    begin
        if not UploadIntoStream(
            'Select Customer Excel File',
            '',
            'Excel Files (*.xlsx)|*.xlsx',
            FileName,
            ExcelStream)
        then
            exit;
        SheetName :=
            ExcelBuffer.SelectSheetsNameStream(
                ExcelStream);
        ExcelBuffer.Reset();
        ExcelBuffer.DeleteAll();
        ErrorText :=
            ExcelBuffer.OpenBookStream(
                ExcelStream, SheetName);

        if ErrorText <> '' then
            Error('%1', ErrorText);

        ExcelBuffer.ReadSheet();
        ExcelBuffer.CloseBook();

        ExcelBuffer.Reset();
        if not ExcelBuffer.FindLast() then
            Error('Excel file is empty.');
        MaxRowNo := ExcelBuffer."Row No.";
        ValidateCustomerCount(ExcelBuffer, MaxRowNo);
        for RowNo := 2 to MaxRowNo do begin
            CustomerNo :=
                GetCellValue(
                    ExcelBuffer, RowNo, 2);
            if CustomerNo <> '' then begin
                ValidateCustomerNo(CustomerNo);
                if not Evaluate(
                    EntryNo,
                    GetCellValue(
                        ExcelBuffer, RowNo, 1))
                then
                    Error(
                        'Invalid Entry No. at row %1',
                        RowNo);
                if not Evaluate(
                    EntryNo,
                    GetCellValue(
                        ExcelBuffer, RowNo, 1))
                then
                    Error(
                        'Invalid Entry No. at row %1',
                        RowNo);

                if EntryNo <= 0 then
                    Error(
                        'Entry No. must be greater than 0 at row %1',
                        RowNo);
                Clear(JsonObj);
                JsonObj.Add(
                    'EntryNo', EntryNo);
                JsonObj.Add(
                    'No', CustomerNo);
                JsonObj.Add(
                    'Name',
                    GetCellValue(
                        ExcelBuffer, RowNo, 3));
                JsonObj.Add(
                    'Address',
                    GetCellValue(
                        ExcelBuffer, RowNo, 4));
                JsonObj.Add(
                    'City',
                    GetCellValue(
                        ExcelBuffer, RowNo, 5));
                JsonObj.Add(
                    'Country',
                    GetCellValue(
                        ExcelBuffer, RowNo, 6));
                JsonArr.Add(JsonObj);
                if CustomerRec.Get(EntryNo) then begin
                    CustomerRec."No." :=
                        CopyStr(CustomerNo, 1, 20);
                    CustomerRec.Name :=
                        CopyStr(
                            GetCellValue(
                                ExcelBuffer, RowNo, 3),
                            1, 100);
                    CustomerRec.Address :=
                        CopyStr(
                            GetCellValue(
                                ExcelBuffer, RowNo, 4),
                            1, 100);
                    CustomerRec.City :=
                        CopyStr(
                            GetCellValue(
                                ExcelBuffer, RowNo, 5),
                            1, 50);
                    CustomerRec.Country :=
                        CopyStr(
                            GetCellValue(
                                ExcelBuffer, RowNo, 6),
                            1, 50);
                    CustomerRec.Modify(true);
                    UpdatedCount += 1;
                end else begin
                    CustomerRec.Init();
                    CustomerRec."Entry No." := EntryNo;
                    CustomerRec."No." :=
                        CopyStr(CustomerNo, 1, 20);
                    CustomerRec.Name :=
                        CopyStr(
                            GetCellValue(
                                ExcelBuffer, RowNo, 3),
                            1, 100);
                    CustomerRec.Address :=
                        CopyStr(
                            GetCellValue(
                                ExcelBuffer, RowNo, 4),
                            1, 100);
                    CustomerRec.City :=
                        CopyStr(
                            GetCellValue(
                                ExcelBuffer, RowNo, 5),
                            1, 50);
                    CustomerRec.Country :=
                        CopyStr(
                            GetCellValue(
                                ExcelBuffer, RowNo, 6),
                            1, 50);
                    CustomerRec.Insert(true);
                    ImportedCount += 1;
                end;
            end;
        end;
        JsonArr.WriteTo(JsonText);
        TempBlob.CreateOutStream(JsonOutStream);
        JsonOutStream.WriteText(JsonText);
        TempBlob.CreateInStream(JsonStream);
        JsonFileName := 'TopTenCustomers.json';
        DownloadFromStream(
            JsonStream,
            '',
            '',
            'JSON Files (*.json)|*.json',
            JsonFileName);
        Message(
            'Excel Import Completed Successfully!\Inserted Records: %1\Updated Records: %2',
            ImportedCount,
            UpdatedCount);
    end;

    local procedure GetCellValue(
        var ExcelBuffer: Record "Excel Buffer" temporary;
        RowNo: Integer;
        ColumnNo: Integer): Text
    begin
        if ExcelBuffer.Get(RowNo, ColumnNo) then
            exit(ExcelBuffer."Cell Value as Text");

        exit('');
    end;


    procedure ValidateCustomerCount(
        var ExcelBuffer: Record "Excel Buffer" temporary;
        MaxRowNo: Integer)
    var
        RowNo: Integer;
        CustomerCount: Integer;
    begin
        CustomerCount := 0;

        for RowNo := 2 to MaxRowNo do begin
            if GetCellValue(ExcelBuffer, RowNo, 2) <> '' then
                CustomerCount += 1;
        end;

        if CustomerCount <> 10 then
            Error(
                'Excel must contain exactly 10 customer records. Found %1 records. No records have been imported.',
                CustomerCount);
    end;

    procedure ValidateCustomerNo(CustomerNo: Text)
    begin
        if StrLen(CustomerNo) > 20 then
            Error(
                'Customer No. cannot exceed 20 characters. Current length is %1. Customer No.: %2',
                StrLen(CustomerNo),
                CustomerNo);
    end;
}
