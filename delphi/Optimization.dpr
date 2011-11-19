program Optimization;

uses
  Forms,
  Form in 'Form.pas' {Form1},
  Matrix in 'Matrix.pas',
  IntStack in 'IntStack.pas',
  About in 'About.pas' {AboutBox};

{$R *.res}

begin
  Randomize;
  Application.Initialize;
  Application.Title := 'Методы оптимизации';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
