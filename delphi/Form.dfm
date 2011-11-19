object Form1: TForm1
  Left = 252
  Top = 159
  Width = 725
  Height = 511
  Caption = #1052#1077#1090#1086#1076#1099' '#1086#1087#1090#1080#1084#1080#1079#1072#1094#1080#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 252
    Width = 717
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 717
    Height = 252
    ActivePage = Sheet_JG
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object Sheet_JG: TTabSheet
      Caption = #1052#1077#1090#1086#1076' '#1046#1086#1088#1076#1072#1085#1072'-'#1043#1072#1091#1089#1089#1072
      object Label_JG_N: TLabel
        Left = 488
        Top = 46
        Width = 56
        Height = 13
        Caption = #1059#1088#1072#1074#1085#1077#1085#1080#1081
      end
      object Button_JG_Eye: TButton
        Left = 480
        Top = 8
        Width = 75
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 2
        OnClick = Button_JG_EyeClick
      end
      object Grid_JG: TStringGrid
        Left = 0
        Top = 0
        Width = 393
        Height = 153
        Align = alCustom
        ColCount = 4
        FixedCols = 0
        RowCount = 3
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
      end
      object Button_JG_Solve: TButton
        Left = 400
        Top = 40
        Width = 75
        Height = 25
        Caption = #1056#1077#1096#1077#1085#1080#1077
        TabOrder = 3
        OnClick = Button_JG_SolveClick
      end
      object Button_JG_Random: TButton
        Left = 400
        Top = 8
        Width = 75
        Height = 25
        Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100
        TabOrder = 1
        OnClick = Button_JG_RandomClick
      end
      object Edit_JG: TEdit
        Left = 552
        Top = 42
        Width = 41
        Height = 21
        TabOrder = 4
        Text = '3'
        OnChange = Edit_JGChange
      end
      object UpDown1: TUpDown
        Left = 593
        Top = 42
        Width = 15
        Height = 21
        Associate = Edit_JG
        Min = 0
        Position = 3
        TabOrder = 5
        Wrap = False
      end
    end
    object Sheet_VG: TTabSheet
      Caption = #1052#1077#1090#1086#1076' '#1074#1077#1090#1074#1077#1081' '#1080' '#1075#1088#1072#1085#1080#1094
      ImageIndex = 1
      object Label_BB_N: TLabel
        Left = 488
        Top = 46
        Width = 39
        Height = 13
        Caption = #1042#1077#1088#1096#1080#1085
      end
      object Grid_BB: TStringGrid
        Left = 0
        Top = 0
        Width = 393
        Height = 153
        Align = alCustom
        ColCount = 6
        FixedCols = 0
        RowCount = 6
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
      end
      object Button_BB_Random: TButton
        Left = 400
        Top = 8
        Width = 75
        Height = 25
        Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100
        TabOrder = 1
        OnClick = Button_BB_RandomClick
      end
      object Button_BB_Eye: TButton
        Left = 480
        Top = 8
        Width = 75
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 2
        OnClick = Button_BB_EyeClick
      end
      object Button_BB_Solve: TButton
        Left = 400
        Top = 40
        Width = 75
        Height = 25
        Caption = #1056#1077#1096#1077#1085#1080#1077
        TabOrder = 3
        OnClick = Button_BB_SolveClick
      end
      object Edit_BB: TEdit
        Left = 536
        Top = 42
        Width = 41
        Height = 21
        TabOrder = 4
        Text = '4'
        OnChange = Edit_BBChange
      end
      object UpDown2: TUpDown
        Left = 577
        Top = 42
        Width = 15
        Height = 21
        Associate = Edit_BB
        Min = 0
        Position = 4
        TabOrder = 5
        Wrap = False
      end
    end
    object Sheet_Search: TTabSheet
      Caption = #1052#1077#1090#1086#1076#1099' '#1087#1086#1080#1089#1082#1072
      ImageIndex = 2
      object Label_Search_a: TLabel
        Left = 304
        Top = 12
        Width = 6
        Height = 13
        Caption = 'a'
      end
      object Label_Search_b: TLabel
        Left = 304
        Top = 36
        Width = 6
        Height = 13
        Caption = 'b'
      end
      object Label_Search_eps: TLabel
        Left = 304
        Top = 60
        Width = 17
        Height = 13
        Caption = 'eps'
      end
      object Label_Search_n: TLabel
        Left = 304
        Top = 84
        Width = 8
        Height = 13
        Caption = 'N'
      end
      object Edit_Search_a: TEdit
        Left = 328
        Top = 8
        Width = 49
        Height = 21
        TabOrder = 0
        Text = '-4'
        OnExit = Edit_Search_aExit
      end
      object Edit_Search_b: TEdit
        Left = 328
        Top = 32
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '8'
        OnExit = Edit_Search_bExit
      end
      object Edit_Search_eps: TEdit
        Left = 328
        Top = 56
        Width = 49
        Height = 21
        TabOrder = 2
        Text = '0,01'
        OnExit = Edit_Search_epsExit
      end
      object Edit_Search_n: TEdit
        Left = 328
        Top = 80
        Width = 33
        Height = 21
        TabOrder = 3
        Text = '17'
        OnChange = Edit_Search_nChange
      end
      object UpDown3: TUpDown
        Left = 361
        Top = 80
        Width = 15
        Height = 21
        Associate = Edit_Search_n
        Min = 0
        Position = 17
        TabOrder = 4
        Wrap = False
      end
      object Button_Search_Passive: TButton
        Left = 392
        Top = 8
        Width = 153
        Height = 25
        Caption = #1055#1072#1089#1089#1080#1074#1085#1099#1081' '#1087#1086#1080#1089#1082
        TabOrder = 5
        OnClick = Button_Search_PassiveClick
      end
      object Button_Search_Dichotomy: TButton
        Left = 392
        Top = 40
        Width = 153
        Height = 25
        Caption = #1052#1077#1090#1086#1076' '#1076#1080#1093#1086#1090#1086#1084#1080#1080
        TabOrder = 6
        OnClick = Button_Search_DichotomyClick
      end
      object Button_Search_Fib: TButton
        Left = 392
        Top = 72
        Width = 153
        Height = 25
        Caption = #1052#1077#1090#1086#1076' '#1060#1080#1073#1086#1085#1072#1095#1095#1080
        TabOrder = 7
        OnClick = Button_Search_FibClick
      end
      object Button_Search_Gold: TButton
        Left = 392
        Top = 104
        Width = 153
        Height = 25
        Caption = #1052#1077#1090#1086#1076' "'#1079#1086#1083#1086#1090#1086#1075#1086' '#1089#1077#1095#1077#1085#1080#1103'"'
        TabOrder = 8
        OnClick = Button_Search_GoldClick
      end
      object Chart_Search: TChart
        Left = 0
        Top = 0
        Width = 281
        Height = 211
        AllowZoom = False
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          '')
        Title.Visible = False
        BottomAxis.Title.Caption = 'f(x) = x^4 + 14 x^3 + 60 x^2 + 70 x'
        Legend.Visible = False
        View3D = False
        BevelOuter = bvNone
        TabOrder = 9
        object Series_Search: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'f(x)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
      end
    end
    object Sheet_Grad: TTabSheet
      Caption = #1043#1088#1072#1076#1080#1077#1085#1090#1085#1099#1077' '#1084#1077#1090#1086#1076#1099
      ImageIndex = 3
      object Label_Grad_a: TLabel
        Left = 304
        Top = 12
        Width = 6
        Height = 13
        Caption = 'a'
      end
      object Label_Grad_b: TLabel
        Left = 304
        Top = 36
        Width = 6
        Height = 13
        Caption = 'b'
      end
      object Label_Grad_eps: TLabel
        Left = 304
        Top = 60
        Width = 17
        Height = 13
        Caption = 'eps'
      end
      object Label_Grad_h: TLabel
        Left = 304
        Top = 84
        Width = 6
        Height = 13
        Caption = 'h'
      end
      object Edit_Grad_a: TEdit
        Left = 328
        Top = 8
        Width = 49
        Height = 21
        TabOrder = 0
        Text = '2'
        OnExit = Edit_Grad_aExit
      end
      object Edit_Grad_b: TEdit
        Left = 328
        Top = 32
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '7'
        OnExit = Edit_Grad_bExit
      end
      object Edit_Grad_eps: TEdit
        Left = 328
        Top = 56
        Width = 49
        Height = 21
        TabOrder = 2
        Text = '0,01'
        OnExit = Edit_Grad_epsExit
      end
      object Button_Grad_1st: TButton
        Left = 392
        Top = 8
        Width = 153
        Height = 25
        Caption = #1052#1077#1090#1086#1076' 1-'#1075#1086' '#1087#1086#1088#1103#1076#1082#1072
        TabOrder = 3
        OnClick = Button_Grad_1stClick
      end
      object Button_Grad_1stmod: TButton
        Left = 392
        Top = 40
        Width = 153
        Height = 25
        Caption = #1052#1077#1090#1086#1076' 1-'#1075#1086' '#1087#1086#1088#1103#1076#1082#1072' ('#1084#1086#1076'.)'
        TabOrder = 4
        OnClick = Button_Grad_1stmodClick
      end
      object Button_Grad_2nd: TButton
        Left = 392
        Top = 72
        Width = 153
        Height = 25
        Caption = #1052#1077#1090#1086#1076' 2-'#1075#1086' '#1087#1086#1088#1103#1076#1082#1072
        TabOrder = 5
        OnClick = Button_Grad_2ndClick
      end
      object Edit_Grad_h: TEdit
        Left = 328
        Top = 80
        Width = 49
        Height = 21
        TabOrder = 6
        Text = '0,8'
        OnExit = Edit_Grad_hExit
      end
      object Chart_Grad: TChart
        Left = 0
        Top = 0
        Width = 281
        Height = 211
        AllowZoom = False
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          '')
        Title.Visible = False
        BottomAxis.Title.Caption = 'f(x) = (x - 4)^2 + 1'
        Legend.Visible = False
        View3D = False
        BevelOuter = bvNone
        TabOrder = 7
        object Series_Grad: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'f(x)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
      end
    end
    object Sheet_Simpl: TTabSheet
      Caption = #1057#1080#1084#1087#1083#1077#1082#1089#1085#1099#1081' '#1084#1077#1090#1086#1076
      ImageIndex = 4
      object Grid_Simpl_c: TStringGrid
        Left = 0
        Top = 0
        Width = 393
        Height = 28
        Align = alCustom
        ColCount = 2
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
      end
      object Grid_Simpl_ogr: TStringGrid
        Left = 0
        Top = 32
        Width = 393
        Height = 153
        ColCount = 3
        FixedCols = 0
        RowCount = 3
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 1
      end
      object Button_Simpl_Random: TButton
        Left = 400
        Top = 8
        Width = 75
        Height = 25
        Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100
        TabOrder = 2
        OnClick = Button_Simpl_RandomClick
      end
      object Button_Simpl_Fill: TButton
        Left = 480
        Top = 8
        Width = 75
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 3
        OnClick = Button_Simpl_FillClick
      end
      object Button_Simple_Solve: TButton
        Left = 400
        Top = 40
        Width = 75
        Height = 25
        Caption = #1056#1077#1096#1077#1085#1080#1077
        TabOrder = 4
        OnClick = Button_Simple_SolveClick
      end
    end
    object Sheet_Dyn: TTabSheet
      Caption = #1044#1080#1085#1072#1084#1080#1095#1077#1089#1082#1086#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1080#1088#1086#1074#1072#1085#1080#1077
      ImageIndex = 5
      object Grid_Dyn_mx: TStringGrid
        Left = 0
        Top = 0
        Width = 263
        Height = 103
        Align = alCustom
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
      end
      object Grid_Dyn_my: TStringGrid
        Left = 272
        Top = 0
        Width = 263
        Height = 103
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 1
      end
      object Button_Dyn_Random: TButton
        Left = 544
        Top = 8
        Width = 75
        Height = 25
        Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100
        TabOrder = 2
        OnClick = Button_Dyn_RandomClick
      end
      object Button_Dyn_Fill: TButton
        Left = 544
        Top = 40
        Width = 75
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 3
        OnClick = Button_Dyn_FillClick
      end
      object Button_Dyn_Solve: TButton
        Left = 544
        Top = 72
        Width = 75
        Height = 25
        Caption = #1056#1077#1096#1077#1085#1080#1077
        TabOrder = 4
        OnClick = Button_Dyn_SolveClick
      end
    end
    object Sheet_Brach: TTabSheet
      Caption = #1047#1072#1076#1072#1095#1072' '#1086' '#1073#1088#1072#1093#1080#1089#1090#1086#1093#1088#1086#1085#1077
      ImageIndex = 6
      object Button_Brach_Solve: TButton
        Left = 296
        Top = 8
        Width = 75
        Height = 25
        Caption = #1056#1077#1096#1077#1085#1080#1077
        TabOrder = 0
        OnClick = Button_Brach_SolveClick
      end
      object Chart_Brach: TChart
        Left = 0
        Top = 0
        Width = 281
        Height = 211
        AllowZoom = False
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          '')
        Title.Visible = False
        Legend.Visible = False
        View3D = False
        BevelOuter = bvNone
        TabOrder = 1
        object Series_Brach: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'f(x)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
      end
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 255
    Width = 717
    Height = 210
    Align = alBottom
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 232
    object N1: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnClick = N1Click
    end
  end
end
