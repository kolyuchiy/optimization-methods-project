unit Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, Math, StdCtrls, Matrix, ExtCtrls, IntStack,
  Menus, About, TeEngine, Series, TeeProcs, Chart;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    Sheet_JG: TTabSheet;
    Sheet_VG: TTabSheet;
    Sheet_Search: TTabSheet;
    Sheet_Grad: TTabSheet;
    Sheet_Simpl: TTabSheet;
    Sheet_Dyn: TTabSheet;
    Sheet_Brach: TTabSheet;
    Grid_JG: TStringGrid;
    Button_JG_Solve: TButton;
    Memo1: TMemo;
    Button_JG_Random: TButton;
    Button_JG_Eye: TButton;
    Splitter1: TSplitter;
    Grid_BB: TStringGrid;
    Button_BB_Random: TButton;
    Button_BB_Eye: TButton;
    Button_BB_Solve: TButton;
    Edit_JG: TEdit;
    UpDown1: TUpDown;
    Label_JG_N: TLabel;
    Label_BB_N: TLabel;
    Edit_BB: TEdit;
    UpDown2: TUpDown;
    Label_Search_a: TLabel;
    Edit_Search_a: TEdit;
    Edit_Search_b: TEdit;
    Edit_Search_eps: TEdit;
    Edit_Search_n: TEdit;
    Label_Search_b: TLabel;
    Label_Search_eps: TLabel;
    Label_Search_n: TLabel;
    UpDown3: TUpDown;
    Button_Search_Passive: TButton;
    Button_Search_Dichotomy: TButton;
    Button_Search_Fib: TButton;
    Button_Search_Gold: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Edit_Grad_a: TEdit;
    Edit_Grad_b: TEdit;
    Edit_Grad_eps: TEdit;
    Label_Grad_a: TLabel;
    Label_Grad_b: TLabel;
    Label_Grad_eps: TLabel;
    Button_Grad_1st: TButton;
    Button_Grad_1stmod: TButton;
    Button_Grad_2nd: TButton;
    Edit_Grad_h: TEdit;
    Label_Grad_h: TLabel;
    Grid_Simpl_c: TStringGrid;
    Grid_Simpl_ogr: TStringGrid;
    Button_Simpl_Random: TButton;
    Button_Simpl_Fill: TButton;
    Button_Simple_Solve: TButton;
    Grid_Dyn_mx: TStringGrid;
    Grid_Dyn_my: TStringGrid;
    Button_Dyn_Random: TButton;
    Button_Dyn_Fill: TButton;
    Button_Dyn_Solve: TButton;
    Button_Brach_Solve: TButton;
    Chart_Search: TChart;
    Series_Search: TLineSeries;
    Chart_Grad: TChart;
    Series_Grad: TLineSeries;
    Chart_Brach: TChart;
    Series_Brach: TLineSeries;
    procedure Button_JG_EyeClick(Sender: TObject);
    procedure Button_JG_RandomClick(Sender: TObject);
    procedure Button_JG_SolveClick(Sender: TObject);
    procedure Button_BB_EyeClick(Sender: TObject);
    procedure Button_BB_RandomClick(Sender: TObject);
    procedure Button_BB_SolveClick(Sender: TObject);
    procedure Edit_JGChange(Sender: TObject);
    procedure Edit_BBChange(Sender: TObject);
    procedure Edit_Search_nChange(Sender: TObject);
    procedure Button_Search_PassiveClick(Sender: TObject);
    procedure Edit_Search_aExit(Sender: TObject);
    procedure Edit_Search_bExit(Sender: TObject);
    procedure Edit_Search_epsExit(Sender: TObject);
    procedure Button_Search_DichotomyClick(Sender: TObject);
    procedure Button_Search_FibClick(Sender: TObject);
    procedure Button_Search_GoldClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Button_Grad_1stClick(Sender: TObject);
    procedure Button_Grad_1stmodClick(Sender: TObject);
    procedure Button_Grad_2ndClick(Sender: TObject);
    procedure Edit_Grad_aExit(Sender: TObject);
    procedure Edit_Grad_bExit(Sender: TObject);
    procedure Edit_Grad_epsExit(Sender: TObject);
    procedure Edit_Grad_hExit(Sender: TObject);
    procedure Button_Simpl_FillClick(Sender: TObject);
    procedure Button_Simpl_RandomClick(Sender: TObject);
    procedure Button_Simple_SolveClick(Sender: TObject);
    procedure Button_Dyn_RandomClick(Sender: TObject);
    procedure Button_Dyn_FillClick(Sender: TObject);
    procedure Button_Dyn_SolveClick(Sender: TObject);
    procedure Button_Brach_SolveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    jg_matrix: TMatrix;
    bb_matrix: TMatrix;
    search_a: double;
    search_b: double;
    search_eps: double;
    search_n: integer;
    grad_a: double;
    grad_b: double;
    grad_eps: double;
    grad_h: double;
    simpl_c: TArray;
    simpl_ogr: TMatrix;
    dyn_mx: TMatrix;
    dyn_my: TMatrix;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

(* Метод Жордана-Гаусса
 *
 *
 *)

procedure JG_Exclude(var matrix: TMatrix; iter: integer);
var i,j: integer;
    t: double;
    BadMatrix: boolean;
