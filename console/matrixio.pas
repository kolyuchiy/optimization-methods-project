
Unit MatrixIO;

interface

uses SysUtils, Math;

type TMatrix = array of array of double;
     TArray = array of double;

procedure ReadArray(var a: TArray);
procedure ReadMatrix(var matrix: TMatrix);
procedure WriteArray(const a: TArray);
procedure WriteMatrix(const matrix: TMatrix);
function lenx(var m: TMatrix): integer;
function leny(var m: TMatrix): integer;

implementation

function lenx(var m: TMatrix): integer;
begin
  lenx := Length(m);
end;

function leny(var m: TMatrix): integer;
begin
  leny := Length(m[0]);
end;

procedure ReadArray(var a: TArray);
var sx,i: integer;
begin
  read(sx);
  SetLength(a,sx);
  for i:= 0 to sx-1 do 
    try read(a[i])
    except on EInOutError do a[i] := Infinity
    end;
end;

procedure ReadMatrix(var matrix: TMatrix);
var sx,sy,i,j: integer;
begin
  read(sx,sy);
  SetLength(matrix,sx,sy);
  for j:= 0 to sy-1 do
  for i:= 0 to sx-1 do
    try read(matrix[i,j])
    except on EInOutError do matrix[i,j] := Infinity
    end;
end;

procedure WriteArray(const a: TArray);
var i: integer;
begin
  for i:= 0 to Length(a)-1 do
    write(a[i]:8:2);
  writeln;
end;

procedure WriteMatrix(const matrix: TMatrix);
var i,j: integer;
begin
  for j:= 0 to Length(matrix[0])-1 do begin
    for i:= 0 to Length(matrix)-1 do 
      write(matrix[i,j]:8:2); write(' ');
    writeln;
  end;
end;

end.

