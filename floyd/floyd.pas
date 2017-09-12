program floyd;
var dis:array[1..1010,1..1010]of int64;
    n,m,s,x,y,i,j,k,w:longint;
begin
  readln(n,m,s);
  for i:=1 to n do
    for j:=1 to n do
      dis[i,j]:=maxlongint;
  for i:=1 to n do dis[i,i]:=0;
  for i:=1 to m do
  begin
    read(x,y,w);
    if w<dis[x,y] then dis[x,y]:=w;
  end;
  for k:=1 to n do
    for i:=1 to n do
      for j:=1 to n do
        if (dis[i,k]+dis[k,j])<dis[i,j] then
          dis[i,j]:=dis[i,k]+dis[k,j];
  for i:=1 to n do write(dis[s,i],' ');
end.
