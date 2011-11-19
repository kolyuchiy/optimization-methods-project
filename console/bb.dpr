program bb;

{$APPTYPE CONSOLE}

uses
  SysUtils, Math,
  MatrixIO in 'matrixio.pas',
  IntStack in 'intstack.pas';

var matrix: TMatrix;

procedure InitMatrix(m: TMatrix);
var i,j: integer;
begin
  for i:= 0 to Length(m)-1 do
  for j:= 0 to Length(m[i])-1 do
    if i = j then m[i,j] := Infinity;
end;

function Reduce(m: TMatrix; x, y: integer): TMatrix;
var i,j: integer;
    n: TMatrix;
begin
  SetLength(n,Length(m),Length(m[0]));
  for i:=0 to Length(m)-1 do
  for j:=0 to Length(m[i])-1 do
    if (i = x) or (j = y) then n[i,j] := Infinity
    else n[i,j] := m[i,j];
  Reduce := n;
end;

var thefirst: integer;
    thebest: double;
    temps, bests: TIntStack;

function LowerBound(var m: TMatrix): double;
var i,j: integer;
    min,len: double;
begin
  len := 0;
  for j:= 0 to Length(m[0])-1 do begin
    min := m[0,j];
    for i:= 1 to Length(m)-1 do
      if m[i,j] < min then min := m[i,j];

    if not IsInfinite(min) then begin
      len := len + min;
      for i:= 0 to Length(m)-1 do
        m[i,j] := m[i,j] - min;
    end;
  end;

  for i:= 0 to Length(m)-1 do begin
    min := m[i,0];
    for j:= 1 to Length(m[i])-1 do
      if m[i,j] < min then min := m[i,j];

    if not IsInfinite(min) then begin
      len := len + min;
      for j:= 0 to Length(m[i])-1 do
        m[i,j] := m[i,j] - min;
    end;
  end;

  LowerBound := len;
end;

procedure Walk(m: TMatrix; start: integer; len: double);
var i: integer;
    atleast: double;
    isLeaf: boolean;
begin
  WriteMatrix(m);
  WriteLn(start, ': ', len:8:2);
  if len >= thebest then begin
    WriteLn(' --- stop here ---');
    exit;
  end;

  Push(temps,start);

  isLeaf := true;
  atleast := LowerBound(m);
  for i:= 0 to Length(m)-1 do
    if i = thefirst then continue
    else if not IsInfinite(m[i,start]) then begin
      isLeaf := false;
      Walk(Reduce(m,i,start),i,len+atleast+m[i,start]);
    end;

  i := thefirst;
  if isLeaf and not IsInfinite(m[i,start]) then begin
    isLeaf := false;
    Walk(Reduce(m,i,start),i,len+atleast+m[i,start]);
  end;

  if isLeaf then begin
    if len < thebest then begin
      thebest := len;
      IntStackCopy(temps,bests); 
    end;
    WriteLn(' --- complete ---');
  end;

  Pop(temps);
end;

begin
  ReadMatrix(matrix);
  InitMatrix(matrix);
  IntStackInit(temps);
  IntStackInit(bests);
  thefirst := 0;
  thebest := Infinity;
  Walk(matrix,thefirst,0);
  WriteLn('thebest: ', thebest:8:2);
  Write('bests: '); while Length(bests) > 0 do Write(Pop(bests):4); WriteLn;
end.
 
