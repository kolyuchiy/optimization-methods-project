program Gradient;

uses Math;

{$APPTYPE CONSOLE}

type TRealFunc = function(x: double): double;

function f(x: double): double;
begin
  f := Power(x-5.9834,2) + 1;
end;

function df(x: double): double;
begin
  df := 2*(x-5.9834);
end;

function d2f(x: double): double;
begin
  d2f := 2*x;
end;

function firstorder(f: TRealFunc; a, b, h, eps: double): double;
var prevx,x: double;
begin
  x := b;
  Writeln(x:9:4, f(x):9:4, df(x):9:4, h:9:4);
  repeat
    prevx := x;
    x := x - h * df(x);
    Writeln(x:9:4, f(x):9:4, df(x):9:4, h:9:4);
  until abs(prevx-x) < eps;

  firstorder := x;
end;

function firstorderext(f: TRealFunc; a, b, h, eps: double): double;
var prevx,prevdf,x,t: double;
begin
  x := b; prevx := a; prevdf := df(x);
  Writeln(x:9:4, f(x):9:4, df(x):9:4, h:9:4);
  repeat
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

    Writeln(x:9:4, f(x):9:4, df(x):9:4, h:9:4);
  until abs(prevx-x) < eps;

  firstorderext := x;
end;

function secondorder(f: TRealFunc; a, b, h, eps: double): double;
var prevx,x: double;
begin
  x := b;
  Writeln(x:9:4, f(x):9:4, (df(x)/d2f(x)):9:4, h:9:4);
  repeat
    prevx := x;
    x := x - h * df(x) / d2f(x);

    Writeln(x:9:4, f(x):9:4, (df(x)/d2f(x)):9:4, h:9:4);
  until abs(prevx-x) < eps;

  secondorder := x;
end;

const a = -4;
      b = 8;
      eps = 0.001;

var t: double;

begin
  WriteLn('a = ', a);
  WriteLn('b = ', b);
  WriteLn('eps = ', eps:8:2);

  t := firstorder(f,a,b,(b-a)/16,eps);
  WriteLn('firstorder x^o = ', t:8:4, '; f(x^o) = ', f(t):8:4);

  t := firstorderext(f,a,b,(b-a)/4,eps);
  WriteLn('firstorderext x^o = ', t:8:4, '; f(x^o) = ', f(t):8:4);

  t := secondorder(f,a,b,(b-a)/1.4,eps);
  WriteLn('secondorder x^o = ', t:8:4, '; f(x^o) = ', f(t):8:4);
end.

