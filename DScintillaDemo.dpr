program DScintillaDemo;

uses
  Forms,
  fm_Main in 'Source\fm_Main.pas' {fmMain},
  fm_FindReplace in 'Source\fm_FindReplace.pas' {fmFindReplace},
  fm_GoTo in 'Source\fm_GoTo.pas' {Form4},
  U_Const in 'Source\U_Const.pas',
  U_Common in 'Source\U_Common.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmFindReplace, fmFindReplace);
  Application.Run;
end.
