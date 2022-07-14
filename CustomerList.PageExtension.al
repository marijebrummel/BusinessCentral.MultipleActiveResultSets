pageextension 60100 CustomerListExt extends "Customer List"
{
    actions
    {

        addfirst(Navigation)
        {
            action(ReadWithLock)
            {
                ApplicationArea = All;
                Caption = 'Read With Lock';

                trigger OnAction()
                var
                    GLAcc: Record "G/L Account";
                    GLEnt: Record "G/L Entry";
                    Start: DateTime;
                    i: Integer;
                begin
                    Start := CurrentDateTime;
                    GLEnt.LockTable();
                    //   GLEnt.SetRange(Amount, 100, 110);
                    GLEnt.FindSet();
                    repeat
                        GLAcc.LockTable();
                        GLAcc.SetRange("No.", GLEnt."G/L Account No.");
                        GLAcc.FindSet();
                        Sleep(1000);
                        i += 1;
                    until (GLEnt.Next() = 0) or (i = 100);
                    Message('Finished in ' + Format(CurrentDateTime - Start));
                end;
            }
            action(ReadWithoutLock)
            {
                ApplicationArea = All;
                Caption = 'Read Without Lock';

                trigger OnAction()
                var
                    GLAcc: Record "G/L Account";
                    GLEnt: Record "G/L Entry";
                    Start: DateTime;
                    i: Integer;
                begin
                    Start := CurrentDateTime;
                    //   GLEnt.SetRange(Amount, 100, 110);
                    GLEnt.FindSet();
                    repeat
                        GLAcc.SetRange("No.", GLEnt."G/L Account No.");
                        GLAcc.FindSet();
                        Sleep(1000);
                        i += 1;
                    until (GLEnt.Next() = 0) or (i = 100);
                    Message('Finished in ' + Format(CurrentDateTime - Start));
                end;
            }
            action(ReadWithTemp)
            {
                ApplicationArea = All;
                Caption = 'Read With Temporary';

                trigger OnAction()
                var
                    GLAcc: Record "G/L Account";
                    GLEnt: Record "G/L Entry";
                    GLEntTemp: Record "G/L Entry" temporary;
                    Start: DateTime;
                    i: Integer;
                begin
                    Start := CurrentDateTime;
                    GLEnt.SetRange(Amount, 100, 110);
                    GLEnt.FindSet();
                    repeat
                        GLEntTemp := GLEnt;
                        GLEntTemp.Insert();
                        i += 1;
                    until (GLEnt.Next() = 0) or (i = 100);

                    GLEntTemp.FindSet();
                    repeat
                        GLAcc.SetRange("No.", GLEntTemp."G/L Account No.");
                        GLAcc.FindSet();
                        Sleep(1000);
                    until (GLEntTemp.Next() = 0) or (i = 100);
                    Message('Finished in ' + Format(CurrentDateTime - Start));
                end;
            }
        }
    }
}