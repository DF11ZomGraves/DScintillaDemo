unit U_Common;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms, msxml,
  DScintilla, DScintillaTypes;

type
  TSearchOptionsSet = set of (foCaseSensitive, foWholeWord, foUp, foReguarExpression, foReplaceAll);

  TFileSearchOptionsSet = set of (fsoFullPath, fsoNoExt);

  TScintillaEditorOptions = record
    seoTabWidth: Integer;
    seoActiveLineColor: Integer;
    seoBracketHighlightColor: Integer;
    seoMarginForeColor: Integer;
    seoIndentLineStyle: Integer;
    seoIndentLineColor: Integer;
    seoFontSize: Integer;
    seoFontName: string;
    seoUseTabIndent: Boolean;
  end;

  TScintillaEx = class(TDScintilla)
    procedure SciteMarginClick(ASender: TObject; AModifiers, APosition,
      AMargin: Integer);
    procedure SciteModified(ASender: TObject; APosition,
      AModificationType: Integer; AText: string; ALength, ALinesAdded, ALine,
      AFoldLevelNow, AFoldLevelPrev: Integer);
    procedure SciteCharAdded(ASender: TObject; ACh: Integer);
    procedure SciteUpdateUI(ASender: TObject; AUpdated: Integer);
  private
    FFileName: string;
    FEncoding: string;
    FHighlighterStr: string;
    FLastProcessedChar: Integer;
    procedure SetEditorStyle;
    function GetSearchFlags(AOptions: TSearchOptionsSet): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    procedure OpenFile(const AFileName: string);
    procedure SaveFile(const AFileName: string);
    procedure LoadConfigFromXml(const ALexerName: string);
    function FindStr(const ASearchStr: string; AOptions: TSearchOptionsSet): Boolean;
    procedure ReplaceStr(const ASearchStr: string; const AReplaceStr: string;
      AOptions: TSearchOptionsSet);
    function GetSearchCount(const ASearchStr: string;
      AOptions: TSearchOptionsSet): Integer;
    property Highlighter: string read FHighlighterStr write FHighlighterStr;
    property CurrentFile: string read FFileName write FFileName;
    property Encoding: string read FEncoding write FEncoding;
    property Modified: Boolean read GetModify;
  end;

const
  WM_MODIFY = WM_USER + $10;
  WM_STATUSBAR_UPDATE = WM_USER + $11;

var
  EditorOptions: TScintillaEditorOptions;

function GetAppVer(const AExeName: string): string;
procedure GetFolderFile(const ADir: string; ADestStringList: TStringList;
  const AExt: string = '*.*'; AOptions: TFileSearchOptionsSet = []);

implementation

uses
  U_Const;

function GetAppVer(const AExeName: string): string;
var
  fPath: PChar;
  InfoSize, aHandle: DWORD;
  VerBuf: Pointer;
  VerFInfo: PVSFixedFileInfo;
  VerBufArray: array[0..3] of Integer;