begin
  BadMatrix := True;
  for j := iter to leny(matrix)-1 do
    if not (matrix[iter,j] = 0) then begin
      BadMatrix := False;
      break;
    end;
  if BadMatrix then raise Exception.Create('Матрица вырождена');
  if not (iter = j) then SwapRows(matrix,j,iter);

  t := matrix[iter,iter];
  if not (matrix[iter,iter] = 1) then
    for i := 0 to lenx(matrix)-1 do
      matrix[i,iter] := matrix[i,iter]/t;

  for j := 0 to leny(matrix)-1 do
    if not (j = iter) then begin
      t := matrix[iter,j];
      for i := 0 to lenx(matrix)-1 do
        matrix[i,j] := matrix[i,j] - matrix[i,iter]*t;
    end;
end;

procedure JG_Solve(matrix: TMatrix; grid: TStringGrid; memo: TMemo);
var i: integer;
begin
  memo.Lines.Append('-- Решение СЛАУ методом Жордана-Гаусса');
  WriteMatrix(matrix,memo);
  for i:= 0 to leny(matrix)-1 do begin
    memo.Lines.Append('Исключение '+IntToStr(i+1)+'-й переменной');
    JG_Exclude(matrix,i);
    WriteMatrix(matrix,memo);
    WriteMatrix(matrix,grid);
  end;
end;

(* Метод ветвей и границ
 *
 *
 *)

function BB_Reduce(const m: TMatrix; x, y: integer): TMatrix;
var i,j: integer;
    n: TMatrix;
begin
  SetLength(n,lenx(m),leny(m));
  for i:=0 to lenx(m)-1 do
  for j:=0 to leny(m)-1 do
    if (i = x) or (j = y) then n[i,j] := Infinity
    else n[i,j] := m[i,j];
  BB_Reduce := n;
end;

function BB_LowerBound(var m: TMatrix): double;
var i,j: integer;
    min,len: double;
begin
  len := 0;
  for j:= 0 to leny(m)-1 do begin
    min := m[0,j];
    for i:= 1 to lenx(m)-1 do
      if m[i,j] < min then min := m[i,j];

    if not IsInfinite(min) then begin
      len := len + min;
      for i:= 0 to lenx(m)-1 do
        m[i,j] := m[i,j] - min;
    end;
  end;

  for i:= 0 to lenx(m)-1 do begin
    min := m[i,0];
    for j:= 1 to leny(m)-1 do
      if m[i,j] < min then min := m[i,j];

    if not IsInfinite(min) then begin
      len := len + min;
      for j:= 0 to leny(m)-1 do
        m[i,j] := m[i,j] - min;
    end;
  end;

  BB_LowerBound := len;
end;

procedure BB_Solve(const m: TMatrix; start: integer;
                   grid: TStringGrid; memo: TMemo);
var thefirst: integer;
    thebest: double;
    temps, bests: TIntStack;
    s: string;
procedure BB_Walk(m: TMatrix; start: integer; len: double); (* Вложенная *)
var i: integer;
    atleast: double;
    isLeaf: boolean;
begin
  WriteMatrix(m,memo);
  WriteMatrix(m,grid);
  memo.Lines.Append('Вершина: ' + IntToStr(start)
                + '; путь: ' + FloatToStr(len));
  if len >= thebest then begin
    memo.Lines.Append('- отсечение ветви');
    exit;
  end;

  Push(temps,start);

  isLeaf := true;
  atleast := BB_LowerBound(m);
  for i:= 0 to Length(m)-1 do
    if i = thefirst then continue
    else if not IsInfinite(m[i,start]) then begin
      isLeaf := false;
      BB_Walk(BB_Reduce(m,i,start),i,len+atleast+m[i,start]);
    end;

  i := thefirst;
  if isLeaf and not IsInfinite(m[i,start]) then begin
    isLeaf := false;
    BB_Walk(BB_Reduce(m,i,start),i,len+atleast+m[i,start]);
  end;

  if isLeaf then begin
    if len < thebest then begin
      thebest := len;
      IntStackCopy(temps,bests); 
    end;
    memo.Lines.Append('- конец ветви');
  end;

  Pop(temps);
end;
begin
  IntStackInit(temps);
  IntStackInit(bests);
  thefirst := 0;
  thebest := Infinity;
  memo.Lines.Append('-- Решение задачи коммивояжера методом ветвей и границ:');
  BB_Walk(m,thefirst,0);
  memo.Lines.Append('Длина наименьшего пути: '+FloatToStr(thebest));
  while Length(bests) > 0 do s := s+IntToStr(Pop(bests))+' <- ';
  memo.Lines.Append('Наименьший путь: '+s);
end;

(* Методы поиска
 *
 *
 *)

type TRealFunc = function(x: double): double;
type TInterval = record a: double; b: double; end;

function search_f(x: double): double;
begin
  search_f := Power(x, 4) - 14*Power(x,3) + 60*Power(x,2) - 70*x;
end;

function grad_f(x: double): double;
begin
  grad_f := Power(x-4,2) + 1;
end;

function grad_df(x: double): double;
begin
  grad_df := 2*(x-4);
end;

