unit fm_Config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfmConfig = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    ComboBox2: TComboBox;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    GroupBox3: TGroupBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox5: TCheckBox;
    Label4: TLabel;
    Edit2: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    class function Execute(AOwner: TForm): Boolean;
  end;

var
  fmConfig: TfmConfig;

implementation

{$R *.dfm}

{ TfmConfig }

class function TfmConfig.Execute(AOwner: TForm): Boolean;
begin
  fmConfig := TfmConfig.Create(AOwner);
  with fmConfig do begin
    Result := (ShowModal = mrOK);
    Destroy;
  end;
end;

end.
