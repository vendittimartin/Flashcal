unit ArbolesBinarios;
INTERFACE
USES CRT,tipos;{
TYPE
T_PUNT = ^T_NODO;
T_NODO = RECORD
 INFO:T_DATO;
 SAI,SAD: T_PUNT;
 END;
PROCEDURE CREAR_ARBOL (VAR RAIZ:T_PUNT);
PROCEDURE AGREGAR (VAR RAIZ:T_PUNT; X:T_DATO);
FUNCTION ARBOL_VACIO (RAIZ:T_PUNT): BOOLEAN;
FUNCTION ARBOL_LLENO (): BOOLEAN;
PROCEDURE INORDEN( RAIZ:T_PUNT);
FUNCTION PREORDEN( RAIZ:T_PUNT;BUSCADO:CHAR):T_PUNT;

PROCEDURE MUESTRA_DATOS (POS: T_PUNT);
PROCEDURE CARGAR_ARBOL(VAR RAIZ:T_PUNT);
PROCEDURE LISTAR (RAIZ:T_PUNT);
PROCEDURE BUSCAR (RAIZ:T_PUNT);
PROCEDURE CONSULTA (RAIZ:T_PUNT);
implementation
PROCEDURE CREAR_ARBOL (VAR RAIZ:T_PUNT);
BEGIN
 RAIZ:= NIL;
 END;

PROCEDURE AGREGAR (VAR RAIZ:T_PUNT; X:T_DATO);
 BEGIN
 IF RAIZ = NIL THEN
 BEGIN
 NEW (RAIZ);
 RAIZ^.INFO:= X;
 RAIZ^.SAI:= NIL;
 RAIZ^.SAD:= NIL;
 END
 ELSE IF RAIZ^.INFO > X THEN AGREGAR (RAIZ^.SAI,X)
 ELSE AGREGAR (RAIZ^.SAD,X)
 END;

FUNCTION ARBOL_VACIO (RAIZ:T_PUNT): BOOLEAN;
 BEGIN
 ARBOL_VACIO:= RAIZ = NIL;
 END;

FUNCTION ARBOL_LLENO (): BOOLEAN;
 BEGIN
 ARBOL_LLENO:= GETHEAPSTATUS.TOTALFREE < SIZEOF (T_NODO);
 END;

FUNCTION PREORDEN(RAIZ:T_PUNT;BUSCADO:CHAR):T_PUNT;
 BEGIN
 IF (RAIZ = NIL) THEN PREORDEN := NIL
 ELSE
 IF ( RAIZ^.INFO = BUSCADO) THEN
 PREORDEN:= RAIZ
ELSE IF RAIZ^.INFO > BUSCADO THEN
 PREORDEN := PREORDEN(RAIZ^.SAI,BUSCADO)
 ELSE
 PREORDEN := PREORDEN(RAIZ^.SAD,BUSCADO)
 END;

PROCEDURE INORDEN(RAIZ:T_PUNT);
 BEGIN
 IF RAIZ <> NIL THEN BEGIN
 INORDEN (RAIZ^.SAI);
 WRITELN (RAIZ^.INFO);
 INORDEN (RAIZ^.SAD);
 end;
 END;

PROCEDURE MUESTRA_DATOS (POS: T_PUNT);
  BEGIN
  WRITELN (POS^.INFO)
  END;

PROCEDURE CARGAR_ARBOL(VAR RAIZ:T_PUNT);
  VAR CAR,TECLA: CHAR;
  BEGIN
  CLRSCR;
  WRITE ('INGRESA? PRESIONE N PARA SALIR: ');
  READLN (TECLA);
  WHILE NOT (ARBOL_LLENO ()) AND (TECLA<> 'N') DO
  BEGIN
  CLRSCR;
  WRITE ('INGRESA CARACTER: ');
  READLN (CAR);
  AGREGAR (RAIZ,CAR);
  WRITE ('INGRESA? PRESIONE N PARA SALIR: ');
  READLN (TECLA);
  end;
  END;

PROCEDURE CONSULTA (RAIZ:T_PUNT);
  VAR POS:T_PUNT; CAR:T_DATO;
  BEGIN
  WRITE('BUSCAR: ');
  READLN (CAR);
  POS:= PREORDEN (RAIZ,CAR);
  IF POS = NIL THEN WRITELN ('NO SE ENCUENTRA' )
  ELSE MUESTRA_DATOS (POS);
  end;

PROCEDURE BUSCAR (RAIZ:T_PUNT);
  BEGIN
  IF ARBOL_VACIO (RAIZ) THEN WRITE ('ARBOL VACIO')
  ELSE CONSULTA(RAIZ);
  READKEY
  end;

PROCEDURE LISTAR (RAIZ:T_PUNT);
  BEGIN
  IF NOT ARBOL_VACIO (RAIZ) THEN INORDEN (RAIZ)
  ELSE WRITELN ('ARBOL VACIO');
  READKEY
  END; }

end.