function grad_d2f(x: double): double;
begin
  grad_d2f := 2;
end;

function xi(i: integer; a,h: double): double;
begin
  xi := a + h*i;
end;

function prev(i,mini: integer): integer;
begin
  if i = mini then prev := i
  else prev := i-1;
end;

function next(i,maxi: integer): integer;
begin
  if i = maxi then next := i
  else next := i+1;
end;

function passive(f: TRealFunc; a, b, eps: double): TInterval;
var N, i, imin: integer;
    t, min, h: double;
begin
  h := eps/2;
  N := trunc((b-a) / h);

  imin := 0;
  min := f(xi(imin,a,h));
  for i:= 1 to N do begin
    t := f(xi(i,a,h));
    if t < min then begin
      min := t;
      imin := i;
    end;
  end;

  passive.a := xi(prev(imin,0), a, h);
  passive.b := xi(next(imin,N), a, h);
end;

function minof4(a: array of double): integer;
var i,imin: integer;
begin
  imin := 0;
  for i:= 1 to 3 do
    if a[i] < a[imin] then imin := i;
  minof4 := imin+1;
end;

function dichotomy(f: TRealFunc; a, b, eps: double; memo: TMemo): TInterval;
var delta: double;
    newi,i,maxcycles: integer;
    x,y: array[1..4] of double;
    s: string;
begin
  delta := eps/2;
  x[1] := a; y[1] := f(x[1]);
  x[4] := b; y[4] := f(x[4]);
  x[2] := (x[1]+x[4])/2 - delta/2; y[2] := f(x[2]);
  x[3] := (x[1]+x[4])/2 + delta/2; y[3] := f(x[3]);

  if abs(x[2]-x[3]) = 0 then
    raise Exception.Create('Переменная eps слишком мала');

  maxcycles := 999;
  while not (x[4]-x[1] < eps) do begin
    newi := minof4(y);

    s := '';
    for i:= 1 to 4 do s := s + FloatToStr(x[i]) + #9;
    memo.Lines.Append(s);

    x[1] := x[prev(newi,1)]; y[1] := y[prev(newi,1)];
    x[4] := x[next(newi,4)]; y[4] := y[prev(newi,4)];
    x[2] := (x[1]+x[4])/2 - delta/2; y[2] := f(x[2]);
    x[3] := (x[1]+x[4])/2 + delta/2; y[3] := f(x[3]);

    dec(maxcycles);
    if maxcycles = 0 then raise Exception.Create('Метод не сходится');
  end;

  dichotomy.a := x[1];
  dichotomy.b := x[4];
end;

function fib(n: integer): integer;
begin
  if n > 2 then fib := fib(n-1) + fib(n-2)
  else fib := 1;
end;

function fibonacci(f: TRealFunc; a, b, eps: double; n: integer;
                   memo: TMemo): TInterval;
var x,y: array[1..4] of double;
    i,j: integer;
    t: double;
    s: string;
begin
  t := ((b-a)*fib(n-1)+eps*sign(n))/fib(n);
  x[1] := a;                      y[1] := f(x[1]);
  x[4] := b;                      y[4] := f(x[4]);
  x[2] := x[4] - t;               y[2] := f(x[2]);
  x[3] := x[1] + t;               y[3] := f(x[3]);

  for i:= 1 to n-3 do begin
    s := '';
    for j:= 1 to 4 do s := s + FloatToStr(x[j]) + #9;
    memo.Lines.Append(s);

    if y[2] < y[3] then begin
      x[4] := x[3];               y[4] := y[3];
      x[3] := x[2];               y[3] := y[2];
      x[2] := x[4] - x[3] + x[1]; y[2] := f(x[2]);
    end
    else begin
      x[1] := x[2];               y[1] := y[2];
      x[2] := x[3];               y[2] := y[3];
      x[3] := x[1] + x[4] - x[2]; y[3] := f(x[3]);
    end;
  end;

  fibonacci.a := x[1];
  fibonacci.b := x[4];
end;

function goldenratio(f: TRealFunc; a, b, eps: double; memo: TMemo): TInterval;
var x,y: array[1..4] of double;
    j: integer;
    s: string;
    tau: double;
begin
  tau := (1 + sqrt(5))/2;
  x[1] := a;                      y[1] := f(x[1]);
  x[4] := b;                      y[4] := f(x[4]);
  x[2] := x[4] - (x[4]-x[1])/tau; y[2] := f(x[2]);
  x[3] := x[1] + (x[4]-x[1])/tau; y[3] := f(x[3]);

  while not (x[4]-x[1] < eps) do begin
    s := '';
    for j:= 1 to 4 do s := s + FloatToStr(x[j]) + #9;
    memo.Lines.Append(s);
    
    if y[2] < y[3] then begin
      x[4] := x[3];               y[4] := y[3];
      x[3] := x[2];               y[3] := y[2];
      x[2] := x[4] - x[3] + x[1]; y[2] := f(x[2]);
    end
    else begin
      x[1] := x[2];               y[1] := y[2];
      x[2] := x[3];               y[2] := y[3];
      x[3] := x[1] + x[4] - x[2]; y[3] := f(x[3]);
    end;
  end;

  goldenratio.a := x[1];
  goldenratio.b := x[4];
