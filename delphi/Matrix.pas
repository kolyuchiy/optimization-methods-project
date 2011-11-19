unit Matrix;

(* Все про прямоугольные матрицы
 * индексы начинаются с 0
 *
 *)

interface

uses SysUtils, StdCtrls, Grids, Math;

type
  TMatrix = array of array of double;
  TArray = array of double;

function lenx(const m: TMatrix): integer;
function leny(const m: TMatrix): integer;
procedure ReadArray(var matrix: TArray; grid: TStringGrid);
procedure ReadMatrix(var matrix: TMatrix; grid: TStringGrid);
procedure WriteArray(const a: TArray; memo: TMemo); overload;
procedure WriteArray(const a: TArray; grid: TStringGrid); overload;
procedure WriteMatrix(const matrix: TMatrix; grid: TStringGrid); overload;
procedure WriteMatrix(const matrix: TMatrix; memo: TMemo); overload;
procedure EyeMatrix(var matrix: TMatrix; x: double = 1);
procedure FillMatrix(var matrix: TMatrix; x: double = 0);
procedure DiagMatrix(var matrix: TMatrix; x: double = 1);
procedure RandomMatrix(var matrix: TMatrix);
procedure SwapRows(var matrix: TMatrix; i,j: integer);

implementation

function lenx(const m: TMatrix): integer;
begin lenx := Length(m) end;

function leny(const m: TMatrix): integer;
begin leny := Length(m[0]) end;

procedure ReadArray(var matrix: TArray; grid: TStringGrid);
var sx,i: integer;
begin
  sx := grid.ColCount;
  SetLength(matrix,sx);
  for i:= 0 to sx-1 do
    try matrix[i] := StrToFloat(grid.Cells[i,0])
    except on EConvertError do matrix[i] := Infinity
    end;
end;

procedure ReadMatrix(var matrix: TMatrix; grid: TStringGrid);
var sx,sy,i,j: integer;
begin
  sx := grid.ColCount; sy := grid.RowCount;
  SetLength(matrix,sx,sy);
  for j:= 0 to sy-1 do
  for i:= 0 to sx-1 do
    try matrix[i,j] := StrToFloat(grid.Cells[i,j])
    except on EConvertError do matrix[i,j] := Infinity
    end;
end;

procedure WriteArray(const a: TArray; memo: TMemo); overload;
var i: integer;
    s: string;
begin
  s := '';
  for i:= 0 to Length(a)-1 do
    s := s + FloatToStrF(a[i], ffFixed, 7, 3) + #9;
  memo.Lines.Append(s);
end;

procedure WriteArray(const a: TArray; grid: TStringGrid); overload;
var i: integer;
begin
  for i:= 0 to length(a)-1 do
    grid.Cells[i,0] := FloatToStrF(a[i], ffFixed, 7, 3);
end;

procedure WriteMatrix(const matrix: TMatrix; grid: TStringGrid); overload;
var i,j: integer;
begin
  for j:= 0 to leny(matrix)-1 do
  for i:= 0 to lenx(matrix)-1 do
    grid.Cells[i,j] := FloatToStrF(matrix[i,j], ffFixed, 7, 3);
end;

procedure WriteMatrix(const matrix: TMatrix; memo: TMemo); overload;
var i,j: integer;
    s: string;
begin
  for j:= 0 to leny(matrix)-1 do begin
    s := '';
    for i:= 0 to lenx(matrix)-1 do
      s := s + FloatToStrF(matrix[i,j], ffFixed, 7, 3)+#9;
    memo.Lines.Append(s);
  end;
  memo.Lines.Append('');
end;

procedure EyeMatrix(var matrix: TMatrix; x: double = 1);
var i,j: integer;
begin
  for i:= 0 to lenx(matrix)-1 do
  for j:= 0 to leny(matrix)-1 do
    if i = j then matrix[i,j] := x
    else matrix[i,j] := 0;
end;

procedure FillMatrix(var matrix: TMatrix; x: double = 0);
var i,j: integer;
begin
  for i:= 0 to lenx(matrix)-1 do
  for j:= 0 to leny(matrix)-1 do
    matrix[i,j] := x;
end;

procedure DiagMatrix(var matrix: TMatrix; x: double = 1);
var i,j: integer;
begin
  for i:= 0 to lenx(matrix)-1 do
  for j:= 0 to leny(matrix)-1 do
    if i = j then matrix[i,j] := x;
end;

procedure RandomMatrix(var matrix: TMatrix);
var i,j: integer;
begin
  for i := 0 to lenx(matrix)-1 do
  for j := 0 to leny(matrix)-1 do begin
    matrix[i,j] := random * 10;
  end;
end;

procedure SwapRows(var matrix: TMatrix; i,j: integer);
var k: integer;
    t: double;
begin
  for k:= 0 to lenx(matrix)-1 do begin
    t := matrix[k,i];
    matrix[k,i] := matrix[k,j];
    matrix[k,j] := t;
  end;
end;

end.
