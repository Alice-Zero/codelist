program AVL;
type treenode=^node;
     node=record
     key,h,hf,num,size:longint;
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
function nodeprec(x:treenode):treenode;
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
function nodesucc(x:treenode):treenode;
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
function numprec(x:treenode;k:longint):treenode;
begin
  if x=nil then exit(x);
  if x^.key>=k then
    exit(numprec(x^.l,k))
  else
    numprec:=numprec(x^.r,k);
  if numprec=nil then exit(x);
end;
function numsucc(x:treenode;k:longint):treenode;
begin
  if x=nil then exit(x);
  if x^.key<=k then
    exit(numsucc(x^.r,k))
  else
    numsucc:=numsucc(x^.l,k);
  if numsucc=nil then exit(x);
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
  var hl,hr,sl,sr:longint;
  begin
    if x^.l=nil then hl:=0 else hl:=x^.l^.h;
    if x^.r=nil then hr:=0 else hr:=x^.r^.h;
    if x^.l=nil then sl:=0 else sl:=x^.l^.size;
    if x^.r=nil then sr:=0 else sr:=x^.r^.size;
    x^.h:=max(hl,hr)+1;
    x^.hf:=hl-hr;
    x^.size:=sl+sr+x^.num;
  end;
  function LL(x:treenode):treenode;
  var y:treenode;
  begin
    y:=x^.l;
    transplant(y,y^.r);
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
    transplant(y,y^.l);
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
  if x^.hf=-2 then
    if x^.r^.hf<=0 then
      x:=RR(x)
    else
      x:=RL(x);
  if (x^.p<>nil){and(h<>x^.h)} then
    rotate(x^.p);
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
      rotate(x);
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
  z^.h:=0;
  z^.num:=1;
  z^.size:=1;
  z^.p:=y;
  if y=nil then root:=z
  else if z^.key<y^.key then
    y^.l:=z
  else
    y^.r:=z;
  rotate(z);
end;
procedure delete(x:treenode);
var y:treenode;
begin
  if x^.num<>1 then
  begin
    dec(x^.num);
    rotate(x);
    exit;
  end;
  if x^.l=nil then
    transplant(x,x^.r)
  else if x^.r=nil then
    transplant(x,x^.l)
  else
  begin
    y:=minnode(x^.r);
    x^.key:=y^.key;
    x^.num:=y^.num;
    y^.num:=1;
    delete(y);
    exit;
  end;
  if x^.p<>nil then rotate(x^.p);
  dispose(x);
end;
procedure dfs(x:treenode);
var i:longint;
begin
  if x=nil then exit;
  dfs(x^.l);
  for i:=1 to x^.num do write(x^.key,' ');
  //writeln(x^.key,' ',x^.num);
  dfs(x^.r);
  if x=root then writeln;
end;
function select(x:treenode;k:longint):longint;
var sl:longint;
begin
  if x^.l<>nil then sl:=x^.l^.size else sl:=0;
  if (k>sl)and(k<=sl+x^.num) then exit(x^.key);
  if k<=sl then
    exit(select(x^.l,k))
  else
    exit(select(x^.r,k-sl-x^.num));
end;
function rank(x:treenode;k:longint):longint;
var sl:longint;
begin
  if x^.l<>nil then sl:=x^.l^.size else sl:=0;
  if k=x^.key then exit(1+sl);
  if k<x^.key then
    exit(rank(x^.l,k))
  else
    exit(rank(x^.r,k)+sl+x^.num);
end;
var n,i,opt,x,s:longint;
    g:treenode;
begin
  root:=nil;
  readln(n);
  for i:=1 to n do
  begin
    readln(opt,x);
    if root<>nil then s:=root^.size;
    if opt=1 then insert(x);
    if opt=2 then delete(search(root,x));
    if opt=3 then writeln(rank(root,x));
    if opt=4 then writeln(select(root,x));
    if opt=5 then writeln(numprec(root,x)^.key);
    if opt=6 then writeln(numsucc(root,x)^.key);
  end;
end.
