unit analizador_sintactico;

interface

uses
  crt,Pila,Listas,TAS,Listas_aplicacion,tipos,arboles;

procedure Algoritmo_reconocimiento(L:T_lista;TAS:T_matriz;var exito:boolean;var arbol:t_arbol);
procedure reconocimiento(var exito,error:boolean;var L:T_lista;var P:T_pila;var X:t_dato_pila; TAS: T_matriz;var arbol:t_arbol);
procedure AnalizadorSintactico(var tabla_s:t_lista;var exito:boolean;var arbol:t_arbol);
implementation

procedure Algoritmo_reconocimiento(L:T_lista;TAS:T_matriz;var exito:boolean;var arbol:t_arbol);
var
  I:integer;
  P:t_pila;
  X:t_dato_pila;
  error:boolean;
  a:string;
  Variables:array[1..31] of string=('Program','Variable','Var','K','Body','Listsent','Sent','Asignacion','Cad','L','Lectura','Escritura','If','While','Exparit','X','D','A','Y','E','B','Z','F','C','Cond','G','H','Q','V','I','R');
begin
  crearpila(P);
  crear_arbol(arbol);
  exito:=false;
  error:=false;
  X.simb:='$';
  Apilar(P,X);
  X.simb:=Variables[1];
  agregar_arbol(arbol,X.simb,a);
  X.arbol:=arbol;
  Apilar(P,X);
  Primero(L);
  while (not exito) and (not error) do
   begin
     Reconocimiento(exito,error,L,P,X,TAS,arbol);
   end;
end;

procedure reconocimiento(var exito,error:boolean;var L:T_lista;var P:T_pila;var X:t_dato_pila; TAS: T_matriz;var arbol:t_arbol);
var
  a:T_dato;
  i,j:integer;
begin
 Desapilar(P,X);
 if Esterminal(X.simb)=true then
 begin
    recuperar_lista(L,a);
    if X.simb=a.complex then
    begin
       if X.simb='$' then
       begin
          exito:=true;
       end
       else
       begin
         X.arbol^.lexema:=a.lexema;
         Siguiente(L);
       end;
    end
    else
    begin
      writeln('Error terminal');
      error:=true;
    end;
 end
 else
   begin
   recuperar_lista(L,a);
   posTAS(X.simb,a.CompLex,i,j);
   if TAS[i,j]='' then
   begin
      writeln('error vacio');
      error:=true;
   end
   else
   if TAS[i,j]<>'eps_ ' then
   begin
      apilar_Variable(P,TAS,a,X);
   end;
   end;
 end;

 procedure AnalizadorSintactico(var tabla_s:t_lista;var exito:boolean;var arbol:t_arbol);
 var
  tablaAS:t_matriz;
 begin
  cargar_TAS(TablaAS);
  agregar_pesos(tabla_s);
  Algoritmo_reconocimiento(tabla_s,TablaAS,exito,arbol);
 end;
end.

