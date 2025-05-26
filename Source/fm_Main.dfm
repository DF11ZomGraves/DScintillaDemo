object fmMain: TfmMain
  Left = 0
  Top = 0
  ClientHeight = 542
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 523
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnChange = PageControl1Change
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 523
    Width = 784
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 150
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end>
  end
  object ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 344
    Top = 176
    object PreviousTab1: TPreviousTab
      Category = 'Tab'
      TabControl = PageControl1
      Caption = '&Previous Tab'
      Enabled = False
      Hint = 'Previous|Go back to the previous tab'
    end
    object NextTab1: TNextTab
      Category = 'Tab'
      TabControl = PageControl1
      Caption = '&Next Tab'
      Enabled = False
      Hint = 'Next|Go to the next tab'
    end
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Dialog.Filter = 
        'All Files|*.*|Text File|*.txt;*.log|C++ Source|*.c;*.cpp;*.h;*.h' +
        'pp;*.cxx|Visual Basic Source|*.bas;*.vb|Visual C# Source|*.cs|Ob' +
        'ject Pascal Source|*.pas;*.dfm;*.lfm;*.dpr;*.inc|Object Pascal P' +
        'roject File|*.dproj;*.groupproj;*.bdsproj|HTML File|*.htm;*.html' +
        '|CSS File|*.css|JavaScript Script|*.js|VBScript Script|*.vbs|jav' +
        'a Source|*.java|XML File|*.xml|SQL Query File|*.sql|ASM Code|*.a' +
        'sm|Config File|*.ini|Json File|*.json|Python Source|*.py|YAML Sc' +
        'ript|*.yml|Lua Script|*.lua|Other Textfiles|*.cfg;*.properties;*' +
        '.bat'
      Dialog.Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
      OnAccept = FileOpen1Accept
    end
    object acAbout: TAction
      Caption = '&About...'
      OnExecute = acAboutExecute
    end
    object acFileNew: TAction
      Category = 'File'
      Caption = 'New'
      ShortCut = 16462
      OnExecute = acFileNewExecute
    end
    object acFileSave: TAction
      Category = 'File'
      Caption = '&Save'
      ShortCut = 16467
      OnExecute = acFileSaveExecute
    end
    object acFileSaveAs: TAction
      Category = 'File'
      Caption = 'Save &As...'
      OnExecute = acFileSaveAsExecute
    end
    object acFileSaveAll: TAction
      Category = 'File'
      Caption = 'Save All'
      OnExecute = acFileSaveAllExecute
    end
    object acFileRecovery: TAction
      Category = 'File'
      Caption = '&Recovery'
      OnExecute = acFileRecoveryExecute
    end
    object acFileClose: TAction
      Category = 'File'
      Caption = 'Close Current'
      OnExecute = acFileCloseExecute
    end
    object acFileCloseAll: TAction
      Category = 'File'
      Caption = 'Close All'
      OnExecute = acFileCloseAllExecute
    end
    object acEditUndo: TAction
      Category = 'Edit'
      Caption = '&Undo'
      ShortCut = 16474
      OnExecute = acEditUndoExecute
    end
    object acEditRedo: TAction
      Category = 'Edit'
      Caption = '&Redo'
      ShortCut = 24666
      OnExecute = acEditRedoExecute
    end
    object acEditCut: TAction
      Category = 'Edit'
      Caption = 'Cu&t'
      ShortCut = 16472
      OnExecute = acEditCutExecute
    end
    object acEditCopy: TAction
      Category = 'Edit'
      Caption = '&Copy'
      ShortCut = 16451
      OnExecute = acEditCopyExecute
    end
    object acEditPaste: TAction
      Category = 'Edit'
      Caption = '&Paste'
      ShortCut = 16470
      OnExecute = acEditPasteExecute
    end
    object acEditDelete: TAction
      Category = 'Edit'
      Caption = '&Delete'
      ShortCut = 46
      OnExecute = acEditDeleteExecute
    end
    object acEditFind: TAction
      Category = 'Edit'
      Caption = '&Find and Replace...'
      ShortCut = 16454
      OnExecute = acEditFindExecute
    end
    object acEditGoTo: TAction
      Category = 'Edit'
      Caption = '&Goto...'
      ShortCut = 16455
      OnExecute = acEditGoToExecute
    end
    object acEditSelectAll: TAction
      Category = 'Edit'
      Caption = 'Select &All'
      ShortCut = 16449
      OnExecute = acEditSelectAllExecute
    end
    object acEditToLCase: TAction
      Category = 'Edit'
      Caption = 'To &Lowercase'
      OnExecute = acEditToLCaseExecute
    end
    object acEditToUCase: TAction
      Category = 'Edit'
      Caption = 'To &Uppercase'
      OnExecute = acEditToUCaseExecute
    end
    object acViewShowWhitespace: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Show Whitespace'
      OnExecute = acViewShowWhitespaceExecute
    end
    object acViewShowIndentLine: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Show Indent Line'
      OnExecute = acViewShowIndentLineExecute
    end
    object acViewWordWrap: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Word Wrap'
      OnExecute = acViewWordWrapExecute
    end
    object acViewShowCrLf: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Show CrLf'
      OnExecute = acViewShowCrLfExecute
    end
    object acViewShowStatusBar: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Status Bar'
      Checked = True
      OnExecute = acViewShowStatusBarExecute
    end
    object acFoldAll: TAction
      Caption = 'Fold All'
      OnExecute = acFoldAllExecute
    end
    object acExpandAll: TAction
      Caption = 'Expand All'
      OnExecute = acExpandAllExecute
    end
    object Action1: TAction
      Caption = 'Action1'
      OnExecute = Action1Execute
    end
  end
  object MainMenu1: TMainMenu
    Left = 416
    Top = 176
    object F1: TMenuItem
      Caption = '&File'
      object N1: TMenuItem
        Action = acFileNew
      end
      object O1: TMenuItem
        Action = FileOpen1
      end
      object S1: TMenuItem
        Action = acFileSave
      end
      object A1: TMenuItem
        Action = acFileSaveAs
      end
      object V2: TMenuItem
        Action = acFileSaveAll
      end
      object R2: TMenuItem
        Action = acFileRecovery
        Caption = '&Revert'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object N12: TMenuItem
        Action = PreviousTab1
      end
      object N11: TMenuItem
        Action = NextTab1
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object X1: TMenuItem
        Action = FileExit1
      end
    end
    object E1: TMenuItem
      Caption = '&Edit'
      object U2: TMenuItem
        Action = acEditUndo
      end
      object U3: TMenuItem
        Action = acEditRedo
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object T1: TMenuItem
        Action = acEditCut
      end
      object C1: TMenuItem
        Action = acEditCopy
      end
      object P2: TMenuItem
        Action = acEditPaste
      end
      object D1: TMenuItem
        Action = acEditDelete
      end
      object A2: TMenuItem
        Action = acEditSelectAll
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object F2: TMenuItem
        Action = acEditFind
      end
      object G1: TMenuItem
        Action = acEditGoTo
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object U4: TMenuItem
        Action = acEditToUCase
      end
      object L1: TMenuItem
        Action = acEditToLCase
      end
    end
    object V1: TMenuItem
      Caption = '&View'
      object S2: TMenuItem
        Action = acViewShowStatusBar
        AutoCheck = True
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object E2: TMenuItem
        Action = acExpandAll
      end
      object F3: TMenuItem
        Action = acFoldAll
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object acViewShowWhitespace1: TMenuItem
        Action = acViewShowWhitespace
        AutoCheck = True
      end
      object N8: TMenuItem
        Action = acViewShowCrLf
        AutoCheck = True
      end
      object I1: TMenuItem
        Action = acViewShowIndentLine
        AutoCheck = True
      end
      object W1: TMenuItem
        Action = acViewWordWrap
        AutoCheck = True
      end
    end
    object C2: TMenuItem
      Action = Action1
      Caption = 'En&coding'
      object ANSI1: TMenuItem
        Caption = 'ANSI'
        RadioItem = True
        OnClick = ANSI1Click
      end
      object UTF81: TMenuItem
        Caption = 'UTF-8'
        RadioItem = True
        OnClick = UTF81Click
      end
      object UTF161: TMenuItem
        Caption = 'UTF-16(Unicode)'
        RadioItem = True
        OnClick = UTF161Click
      end
      object UTF162: TMenuItem
        Caption = 'UTF-16 Big Endian'
        RadioItem = True
      end
    end
    object H2: TMenuItem
      Caption = 'High&lights'
      object N7: TMenuItem
        Caption = 'Plain Text'
        OnClick = N7Click
      end
    end
    object H1: TMenuItem
      Caption = '&Help'
      object A3: TMenuItem
        Action = acAbout
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 488
    Top = 176
    object N6: TMenuItem
      Action = acFileClose
    end
    object N9: TMenuItem
      Action = acFileCloseAll
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.txt'
    Filter = 
      'Text file|*.txt;*.log|C++ Source|*.c;*.cpp;*.h;*.hpp;*.cxx|Visua' +
      'l Basic Source|*.bas;*.vb|Visual C# Source|*.cs|Object Pascal So' +
      'urce|*.pas;*.dfm;*.lfm;*.dpr;*.inc|Object Pascal Project File|*.' +
      'dproj;*.groupproj;*.bdsproj|HTML File|*.htm;*.html|CSS File|*.cs' +
      's|JavaScript Script|*.js|VBScript Script|*.vbs|java Source|*.jav' +
      'a|XML File|*.xml|SQL Query File|*.sql|ASM Code|*.asm|Config File' +
      '|*.ini|JSON File|*.json|Python Source|*.py|YAML Script|*.yml|Lua' +
      ' Script|*.lua|All Files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 344
    Top = 232
  end
  object PopupMenu2: TPopupMenu
    Left = 488
    Top = 232
    object Undo1: TMenuItem
      Action = acEditUndo
    end
    object Redo1: TMenuItem
      Action = acEditRedo
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Cut1: TMenuItem
      Action = acEditCut
    end
    object Copy1: TMenuItem
      Action = acEditCopy
    end
    object Paste1: TMenuItem
      Action = acEditPaste
    end
    object Delete1: TMenuItem
      Action = acEditDelete
    end
    object SelectAll1: TMenuItem
      Action = acEditSelectAll
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object Goto1: TMenuItem
      Action = acEditGoTo
    end
    object FoldAll1: TMenuItem
      Action = acFoldAll
    end
    object ExpandAll1: TMenuItem
      Action = acExpandAll
    end
  end
end
