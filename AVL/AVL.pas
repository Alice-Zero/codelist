program AVL;
type treenode=^node;
     node=record
     key,h,hf,num:longint;
     l,r,p:treenode;
     end;
var root:treenode;
function max(a,b:longint):longint;
begin
  if a>b then exit(a) else exit(b);
end;
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
procedure rotate(x:treenode);
  procedure calch(x:treenode);
  var l,r:longint;
  begin
    if x^.l=nil then l:=0 else l:=x^.l^.h;
    if x^.r=nil then r:=0 else r:=x^.r^.h;
    x^.h:=max(l,r)+1;
    x^.hf:=l-r;
  end;
  function LL(x:treenode):treenode;
  var y:treenode;
  begin
    y:=x^.l;
    transplant(x^.l,y^.r);
    transplant(x,y);
    y^.r:=x;
    x^.p:=y;
    calch(x);
    calch(y);
    exit(y);
  end;
  function RR(x:treenode):treenode;
  var y:treenode;
  begin
    y:=x^.r;
    transplant(x^.r,y^.l);
    transplant(x,y);
    y^.l:=x;
    x^.p:=y;
    calch(x);
    calch(y);
    exit(y);
  end;
  function LR(x:treenode):treenode;
  begin
    RR(x^.l);
    exit(LL(x));
  end;
  function RL(x:treenode):treenode;
  begin
    LL(x^.r);
    exit(RR(x));
  end;
var h:longint;
begin
  h:=x^.h;
  calch(x);
  if x^.hf=2 then
    if x^.l^.hf>=0 then
      x:=LL(x)
    else
      x:=LR(x);
  if x^.hf=-1 then
    if x^.r^.hf<=0 then
      x:=RR(x)
    else
      x:=RL(x);
  if (x^.p<>nil)and(h<>x^.h) then rotate(x^.p);
end;
procedure insert(k:longint);
var x,y,z:treenode;
begin
  y:=nil;
  x:=root;
  while x<>nil do
  begin
    y:=x;
    if k=x^.key then
    begin
      inc(x^.num);
      exit;
    end;
    if k<x^.key then
      x:=x^.l
    else
      x:=x^.r;
  end;
  new(z);
  z^.key:=k;
  z^.l:=nil;
  z^.r:=nil;
  z^.h:=1;
  z^.num:=1;
  z^.p:=y;
  if y=nil then root:=z
  else if z^.key<y^.key then
    y^.l:=z
  else
    y^.r:=z;
  rotate(z);
end;
procedure delete(x:treenode);
var y,t:treenode;
begin
  if x^.num<>1 then
  begin
    dec(x^.num);
    exit;
  end;
  t:=x^.p;
  if x^.l=nil then
    transplant(x,x^.r)
  else if x^.r=nil then
    transplant(x,x^.l)
  else
  begin
    y:=minnode(x^.r);
    t:=y;
    if y^.p<>x then
    begin
      t:=y^.r;
      transplant(y,y^.r);
      y^.r:=x^.r;
      y^.r^.p:=y;
    end;
    transplant(x,y);
    y^.l:=x^.l;
    y^.l^.p:=y;
  end;
  if t<>nil then rotate(t);
  dispose(x);
end;
procedure dfs(x:treenode);
var i:longint;
begin
  if x=nil then exit;
  dfs(x^.l);
  for i:=1 to x^.num do write(x^.key,' ');
  dfs(x^.r);
  if x=root then writeln;
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
  dfs(root);
  {while true do
  begin
    read(t);
    if t=0 then dfs(root) else
    if t=1 then writeln(minnode(root)^.key) else
    if t=2 then writeln(maxnode(root)^.key) else
    read(t1);
    if t=3 then writeln(precursor(search(root,t1))^.key);
    if t=4 then writeln(successor(search(root,t1))^.key);
    if t=5 then delete(search(root,t1));
  end;}
end.
