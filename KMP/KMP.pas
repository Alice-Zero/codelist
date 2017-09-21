program KMP;
const maxn=1000000;
var s,p:array[0..maxn]of char;
    next:array[0..maxn]of longint;
    i,lens,lenp:longint;
procedure getnext(s:array of char;lp:longint);
var j,k:longint;
begin
  next[0]:=-1;
  k:=-1;
  j:=0;
  while j<lp do
  begin
    if (k=-1)or(s[j]=s[k]) then
    begin
      inc(j);
      inc(k);
      if s[j]<>s[k] then
        next[j]:=k
      else
        next[j]:=next[k];
    end
    else
      k:=next[k];
  end;
end;

procedure kmp(s,p:array of char;ls,lp:longint);
var i,j:longint;
begin
  i:=0;
  j:=0;
  while i<ls do
  begin
    if (j=-1)or(s[i]=p[j]) then
    begin
      inc(i);
      inc(j);
    end
    else
      j:=next[j];
    if j=lp then writeln(i-j+1);
  end;
end;
begin
  while not eoln do
  begin
    read(s[lens]);
    inc(lens);
  end;
  readln;
  while not eoln do
  begin
    read(p[lenp]);
    inc(lenp);
  end;
  getnext(p,lenp);
  kmp(s,p,lens,lenp);
  for i:=1 to lenp do
    write(next[i],' ');
end.
