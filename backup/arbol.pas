unit Arbol;

{$codepage UTF-8}

interface

uses
  Tipos;

procedure crear_arbol(var raiz:t_arbol);
procedure agregar_arbol(var raiz:t_arbol;simb,lexema:string);
procedure agregar_hijos(var raiz,hijo:t_arbol);

implementation

procedure crear_arbol(var raiz:t_arbol);
begin
  raiz:=nil;
end;

procedure agregar_arbol(var raiz:t_arbol;simb,lexema:string);
var i:integer;
    aux:t_arbol;
begin
  new(aux);
  aux^.simb:=simb;
  aux^.Lexema:=lexema;
  aux^.Chijos:=0;
  for i:=1 to 9 do
  aux^.hijos[i]:=nil;
  raiz:=aux;
end;

procedure agregar_hijos(var raiz,hijo:t_arbol);
begin
  if raiz^.cant_hijos<9 then
  begin
    inc(raiz^.Chijos);
    raiz^.hijos[raiz^.Chijos]:=hijo;
  end;
end;

end.

