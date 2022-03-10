unit Estados;

interface

uses
  Tipos,SysUtils;

 procedure Cargar (var L:T_estado; E:T_dato_estado);
 procedure Recuperar_lista (L:T_estado; Var E:T_dato_estado);
 function Lista_vacia (L:T_estado):boolean;
 procedure Primero (var L:T_estado);
 procedure Siguiente (var L:T_estado);
 function Fin (L:T_estado):boolean;
 procedure Eliminar (var L:T_estado;buscado:string);

implementation

procedure Cargar (var L:T_estado; E:T_dato_estado);
var
  Ant,Dir:T_Punt;
begin
  new(Dir);
  Dir^.Info:=E;
     If (L.cab=NIL) then
        begin
          Dir^.sig:=L.cab;
          L.cab:=Dir
        end
        else
         begin
           Ant:=L.cab;
           L.act:=L.cab^.sig;
           while (L.act<>NIL) do
             begin
              Ant:=L.act;
              L.act:=L.act^.sig;
             end;
             Ant^.sig:=Dir;
             Dir^.sig:=L.act;
         end;
         inc(L.tam);
end;



procedure Recuperar_lista (L:T_estado; Var E:T_dato_estado);
   begin
     E:=L.act^.info
   end;

function Lista_vacia (L:T_estado):boolean;
   begin
     Lista_vacia:=(L.tam=0);
   end;

procedure Primero (var L:T_estado);
   begin
     L.act:=L.cab;
   end;

procedure Siguiente (var L:T_estado);
   begin
     L.act:=L.act^.sig;
   end;

function Fin (L:T_estado):boolean;
   begin
     Fin:=L.act=NIL;
   end;

procedure Eliminar (var L:T_estado; buscado:string);
var
  ant:T_punt;
begin
  if L.cab^.Info.variable=buscado then
     begin
       L.act:=L.cab;
       L.cab:=L.cab^.sig;
       dispose(L.act);
      end
      else
        begin
          Ant:=L.cab;
          L.act:=L.cab^.sig;
            while (L.act<>NIL) and (L.act^.info.variable<>buscado) do
               begin
                 Ant:=L.act;
                 L.act:=L.act^.sig;
               end;
          Ant^.sig:=L.act^.sig;
          dispose(L.act);
        end;
      dec(L.tam);
end;
end.