begin
  Result := '0.0.0.0';
  fPath := PChar(AExeName);
  InfoSize := GetFileVersionInfoSize(fPath, aHandle);
  if InfoSize = 0 then
    Exit;
  GetMem(VerBuf, InfoSize);
  GetFileVersionInfo(fPath, aHandle, InfoSize, VerBuf);
  VerQueryValue(VerBuf, '\', Pointer(VerFInfo), InfoSize);
  with VerFInfo^ do begin
    VerBufArray[0] := dwFileVersionMS shr 16;
    VerBufArray[1] := dwFileVersionMS and $FFFF;
    VerBufArray[2] := dwFileVersionLS shr 16;
    VerBufArray[3] := dwFileVersionLS and $FFFF;
  end;
  FreeMem(VerBuf);
  Result := Format('%d.%d.%d.%d', [VerBufArray[0], VerBufArray[1],
    VerBufArray[2], VerBufArray[3]]);
end;

procedure GetFolderFile(const ADir: string; ADestStringList: TStringList;
  const AExt: string; AOptions: TFileSearchOptionsSet);
var
  FileRec: TSearchrec;
  tempStringList: TStringList;
  tempPath: string;
  sBuffer: string;
begin
  if ADestStringList = nil then
    Exit;
  if not DirectoryExists(ADir) then
    Exit;
  ADestStringList.Clear;
  tempStringList := TStringList.Create;
  tempPath := ADir + '\' + AExt;
  if FindFirst(tempPath, faAnyFile, FileRec) = 0 then repeat
    if ((FileRec.Attr and faDirectory) = 0) then begin
      if fsoNoExt in AOptions then
        sBuffer := ChangeFileExt(FileRec.Name, '')
      else
        sBuffer := FileRec.Name;
      if fsoFullPath in AOptions then
        sBuffer := ADir + '\' + sBuffer;
      tempStringList.Add(sBuffer);
    end;
  until FindNext(FileRec) <> 0;
  FindClose(FileRec);
  ADestStringList.Assign(tempStringList);
  tempStringList.Destroy;
end;

{ TScintillaEx }

constructor TScintillaEx.Create(AOwner: TComponent);
begin
  inherited;
  Parent := TWinControl(AOwner);
  FFileName := '';
  Align := alClient;
  SetMarginWidthN(0, 32);
  SetMarginWidthN(1, 8);
  SetEditorStyle;
  OnModified := SciteModified;
  OnMarginClick := SciteMarginClick;
  OnCharAdded := SciteCharAdded;
  OnUpdateUI := SciteUpdateUI;
  FEncoding := ENCODING_ANSI;
end;

function TScintillaEx.FindStr(const ASearchStr: string;
  AOptions: TSearchOptionsSet): Boolean;
var
  SearchFlags, p: Integer;
begin
  Result := False;
  SearchFlags := GetSearchFlags(AOptions);
  SetSearchFlags(SearchFlags);
  if foUp in AOptions then begin
    SetTargetStart(GetSelectionStart);
    SetTargetEnd(0);
    p := SearchInTarget(ASearchStr);
    if p = -1 then
      Exit;
  end
  else begin
    SetTargetStart(GetSelectionEnd);
    SetTargetEnd(GetLength);
    p := SearchInTarget(ASearchStr);
    if p = -1 then
      Exit;
  end;
  SetSelectionStart(GetTargetStart);
  SetSelectionEnd(GetTargetEnd);
  ScrollCaret;
  Result := True;
end;

function TScintillaEx.GetSearchCount(const ASearchStr: string;
  AOptions: TSearchOptionsSet): Integer;
var
  SearchFlags, p: Integer;
begin
  Result := 0;
  SearchFlags := GetSearchFlags(AOptions);
  SetSearchFlags(SearchFlags);
  p := 0;
  SetTargetStart(p);
  SetTargetEnd(GetLength);
  while True do begin
    p := SearchInTarget(ASearchStr);
    if p < 0 then
      Break;
    Inc(Result);
    SetTargetStart(GetTargetEnd);
    SetTargetEnd(GetLength);
  end;
end;

function TScintillaEx.GetSearchFlags(AOptions: TSearchOptionsSet): Integer;
begin
  Result := 0;
  if foCaseSensitive in AOptions then
    Result := Result + SCFIND_MATCHCASE;
  if foWholeWord in AOptions then
    Result := Result + SCFIND_WHOLEWORD;
  if foReguarExpression in AOptions then
    Result := Result + SCFIND_REGEXP;
end;

procedure TScintillaEx.LoadConfigFromXml(const ALexerName: string);
const
  MARGIN_FOLD = 2;

  procedure SetFoldSettings;
  begin
    SetProperty('fold', '1');
    SetMarginTypeN(MARGIN_FOLD, SC_MARGIN_SYMBOL);
    SetMarginMaskN(MARGIN_FOLD, SC_MASK_FOLDERS);
    SetMarginWidthN(MARGIN_FOLD, 12);
    SetMarginSensitiveN(MARGIN_FOLD, True);
    MarkerDefine(SC_MARKNUM_FOLDER, SC_MARK_BOXPLUS);
    MarkerDefine(SC_MARKNUM_FOLDEROPEN, SC_MARK_BOXMINUS);
    MarkerDefine(SC_MARKNUM_FOLDEREND, SC_MARK_BOXPLUSCONNECTED);
    MarkerDefine(SC_MARKNUM_FOLDEROPENMID, SC_MARK_BOXMINUSCONNECTED);
    MarkerDefine(SC_MARKNUM_FOLDERMIDTAIL, SC_MARK_TCORNER);
    MarkerDefine(SC_MARKNUM_FOLDERSUB, SC_MARK_VLINE);
    MarkerDefine(SC_MARKNUM_FOLDERTAIL, SC_MARK_LCORNER);
    MarkerSetBack(SC_MARKNUM_FOLDERSUB, $a0a0a0);
    MarkerSetBack(SC_MARKNUM_FOLDERMIDTAIL, $a0a0a0);
    MarkerSetBack(SC_MARKNUM_FOLDERTAIL, $a0a0a0);
    MarkerSetBack(SC_MARKNUM_FOLDER, $a0a0a0);
    MarkerSetBack(SC_MARKNUM_FOLDEROPEN, $a0a0a0);
    MarkerSetBack(SC_MARKNUM_FOLDEREND, $a0a0a0);
    MarkerSetBack(SC_MARKNUM_FOLDEROPENMID, $a0a0a0);
    MarkerSetFore(SC_MARKNUM_FOLDER, clWhite);
    MarkerSetFore(SC_MARKNUM_FOLDEROPEN, clWhite);
    MarkerSetFore(SC_MARKNUM_FOLDEREND, clWhite);
    MarkerSetFore(SC_MARKNUM_FOLDEROPENMID, clWhite);
//    SetFoldFlags(16 or 4);
    SetFoldFlags(SC_FOLDFLAG_LINEAFTER_CONTRACTED);
    SetAutomaticFold(SC_AUTOMATICFOLD_SHOW or SC_AUTOMATICFOLD_CHANGE);
  end;

  procedure SetTransBackColor(const AType: Integer; const AColor: Integer);
  begin
    if AColor = clNone then
      Exit;
    StyleSetBack(AType, AColor);
  end;

var
  doc: IXMLDOMDocument;
  Node: IXMLDOMNode;
  Elmt: IXMLDOMElement;
  List: IXMLDOMNodeList;
  s: string;
  i, sType, c: Integer;
  b: Boolean;
begin
  StyleClearAll;
  SetLexerLanguage(ALexerName);
  SetEditorStyle;
  if ALexerName = '' then begin
    SetMarginWidthN(MARGIN_FOLD, 0);
    SetProperty('fold', '0');
    SetMarginSensitiveN(MARGIN_FOLD, False);
    FHighlighterStr := 'Plain text';
    Exit;
  end;
  s := ExtractFilePath(Application.ExeName) + 'Data\' + ALexerName + '.xml';
  doc := CODOMDocument.Create;
  try
    if not doc.load(s) then
      raise Exception.Create(Format(MSG_OPEN_FILE_ERROR, [s, doc.parseError.reason]));
    Node := doc.selectSingleNode(NODE_LEXER_ROOT);
    if Node = nil then
      raise Exception.Create(Format(MSG_NODE_NOT_FOUND, [NODE_LEXER_ROOT]));
    Elmt := Node as IXMLDOMElement;
    FHighlighterStr := Elmt.getAttribute(NODE_LEXER_DESC);
    List := Node.childNodes;
    for I := 0 to List.length - 1 do begin
      Node := List.item[i];
      Elmt := Node as IXMLDOMElement;
      with Elmt do begin
        if nodeType <> NODE_ELEMENT then
          Continue;
        s := nodeName;
        if s = NODE_LEXER_ATTRIBUTE then begin
          sType := getAttribute(NODE_LEXER_TYPE);
          c := getAttribute('foreColor');
          StyleSetFore(sType, c);
          c := getAttribute('backColor');
          SetTransBackColor(sType, c);
          b := getAttribute('bold');
          StyleSetBold(sType, b);
          b := getAttribute('italic');
          StyleSetItalic(sType, b);
        end
        else if s = NODE_LEXER_KEYWORD then
          Self.SetKeyWords(getAttribute('set'), Node.text);
      end;
    end;
    Colourise(0, -1);
    SetFoldSettings;
  except on E: Exception do
    Application.MessageBox(PChar(E.Message), TITLE_LOAD_XML_CONFIG, 48);
  end;
end;

procedure TScintillaEx.OpenFile(const AFileName: string);

  function LoadTextFile: string;
  var
    i, l: Integer;
    fs: TFileStream;
    sBuffer: AnsiString;
    pCh: PByte absolute sBuffer;
    pResult: array of word absolute Result;

    function IsUTF8Format(): Boolean;
    var
      i: Integer;
      j, k: Byte;
    begin
      Result := False;
      I := 0;
      while i < l do begin
        k := pch[i];
        if (k and $80) > 0 then begin
          if (k and $e0) = $c0 then         //110xxxxx
            k := 1
          else if (k and $f0) = $e0 then    //1110xxxx
            k := 2
          else if (k and $f8) = $f0 then    //11110xxx
            k := 3
          else if (k and $fc) = $f8 then    //111110xx
            k := 4
          else if (k and $fe) = $fc then    //1111110x
            k := 5
          else
            Exit;
          for j := 1 to k do
            if (pch[i + j] and $c0) <> $80 then
              Exit;
          Inc(i, k);
        end;
        Inc(i);
      end;
      Result := True;
    end;

  begin
    Result := '';
    try
      fs := TFileStream.Create(AFileName, fmOpenRead);
      with fs do begin
        l := Size;
        SetLength(sBuffer, l);
        Read(pch^, l);
      end;
    finally
      FreeAndNil(fs);
    end;
    if l > 1 then
      if (pch[0] = $ff) and (pch[1] = $fe) then begin  //UTF-16
        Dec(l, 2);
        sBuffer := System.Copy(sBuffer, 3, l);
        SetLength(Result, l div 2);
        CopyMemory(Pointer(Result), pch, l);
        FEncoding := ENCODING_UTF16;
      end
      else if (pch[0] = $fe) and (pch[1] = $ff) then begin //UTF-16 big endian
        Dec(l, 2);
        sBuffer := System.Copy(sBuffer, 3, l);
        SetLength(Result, l div 2);
        CopyMemory(Pointer(Result), pch, l);
        FEncoding := ENCODING_UTF16_BIG_ENDIAN;
        for I := 0 to l div 2 - 1 do
          pResult[i] := ((pResult[i] and $ff) shl 8) or (pResult[i] shr 8);
      end
      else if (pch[0] = $EF) and (pch[1] = $BB) and (pch[2] = $BF) then begin
        Dec(l, 3);
        sBuffer := System.Copy(sBuffer, 4, l);
        Result := Utf8ToString(sBuffer);
        FEncoding := ENCODING_UTF8;
      end;
    if Result = '' then
      if IsUtf8Format then begin
        Result := Utf8ToString(sBuffer);
        FEncoding := ENCODING_UTF8;
      end
      else begin
        Result := UnicodeString(sBuffer);
        FEncoding := ENCODING_ANSI;
      end;
  end;

begin
  OnModified := nil;
  SetText(LoadTextFile);
  FFileName := AFileName;
  OnMarginClick := nil;
  SetSavePoint;
  EmptyUndoBuffer;
  case GetLineCount of
    0..9:
      SetMarginWidthN(0, 16);
    10..99:
      SetMarginWidthN(0, 24);
    100..999:
      SetMarginWidthN(0, 32);
    1000..9999:
      SetMarginWidthN(0, 48);
    else
      SetMarginWidthN(0, 64);
  end;
  OnMarginClick := SciteMarginClick;
  OnModified := SciteModified;
end;

procedure TScintillaEx.ReplaceStr(const ASearchStr, AReplaceStr: string;
  AOptions: TSearchOptionsSet);
var
  SearchFlags: Integer;
begin
  SearchFlags := GetSearchFlags(AOptions);
  if foReplaceAll in AOptions then begin
    SetTargetStart(0);
    SetTargetEnd(GetLength);
    while SearchNext(SearchFlags, ASearchStr) >= 0 do begin
      ReplaceSel(AReplaceStr);
      SetTargetStart(0);
      SetTargetEnd(GetLength);
    end;
  end
  else begin
    if (GetSelText = '') or
      (GetTextRange(GetTargetStart, GetTargetEnd) <> GetSelText) then
      if not FindStr(ASearchStr, AOptions) then
        Exit;
    ReplaceSel(AReplaceStr);
    FindStr(ASearchStr, AOptions);
  end;
end;

procedure TScintillaEx.SaveFile(const AFileName: string);

  procedure SaveANSIFile;
  var
    a: AnsiString;
  begin
    a := AnsiString(GetText);
    with TFilestream.Create(AFileName, fmCreate or fmOpenWrite) do begin
      Write(PByte(a)^, Length(a));
      Destroy;
    end;
  end;

begin
  if FEncoding = ENCODING_ANSI then
    SaveANSIFile
  else if FEncoding = ENCODING_UTF16 then
    Lines.SaveToFile(AFileName)
  else if FEncoding = ENCODING_UTF8 then
    Lines.SaveToFileUTF8(AFileName);
  SetSavePoint;
end;

procedure TScintillaEx.SciteCharAdded(ASender: TObject; ACh: Integer);
begin
  FLastProcessedChar := ACh;
end;

procedure TScintillaEx.SciteMarginClick(ASender: TObject; AModifiers, APosition,
  AMargin: Integer);
var
  LineFold: Integer;
begin
  LineFold := LineFromPosition(APosition);
  ToggleFold(LineFold);
end;

procedure TScintillaEx.SciteModified(ASender: TObject; APosition,
  AModificationType: Integer; AText: string; ALength, ALinesAdded, ALine,
  AFoldLevelNow, AFoldLevelPrev: Integer);
begin
  SendMessage(Application.MainFormHandle, WM_MODIFY, Integer(Modified), 0);
end;

procedure TScintillaEx.SciteUpdateUI(ASender: TObject; AUpdated: Integer);

  procedure MatchBrackets;
  var
    p1, p2: Integer;
  begin
    p1 := GetCurrentPos;
    p2 := BraceMatch(p1);
    if p2 = -1 then
      BraceBadLight(-1)
    else
      BraceHighlight(p1, p2);
  end;

  function IndentStr(const ASpaceLength: Integer; const ATabWidth: Integer): string;
  var
    r, d: Integer;
  begin
    Result := '';
    d := ASpaceLength div ATabWidth;
    r := ASpaceLength mod ATabWidth;
    if d > 0 then
      Result := Result + StringOfChar(#9, d);
    if r > 0 then
      Result := Result + StringOfChar(#32, r);
  end;

var
  p, l, ch, i: Integer;
  StartPos, LinePos: Integer;
  othpos, othline, nIndent, nPrevLinePos: Integer;
  sp: string;
begin
  p := GetCurrentPos;
  l := LineFromPosition(p);
  case FLastProcessedChar of
    41, 62, 93, 125:
      begin
        ch := GetCharAt(p - 2);
        case ch of
          9, 10, 13, 32:
            begin
              StartPos := WordStartPosition(p - 1, False);
              LinePos := PositionFromLine(l);
              if StartPos = LinePos then begin
                othpos := BraceMatch(p - 1);
                othline := LineFromPosition(othpos);
                nIndent := GetLineIndentation(othline);
                SetTargetStart(StartPos);
                SetTargetEnd(p - 1);
                if EditorOptions.seoUseTabIndent then
                  sp := IndentStr(nIndent, GetTabWidth)
                else
                  sp := StringOfChar(#32, nIndent);
                Self.ReplaceTarget(sp);
              end;
            end;
        end;
      end;
    10, 13:
      if l > 0 then begin
        nIndent := GetLineIndentation(l - 1);
        nPrevLinePos := PositionFromLine(l - 1);
        ch := 32;
        i := p - 2;
        while (i >= nPrevLinePos) and (ch = 32) do begin
          ch := GetCharAt(i);
          case ch of
            32, 40, 60, 91, 123:
              nIndent := nIndent + 4;
          end;
          if EditorOptions.seoUseTabIndent then
            sp := IndentStr(nIndent, GetTabWidth)
          else
            sp := StringOfChar(#32, nIndent);
          ReplaceSel(sp);
          Dec(i);
        end;
      end;
  end;
  FLastProcessedChar := 0;
  MatchBrackets;
  SendMessage(Application.MainFormHandle, WM_STATUSBAR_UPDATE, Integer(GetOvertype), 0);
end;

procedure TScintillaEx.SetEditorStyle;
begin
  with EditorOptions do begin
    StyleSetSize(32, seoFontSize);
    StyleSetFont(32, seoFontName);
    SetTabWidth(seoTabWidth);
    SetWhitespaceFore(True, seoIndentLineColor);
    SetCaretLineBack(seoActiveLineColor);
    SetCaretLineVisible(True);
    IndicSetStyle(1, 7);
    IndicSetFore(1, seoBracketHighlightColor);
    IndicSetOutlineAlpha(1, 80);
    BraceHighlightIndicator(True, 1);
    SetIndentationGuides(seoIndentLineStyle);
    StyleSetFore(37, seoIndentLineColor);
    SetViewWS(1);
  end;
end;

end.
