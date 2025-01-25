object fmFindReplace: TfmFindReplace
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Find and Replace Text'
  ClientHeight = 234
  ClientWidth = 381
  Color = clBtnFace
  Constraints.MaxHeight = 270
  Constraints.MinHeight = 270
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl1: TTabControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 375
    Height = 228
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      'Find'
      'Replace')
    TabIndex = 0
    OnChange = TabControl1Change
    DesignSize = (
      375
      228)
    object Label1: TLabel
      Left = 17
      Top = 33
      Width = 60
      Height = 13
      Caption = '&Text to find:'
    end
    object Label2: TLabel
      Left = 17
      Top = 59
      Width = 65
      Height = 13
      Caption = '&Replace with:'
      Visible = False
    end
    object Label3: TLabel
      Left = 17
      Top = 207
      Width = 6
      Height = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 101
      Top = 30
      Width = 254
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
    end
    object Button1: TButton
      Left = 258
      Top = 90
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Find Next'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 258
      Top = 152
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Re&place'
      TabOrder = 2
      Visible = False
      OnClick = Button2Click
    end
    object Button3: TButton
      Tag = 1
      Left = 258
      Top = 183
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Replace &All'
      TabOrder = 3
      Visible = False
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 258
      Top = 121
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Count'
      TabOrder = 4
      OnClick = Button4Click
    end
    object GroupBox1: TGroupBox
      Left = 17
      Top = 90
      Width = 185
      Height = 111
      Caption = '&Options'
      TabOrder = 5
      object CheckBox1: TCheckBox
        Left = 6
        Top = 19
        Width = 147
        Height = 17
        Caption = '&Case Sensitive'
        TabOrder = 0
      end
      object CheckBox3: TCheckBox
        Left = 6
        Top = 42
        Width = 147
        Height = 17
        Caption = 'Search &Backward'
        TabOrder = 1
      end
      object CheckBox2: TCheckBox
        Left = 6
        Top = 65
        Width = 147
        Height = 17
        Caption = '&Whole Words Only'
        TabOrder = 2
      end
      object CheckBox4: TCheckBox
        Left = 6
        Top = 88
        Width = 147
        Height = 17
        Caption = '&Use Regular Expression'
        TabOrder = 3
      end
    end
    object ComboBox2: TComboBox
      Left = 101
      Top = 56
      Width = 254
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 6
      Visible = False
    end
  end
end
