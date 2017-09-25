program AC;
type treenode=record
     cot,fail:longint;
     son:array['a'..'z']of longint;
     failed:boolean;
     end;
var s:ansistring;
    trie:array[1..1000000]of treenode;
    cot,n,i:longint;
procedure insert(x:ansistring);
var  i:longint;
     g:^treenode;
begin
  g:=@trie[1];
  for i:=1 to length(s) do
  begin
    if g^.son[s[i]]=0 then
    begin
      inc(cot);
      g^.son[s[i]]:=cot;
    end;
    g:=@trie[g^.son[s[i]]];
  end;
  inc(g^.cot);
end;

procedure bfs;
var q:array[1..1000000]of longint;
    l,r,son:longint;
    ch:char;
    g,t:^treenode;
begin
  l:=0;
  r:=0;
  g:=@trie[1];
  //trie[1].fail:=1;
  for ch:='a' to 'z' do
  begin
    son:=g^.son[ch];
    if son<>0 then
    begin
      inc(r);
      q[r]:=son;
      trie[son].fail:=1;
    end;
  end;
  while r>l do
  begin
    inc(l);
    g:=@trie[q[l]];
    for ch:='a' to 'z' do
    begin
      son:=g^.son[ch];
      if son<>0 then
      begin
        t:=@trie[g^.fail];
        while (t^.son[ch]=0)and(t<>@trie[1]) do
          t:=@trie[t^.fail];
        if t^.son[ch]=0 then
          trie[son].fail:=1
        else
          trie[son].fail:=t^.son[ch];
        inc(r);
        q[r]:=son;
      end;
    end;
  end;
end;

function ac(s:ansistring):longint;
var i,son:longint;
    g,t:^treenode;
begin
  ac:=0;
  g:=@trie[1];
  g^.failed:=true;
  for i:=1 to length(s) do
  begin
    while (g^.son[s[i]]=0)and(g<>@trie[1]) do
      g:=@trie[g^.fail];
    if g^.son[s[i]]=0 then continue;
    g:=@trie[g^.son[s[i]]];
    t:=g;
    while not t^.failed do
    begin
      inc(ac,t^.cot);
      t^.failed:=true;
      t:=@trie[t^.fail];
    end;
  end;
end;
begin
  readln(n);
  cot:=1;
  for i:=1 to n do
  begin
    readln(s);
    insert(s);
  end;
  bfs;
  readln(s);
  writeln(ac(s));
end.

