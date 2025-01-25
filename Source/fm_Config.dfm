object fmConfig: TfmConfig
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #36873#39033
  ClientHeight = 343
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 546
    Height = 302
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 405
    object TabSheet1: TTabSheet
      Caption = 'General'
      ExplicitHeight = 377
      object GroupBox1: TGroupBox
        Left = 16
        Top = 16
        Width = 249
        Height = 241
        Caption = 'Editor'
        TabOrder = 0
        object Label2: TLabel
          Left = 18
          Top = 22
          Width = 114
          Height = 12
          Caption = 'Default Highlighter'
        end
        object ComboBox2: TComboBox
          Left = 18
          Top = 40
          Width = 215
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 0
          Text = 'Plain Text'
          Items.Strings = (
            'Plain Text')
        end
        object CheckBox1: TCheckBox
          Left = 18
          Top = 75
          Width = 215
          Height = 17
          Caption = 'Brace Match Highlight'
          TabOrder = 1
        end
        object CheckBox2: TCheckBox
          Left = 18
          Top = 98
          Width = 215
          Height = 17
          Caption = 'Brace Bad Highlight'
          TabOrder = 2
        end
        object CheckBox3: TCheckBox
          Left = 18
          Top = 121
          Width = 215
          Height = 17
          Caption = 'Enabled Folding'
          TabOrder = 3
        end
        object CheckBox8: TCheckBox
          Left = 18
          Top = 144
          Width = 215
          Height = 17
          Caption = 'Auto Indent'
          TabOrder = 4
        end
        object CheckBox9: TCheckBox
          Left = 18
          Top = 190
          Width = 215
          Height = 17
          Caption = 'Word Wrap'
          TabOrder = 5
        end
        object CheckBox10: TCheckBox
          Left = 18
          Top = 167
          Width = 215
          Height = 17
          Caption = 'Use SPACE Tab'
          TabOrder = 6
        end
      end
      object GroupBox2: TGroupBox
        Left = 271
        Top = 16
        Width = 250
        Height = 92
        Caption = 'Save'
        TabOrder = 1
        object Label1: TLabel
          Left = 17
          Top = 29
          Width = 96
          Height = 12
          Caption = 'Default Encoding'
        end
        object ComboBox1: TComboBox
          Left = 16
          Top = 48
          Width = 225
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 0
          Text = 'ANSI'
          Items.Strings = (
            'ANSI'
            'Unicode'
            'UTF-8')
        end
      end
      object GroupBox3: TGroupBox
        Left = 271
        Top = 114
        Width = 250
        Height = 143
        Caption = 'Display'
        TabOrder = 2
        object Label4: TLabel
          Left = 18
          Top = 93
          Width = 54
          Height = 12
          Caption = 'Tab Width'
        end
        object CheckBox6: TCheckBox
          Left = 18
          Top = 24
          Width = 215
          Height = 17
          Caption = 'Show CrLf'
          TabOrder = 0
        end
        object CheckBox7: TCheckBox
          Left = 18
          Top = 47
          Width = 215
          Height = 17
          Caption = 'Show Whitespace'
          TabOrder = 1
        end
        object CheckBox5: TCheckBox
          Left = 18
          Top = 70
          Width = 215
          Height = 17
          Caption = 'Show Indent Line'
          TabOrder = 2
        end
        object Edit2: TEdit
          Left = 18
          Top = 111
          Width = 145
          Height = 20
          NumbersOnly = True
          TabOrder = 3
          Text = '4'
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 302
    Width = 546
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 405
    DesignSize = (
      546
      41)
    object Button1: TButton
      Left = 372
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 453
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
