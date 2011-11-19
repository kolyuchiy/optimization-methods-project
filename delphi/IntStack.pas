unit IntStack;

(* Стэк целых чисел
 *
 *
 *)

interface

type TIntStack = array of integer;

procedure IntStackInit(var s: TIntStack);
procedure IntStackCopy(const from: TIntStack; var into: TIntStack);
procedure Push(var s: TIntStack; v: integer);
function Pop(var s: TIntStack): integer;

implementation

procedure IntStackInit(var s: TIntStack);
begin
  SetLength(s,0);
end;

procedure IntStackCopy(const from: TIntStack; var into: TIntStack);
var i: integer;
begin
  SetLength(into,Length(from));
  for i:= 0 to Length(from)-1 do
    into[i] := from[i];
end;

procedure Push(var s: TIntStack; v: integer);
var t: integer;
begin
  t := Length(s);
  SetLength(s,t+1);
  s[t] := v;
end;

function Pop(var s: TIntStack): integer;
var t: integer;
begin
  t := Length(s);
  Pop := s[t-1];
  SetLength(s,t-1);
end;

end.
