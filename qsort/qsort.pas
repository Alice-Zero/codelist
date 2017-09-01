var a:array[0..10000] of longint;
    n,i:longint;
procedure qsort(l,r:longint);
var i,j,mid:longint;
begin
  if l>=r then exit;
  i:=l;j:=r;mid:=a[(l+r)div 2];
  repeat
    while a[i]<mid do inc(i);
    while a[j]>mid do dec(j);
    if i<= j then
    begin
    a[0]:=a[i];a[i]:=a[j];a[j]:=a[0];
    inc(i);dec(j);
    end;
  until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
end;
begin
  readln(n);
  for i:=1 to n do read(a[i]);
  qsort(1,n);
  for i:=1 to n do write(a[i],' ');
end.

