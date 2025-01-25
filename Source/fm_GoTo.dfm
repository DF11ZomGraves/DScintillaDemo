object Form4: TForm4
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Goto'
  ClientHeight = 105
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 23
    Height = 13
    Caption = '&Line:'
  end
  object Edit1: TEdit
    Left = 16
    Top = 35
    Width = 225
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    Text = '1'
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 85
    Top = 69
    Width = 75
    Height = 25
    Caption = '&Goto'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 166
    Top = 69
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
