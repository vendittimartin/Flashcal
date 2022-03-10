Program Proyecto_interprete;
{$codepage UTF-8}
uses
  crt,Analizador_lexico,Listas,analizador_sintactico,tipos,Arboles,Evaluador,Estados,Archivos;
var
  L_lista:T_lista;
  exito:boolean;
  arbol:t_arbol;
  L_Estado:t_estado;
begin
    analizadorLexico(L_lista);
    analizadorSintactico(L_lista,exito,arbol);
    if exito then
    begin
    clrscr;
    EvaluarProgram(arbol,L_Estado);
    end;
    readkey;
end.
