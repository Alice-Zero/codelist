program bellman_ford;
var dis:array[1..10100]of int64;
    e:array[1..505000,1..3]of longint;
    n,m,s,i,j:longint;
    flag:boolean;
begin
  readln(n,m,s);
  flag:=true;
  for i:=1 to n do
    dis[i]:=maxlongint;
  dis[s]:=0;
  for j:=1 to m do
    readln(e[j,1],e[j,2],e[j,3]);
  for i:=1 to n-1 do
    for j:=1 to m do
      if dis[e[j,1]]+e[j,3]<dis[e[j,2]] then
        dis[e[j,2]]:=dis[e[j,1]]+e[j,3];
  for j:=1 to m do
    if  dis[e[j,1]]+e[j,3]<dis[e[j,2]] then flag:=false;
  if flag then
    for i:=1 to n do write(dis[i],' ');
end.
