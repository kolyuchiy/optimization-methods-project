program DynamicProgramming;

{$APPTYPE CONSOLE}

uses
  SysUtils, Math,
  MatrixIO in 'matrixio.pas';

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

function dynamic(mx, my: TMatrix; compare: TCompareFun): TMatrix;
var i,j: integer;
    t: TMatrix;
begin
  WriteMatrix(mx); writeln;
  WriteMatrix(my); writeln;
 
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

  dynamic := t; 
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

function ds(dx,dy: double): double;
begin
  ds := sqrt(power(dx,2) + power(dy,2));
end;

function dt(v0,a,dx,dy: double): double;
begin
  dt := (-v0 + sqrt(power(v0,2) + 2*a*ds(dx,dy)))/a;
end;

function MinIndex(a: array of double): integer;
var i,mini: integer;
begin
  mini := 0;
  for i:= 0 to Length(a)-1 do
    if a[i] < a[mini] then mini := i;
  MinIndex := mini;
end;

function brachistochrone(dx,dy: double; sx,sy: integer): TMatrix;
var i,j,k: integer;
    t,p: TMatrix;
    ti: TArray;
begin
  Setlength(t,sx+1,sy+1);
  Setlength(p,sx+1,sy+1);

  for i:= 0 to lenx(t)-1 do
  for j:= 0 to leny(t)-1 do begin
    if i = 0 then begin
      t[i,j] := dt(0, 9.8, 0, dy/sy * j);
      p[i,j] := 0;
    end
    else if i = 1 then begin
      t[i,j] := dt(0, 9.8, dx/sx, dy/sy * j);
      p[i,j] := 0;
    end
    else begin
      SetLength(ti,sy+1);
      for k:= 0 to sy do 
        ti[k] := t[i-1,k] + dt(9.8*t[i-1,k], 9.8, dx/sx, dy/sy * (k-j));
      t[i,j] := ti[MinIndex(ti)];
      p[i,j] := MinIndex(ti);
    end;
  end;

  WriteMatrix(p); writeln;

  i:= lenx(p)-1; j:= leny(p)-1;
  writeln(i,';',j);
  while not ((i = 0) and (j = 0)) do begin
    j := trunc(p[i,j]);
    i := i-1;
    writeln(i,';',j);
  end;

  brachistochrone := t;
end;

var mx, my: TMatrix;
    t: TMatrix;
    p: TMatrix; 

begin
  ReadMatrix(mx);
  ReadMatrix(my);
  t := dynamic(mx,my, less);
  WriteMatrix(t); writeln;
  p := getpath(t, less);
  Writematrix(p); writeln;

  t := brachistochrone(1,1,8,22);
  WriteMatrix(t); writeln;
end.
 
