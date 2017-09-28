program BST;
type treenode=^node;
     node=record
     key:longint;
     l,r,p:treenode;
     end;
var root:treenode;
function search(x:treenode;k:longint):treenode;
begin
  if (x=nil)or(x^.key=k) then exit(x);
  if k<x^.key then
    exit(search(x^.l,k))
  else
    exit(search(x^.r,k));
end;
function minnode(x:treenode):treenode;
begin
  while x^.l<>nil do
    x:=x^.l;
  exit(x);
end;
function maxnode(x:treenode):treenode;
begin
  while x^.r<>nil do
    x:=x^.r;
  exit(x);
end;
function precursor(x:treenode):treenode;
var y:treenode;
begin
  if x^.l<>nil then exit(maxnode(x^.l));
  y:=x^.p;
  while (y<>nil)and(x=y^.l) do
  begin
    x:=y;
    y:=y^.p;
  end;
  exit(y);
end;
function successor(x:treenode):treenode;
var y:treenode;
begin
  if x^.r<>nil then exit(minnode(x^.r));
  y:=x^.p;
  while (y<>nil)and(x=y^.r) do
  begin
    x:=y;
    y:=y^.p;
  end;
  exit(y);
end;
procedure insert(k:longint);
var x,y,z:treenode;
begin
  new(z);
  z^.key:=k;
  z^.l:=nil;
  z^.r:=nil;
  y:=nil;
  x:=root;
  while x<>nil do
  begin
    y:=x;
    if z^.key<x^.key then
      x:=x^.l
    else
      x:=x^.r;
  end;
  z^.p:=y;
  if y=nil then root:=z
  else if z^.key<y^.key then
    y^.l:=z
  else
    y^.r:=z;
end;
procedure delete(x:treenode);
var y:treenode;
  procedure transplant(u,v:treenode);
  begin
    if u^.p=nil then
      root:=v
    else if u=u^.p^.l then
      u^.p^.l:=v
    else
      u^.p^.r:=v;
    if v<>nil then v^.p:=u^.p;
  end;
begin
  if x^.l=nil then
    transplant(x,x^.r)
  else if x^.r=nil then
    transplant(x,x^.l)
  else
  begin
    y:=minnode(x^.r);
    if y^.p<>x then
    begin
      transplant(y,y^.r);
      y^.r:=x^.r;
      y^.r^.p:=y;
    end;
    transplant(x,y);
    y^.l:=x^.l;
    y^.l^.p:=y;
  end;
  dispose(x);
end;
var n,i,t,t1:longint;
    g:treenode;
begin
  root:=nil;
  readln(n);
  for i:=1 to n do
  begin
    read(t);
    insert(t);
  end;
  while true do
  begin
    read(t);
    if t=1 then writeln(minnode(root)^.key) else
    if t=2 then writeln(maxnode(root)^.key) else
    read(t1);
    if t=3 then writeln(precursor(search(root,t1))^.key);
    if t=4 then writeln(successor(search(root,t1))^.key);
    if t=5 then delete(search(root,t1));
  end;
end.
