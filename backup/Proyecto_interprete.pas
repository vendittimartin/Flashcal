Program Proyecto_interprete;
{$codepage UTF-8}
uses
  crt,Analizador_lexico,Listas,analizador_sintactico,tipos,Arboles,Evaluador,Estados,Archivos;
var
  L_lista:T_lista;
  exito,errorlexico:boolean;
  arbol:t_arbol;
  L_Estado:t_estado;
begin
    errorlexico:=false;
    analizadorLexico(L_lista,errorlexico);
    if not errorlexico then
    begin
    analizadorSintactico(L_lista,exito,arbol);
    if exito then
    begin
    clrscr;
    EvaluarProgram(arbol,L_Estado);
    end;
    end;
    readkey;
end.
