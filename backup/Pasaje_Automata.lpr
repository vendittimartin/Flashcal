Program Pasaje_Automata;
{$codepage UTF-8}
uses
  crt, Automatas,Tabla,archivos,tabla_simb,TAS,AutomataPDA,Pila;
var
  arch:T_arch;
  control:longint;
  lexema:string;
  complex:string;
  caracter:char;
  tabla_s:T_lista;
  exito:boolean;
  P:t_pila;
  tablaAS:t_matriz;
  pesos,punto:t_dato;
  begin
  analizadorLexico(arch,control,complex,lexema,tabla_s,exito,caracter);
  Listar_Tabla_s(tabla_s);
  readkey;
  clrscr;
  cargar_TAS(TablaAS);
  punto.complex:=';';
  punto.lexema:=';';
  agregar_en_tabla_s(punto.Lexema,tabla_s,punto.CompLex);
  pesos.complex:='$';
  pesos.lexema:='$';
  agregar_en_tabla_s(pesos.Lexema,tabla_s,pesos.CompLex);
  Algoritmo_reconocimiento(P,tabla_s,TablaAS);
end.