end;

(* Градиентные методы
 *
 *
 *)

function firstorder(f,df: TRealFunc; a, b, h, eps: double; memo: TMemo): double;
var prevx,x: double;
    maxcycles: integer;
begin
  memo.Lines.Append('x'+#9
                   +'f'+#9
                   +'df'+#9
                   +'h');
  x := b;
  maxcycles := 999;
  repeat
    dec(maxcycles);
    if maxcycles = 0 then raise Exception.Create('Метод не сходится');
    memo.Lines.Append(FloatToStr(x)+#9
                     +FloatToStr(f(x))+#9
                     +FloatToStr(df(x))+#9
                     +FloatToStr(h));
    prevx := x;
    x := x - h * df(x);
  until abs(prevx-x) < eps;

  firstorder := x;
end;

function firstorderext(f,df: TRealFunc; a, b, h, eps: double; memo: TMemo): double;
var prevx,prevdf,x,t: double;
    maxcycles: integer;
begin
  memo.Lines.Append('x'+#9
                   +'f'+#9
                   +'df'+#9
                   +'h');
  x := b; prevx := a; prevdf := df(x);
  memo.Lines.Append(FloatToStr(x)+#9
                   +FloatToStr(f(x))+#9
                   +FloatToStr(df(x))+#9
                   +FloatToStr(h));
  maxcycles := 999;
  repeat
    dec(maxcycles);
    if maxcycles = 0 then raise Exception.Create('Метод не сходится');

    t := x;
    x := x - h * df(x);

    if not (f(x) - f(prevx) <= -eps*h*Power(abs(df(x)),2)) then begin
      x := t;
      h := h / 2;
      continue;
    end;

    if sign(df(x)) = sign(prevdf) then begin
      x := t;
      h := h * 4/3;
      continue;
    end;

    prevx := t;
    prevdf := df(x);

    memo.Lines.Append(FloatToStr(x)+#9
                     +FloatToStr(f(x))+#9
                     +FloatToStr(df(x))+#9
                     +FloatToStr(h));
  until abs(prevx-x) < eps;

  firstorderext := x;
end;

function secondorder(f,df,d2f: TRealFunc; a, b, h, eps: double; memo: TMemo): double;
var prevx,x: double;
    maxcycles: integer;
begin
  memo.Lines.Append('x'+#9
                   +'f'+#9
                   +'df/d2f'+#9
                   +'h');
  x := b;
  memo.Lines.Append(FloatToStr(x)+#9
                   +FloatToStr(f(x))+#9
                   +FloatToStr(df(x)/d2f(x))+#9
                   +FloatToStr(h));
  maxcycles := 999;
  repeat
    dec(maxcycles);
    if maxcycles = 0 then raise Exception.Create('Метод не сходится');

    prevx := x;
    x := x - h * df(x) / d2f(x);

    memo.Lines.Append(FloatToStr(x)+#9
                     +FloatToStr(f(x))+#9
                     +FloatToStr(df(x)/d2f(x))+#9
                     +FloatToStr(h));
  until abs(prevx-x) < eps;

  secondorder := x;
end;

(* Симплексный метод
 *
 *
 *)

procedure Simplex_Exclude(var matrix: TMatrix; n,m: integer);
var i,j: integer;
    t: extended;
begin
  for j := 0 to leny(matrix)-1 do begin
    if j = m then continue;
    t := matrix[n,j];
    for i := 0 to lenx(matrix)-1 do
      matrix[i,j] := matrix[i,j] - matrix[i,m]*t;
  end;
end;

function simplex(var c: TArray; var ogr: TMatrix; memo: TMemo): TArray;
var i,j,t,imin,jmin: integer;
    EOC: boolean;
    tt: double;
    a: TMatrix;
    cd,d,m1,res: TArray;
    maxcycles: integer;
