unit fm_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, StdActns, ExtActns, ComCtrls, DScintillaCustom,
  U_Common, msxml, ShellAPI;

type
  TfmMain = class(TForm)
    {$REGION 'PUBLISHED_TfmMain'}
    PageControl1: TPageControl;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    PopupMenu1: TPopupMenu;
    PreviousTab1: TPreviousTab;
    NextTab1: TNextTab;
    FileOpen1: TFileOpen;
    FileExit1: TFileExit;
    acFileSave: TAction;
    acFileNew: TAction;
    F1: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    O1: TMenuItem;
    S1: TMenuItem;
    A1: TMenuItem;
    N2: TMenuItem;
    X1: TMenuItem;
    acEditUndo: TAction;
    acEditRedo: TAction;
    acEditCut: TAction;
    acEditCopy: TAction;
    acEditPaste: TAction;
    U2: TMenuItem;
    U3: TMenuItem;
    N4: TMenuItem;
    T1: TMenuItem;
    C1: TMenuItem;
    P2: TMenuItem;
    acEditDelete: TAction;
    D1: TMenuItem;
    N5: TMenuItem;
    acEditFind: TAction;
    F2: TMenuItem;
    acEditGoTo: TAction;
    G1: TMenuItem;
    acEditSelectAll: TAction;
    A2: TMenuItem;
    H1: TMenuItem;
    acAbout: TAction;
    A3: TMenuItem;
    StatusBar1: TStatusBar;
    acFileRecovery: TAction;
    R2: TMenuItem;
    V1: TMenuItem;
    acViewShowWhitespace: TAction;
    acViewShowWhitespace1: TMenuItem;
    acViewShowIndentLine: TAction;
    I1: TMenuItem;
    acViewWordWrap: TAction;
    W1: TMenuItem;
    H2: TMenuItem;
    N7: TMenuItem;
    acViewShowCrLf: TAction;
    N8: TMenuItem;
    acFileClose: TAction;
    acFileCloseAll: TAction;
    N6: TMenuItem;
    N9: TMenuItem;
    SaveDialog1: TSaveDialog;
    acFileSaveAs: TAction;
    C2: TMenuItem;
    ANSI1: TMenuItem;
    UTF161: TMenuItem;
    UTF81: TMenuItem;
    UTF162: TMenuItem;
    N3: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    acFileSaveAll: TAction;
    V2: TMenuItem;
    acEditToLCase: TAction;
    acEditToUCase: TAction;
    L1: TMenuItem;
    U4: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    S2: TMenuItem;
    acViewShowStatusBar: TAction;
    acFoldAll: TAction;
    F3: TMenuItem;
    N15: TMenuItem;
    acExpandAll: TAction;
    E2: TMenuItem;
    PopupMenu2: TPopupMenu;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    N10: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    SelectAll1: TMenuItem;
    N16: TMenuItem;
    Goto1: TMenuItem;
    ExpandAll1: TMenuItem;
    FoldAll1: TMenuItem;
    Action1: TAction;
    procedure acAboutExecute(Sender: TObject);
    procedure acFileNewExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileOpen1Accept(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure acEditSelectAllExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure acEditUndoExecute(Sender: TObject);
    procedure acEditRedoExecute(Sender: TObject);
    procedure acEditPasteExecute(Sender: TObject);
    procedure acEditCopyExecute(Sender: TObject);
    procedure acEditDeleteExecute(Sender: TObject);
    procedure acEditCutExecute(Sender: TObject);
    procedure acFileRecoveryExecute(Sender: TObject);
    procedure acFileSaveExecute(Sender: TObject);
    procedure acViewShowWhitespaceExecute(Sender: TObject);
    procedure acViewShowIndentLineExecute(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure acViewShowCrLfExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acFileCloseExecute(Sender: TObject);
    procedure acFileSaveAsExecute(Sender: TObject);
    procedure acViewWordWrapExecute(Sender: TObject);
    procedure acFileSaveAllExecute(Sender: TObject);
    procedure ANSI1Click(Sender: TObject);
    procedure UTF81Click(Sender: TObject);
    procedure UTF161Click(Sender: TObject);
    procedure acFileCloseAllExecute(Sender: TObject);
    procedure acEditFindExecute(Sender: TObject);
    procedure acEditToLCaseExecute(Sender: TObject);
    procedure acEditToUCaseExecute(Sender: TObject);
    procedure acEditGoToExecute(Sender: TObject);
    procedure acViewShowStatusBarExecute(Sender: TObject);
    procedure acFoldAllExecute(Sender: TObject);
    procedure acExpandAllExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    {$ENDREGION}
  private
    { Private declarations }
    FFileNo: Integer;
    function GetSc: TScintillaEx;
    function ClosePage: Boolean;
    function SaveFile(const ASaveAs: Boolean = False): Boolean;
    procedure LoadXmlConfig;
  public
    { Public declarations }
    procedure DragFileMsg(var Msg: TMessage); message WM_DROPFILES;
    procedure DoModify(var Msg: TMessage); message WM_MODIFY;
    procedure UpdateStatusBar(var Msg: TMessage); message WM_STATUSBAR_UPDATE;
    property Scite: TScintillaEx read GetSc;
  end;

var
  fmMain: TfmMain;

implementation

uses
  U_Const, fm_FindReplace, fm_GoTo, DScintillaTypes;

{$R *.dfm}

procedure TfmMain.acAboutExecute(Sender: TObject);
var
  Ver, sScintillaVer, s: string;
begin
  Ver := GetAppVer(Application.ExeName);
  sScintillaVer := GetAppVer(cDSciLexerDll);
  s := Format('CodeEditor2 Demo'#13#10#13#10'Current Scintilla Version: %s'#13#10'Author: DF11ZomGraves',
    [sScintillaVer]);
  Application.MessageBox(PChar(s), TITLE_ABOUT, 0);
end;

procedure TfmMain.acEditCopyExecute(Sender: TObject);
begin
  Scite.Copy;
end;

procedure TfmMain.acEditCutExecute(Sender: TObject);
begin
  Scite.Cut;
end;

procedure TfmMain.acEditDeleteExecute(Sender: TObject);
begin
  Scite.ReplaceSel('');
end;

procedure TfmMain.acEditFindExecute(Sender: TObject);
begin
  fmFindReplace.Show;
end;

procedure TfmMain.acEditGoToExecute(Sender: TObject);
var
  d: Integer;
begin
  if TForm4.Execute(Self, d) then
    Scite.GotoLine(d);
end;

procedure TfmMain.acEditPasteExecute(Sender: TObject);
begin
  Scite.Paste;
end;

procedure TfmMain.acEditRedoExecute(Sender: TObject);
begin
  Scite.Redo;
end;

procedure TfmMain.acEditSelectAllExecute(Sender: TObject);
begin
  Scite.SelectAll;
end;

procedure TfmMain.acEditToLCaseExecute(Sender: TObject);
begin
  Scite.LowerCase;
end;

procedure TfmMain.acEditToUCaseExecute(Sender: TObject);
begin
  Scite.UpperCase;
end;

procedure TfmMain.acEditUndoExecute(Sender: TObject);
begin
  Scite.Undo;
end;

procedure TfmMain.acExpandAllExecute(Sender: TObject);
begin
  Scite.FoldAll(SC_FOLDACTION_EXPAND);
end;

procedure TfmMain.acFileCloseAllExecute(Sender: TObject);
begin
  while PageControl1.PageCount > 0 do
    if not ClosePage then
      Break;
end;

procedure TfmMain.acFileCloseExecute(Sender: TObject);
begin
  ClosePage;
end;

procedure TfmMain.acFileNewExecute(Sender: TObject);
var
  tab: TTabSheet;
  sCaption: string;
  sc: TScintillaEx;
begin
  tab := TTabSheet.Create(PageControl1);
  Inc(FFileNo);
  sCaption := Format(FILE_DEFAULT_NAME, [FFileNo]);
  with tab do begin
    PageControl := PageControl1;
    Parent := PageControl1;
    tab.Caption := sCaption;
  end;
  PageControl1.ActivePage := tab;
  sc := TScintillaEx.Create(PageControl1.ActivePage);
  sc.PopupMenu := PopupMenu2;
  Self.Caption := Format(TITLE_FORM, [sCaption]);
  with StatusBar1 do begin
    Panels[0].Text := 'Plain text';
    Panels[1].Text := sc.Encoding;
    Panels[2].Text := '';
    Panels[3].Text := STATUS_INSERT;                       
  end;
  if Self.Visible then
    sc.SetFocus;
end;

procedure TfmMain.acFileRecoveryExecute(Sender: TObject);
var
  f, c: string;
  p: Integer;
begin
  with Scite do begin
    f := CurrentFile;
    if f <> '' then
      OpenFile(f)
    else begin
      ClearAll;
      SetSavePoint;
      EmptyUndoBuffer;
      c := PageControl1.ActivePage.Caption;
      p := Pos('*', c);
      if p > 0 then
        SetLength(c, p - 1);
        PageControl1.ActivePage.Caption := c;
      StatusBar1.Panels[2].Text := '';
    end;
  end;
end;

procedure TfmMain.acFileSaveAllExecute(Sender: TObject);
var
  I: Integer;
  sFile, sFileName: string;
begin
  for I := 0 to PageControl1.PageCount - 1 do begin
    sFile := TScintillaEx(PageControl1.Pages[i].Controls[0]).CurrentFile;
    if sFile = '' then
      if SaveDialog1.Execute then
        sFile := SaveDialog1.FileName
      else
        Exit;
    TScintillaEx(PageControl1.Pages[i].Controls[0]).SaveFile(sFile);
    if i = PageControl1.ActivePage.TabIndex then begin
      sFileName := ExtractFileName(sFile);
      PageControl1.ActivePage.Caption := sFileName;
      Self.Caption := Format(TITLE_FORM, [sFileName]);
    end;
  end;
end;

procedure TfmMain.acFileSaveAsExecute(Sender: TObject);
begin
  SaveFile(True);
end;

procedure TfmMain.acFileSaveExecute(Sender: TObject);
begin
  SaveFile(False);
end;

procedure TfmMain.acFoldAllExecute(Sender: TObject);
begin
  Scite.FoldAll(SC_FOLDACTION_CONTRACT);
end;

procedure TfmMain.Action1Execute(Sender: TObject);
begin
  //
end;

procedure TfmMain.ActionList1Update(Action: TBasicAction; var Handled: Boolean);
var
  IsEmptySelection: Boolean;
  s: string;
begin
  if Scite = nil then
    Exit;
  with Scite do begin
    acEditUndo.Enabled := CanUndo;
    acEditRedo.Enabled := CanRedo;
    acEditPaste.Enabled := CanPaste;
    IsEmptySelection := not GetSelectionEmpty;
    acViewWordWrap.Checked := (GetWrapMode = SC_WRAP_CHAR);
    acViewShowWhitespace.Checked := (GetViewWS <> SCWS_INVISIBLE);
    acViewShowCrLf.Checked := GetViewEOL;
    acViewShowIndentLine.Checked := (GetIndentationGuides <> SC_IV_NONE);
    s := Encoding;
    if s = ENCODING_ANSI then
      ANSI1.Checked := True
    else if s = ENCODING_UTF16 then
      UTF161.Checked := True
    else if s = ENCODING_UTF8 then
      UTF81.Checked := True;
  end;
  acEditCopy.Enabled := IsEmptySelection;
  acEditCut.Enabled := IsEmptySelection;
  acEditDelete.Enabled := IsEmptySelection;
  acEditToLCase.Enabled := IsEmptySelection;
  acEditToUCase.Enabled := IsEmptySelection;
end;

procedure TfmMain.acViewShowCrLfExecute(Sender: TObject);
begin
  Scite.SetEOLMode(SC_EOL_CRLF);
  Scite.SetViewEOL(acViewShowCrLf.Checked);
end;

procedure TfmMain.acViewShowIndentLineExecute(Sender: TObject);
begin
  if acViewShowIndentLine.Checked then
    Scite.SetIndentationGuides(SC_IV_REAL)
  else
    Scite.SetIndentationGuides(SC_IV_NONE);
end;

procedure TfmMain.acViewShowStatusBarExecute(Sender: TObject);
begin
  StatusBar1.Visible := acViewShowStatusBar.Checked;
end;

procedure TfmMain.acViewShowWhitespaceExecute(Sender: TObject);
begin
  if acViewShowWhitespace.Checked then
    Scite.SetViewWS(SCWS_VISIBLEALWAYS)
  else
    Scite.SetViewWS(SCWS_INVISIBLE);
end;

procedure TfmMain.acViewWordWrapExecute(Sender: TObject);
begin
  if acViewWordWrap.Checked then
    Scite.SetWrapMode(SC_WRAP_CHAR)
  else
    Scite.SetWrapMode(SC_WRAP_NONE);
end;

procedure TfmMain.ANSI1Click(Sender: TObject);
begin
  Scite.Encoding := ENCODING_ANSI;
  StatusBar1.Panels[1].Text := ENCODING_ANSI;
end;

function TfmMain.ClosePage: Boolean;
begin
  if Scite.Modified then
    case Application.MessageBox(PROMOPT_SAVE, TITLE_SAVE, 51) of
      IDYES:
        Result := SaveFile(False);
      IDNO:
        Result := True;
      else
        Result := False;
    end
  else
    Result := True;
  if Result then
    PageControl1.ActivePage.Destroy;
end;

procedure TfmMain.DoModify(var Msg: TMessage);
var
  c: string;
  p: Integer;
begin
  if not Boolean(Msg.WParam) then begin
    StatusBar1.Panels[2].Text := '';
    Exit;
  end;
  c := PageControl1.ActivePage.Caption;
  p := Pos('*', c);
  if p = 0 then
    PageControl1.ActivePage.Caption := c + '*';
  StatusBar1.Panels[2].Text := STATUS_MODIFIED;
end;

procedure TfmMain.DragFileMsg(var Msg: TMessage);
var
  i, j: Integer;
  s, c: string;
  buffer: array[0..254] of Char;
begin
  j := DragQueryFile(msg.WParam, $FFFFFFFF, nil, 0);
  for I := 0 to j - 1 do begin
    DragQueryFile(msg.WParam, i, buffer, 255);
    s := StrPas(buffer);
    with Scite do
      if Modified or (CurrentFile <> '') then begin
        Dec(FFileNo);
        acFileNew.Execute;
      end;
    Scite.OpenFile(s);
    c := ExtractFileName(s);
    PageControl1.ActivePage.Caption := c;
  end;
  Caption := Format(TITLE_FORM, [c]);
  with Scite do begin
    StatusBar1.Panels[0].Text := Highlighter;
    StatusBar1.Panels[1].Text := Encoding;
  end;
end;

procedure TfmMain.FileOpen1Accept(Sender: TObject);
var
  fPath, c: string;
  i: Integer;
begin
  for I := 0 to FileOpen1.Dialog.Files.Count - 1 do begin
    fPath := FileOpen1.Dialog.Files[i];
    with Scite do
      if Modified or (CurrentFile <> '') then begin
        Dec(FFileNo);
        acFileNew.Execute;
      end;
    Scite.OpenFile(fPath);
    c := ExtractFileName(fPath);
    PageControl1.ActivePage.Caption := c;
  end;
  Caption := Format(TITLE_FORM, [c]);
  with Scite do begin
    StatusBar1.Panels[0].Text := Highlighter;
    StatusBar1.Panels[1].Text := Encoding;
  end;
  FileOpen1.Dialog.FileName := '';
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  acFileCloseAll.Execute;
  if PageControl1.PageCount > 0 then
    CanClose := False;
end;

procedure TfmMain.FormCreate(Sender: TObject);

  procedure LoadXmlList;
  var
    dir, s, xPath, LexerName: string;
    XmlList: TStringList;
    i: Integer;
    XmlMenu: TMenuItem;
    doc: IXMLDOMDocument;
    Elmt: IXMLDOMElement;
  begin
    dir := ExtractFilePath(Application.ExeName) + 'Data';
    doc := CODOMDocument.Create;
    XmlList := TStringList.Create;
    try
      GetFolderFile(dir, XmlList, '*.xml', [fsoNoExt]);
      for I := 0 to XmlList.Count - 1 do begin
        s := XmlList.Strings[i];
        if s = 'Editor' then
          Continue;
        xPath := dir + '\' + s + '.xml';
        if not doc.load(xPath) then
          Continue;
        try
          Elmt := doc.selectSingleNode(NODE_LEXER_ROOT) as IXMLDOMElement;
          if Elmt = nil then
            Continue;
          LexerName := Elmt.getAttribute('desc');
          if LexerName = '' then
            Continue;
          XmlMenu := TMenuItem.Create(Self);
          with XmlMenu do begin
            Hint := s;
            Caption := LexerName;
            OnClick := N7Click;
          end;
          H2.Add(XmlMenu);
        except
          Continue;
        end;
      end;
    finally
      XmlList.Destroy;
    end;
  end;

begin
  DragAcceptFiles(Self.Handle, True);
  FFileNo := 0;
  //LoadLibrary(cDSciLexerDll);
  LoadXmlConfig;
  LoadXmlList;
  acFileNew.Execute;
end;

function TfmMain.GetSc: TScintillaEx;
var
  tab: TTabSheet;
begin
  tab := PageControl1.ActivePage;
  if Assigned(tab) then
    Result := TScintillaEx(PageControl1.ActivePage.Controls[0])
  else
    Result := nil;
end;

procedure TfmMain.LoadXmlConfig;
var
  doc: IXMLDOMDocument;
  Node: IXMLDOMNode;
  Elmt: IXMLDOMElement;
  s: string;

  procedure SelectSingleNodeEx(const APath: string);
  begin
    Node := doc.selectSingleNode(APath);
    if Node = nil then
      raise Exception.Create(Format(MSG_NODE_NOT_FOUND, [APath]));
    Elmt := Node as IXMLDOMElement;
  end;

begin
  doc := CODOMDocument.Create;
  s := ExtractFilePath(Application.ExeName) + 'Data\Editor.xml';
  try
    if not doc.load(s) then
      raise Exception.CreateFmt(MSG_OPEN_FILE_ERROR, [s, doc.parseError.reason]);
    SelectSingleNodeEx('Editor/Font');
    EditorOptions.seoFontName := Elmt.getAttribute('name');
    EditorOptions.seoFontSize := Elmt.getAttribute('size');
    SelectSingleNodeEx('Editor/IndentLines');
    with Elmt, EditorOptions do begin
      seoIndentLineStyle := getAttribute('style');
      seoIndentLineColor := getAttribute('color');
    end;
    SelectSingleNodeEx('Editor/BracketMatch');
    EditorOptions.seoBracketHighlightColor := Elmt.getAttribute('color');
    SelectSingleNodeEx('Editor/Tab');
    EditorOptions.seoTabWidth := Elmt.getAttribute('width');
    SelectSingleNodeEx('Editor/ActiveLine');
    EditorOptions.seoActiveLineColor := Elmt.getAttribute('color');
  except on E: Exception do
    Application.MessageBox(PChar(E.Message), TITLE_LOAD_XML_CONFIG, 48);
  end;
end;

procedure TfmMain.N7Click(Sender: TObject);
var
  s: string;
begin
  s := TMenuItem(Sender).Hint;
  Scite.LoadConfigFromXml(s);
  StatusBar1.Panels[0].Text := Scite.Highlighter;
end;

procedure TfmMain.PageControl1Change(Sender: TObject);
var
  c: string;
begin
  c := PageControl1.ActivePage.Caption;
  Self.Caption := Format(TITLE_FORM, [c]);
  with Scite do begin
    if Modified then
      c := STATUS_MODIFIED
    else
      c := '';
    StatusBar1.Panels[0].Text := Highlighter;
    StatusBar1.Panels[1].Text := Encoding;
    StatusBar1.Panels[2].Text := c;
  end;
end;

function TfmMain.SaveFile(const ASaveAs: Boolean): Boolean;
var
  sFile, sFileName: string;
begin
  Result := True;
  sFile := Scite.CurrentFile;
  if (sFile = '') or ASaveAs then
    if SaveDialog1.Execute then
      sFile := SaveDialog1.FileName
    else
      Exit(False);
  Scite.SaveFile(sFile);
  sFileName := ExtractFileName(sFile);
  PageControl1.ActivePage.Caption := sFileName;
  Self.Caption := Format(TITLE_FORM, [sFileName]);
end;

procedure TfmMain.UpdateStatusBar(var Msg: TMessage);
begin
  if Boolean(Msg.WParam) then
    StatusBar1.Panels[3].Text := STATUS_OVERWRITE
  else
    StatusBar1.Panels[3].Text := STATUS_INSERT
end;

procedure TfmMain.UTF161Click(Sender: TObject);
begin
  Scite.Encoding := ENCODING_UTF16;
  StatusBar1.Panels[1].Text := ENCODING_UTF16;
end;

procedure TfmMain.UTF81Click(Sender: TObject);
begin
  Scite.Encoding := ENCODING_UTF8;
  StatusBar1.Panels[1].Text := ENCODING_UTF8;
end;

end.
