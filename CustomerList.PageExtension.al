pageextension 50100 CustomerListExt extends "Customer List"
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
                    i: Integer;
                begin
                    GLEnt.SetRange(Amount, 100, 110);
                    GLEnt.FindSet();
                    repeat
                        GLAcc.LockTable();
                        GLAcc.SetRange("No.", GLEnt."G/L Account No.");
                        GLAcc.FindSet();
                        Sleep(1000);
                        i += 1;
                    until (GLEnt.Next() = 0) or (i = 1000);
                    Message('Finished');
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
                    i: Integer;
                begin
                    GLEnt.SetRange(Amount, 100, 110);
                    GLEnt.FindSet();
                    repeat
                        GLAcc.SetRange("No.", GLEnt."G/L Account No.");
                        GLAcc.FindSet();
                        Sleep(1000);
                    until (GLEnt.Next() = 0) or (i = 1000);
                    Message('Finished');
                end;
            }
        }
    }



}