begin
  t := Length(c);
  SetLength(c,t+leny(ogr)+1);
  for i:= t to length(c)-1 do c[i] := 0;
  SetLength(a,lenx(ogr)+leny(ogr),leny(ogr));
  for j:= 0 to leny(a)-1 do
  for i:= 0 to lenx(a)-1 do
    if i < lenx(ogr)-1 then a[i,j] := ogr[i,j]
    else if i = j+lenx(ogr)-1 then a[i,j] := 1
    else if i = lenx(a)-1 then a[i,j] := ogr[lenx(ogr)-1,j]
    else a[i,j] := 0;

  SetLength(m1,lenx(a));

  SetLength(d,leny(a));
  for i:= 0 to Length(d)-1 do d[i] := i + leny(a)-1;
  SetLength(cd,leny(a));

  maxcycles := 99;
  repeat
    dec(maxcycles);
    if maxcycles = 0 then
      raise Exception.Create('Метод не сходится');

  for i:= 0 to Length(cd)-1 do cd[i] := c[round(d[i])];

  memo.Lines.Append('D:'); WriteArray(d,memo);
  memo.Lines.Append('Cб:'); WriteArray(cd,memo);
  memo.Lines.Append('C:'); WriteArray(c,memo);
  memo.Lines.Append('A|B:'); WriteMatrix(a,memo);

  for i:= 0 to Length(m1)-1 do begin
    m1[i] := 0;
    for j:= 0 to Length(m1)-1 do
      m1[i] := m1[i] + cd[j] * a[i,j];
    m1[i] := m1[i] - c[i];
  end;

  memo.Lines.Append('A|B (m+1):'); WriteArray(m1,memo);

  EOC := True;
  for i:= 0 to Length(m1)-1 do
    if m1[i] < 0 then begin
      EOC := False;
      break;
    end;
  if EOC then break;

  imin := 0;
  for i:= 1 to length(m1)-1 do
    if m1[i] < m1[imin] then imin := i;

  jmin := 0;
  for j:= 1 to leny(a)-1 do
    if not (a[imin,j] = 0) and
       not (a[imin,jmin] = 0) then
    if a[lenx(a)-1,j] / a[imin,j] < a[lenx(a)-1,jmin] / a[imin,jmin] then 
      jmin := j;

  tt := a[imin,jmin];
  d[jmin] := imin;
  cd[jmin] := c[jmin+t];
  for i:= 0 to lenx(a)-1 do
    a[i,jmin] := a[i,jmin] / tt;
  Simplex_Exclude(a,imin,jmin);

  until false;

  SetLength(res,lenx(a));
  for i:= 0 to Length(res)-1 do res[i] := 0;
  for i:= 0 to Length(d)-1 do res[round(d[i])] := a[lenx(a)-1,i];
  res[lenx(a)-1] := m1[length(m1)-1];

  simplex := res;
end;

(* Динамическое программирование
 *
 *
 *)

type TCompareFun = function(a,b: double): integer;

function less(a,b: double): integer;
begin
  if a < b then less := 1
  else if a = b then less := 0
  else less := -1;
end;

function greater(a,b: double): integer;
begin
  if a > b then greater := 1
  else if a = b then greater := 0
  else greater := -1;
end;

function dynamic_progr(mx, my: TMatrix; compare: TCompareFun; memo: TMemo): TMatrix;
var i,j: integer;
    t: TMatrix;
begin
  memo.Lines.Append('(Число в ячейке соответствует цене перемещения в соотв. клетку)');
  memo.Lines.Append('Матрица перемещений по горизонтали:');
  WriteMatrix(mx, memo);
  memo.Lines.Append('Матрица перемещений по вертикали:');
  WriteMatrix(my, memo);
 
  SetLength(t, lenx(mx), leny(my));

  for i:= 0 to lenx(mx)-1 do
  for j:= 0 to leny(my)-1 do 
    if (i = 0) and (j = 0) then 
      t[i,j] := 0
    else if j = 0 then 
      t[i,j] := t[i-1,j] + mx[i,j]
    else if i = 0 then
      t[i,j] := t[i,j-1] + my[i,j]
    else if compare(mx[i,j]+t[i-1,j], my[i,j]+t[i,j-1]) <> -1 then 
      t[i,j] := t[i-1,j] + mx[i,j]
    else if compare(my[i,j]+t[i,j-1], mx[i,j]+t[i-1,j]) <> -1 then
      t[i,j] := t[i,j-1] + my[i,j];

  dynamic_progr := t; 
end;

function getpath(m: TMatrix; compare: TCompareFun): TMatrix;
var i,j,n: integer;
    t: TMatrix;
begin
  i := lenx(m)-1; j := leny(m)-1;
  SetLength(t,2,j+i+1);

  t[0,0] := i; t[1,0] := j;

  n := 1;
  while not ((i = 0) and (j = 0)) do begin
    if j = 0 then
      i := i-1
    else if i = 0 then
      j := j-1
    else if compare(m[i-1,j], m[i,j-1]) <> -1 then
      i := i-1
    else if compare(m[i,j-1], m[i-1,j]) <> -1 then
      j := j-1;

    t[0,n] := i; t[1,n] := j;

    n := n + 1;
  end;

  getpath := t;
end;

(* Задача о брахистохроне
 *
 *
 *)

function ds(dx,dy: double): double; overload;
begin
  ds := sqrt(power(dx,2) + power(dy,2));
end;

function ds(v0,a,t: double): double; overload;
begin
  ds := v0*t + a*power(t,2)/2;
end;

function dt(dx,dy,a,v0: double): double;
begin
  if (abs(a) < 0.00001) and (abs(v0) < 0.00001) then dt := Infinity
  else if abs(a) < 0.00001 then dt := ds(dx,dy)/v0
  else dt := (-v0 + sqrt(2*a*ds(dx,dy) + power(v0,2)))/a;
end;

function MinIndex(a: TArray): integer;
var i,mini: integer;
begin
  mini := 0;
  for i := 0 to length(a)-1 do
    if a[i] < a[mini] then mini := i;
  MinIndex := mini;
end;

