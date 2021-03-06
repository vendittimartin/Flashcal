unit Pila;


interface
uses crt,tipos;
CONST
     N=100;
TYPE
    T_pila= RECORD
            TOPE,TAM: 0..N;
            ELEM:ARRAY [1..N] OF T_DATO_pila;
            END;
PROCEDURE CREARPILA(VAR P:T_PILA);
PROCEDURE APILAR (VAR P:T_PILA; X:T_DATO_pila);
FUNCTION PILA_LLENA (VAR P:T_PILA): BOOLEAN;
FUNCTION PILA_VACIA (VAR P:T_PILA): BOOLEAN;
PROCEDURE DESAPILAR (VAR P:T_PILA;VAR X:T_DATO_pila);
//PROCEDURE MUESTRA_PILA (VAR P:T_PILA);
implementation
PROCEDURE CREARPILA(VAR P:T_PILA); BEGIN
P.TAM:=0;
P.TOPE:=0;
END;

PROCEDURE APILAR (VAR P:T_PILA; X:T_DATO_pila);
BEGIN
P.TOPE:=P.TOPE+1;
P.ELEM[P.TOPE]:=X;
INC(P.TAM)
END;

FUNCTION PILA_LLENA (VAR P:T_PILA): BOOLEAN;
BEGIN
PILA_LLENA:=P.TAM=N;
END;

FUNCTION PILA_VACIA (VAR P:T_PILA): BOOLEAN;
BEGIN
PILA_VACIA:= P.TAM=0;
END;

PROCEDURE DESAPILAR (VAR P:T_PILA;VAR X:T_DATO_pila);
BEGIN
X:= P.ELEM[P.TOPE];
P.TOPE:=P.TOPE-1;
DEC(P.TAM);
END;

{PROCEDURE MUESTRA_PILA (VAR P:T_PILA);
var
LINEA:BYTE;
X:T_DATO_pila;
BEGIN
CLRSCR;
LINEA:=0;
WHILE (NOT (PILA_VACIA(P))) DO
BEGIN
DESAPILAR (P,X);
GOTOXY(35,8+LINEA);
WRITE (X);
INC (LINEA);
READKEY;
END;
END;}

end.
