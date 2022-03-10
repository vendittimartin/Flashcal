unit Arboles;

{$codepage UTF-8}

interface

uses
  Tipos,crt,Sysutils;

procedure crear_arbol(var raiz:t_arbol);
procedure agregar_arbol(var raiz:t_arbol;simb,lexema:string);
procedure agregar_hijo(var raiz,hijo:t_arbol);
procedure listar_arbol(var arbol:t_arbol);

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

procedure agregar_hijo(var raiz,hijo:t_arbol);
begin
  if raiz^.Chijos<9 then
  begin
    inc(raiz^.Chijos);
    raiz^.hijos[raiz^.Chijos]:=hijo;
  end;
end;

procedure listar_arbol(var arbol:t_arbol);
var
    i:integer;
begin
    writeln(arbol^.simb);
    for i:=1 to arbol^.Chijos do
      begin
        listar_arbol(arbol^.hijos[i]);
        delay(150);
      end;
end;












end.