(*function brachistochrone(sx,sy: integer;
                         memo: TMemo; series: TLineSeries): TMatrix;
var dx,dy,a: double;
    i,j,k,mini: integer;
    t,v,p: TMatrix;
    ti: TArray;
const g = 9.81;
begin
  dx := 1/sx; dy := 1/sy;
  SetLength(t,sx+1,sy+1);
  SetLength(v,sx+1,sy+1);
  SetLength(p,sx+1,sy+1);

  t[0,0] := 0; v[0,0] := 0;
  for i:= 1 to sx do
  for j:= 1 to sy do
    if i = 1 then begin
      a := g * dy*j / ds(dx,dy*j);
      t[i,j] := dt(dx,dy*j,a,0);
      v[i,j] := a*t[i,j];
      p[i,j] := 0;
    end
    else begin
      SetLength(ti,j+1);
      for k:= 0 to length(ti)-1 do begin
        a := g * dy*(j-k) / ds(dx,dy*(j-k));
        ti[k] := t[i-1,k] + dt(dx,dy*(j-k),a,v[i-1,k] + a*t[i-1,k]);
      end;

      ti[0] := Infinity;
      mini := MinIndex(ti);
      a := g * dy*(j-mini) / ds(dx,dy*(j-mini));
      t[i,j] := t[i-1,mini] + dt(dx,dy*(j-mini),a,v[i-1,mini]);
      v[i,j] := v[i-1,mini] + a*t[i,j];
      p[i,j] := mini;
    end;


  memo.Lines.Append('Матрица времени:');
  WriteMatrix(t,memo);
  memo.Lines.Append('Матрица скоростей:');
  WriteMatrix(v,memo);
  memo.Lines.Append('Матрица путей:');
  WriteMatrix(p,memo);

  i:= lenx(p)-1; j:= leny(p)-1;
  series.AddXY(i,j);
  while not ((i = 0) and (j = 0)) do begin
    j := trunc(p[i,j]);
    i := i-1;
    series.AddXY(i,j);
  end;
end;*)

procedure brachistochrone(sx,sy: integer;
                          memo: TMemo; series: TLineSeries);
var Level,i,Index: integer;
    Time: TMatrix;
    TimeMin,dX,A,X,Y,Amin: array[0..1000] of real;
    Remove,dY,AllTime: real;
const g = 9.81;

function IndexMin(m: TMatrix;
                  level,index: integer):integer;
var i,mini: integer;
begin
  mini := Index+1;
  for i:= Index+2 to leny(m)-1 do
    if m[level+1,i] < m[level+1,mini] then
      mini := i;
  IndexMin := mini;
end;

begin
  SetLength(time,sx+1,sx);
  Remove := 1;
  dY := 1;
  Index := 0;
  AllTime := 0;

  for i:= 0 to sx-1 do Time[0,i]:=0;
  TimeMin[0] := 0;

  for Level:= 0 to sx-1 do begin
    dX[Index] := 0;
    for i:= Index+1 to sx-1 do begin
      dX[i] := dX[i-1] + Remove;
      A[i] := g/ds(dx[i],dy);
      Time[Level+1,i] := dt(dx[i],dy,a[i],a[i]*alltime);
    end;

    if Level = 0 then begin
      X[Level] := 0;
      Y[Level] := sx-1;
    end;

    Index := IndexMin(time,level,index);
    Amin[Level+1] := A[Index];
    TimeMin[Level+1] := Time[Level+1,Index];
    AllTime := AllTime + TimeMin[Level+1];
  end;

  for i:=0 to sx-1 do begin
    X[i+1] := X[i]+Remove;
    Y[i+1] := Y[i]-Amin[i+1]*TimeMin[i+1]*TimeMin[i+1]/2;
    series.AddXY(X[i],Y[i]);
  end;
end;



(* GUI
 *
 *
 *)

procedure TForm1.N1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TForm1.Button_JG_EyeClick(Sender: TObject);
begin
  ReadMatrix(jg_matrix, Grid_JG);
  EyeMatrix(jg_matrix);
  WriteMatrix(jg_matrix, Grid_JG);
end;

procedure TForm1.Button_JG_RandomClick(Sender: TObject);
begin
  ReadMatrix(jg_matrix, Grid_JG);
  RandomMatrix(jg_matrix);
  WriteMatrix(jg_matrix, Grid_JG);
end;

procedure TForm1.Button_JG_SolveClick(Sender: TObject);
begin
  ReadMatrix(jg_matrix, Grid_JG);
  JG_Solve(jg_matrix, Grid_JG, Memo1);
  WriteMatrix(jg_matrix,Grid_JG);
end;

procedure TForm1.Edit_JGChange(Sender: TObject);
var i: integer;
begin
  i := StrToInt(Edit_JG.Text);
  Grid_JG.RowCount := i;
  Grid_JG.ColCount := i + 1;
end;

procedure TForm1.Button_BB_EyeClick(Sender: TObject);
begin
  ReadMatrix(bb_matrix, Grid_BB);
  EyeMatrix(bb_matrix, Infinity);
  WriteMatrix(bb_matrix, Grid_BB);
end;

procedure TForm1.Button_BB_RandomClick(Sender: TObject);
begin
  ReadMatrix(bb_matrix, Grid_BB);
  RandomMatrix(bb_matrix);
  DiagMatrix(bb_matrix, Infinity);
  WriteMatrix(bb_matrix, Grid_BB);
end;

procedure TForm1.Button_BB_SolveClick(Sender: TObject);
begin
  ReadMatrix(bb_matrix, Grid_BB);
  DiagMatrix(bb_matrix, Infinity);
  BB_Solve(bb_matrix,0,Grid_BB,Memo1);
  WriteMatrix(bb_matrix,Grid_BB);
