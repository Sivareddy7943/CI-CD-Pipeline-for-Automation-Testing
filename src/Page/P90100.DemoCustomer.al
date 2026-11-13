
page 90100 "Top Ten Customers"
{
    PageType = List;
    SourceTable = "Top Ten Customers";
    Caption = 'Top Ten Customers';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportData)
            {
                Caption = 'Import Data';
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ImportMgt: Codeunit "Top Ten Customer Import";
                begin
                    ImportMgt.ImportExcelToJson();
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
