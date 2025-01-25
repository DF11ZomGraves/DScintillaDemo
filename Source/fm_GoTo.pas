unit fm_GoTo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Execute(AOwner: TForm; var ALine: Integer): Boolean;
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Edit1Change(Sender: TObject);
begin
  Button1.Enabled := (Edit1.Text <> '');
end;

class function TForm4.Execute(AOwner: TForm; var ALine: Integer): Boolean;
begin
  Form4 := TForm4.Create(AOwner);
  with Form4 do begin
    Result := (ShowModal = mrOK);
    ALine := StrToIntDef(Edit1.Text, 1);
    Destroy;
  end;
end;

end.
