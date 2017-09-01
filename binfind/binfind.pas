program binfind;
type data=record
     num,data:longint;
     end;
var a,t:array[1..100000] of data;
    i,n,q,temp:longint;
procedure mergesort(l,r:longint);
var m,i,j,k:longint;
begin
  if l=r then exit;
  m:=(l+r)shr 1;
  mergesort(l,m);
  mergesort(m+1,r);
  i:=l;
  j:=m+1;
  k:=l;
  while (i<=m)and(j<=r) do
    if a[i].data<=a[j].data then
    begin t[k]:=a[i];inc(k);inc(i);end
    else
    begin t[k]:=a[j];inc(k);inc(j);end;
  while (i<=m) do begin t[k]:=a[i];inc(k);inc(i);end;
  while (j<=r) do begin t[k]:=a[j];inc(k);inc(j);end;
  for i:=l to r do a[i]:=t[i];
end;
function binfind(k,l,r:longint):longint;
var m:longint;
begin
  m:=(l+r) shr 1;
  if a[m].data=k then exit(m);
  if l=r then exit(0);
  if k<a[m].data then exit(binfind(k,l,m));
  if k>a[m].data then exit(binfind(k,m+1,r));
end;
begin
  readln(n);
  for i:=1 to n do begin read(a[i].data);a[i].num:=i;end;
  mergesort(1,n);
  readln(q);
  for i:=1 to q do
  begin
    readln(temp);
    writeln(a[binfind(temp,1,n)].num);
  end;
end.

