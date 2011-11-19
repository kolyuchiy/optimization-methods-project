program SimplexMethod;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  MatrixIO in 'matrixio.pas';

procedure Exclude(matrix: TMatrix; n,m: integer);
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

function simplex(c: TArray; ogr: TMatrix): TArray;
var i,j,t,imin,jmin: integer;
    tt: double;
    a: TMatrix;
    cd,d,m1,res: TArray;
begin
  t := Length(c);
  SetLength(c,t+leny(ogr));
  for i:= t to leny(ogr)-1 do c[i] := 0;
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

  repeat

  for i:= 0 to Length(cd)-1 do cd[i] := c[round(d[i])];

  Writeln('c'); WriteArray(c);
  Writeln('a'); WriteMatrix(a);
  Writeln('d'); WriteArray(d);
  Writeln('cd'); WriteArray(cd);

  for i:= 0 to Length(m1)-1 do begin
    m1[i] := 0;
    for j:= 0 to Length(m1)-1 do
      m1[i] := m1[i] + cd[j] * a[i,j];
    m1[i] := m1[i] - c[i];
  end;

  WriteLn('m1'); WriteArray(m1);

  for i:= 0 to Length(m1)-1 do
    if m1[i] < 0 then break;

  if not (m1[i] < 0) then break;

  imin := 0;
  for i:= 1 to length(m1)-1 do
    if m1[i] < m1[imin] then imin := i;

  jmin := 0;
  for j:= 1 to leny(a)-1 do
    if not (a[imin,j] = 0) then
    if a[lenx(a)-1,j] / a[imin,j] < a[lenx(a)-1,jmin] / a[imin,jmin] then 
      jmin := j;

  tt := a[imin,jmin];
  d[jmin] := imin;
  cd[jmin] := c[jmin+t];
  for i:= 0 to lenx(a)-1 do
    a[i,jmin] := a[i,jmin] / tt;
  Exclude(a,imin,jmin);

  until false;

  SetLength(res,lenx(a));
  for i:= 0 to Length(res)-1 do res[i] := 0;
  for i:= 0 to Length(d)-1 do res[round(d[i])] := a[lenx(a)-1,i];
  res[lenx(a)-1] := m1[length(m1)-1];

  simplex := res;
end;

var fun,t: TArray;
    ogr: TMatrix;
    i: integer;

begin
  ReadArray(fun);
  WriteArray(fun);
  ReadMatrix(ogr);
  WriteMatrix(ogr);

  t := simplex(fun,ogr);
  for i:= 0 to length(t)-1 do write(t[i]:8:4);
  writeln;
end.
 
