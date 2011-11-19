program OptimalSearch;

uses Math;

{$APPTYPE CONSOLE}

type TRealFunc = function(x: double): double;
type TInterval = record a: double; b: double; end;

function f(x: double): double;
begin
  f := Power(x, 4) - 14*Power(x,3) + 60*Power(x,2) - 70*x;
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

function dichotomy(f: TRealFunc; a, b, eps: double): TInterval;
var delta: double;
    newi: integer;
    x,y: array[1..4] of double;
begin
  delta := eps/2;
  x[1] := a; y[1] := f(x[1]);
  x[4] := b; y[4] := f(x[4]);
  x[2] := (x[1]+x[4])/2 - delta/2; y[2] := f(x[2]);
  x[3] := (x[1]+x[4])/2 + delta/2; y[3] := f(x[3]);

  while not (x[4]-x[1] < eps) do begin
    newi := minof4(y);
    WriteLn(x[1]:8:4, x[2]:8:4, x[3]:8:4, x[4]:8:4);
    x[1] := x[prev(newi,1)]; y[1] := y[prev(newi,1)];
    x[4] := x[next(newi,4)]; y[4] := y[prev(newi,4)];
    x[2] := (x[1]+x[4])/2 - delta/2; y[2] := f(x[2]);
    x[3] := (x[1]+x[4])/2 + delta/2; y[3] := f(x[3]);
  end;

  dichotomy.a := x[1];
  dichotomy.b := x[4];
end;

function fib(n: integer): integer;
begin
  if n > 2 then fib := fib(n-1) + fib(n-2)
  else fib := 1;
end;

function fibonacci(f: TRealFunc; a, b, eps: double; n: integer): TInterval;
var x,y: array[1..4] of double;
    i: integer;
    t: double;
begin
  t := ((b-a)*fib(n-1)+eps*sign(n))/fib(n);
  x[1] := a;                      y[1] := f(x[1]);
  x[4] := b;                      y[4] := f(x[4]);
  x[2] := x[4] - t;               y[2] := f(x[2]);
  x[3] := x[1] + t;               y[3] := f(x[3]);

  for i:= 1 to n-3 do begin
    WriteLn(x[1]:8:4, x[2]:8:4, x[3]:8:4, x[4]:8:4);
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

function goldenratio(f: TRealFunc; a, b, eps: double): TInterval;
var x,y: array[1..4] of double;
    tau: double;
begin
  tau := (1 + sqrt(5))/2;
  x[1] := a;                      y[1] := f(x[1]);
  x[4] := b;                      y[4] := f(x[4]);
  x[2] := x[4] - (x[4]-x[1])/tau; y[2] := f(x[2]);
  x[3] := x[1] + (x[4]-x[1])/tau; y[3] := f(x[3]);

  while not (x[4]-x[1] < eps) do begin
    WriteLn(x[1]:8:4, x[2]:8:4, x[3]:8:4, x[4]:8:4);
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

const a = -4;
      b = 8;
      eps = 0.01;
      N = 17;

var t: TInterval;

begin
  WriteLn('a = ', a);
  WriteLn('b = ', b);
  WriteLn('eps = ', eps:8:2);
  WriteLn('N = ', N);

  t := passive(f,a,b,eps);
  WriteLn('passive x^o \in [', t.a:8:4, ', ', t.b:8:4, ']; ',
  'f(x^o) \approx ', f(t.a):8:4);

  t := dichotomy(f,a,b,eps);
  WriteLn('dichotomy x^o \in [', t.a:8:4, ', ', t.b:8:4, ']; ',
  'f(x^o) \approx ', f(t.a):8:4);

  t := fibonacci(f,a,b,eps,N);
  WriteLn('fibonacci x^o \in [', t.a:8:4, ', ', t.b:8:4, ']; ',
  'f(x^o) \approx ', f(t.a):8:4);

  t := goldenratio(f,a,b,eps);
  WriteLn('goldenratio x^o \in [', t.a:8:4, ', ', t.b:8:4, ']; ',
  'f(x^o) \approx ', f(t.a):8:4);
end.

