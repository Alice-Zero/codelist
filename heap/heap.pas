program minheap;
type data=record
       num,l,r,level:longint;
     end;
var heap:array[0..20000]of data;
    a:array[0..1000000]of data;
    size,i,temp,n,j:longint;
    now:int64;
    t:data;
procedure push(x:data);
var fa,son:longint;
begin
  inc(size);
  heap[size]:=x;
  son:=size;
  fa:=son shr 1;
  while (size<>1)and((heap[fa].level<heap[son].level)or((heap[fa].level=heap[son].level)and(heap[fa].l>heap[son].l))) do
  begin
    heap[0]:=heap[fa];
    heap[fa]:=heap[son];
    heap[son]:=heap[0];
    son:=fa;
    fa:=son shr 1;
  end;
end;
procedure pop;
var fa,son:longint;
begin
  inc(now,heap[1].r);
  writeln(heap[1].num,' ',now);
  heap[1]:=heap[size];
  dec(size);
  fa:=1;
  son:=2;
  while (son<=size) do
  begin
    if not((son=size)or((heap[son].level>heap[son+1].level)or((heap[son].level=heap[son+1].level)and(heap[son].l<heap[son+1].l))))
    then inc(son);
    if ((heap[fa].level<heap[son].level)or((heap[fa].level=heap[son].level)and(heap[fa].l>heap[son].l))) then
    begin
      heap[0]:=heap[fa];
      heap[fa]:=heap[son];
      heap[son]:=heap[0];
      fa:=son;
      son:=fa shl 1;
    end
    else break;
  end;
end;
begin
  now:=0;
  j:=1;
  while not eof do begin inc(n);readln(a[n].num,a[n].l,a[n].r,a[n].level);end;
  for j:=1 to n do
  begin
    while (size>=1)and(now+heap[1].r<=a[j].l)
      do pop;
    if size>=1 then dec(heap[1].r,a[j].l-now);
    now:=a[j].l;
    push(a[j]);
  end;
  while (size>=1)
    do pop;
end.

