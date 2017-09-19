program st;
var f:array[1..101000,0..20]of longint;
    i,j,k,n,m,l,r:longint;
function max(a,b:longint):longint;
begin
  if a>b then exit(a) else exit(b);
end;
begin
  readln(n,m);
  for i:=1 to n do read(f[i,0]);
  for j:=1 to 20 do
    for i:=1 to n do
      if i-1+1<<j<=n then
        f[i,j]:=max(f[i,j-1],f[i+1<<(j-1),j-1]);
  for i:=1 to m do
  begin
    readln(l,r);
    k:=trunc(ln(r-l+1)/ln(2));
    writeln(max(f[l,k],f[r-1<<k+1,k]))
  end;
end.
