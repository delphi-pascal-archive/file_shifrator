program Crypter;

uses
  Forms,
  MainForm in 'MainForm.pas' {Main};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�������� ������';
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
