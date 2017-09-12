program kruskal;
type edge=record
     f1,f2,key:longint;
     end;
var a:array[0..202000]of edge;
procedure  qsort(l,r:longint);
var i,j:longint;
    mid:edge;
begin
  mid:=a[(l+r)>>1];
  i:=l;j:=r;
  repeat
    while a[i].key<mid.key do inc(i);
    while a[j].key>mid.key do dec(j);
    if i<=j then
    begin
      a[0]:=a[i];
      a[i]:=a[j];
      a[j]:=a[0];
      inc(i);dec(j);
    end;
  until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
end;
var u,r:array[0..5050]of longint;
function find(x:longint):longint;
begin
  if u[x]=x then exit(x);
  u[x]:=find(u[x]);
  exit(u[x]);
end;
procedure union(x,y:longint);
var xx,yy:longint;
begin
  xx:=find(x);yy:=find(y);
  if r[xx]>r[yy] then u[yy]:=xx
  else
  begin
    u[xx]:=yy;
    if r[xx]=r[yy] then inc(r[xx]);
  end;
end;
var n,m,i,ans,cnt:longint;
begin
  readln(n,m);
  for i:=1 to n do u[i]:=i;
  for i:=1 to m do readln(a[i].f1,a[i].f2,a[i].key);
  qsort(1,m);
  ans:=0;cnt:=0;
  for i:=1 to m do
  if find(a[i].f1)<>find(a[i].f2) then
  begin
    inc(ans,a[i].key);
    union(a[i].f1,a[i].f2);
    inc(cnt);
    if cnt=n-1 then break;
  end;
  writeln(ans);
end.
