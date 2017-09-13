program tarjan;
type edge=record
     go,next,a:longint;
     end;
var e,q:array[1..1010000]of edge;
    heade,headq,u,rank:array[1..505000]of longint;
    vis:array[1..505000]of boolean;
    i,n,m,r:longint;
procedure adde;
var x,y:longint;
begin
  readln(x,y);
  e[i*2-1].next:=heade[x];
  e[i*2-1].go:=y;
  heade[x]:=i*2-1;
  e[i*2].next:=heade[y];
  e[i*2].go:=x;
  heade[y]:=i*2;
end;
procedure addq;
var x,y:longint;
begin
  readln(x,y);
  q[i*2-1].next:=headq[x];
  q[i*2-1].go:=y;
  headq[x]:=i*2-1;
  q[i*2].next:=headq[y];
  q[i*2].go:=x;
  headq[y]:=i*2;
end;
function find(x:longint):longint;
begin
  if x=u[x] then exit(x)
  else u[x]:=find(u[x]);
  exit(u[x]);
end;
procedure union(x,y:longint);
begin
  u[x]:=y;
end;
procedure tarjan(x,fa:longint);
var t:longint;
    g:edge;
begin
  t:=heade[x];
  while t<>-1 do
  begin
    g:=e[t];
    if g.go=fa then
    begin
      t:=g.next;
      continue;
    end;
    tarjan(g.go,x);
    union(g.go,x);
    vis[g.go]:=true;
    t:=g.next;
  end;
  t:=headq[x];
  while t<>-1 do
  begin
    g:=q[t];
    if vis[g.go] then q[t].a:=find(g.go);
    t:=g.next;
  end;
end;
begin
  fillchar(heade,sizeof(heade),-1);
  fillchar(headq,sizeof(headq),-1);
  readln(n,m,r);
  for i:=1 to n do u[i]:=i;
  for i:=1 to n-1 do adde;
  for i:=1 to m do addq;
  tarjan(r,0);
  for i:= 1 to m*2 do if q[i].a<>0 then writeln(q[i].a);
end.
