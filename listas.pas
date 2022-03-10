unit Listas;
{$codepage UTF-8}


interface
type
    t_dato=Record
       lexema:string;
       complex:string;
       end;

    T_punt=^T_nodo;

    T_lista=Record
       tam:integer;
       act,cab:T_punt;
    end;

    T_nodo=Record
       Info:T_dato;
       Sig:T_punt;
    end;

 procedure Cargar (var L:T_Lista; E:T_Dato);
 procedure Eliminar (var L:T_Lista; buscado:string; Var E:T_Dato);
 procedure Recuperar_lista (L:T_Lista; Var E:T_Dato);
 function Lista_llena (L:T_lista):boolean;
 function Lista_vacia (L:T_lista):boolean;
 procedure Primero (var L:T_Lista);
 procedure Siguiente (var L:T_Lista);
 function Fin (L:T_Lista):boolean;

implementation

procedure Cargar (var L:T_Lista; E:T_Dato);
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

procedure Eliminar (var L:T_Lista; buscado:string; Var E:T_dato);
var
  act,ant:T_punt;
begin
  if L.cab^.Info.lexema=buscado then
     begin
       E:=L.cab^.Info;
       L.act:=L.cab;
       L.cab:=L.cab^.sig;
       dispose(L.act);
      end
      else
        begin
          Ant:=L.cab;
          L.act:=L.cab^.sig;
            while (L.act<>NIL) and (L.act^.info.lexema<>buscado) do
               begin
                 Ant:=L.act;
                 L.act:=L.act^.sig;
               end;
          E:=L.act^.info;
          Ant^.sig:=L.act^.sig;
          dispose(L.act);
        end;
      dec(L.tam);
end;

procedure Recuperar_lista (L:T_Lista; Var E:T_dato);
   begin
     E:=L.act^.info
   end;

function Lista_llena (L:T_lista):boolean;
   begin
     Lista_llena:=getheapstatus.totalfree<SizeOF(T_Nodo);
   end;

function Lista_vacia (L:T_lista):boolean;
   begin
     Lista_vacia:=(L.tam=0);
   end;

procedure Primero (var L:T_Lista);
   begin
     L.act:=L.cab;
   end;

procedure Siguiente (var L:T_Lista);
   begin
     L.act:=L.act^.sig;
   end;

function Fin (L:T_Lista):boolean;
   begin
     Fin:=L.act=NIL;
   end;
end.

