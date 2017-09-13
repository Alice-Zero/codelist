program mul;
type edge=record
     go,next:longint;
     end;
var e:array[1..1010000]of edge;
    heade,dep:array[1..524888]of longint;
    p:array[1..524888,0..20]of longint;
    lg:array[0..524888]of longint;
    i,n,m,r,x,y,l,lt,cnt:longint;
procedure adde;
var x,y:longint;
begin
  readln(x,y);
  inc(cnt);
  e[cnt].next:=heade[x];
  e[cnt].go:=y;
  heade[x]:=cnt;
  inc(cnt);
  e[cnt].next:=heade[y];
  e[cnt].go:=x;
  heade[y]:=cnt;
end;
procedure dfs(u,x:longint);
var t,i:longint;
    g:edge;
begin
  t:=heade[u];
  while t<>-1 do
  begin
    g:=e[t];
    if g.go=x then
    begin
      t:=g.next;
      continue;
    end;
    dep[g.go]:=dep[u]+1;
    p[g.go,0]:=u;
    for i:=1 to lg[dep[g.go]] do
      p[g.go,i]:=p[p[g.go,i-1],i-1];
    dfs(g.go,u);
    t:=g.next;
  end;
end;
function lca(x,y:longint):longint;
var t,i:longint;
begin
  if dep[x]>dep[y] then
  begin
    t:=x;
    x:=y;
    y:=t;
  end;
  while dep[x]<dep[y] do
    y:=p[y,lg[dep[y]-dep[x]]];
  if x=y then exit(x);
  for i:=lg[dep[x]] downto 0 do
    if p[x,i]<>p[y,i] then
    begin
      x:=p[x,i];
      y:=p[y,i];
    end;
  exit(p[x,0]);
end;
begin
  fillchar(heade,sizeof(heade),-1);
  readln(n,m,r);
  lt:=2;
  while cnt<18 do
  begin
    l:=lt*2;
    inc(cnt);
    for i:=lt to l-1 do lg[i]:=cnt;
    lt:=l;
  end;
  cnt:=0;
  for i:=1 to n-1 do adde;
  dfs(r,0);
  for i:=1 to m do
  begin
    readln(x,y);
    writeln(lca(x,y));
  end;
end.
