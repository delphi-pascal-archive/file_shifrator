object Main: TMain
  Left = 225
  Top = 127
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1064#1080#1092#1088#1072#1090#1086#1088' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 265
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001001010080000000000280100001600000028000000100000002000
    0000010004000000000080000000000000000000000010000000000000000000
    000000840000181818002121210000737300008C8C0000A5A50083838300ADAD
    AD00BDBDBD0000D6D600D6D6D600E7E7E70000F7F700FFFFFF00000000000000
    0000000000000000000323000000009339B2A2B93300006A242542224430005A
    2445B2A45420722AD2569525B82004425CBDDBDD52440455CD333228D3444B5C
    D77B7725CDB14555C77C9727D9200035CC7C772BD520006CDD7C9725CD300006
    6779772767000000007CE930000000000009990000000000000000000000FFFF
    0000FE3F0000C0030000C0010000C00100000000000000000000000000000000
    000000000000C0010000C0010000E0030000FC1F0000FE3F0000FFFF0000}
  OldCreateOrder = False
  Position = poScreenCenter
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 308
    Height = 17
    Caption = #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091', '#1082#1086#1090#1086#1088#1099#1081' '#1085#1091#1078#1085#1086' '#1079#1072#1096#1080#1092#1088#1086#1074#1072#1090#1100':'
  end
  object VerLb: TLabel
    Left = 456
    Top = 188
    Width = 129
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'FileVersion'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = 10395294
    Font.Height = -12
    Font.Name = 'MS Serif'
    Font.Style = []
    ParentFont = False
    Transparent = False
    Layout = tlCenter
  end
  object Label6: TLabel
    Left = 456
    Top = 136
    Width = 129
    Height = 48
    Cursor = crHandPoint
    Hint = 'www.web-segment.ru'
    Alignment = taCenter
    AutoSize = False
    Caption = '(c) 2006,'#13#10'Web-Segment'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clSilver
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = False
    Layout = tlCenter
    OnClick = Label6Click
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 64
    Width = 241
    Height = 81
    Caption = ' '#1058#1080#1087' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '
    TabOrder = 0
  end
  object B64Rb: TRadioButton
    Left = 21
    Top = 112
    Width = 80
    Height = 22
    Hint = 
      #1057#1090#1072#1085#1076#1072#1088#1090#1085#1099#1081' '#1072#1083#1075#1086#1088#1080#1090#1084' '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1103' '#1076#1072#1085#1085#1099#1093'. '#1055#1088#1080#1074#1077#1076#1077#1085' '#1076#1083#1103' '#1086#1079#1085#1072#1082#1086#1084#1083#1077#1085#1080 +
      #1103' ('#1085#1077' '#1088#1077#1082#1086#1084#1077#1085#1076#1091#1077#1090#1089#1103' '#1077#1075#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100').'
    Caption = 'Base64'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = B64RbClick
  end
  object XORRb: TRadioButton
    Left = 21
    Top = 89
    Width = 226
    Height = 22
    Hint = 
      #1069#1090#1086#1090' '#1072#1083#1075#1086#1088#1080#1090#1084' '#1085#1072#1080#1073#1086#1083#1077#1077' '#1073#1089#1090#1088#1099#1081' '#1080' '#1087#1086#1079#1074#1086#1083#1103#1077#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1082#1083#1102#1095' '#1076#1083#1103' ' +
      #1079#1072#1097#1080#1090#1099', '#1074' '#1086#1090#1083#1080#1095#1080#1077' '#1086#1090' '#1072#1083#1086#1075#1088#1080#1090#1084#1072' Base64.'
    Caption = 'Mapped XOR ('#1088#1077#1082#1086#1084#1077#1085#1076#1091#1077#1090#1089#1103')'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TabStop = True
    OnClick = XORRbClick
  end
  object GoBtn: TButton
    Left = 456
    Top = 64
    Width = 129
    Height = 25
    Caption = '&'#1064#1080#1092#1088#1086#1074#1072#1090#1100'!'
    TabOrder = 3
    OnClick = GoBtnClick
  end
  object ExitBtn: TButton
    Left = 456
    Top = 232
    Width = 129
    Height = 25
    Caption = '&'#1042#1099#1093#1086#1076
    TabOrder = 4
    OnClick = ExitBtnClick
  end
  object GroupBox1: TGroupBox
    Left = 256
    Top = 64
    Width = 193
    Height = 193
    Caption = ' '#1061#1086#1076' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '
    TabOrder = 5
    object Label3: TLabel
      Left = 8
      Top = 21
      Width = 27
      Height = 16
      Caption = #1058#1080#1087':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Serif'
      Font.Style = []
      ParentFont = False
    end
    object TypeLb: TLabel
      Left = 8
      Top = 34
      Width = 176
      Height = 17
      AutoSize = False
      Caption = 'MXOR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 55
      Width = 147
      Height = 16
      Caption = #1044#1083#1080#1085#1072' '#1080#1089#1093#1086#1076#1085#1086#1075#1086' '#1092#1072#1081#1083#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Serif'
      Font.Style = []
      ParentFont = False
    end
    object InLengthLb: TLabel
      Left = 8
      Top = 71
      Width = 171
      Height = 17
      AutoSize = False
      Caption = '0 '#1041#1072#1081#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label5: TLabel
      Left = 8
      Top = 92
      Width = 172
      Height = 16
      Caption = #1044#1083#1080#1085#1072' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1086#1075#1086' '#1092#1072#1081#1083#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Serif'
      Font.Style = []
      ParentFont = False
    end
    object OutLengthLb: TLabel
      Left = 8
      Top = 107
      Width = 171
      Height = 17
      AutoSize = False
      Caption = '0 '#1041#1072#1081#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label7: TLabel
      Left = 8
      Top = 126
      Width = 101
      Height = 16
      Caption = #1058#1077#1082#1091#1097#1080#1081' '#1073#1072#1081#1090' '#8470':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Serif'
      Font.Style = []
      ParentFont = False
    end
    object CurrByteLb: TLabel
      Left = 8
      Top = 141
      Width = 176
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object ProgressBar: TProgressBar
      Left = 5
      Top = 165
      Width = 179
      Height = 12
      Smooth = True
      TabOrder = 0
    end
  end
  object UnGoBtn: TButton
    Left = 456
    Top = 96
    Width = 129
    Height = 25
    Caption = '&'#1044#1077#1096#1080#1092#1088#1086#1074#1072#1090#1100'!'
    TabOrder = 6
    OnClick = UnGoBtnClick
  end
  object FileNameEd: TFilenameEdit
    Left = 8
    Top = 32
    Width = 577
    Height = 25
    AcceptFiles = True
    DefaultExt = '*.*'
    DialogOptions = [ofHideReadOnly, ofFileMustExist, ofEnableSizing, ofForceShowHidden]
    DialogTitle = #1042#1099#1073#1086#1088' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 7
    Text = 
      #1055#1077#1088#1077#1090#1072#1097#1080#1090#1077' '#1089#1102#1076#1072' '#1092#1072#1081#1083' '#1080#1079' '#1055#1088#1086#1074#1086#1076#1085#1080#1082#1072' '#1080#1083#1080' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1077#1075#1086' '#1089' '#1087#1086#1084#1086#1097#1100#1102' '#1082#1085 +
      #1086#1087#1082#1080
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 152
    Width = 241
    Height = 105
    Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080' '
    TabOrder = 8
    object Label2: TLabel
      Left = 8
      Top = 76
      Width = 53
      Height = 16
      Caption = #1055#1072#1088#1086#1083#1100':'
    end
    object OnTopChk: TCheckBox
      Left = 10
      Top = 18
      Width = 148
      Height = 23
      Hint = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1101#1090#1086' '#1086#1082#1085#1086' '#1087#1086#1074#1077#1088#1093' '#1086#1089#1090#1072#1083#1100#1085#1099#1093' '#1074' '#1089#1080#1089#1090#1077#1084#1077'.'
      Caption = #1055#1086#1074#1077#1088#1093' '#1074#1089#1077#1093' '#1086#1082#1086#1085
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
    end
    object PassEdit: TEdit
      Left = 71
      Top = 71
      Width = 87
      Height = 24
      Hint = 
        #1050#1083#1102#1095' '#1076#1083#1103' '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1103' ('#1083#1102#1073#1086#1077' '#1094#1077#1083#1086#1077' '#1087#1086#1083#1086#1078#1080#1090#1077#1083#1100#1085#1086#1077' '#1095#1080#1089#1083#1086' '#1076#1083#1080#1085#1086#1081' '#1076#1086' 1' +
        '0 '#1089#1080#1084#1074#1086#1083#1086#1074' '#1074#1082#1083#1102#1095#1080#1090#1077#1083#1100#1085#1086')'
      MaxLength = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '1236547896'
    end
    object CopyChk: TCheckBox
      Left = 10
      Top = 42
      Width = 227
      Height = 22
      Hint = #1047#1072#1087#1080#1089#1099#1074#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1074' '#1085#1086#1074#1099#1081' '#1074#1085#1077#1096#1085#1080#1081' '#1092#1072#1081#1083'.'
      Caption = #1054#1073#1088#1072#1073#1072#1090#1099#1074#1072#1090#1100' '#1074' '#1085#1086#1074#1099#1081' '#1092#1072#1081#1083
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object Timer: TTimer
    Interval = 10
    OnTimer = TimerTimer
    Left = 356
    Top = 106
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 386
    Top = 106
  end
end
