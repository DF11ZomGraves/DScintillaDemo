unit fm_FindReplace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, U_Common;

type
  TfmFindReplace = class(TForm)
    TabControl1: TTabControl;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    ComboBox2: TComboBox;
    Label3: TLabel;
    procedure TabControl1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateComboBoxList(Sender: TComboBox);
    function GetSearchOptions: TSearchOptionsSet;
  public
    { Public declarations }
  end;

var
  fmFindReplace: TfmFindReplace;

implementation

uses
  fm_Main;

{$R *.dfm}

procedure TfmFindReplace.Button1Click(Sender: TObject);
var
  s: string;
begin
  s := ComboBox1.Text;
  if not fmMain.Scite.FindStr(s, GetSearchOptions) then begin
    with Label3 do begin
      Font.Color := clRed;
      Caption := Format('Search text "%s" not found.', [s]);
    end;
  end
  else
    Label3.Caption := '';
  UpdateComboBoxList(ComboBox1);
end;

procedure TfmFindReplace.Button2Click(Sender: TObject);
var
  f: TSearchOptionsSet;
begin
  f := GetSearchOptions;
  if TButton(Sender).Tag = 1 then
    Include(f, foReplaceAll);
  fmMain.Scite.ReplaceStr(ComboBox1.Text, ComboBox2.Text, f);
  Label3.Caption := '';
  UpdateComboBoxList(ComboBox1);
  UpdateComboBoxList(ComboBox2);
end;

procedure TfmFindReplace.Button4Click(Sender: TObject);
var
  d: Integer;
begin
  d := fmMain.Scite.GetSearchCount(ComboBox1.Text, GetSearchOptions);
  with Label3 do begin
    Caption := Format('Found text in %d time(s).', [d]);
    Font.Color := clBlue;
  end;
end;

function TfmFindReplace.GetSearchOptions: TSearchOptionsSet;
begin
  Result := [];
  if CheckBox1.Checked then
    Include(Result, foCaseSensitive);
  if CheckBox2.Checked then
    Include(Result, foWholeWord);
  if CheckBox3.Checked then
    Include(Result, foUp);
  if CheckBox4.Checked then
    Include(Result, foReguarExpression);
end;

procedure TfmFindReplace.TabControl1Change(Sender: TObject);
var
  b: Boolean;
begin
  b := (TabControl1.TabIndex = 1);
  ComboBox2.Visible := b;
  Label2.Visible := b;
  Button2.Visible := b;
  Button3.Visible := b;
end;

procedure TfmFindReplace.UpdateComboBoxList(Sender: TComboBox);
var
  s, s2: string;
  i: Integer;
begin
  s := Sender.Text;
  with Sender.Items do begin
    for I := 0 to Count - 1 do begin
      s2 := Strings[i];
      if s = s2 then begin
        Delete(i);
        Break;
      end;
    end;
    Insert(0, s);
  end;
  Sender.Text := s;
end;

end.
