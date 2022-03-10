unit Tipos;

{$codepage UTF-8}

interface

uses
  Classes, SysUtils;
type
  t_arch=file of char;

  t_matriz=array [1..31,1..33] of string;

  t_arbol =  ^t_nodo;

  t_nodo=record
       simb,lexema:string;
       hijos:array [1..9] of t_arbol;
       Chijos:0..9;
       end;

  t_dato_pila=record
       simb:string;
       arbol:t_arbol;
       end;

  t_dato_estado=record
       variable:string;
       valor:real;
       end;

  t_punt=^t_nodo_estado;

  t_nodo_estado=record
       Info:T_dato_estado;
       Sig:T_punt;
       end;

  t_estado=Record
       tam:integer;
       act,cab:T_punt;
       end;

implementation

end.

