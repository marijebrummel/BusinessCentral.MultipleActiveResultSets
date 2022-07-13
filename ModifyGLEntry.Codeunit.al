codeunit 60100 "Modify G/L Entry"
{
    Permissions = tabledata "G/L Entry" = M;

    trigger OnRun()
    var
        GLEnt: Record "G/L Entry";
    begin
        GLEnt.LockTable();
        GLEnt.SetRange(Amount, 1, 10);
        GLEnt.FindFirst();
        GLEnt.Description := 'Marije 1234';
        GLEnt.Modify();
        Message('Finished');
    end;
}