program segmenttree;
type treenode=record
     l,r,sum,add,mul:qword;
end;

var a:array[1..1000000]of treenode;
    b:array[1..1000000]of qword;
    m,n,i,t,l,r,k,p:longint;

procedure build(u,l,r:longint);
begin
  a[u].l:=l;a[u].r:=r;a[u].mul:=1;
  if l=r then
  begin
    a[u].sum:=b[l];
    exit;
  end;
  build(u<<1,l,(l+r)>>1);
  build(u<<1+1 ,(l+r)>>1+1 ,r);
  a[u].sum:=a[u<<1].sum+a[u<<1 + 1].sum;
end;

procedure pushdown(u:longint);
begin
  a[u<<1].mul:=a[u].mul*a[u<<1].mul mod p;
  a[u<<1].add:=a[u].mul*a[u<<1].add mod p;
  a[u<<1].sum:=a[u].mul*a[u<<1].sum mod p;
  a[u<<1+1].mul:=a[u].mul*a[u<<1+1].mul mod p;
  a[u<<1+1].add:=a[u].mul*a[u<<1+1].add mod p;
  a[u<<1+1].sum:=a[u].mul*a[u<<1+1].sum mod p;
  a[u].mul:=1;
  inc(a[u<<1].sum,(a[u<<1].r-a[u<<1].l+1)*a[u].add);
  inc(a[u<<1+1].sum,(a[u<<1+1].r-a[u<<1+1].l+1)*a[u].add);
  inc(a[u<<1].add,a[u].add);
  inc(a[u<<1+1].add,a[u].add);
  a[u].add:=0;
end;

function query(u,l,r:longint):qword;
begin
  if (a[u].l>r) or (a[u].r<l) then exit(0);
  if (a[u].l>=l) and (a[u].r<=r) then exit(a[u].sum);
  if (a[u].add<>0)or(a[u].mul<>1) then pushdown(u);
  exit((query(u<<1,l,r)+query(u<<1+1,l,r)) mod p);
end;

procedure add(u,l,r,k:longint);
begin
  if (a[u].l>r)or(a[u].r<l) then exit;
  if (a[u].l>=l)and(a[u].r<=r) then
  begin
    inc(a[u].add,k);
    inc(a[u].sum,(a[u].r-a[u].l+1)*k);
    exit;
  end;
  if (a[u].add<>0)or(a[u].mul<>1) then pushdown(u);
  add(u<<1,l,r,k);
  add(u<<1+1,l,r,k);
  a[u].sum:=a[u<<1].sum+a[u<<1+1].sum;
end;

procedure mul(u,l,r,k:longint);
begin
  if (a[u].l>r)or(a[u].r<l) then exit;
  if (a[u].l>=l)and(a[u].r<=r) then
  begin
    a[u].mul:=a[u].mul*k mod p;
    a[u].add:=a[u].add*k mod p;
    a[u].sum:=a[u].sum*k mod p;
    exit;
  end;
  if (a[u].add<>0)or(a[u].mul<>1) then pushdown(u);
  mul(u<<1,l,r,k);
  mul(u<<1+1,l,r,k);
  a[u].sum:=(a[u<<1].sum+a[u<<1+1].sum) mod p;
end;

begin
  readln(m,n,p);
  for i:=1 to m do read(b[i]);
  build(1,1,m);
  for i:=1 to n do
  begin
    read(t);
    if t=1 then
    begin
      readln(l,r,k);
      mul(1,l,r,k);
    end;
    if t=2 then
    begin
      readln(l,r,k);
      add(1,l,r,k);
    end;
    if t=3 then
    begin
      readln(l,r);
      writeln(query(1,l,r));
    end;
  end;
end.
