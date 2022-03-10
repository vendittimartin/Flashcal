unit Listas_aplicacion;
{$codepage UTF-8}

interface

 uses
  Classes, SysUtils,Listas,Archivos,tipos,crt;

 procedure recuperar_registro(var L:T_lista);
 procedure Agregar_en_lista(Lexema:string;var L:T_lista; CompLex:string);
 procedure Agregar_pesos(var L:T_lista);


implementation

procedure recuperar_registro(var L:T_lista);
var
   bien:boolean;
   i:integer;
   E:T_dato;
   P_reservada:array[1..13] of string = ('programa','variables','cuerpo','fin','mientras','si','sino','leer','escribir','raiz','or','and','no');
    begin
           bien:=false;
           Recuperar_lista(L,E);
           case E.compLex of
                '+':writeln('Caracter Especial: ',E.compLex);
                '-':writeln('Caracter Especial: ',E.compLex);
                '*':writeln('Caracter Especial: ',E.compLex);
                '/':writeln('Caracter Especial: ',E.compLex);
                '^':writeln('Caracter Especial: ',E.compLex);
                '(':writeln('Caracter Especial: ',E.compLex);
                ')':writeln('Caracter Especial: ',E.compLex);
                '{':writeln('Caracter Especial: ',E.compLex);
                '}':writeln('Caracter Especial: ',E.compLex);
                '[':writeln('Caracter Especial: ',E.compLex);
                ']':writeln('Caracter Especial: ',E.compLex);
                ';':writeln('Caracter Especial: ',E.compLex);
                ',':writeln('Caracter Especial: ',E.compLex);
                ':':writeln('Caracter Especial: ',E.compLex);
           else
            begin
            i:=1;
            while (i<=13) and (not bien) do
            begin
               if E.Complex=P_reservada[i] then
               begin
                  writeln('Palabra Reservada: ',E.compLex);
                  bien:=true;
               end
               else
               inc(i);
            end;
               if E.Complex='SimboloEsp' then
           else
             begin
               if not bien then
               begin
                  write(E.CompLex, ': ');
                  writeln(E.Lexema);
               end;
             end;
             end;
    end;
    Siguiente(L);
    end;

procedure Agregar_en_lista(Lexema:string;var L:T_lista; CompLex:string);
var
   R:T_dato;
begin
   R.lexema:=Lexema;
   R.CompLex:=CompLex;
   Cargar(L,R);
end;

procedure Agregar_pesos(var L:T_lista);
var
  a,b:t_dato;
begin
  b.complex:=';';
  b.lexema:=';';
  agregar_en_lista(b.Lexema,L,b.CompLex);
  a.complex:='$';
  a.lexema:='$';
  agregar_en_lista(a.Lexema,L,a.CompLex);
end;
end.