end;

procedure TForm1.Edit_BBChange(Sender: TObject);
var i: integer;
begin
  i := StrToInt(Edit_BB.Text);
  Grid_BB.ColCount := i;
  Grid_BB.RowCount := i;
end;

procedure TForm1.Edit_Search_aExit(Sender: TObject);
begin
  search_a := StrToFloat(Edit_Search_a.Text);
end;

procedure TForm1.Edit_Search_bExit(Sender: TObject);
begin
  search_b := StrToFloat(Edit_Search_b.Text);
end;

procedure TForm1.Edit_Search_epsExit(Sender: TObject);
begin
  search_eps := StrToFloat(Edit_Search_eps.Text);
end;

procedure TForm1.Edit_Search_nChange(Sender: TObject);
begin
  search_N := StrToInt(Edit_Search_n.Text);
end;

procedure TForm1.Button_Search_PassiveClick(Sender: TObject);
var t: TInterval;
begin
  search_a := StrToFloat(Edit_Search_a.Text);
  search_b := StrToFloat(Edit_Search_b.Text);
  search_eps := StrToFloat(Edit_Search_eps.Text);
  t := passive(search_f,search_a,search_b,search_eps);
  Memo1.Lines.Append('-- Пассивный поиск: x^o = [' + FloatToStr(t.a) + ', '
                    + FloatToStr(t.b) + ']; '
                    + 'f(x^o) = ' + FloatToStr(search_f(t.a)));
end;

procedure TForm1.Button_Search_DichotomyClick(Sender: TObject);
var t: TInterval;
begin
  search_a := StrToFloat(Edit_Search_a.Text);
  search_b := StrToFloat(Edit_Search_b.Text);
  search_eps := StrToFloat(Edit_Search_eps.Text);
  t := dichotomy(search_f,search_a,search_b,search_eps,Memo1);
  Memo1.Lines.Append('-- Метод дихотомии: x^o = [' + FloatToStr(t.a) + ', '
                    + FloatToStr(t.b) + ']; '
                    + 'f(x^o) = ' + FloatToStr(search_f(t.a)));
end;

procedure TForm1.Button_Search_FibClick(Sender: TObject);
var t: TInterval;
begin
  search_a := StrToFloat(Edit_Search_a.Text);
  search_b := StrToFloat(Edit_Search_b.Text);
  search_eps := StrToFloat(Edit_Search_eps.Text);
  search_N := StrToInt(Edit_Search_N.Text);
  t := fibonacci(search_f,search_a,search_b,search_eps,search_N,Memo1);
  Memo1.Lines.Append('-- Метод Фибоначчи: x^o = [' + FloatToStr(t.a) + ', '
                    + FloatToStr(t.b) + ']; '
                    + 'f(x^o) = ' + FloatToStr(search_f(t.a)));
end;

procedure TForm1.Button_Search_GoldClick(Sender: TObject);
var t: TInterval;
begin
  search_a := StrToFloat(Edit_Search_a.Text);
  search_b := StrToFloat(Edit_Search_b.Text);
  search_eps := StrToFloat(Edit_Search_eps.Text);
  t := goldenratio(search_f,search_a,search_b,search_eps, Memo1);
  Memo1.Lines.Append('-- Метод "золотого сечения": x^o = [' + FloatToStr(t.a) + ', '
                    + FloatToStr(t.b) + ']; '
                    + 'f(x^o) = ' + FloatToStr(search_f(t.a)));
end;

procedure TForm1.Edit_Grad_aExit(Sender: TObject);
begin
  grad_a := StrToFloat(Edit_Grad_a.Text);
end;

procedure TForm1.Edit_Grad_bExit(Sender: TObject);
begin
  grad_b := StrToFloat(Edit_Grad_b.Text);
end;

procedure TForm1.Edit_Grad_epsExit(Sender: TObject);
begin
  grad_eps := StrToFloat(Edit_Grad_eps.Text);
end;

procedure TForm1.Edit_Grad_hExit(Sender: TObject);
begin
  grad_h := StrToFloat(Edit_Grad_h.Text);
end;

procedure TForm1.Button_Grad_1stClick(Sender: TObject);
var t: double;
begin
  grad_a := StrToFloat(Edit_Grad_a.Text);
  grad_b := StrToFloat(Edit_Grad_b.Text);
  grad_eps := StrToFloat(Edit_Grad_eps.Text);
  grad_h := StrToFloat(Edit_Grad_h.Text);
  t := firstorder(grad_f,grad_df,grad_a,grad_b,grad_h,grad_eps,Memo1);
  Memo1.Lines.Append('-- Метод 1-го порядка: x^o = ' + FloatToStr(t) + '; '
                    + 'f(x^o) = ' + FloatToStr(grad_f(t)));
end;

procedure TForm1.Button_Grad_1stmodClick(Sender: TObject);
var t: double;
begin
  grad_a := StrToFloat(Edit_Grad_a.Text);
  grad_b := StrToFloat(Edit_Grad_b.Text);
  grad_eps := StrToFloat(Edit_Grad_eps.Text);
  grad_h := StrToFloat(Edit_Grad_h.Text);
  t := firstorderext(grad_f,grad_df,grad_a,grad_b,grad_h,grad_eps,Memo1);
  Memo1.Lines.Append('-- Метод 1-го порядка (мод.): x^o = '
                    + FloatToStr(t) + '; '
                    + 'f(x^o) = ' + FloatToStr(grad_f(t)));
