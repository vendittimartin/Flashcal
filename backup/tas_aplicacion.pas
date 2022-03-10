unit tabla_simb;
{$codepage UTF-8}

interface

 uses
  Classes, SysUtils,Tabla,Archivos;

 //Procedure baja;
 procedure recuperar_registro(var L:T_lista);
 //procedure Listar_TAS(var L:T_lista);
 procedure Agregar_en_TAS(Lexema:string;var tas:T_lista; CompLex:string);


implementation

procedure recuperar_registro(var L:T_lista);
var E:T_dato;
begin
    Primero(L);
    while (not fin(L)) do
       begin
           Recuperar_lista(L,E);
           write(E.CompLex, ' ');
           writeln(E.Lexema);
           Siguiente(L);
       end;
end;

{procedure Listar_TAS(var L:T_lista); 
   begin
     if not Lista_vacia(L) then Listar(L) else write ('Lista vacia');
   end; }

procedure Agregar_en_TAS(Lexema:string;var tas:T_lista; CompLex:string);
var
   R:T_dato;
begin
   R.lexema:=Lexema;
   R.CompLex:=CompLex;
   Cargar(tas,R);
end;

end.

