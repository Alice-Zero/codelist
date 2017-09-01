program mergesort;
var a,t:array[1..10000] of longint;
    i:longint;
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
    if a[i]<=a[j] then
    begin t[k]:=a[i];inc(k);inc(i);end
    else
    begin t[k]:=a[j];inc(k);inc(j);end;
  while (i<=m) do begin t[k]:=a[i];inc(k);inc(i);end;
  while (j<=r) do begin t[k]:=a[j];inc(k);inc(j);end;
  for i:=l to r do a[i]:=t[i];
end;
begin
  for i:=1 to 5 do
    read(a[i]);
  mergesort(1,5);
end.
        1