end;

procedure TForm1.Button_Grad_2ndClick(Sender: TObject);
var t: double;
begin
  grad_a := StrToFloat(Edit_Grad_a.Text);
  grad_b := StrToFloat(Edit_Grad_b.Text);
  grad_eps := StrToFloat(Edit_Grad_eps.Text);
  grad_h := StrToFloat(Edit_Grad_h.Text);
  t := secondorder(grad_f,grad_df,grad_d2f,grad_a,grad_b,grad_h,grad_eps,Memo1);
  Memo1.Lines.Append('-- Метод 2-го порядка: x^o = '
                    + FloatToStr(t) + '; '
                    + 'f(x^o) = ' + FloatToStr(grad_f(t)));
end;

procedure TForm1.Button_Simpl_FillClick(Sender: TObject);
var i: integer;
begin
  ReadArray(simpl_c, Grid_Simpl_c);
  for i:=0 to length(simpl_c)-1 do simpl_c[i] := 0;
  WriteArray(simpl_c, Grid_Simpl_c);

  ReadMatrix(simpl_ogr, Grid_Simpl_ogr);
  EyeMatrix(simpl_ogr);
  WriteMatrix(simpl_ogr, Grid_Simpl_ogr);
end;

procedure TForm1.Button_Simpl_RandomClick(Sender: TObject);
var i,sx: integer;
begin
  ReadArray(simpl_c, Grid_Simpl_c);
  for i:= 0 to length(simpl_c)-1 do simpl_c[i] := Random * 10;
  WriteArray(simpl_c, Grid_Simpl_c);

  ReadMatrix(simpl_ogr, Grid_Simpl_ogr);
  RandomMatrix(simpl_ogr);
  sx := lenx(simpl_ogr)-1;
  for i:= 0 to leny(simpl_ogr)-1 do simpl_ogr[sx,i] := simpl_ogr[sx,i] * 10;
  WriteMatrix(simpl_ogr, Grid_Simpl_ogr);
end;

procedure TForm1.Button_Simple_SolveClick(Sender: TObject);
var fun,t: TArray;
    ogr: TMatrix;
    i: integer;
    s: string;
begin
  Memo1.Lines.Append('-- Симплексный метод:');
  ReadArray(fun,Grid_Simpl_c);
  ReadMatrix(ogr,Grid_Simpl_ogr);
  t := simplex(fun,ogr,Memo1);
  s := '';
  for i:= 0 to length(t)-1 do
    s := s + FloatToStr(t[i]) + #9;
  Memo1.Lines.Append('Ответ: ' + s);
  WriteArray(fun,Grid_Simpl_c);
  WriteMatrix(ogr,Grid_Simpl_ogr);
end;

procedure TForm1.Button_Dyn_RandomClick(Sender: TObject);
begin
  ReadMatrix(dyn_mx, Grid_Dyn_mx);
  RandomMatrix(dyn_mx);
  WriteMatrix(dyn_mx, Grid_Dyn_mx);

  ReadMatrix(dyn_my, Grid_Dyn_my);
  RandomMatrix(dyn_my);
  WriteMatrix(dyn_my, Grid_Dyn_my);
end;

procedure TForm1.Button_Dyn_FillClick(Sender: TObject);
begin
  ReadMatrix(dyn_mx, Grid_Dyn_mx);
  FillMatrix(dyn_mx);
  WriteMatrix(dyn_mx, Grid_Dyn_mx);

  ReadMatrix(dyn_my, Grid_Dyn_my);
  FillMatrix(dyn_my);
  WriteMatrix(dyn_my, Grid_Dyn_my);
end;

procedure TForm1.Button_Dyn_SolveClick(Sender: TObject);
var t,p: TMatrix;
begin
  Memo1.Lines.Append('-- Метод динамического программирования:');
  ReadMatrix(dyn_mx, Grid_Dyn_mx);
  ReadMatrix(dyn_my, Grid_Dyn_my);
  t := dynamic_progr(dyn_mx, dyn_my, less, Memo1);
  Memo1.Lines.Append('Матрица наименьших путей:');
  WriteMatrix(t, Memo1);
  p := getpath(t, less);
  Memo1.Lines.Append('Наименьший путь из (0,0) в (n,m):');
  WriteMatrix(p, Memo1);
end;

procedure TForm1.Button_Brach_SolveClick(Sender: TObject);
begin
  brachistochrone(22,22, Memo1, Series_Brach);
end;

procedure TForm1.FormCreate(Sender: TObject);
var t: double;
begin
  Series_Search.Clear;
  t := -1;
  while t < 8 do begin
    Series_Search.AddXY(t, search_f(t), '', clTeeColor);
    t := t + 0.2;
  end;

  Series_Grad.Clear;
  t := 2;
  while t < 7 do begin
    Series_Grad.AddXY(t, grad_f(t), '', clTeeColor);
    t := t + 0.2;
  end;
end;

end.
