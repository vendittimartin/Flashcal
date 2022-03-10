unit Evaluador;

{$codepage UTF-8}

interface

uses
  SysUtils,Estados,crt,tipos;

Function Potencia(var a,b:real):real;
Procedure AgregarVariable(var Estado:t_estado;lexema:string);
Procedure AsignarValor(var Estado:t_estado;lexema:string;resultado:real);
Procedure LeerValor(var Estado:t_estado;lexema:string;var resultado:real);
Function realToInteger(a:real):integer;
Procedure EvaluarProgram(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarVariable(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarVar(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarK(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarBody(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarListsent(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarSent(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarAsignacion(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarCad(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarL(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarLectura(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarEscritura(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarIf(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarWhile(Arbol:t_arbol;var Estado:t_estado);
Procedure EvaluarExparit(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarA(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarX(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarD(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarY(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarE(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarB(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarZ(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarF(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarC(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
Procedure EvaluarCond(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
Procedure EvaluarQ(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
Procedure EvaluarG(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
Procedure EvaluarH(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
Procedure EvaluarV(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
Procedure EvaluarI(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
Procedure EvaluarR(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);


implementation
Function Potencia(var a,b:real):real;
begin
   Potencia:=Exp(b*Ln(a));
end;

Procedure AgregarVariable(var Estado:t_estado;lexema:string);
var
  a:t_dato_estado;
begin
  a.variable:=lexema;
  cargar(Estado,a);
end;
Procedure AsignarValor(var Estado:t_estado;lexema:string;resultado:real);
var
  a:t_dato_estado;
  exito:boolean;
begin
  exito:=false;
  Primero(Estado);
  while (not fin(Estado)) and (not exito) do
  begin
    Recuperar_lista(Estado,a);
    if a.Variable=lexema then
    begin
       Eliminar(Estado,a.Variable);
       a.Valor:=resultado;
       cargar(Estado,a);
       exito:=true;
    end
    else
    Siguiente(Estado);
  end;
  if not exito then
  begin
     writeln('Variable ',lexema,' no declarada');
     readkey;
  end;
end;
Procedure LeerValor(var Estado:t_estado;lexema:string;var resultado:real);
var
  a:t_dato_estado;
  exito:boolean;
begin
  exito:=false;
  Primero(Estado);
  while (not fin(Estado)) and (not exito)do
  begin
    Recuperar_Lista(Estado,a);
    if a.Variable=lexema then
    begin
       resultado:=a.Valor;
       exito:=true;
    end
    else
    Siguiente(Estado);
  end;
end;

Function realToInteger(a:real):integer;
var
   b:integer;
begin
   b:=0;
If a>0 then
begin
While (not (a<1))  do
begin
	a:=a-1;
	Inc(b);
End
end
Else
Begin
If a<0 then
begin
While (not (a>-1)) do
begin
	 a:=a+1;
	 Dec(b);
end
end
Else
b:=0;
End;
realToInteger:=b;
end;
Procedure EvaluarProgram(Arbol:t_arbol;var Estado:t_estado);
begin
     AgregarVariable(Estado,Arbol^.Hijos[2]^.Lexema);
     EvaluarVariable(Arbol^.Hijos[4],Estado);
     EvaluarBody(Arbol^.Hijos[6],Estado);
end;
Procedure EvaluarVariable(Arbol:t_arbol;var Estado:t_estado);
begin
     EvaluarVar(Arbol^.Hijos[2],Estado);
end;
Procedure EvaluarVar(Arbol:t_arbol;var Estado:t_estado);
begin
     if Arbol^.Hijos[1]<>nil then
     begin
        AgregarVariable(Estado,Arbol^.Hijos[1]^.Lexema);
	EvaluarK(Arbol^.Hijos[2],Estado);
     end;
end;
Procedure EvaluarK(Arbol:t_arbol;var Estado:t_estado);
begin
     if Arbol^.Hijos[1]<>nil then
     begin
        AgregarVariable(Estado,Arbol^.Hijos[2]^.Lexema);
        EvaluarK(Arbol^.Hijos[3],Estado);
     end;
end;
Procedure EvaluarBody(Arbol:t_arbol;var Estado:t_estado);
begin
     EvaluarListsent(Arbol^.Hijos[2],Estado);
end;
Procedure EvaluarListsent(Arbol:t_arbol;var Estado:t_estado);
begin
     if Arbol^.Hijos[1]<>nil then
     begin
        EvaluarSent(Arbol^.Hijos[1],Estado);
	EvaluarListsent(Arbol^.Hijos[3],Estado);
     end;
end;
Procedure EvaluarSent(Arbol:t_arbol;var Estado:t_estado);
begin
      if Arbol^.Hijos[1]^.simb='Asignacion' then
      begin
         EvaluarAsignacion(Arbol^.Hijos[1],Estado);
      end
      else
      if Arbol^.Hijos[1]^.simb='Cad' then
      begin
         EvaluarCad(Arbol^.Hijos[1],Estado);
      end
      else
      if Arbol^.Hijos[1]^.simb='If' then
      begin
         EvaluarIf(Arbol^.Hijos[1],Estado);
      end
      else
      if Arbol^.Hijos[1]^.simb='While' then
      begin
         EvaluarWhile(Arbol^.Hijos[1],Estado);
      end;
end;
Procedure EvaluarAsignacion(Arbol:t_arbol;var Estado:t_estado);
var
  resultado:real;
begin
      EvaluarExparit(Arbol^.Hijos[3],Estado,resultado);
      AsignarValor(Estado,Arbol^.Hijos[1]^.lexema,resultado);
end;
Procedure EvaluarCad(Arbol:t_arbol;var Estado:t_estado);
begin
      Write(Arbol^.Hijos[1]^.lexema);
      EvaluarL(Arbol^.Hijos[3],Estado);
end;
Procedure EvaluarL(Arbol:t_arbol;var Estado:t_estado);
begin
      if Arbol^.Hijos[1]^.simb='Lectura' then
         EvaluarLectura(Arbol^.Hijos[1],Estado)
      else
         EvaluarEscritura(Arbol^.Hijos[1],Estado);
end;
Procedure EvaluarLectura(Arbol:t_arbol;var Estado:t_estado);
var
  X:string;
  r,c,d,k,l:real;
  B:TStringArray;
  i:integer;
begin
      Readln(X);
      val(X,r,i);
           if i<>0 then
           begin
                B:=X.split(',');
                val(B[0],c,i);
                val(B[1],d,i);
                k:=-length(B[1]);
                l:=10;
                r:=(c+d*Potencia(l,k));
           end;
      AsignarValor(Estado,Arbol^.Hijos[3]^.lexema,r);
end;
Procedure EvaluarEscritura(Arbol:t_arbol;var Estado:t_estado);
var
  resultado:real;
begin
      EvaluarExparit(Arbol^.Hijos[3],Estado,resultado);
      Writeln(Resultado:0:2);
end;
Procedure EvaluarIf(Arbol:t_arbol;var Estado:t_estado);
var
  Cond:boolean;
begin
      EvaluarCond(arbol^.Hijos[2],Estado,Cond);
      if Cond then
         EvaluarListsent(Arbol^.Hijos[4],Estado)
      else
         EvaluarListsent(Arbol^.Hijos[8],Estado);
end;
Procedure EvaluarWhile(Arbol:t_arbol;var Estado:t_estado);
var
  Cond:boolean;
begin
      EvaluarCond(Arbol^.Hijos[2],Estado,Cond);
      While Cond do
      begin
            EvaluarListsent(Arbol^.Hijos[4],Estado);
            EvaluarCond(Arbol^.Hijos[2],Estado,Cond);
      end;
end;
Procedure EvaluarExparit(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
begin
      EvaluarA(Arbol^.Hijos[1],Estado,Resultado);
      EvaluarX(Arbol^.Hijos[2],Estado,Resultado);
end;
Procedure EvaluarA(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
begin
      EvaluarB(Arbol^.Hijos[1],Estado,Resultado);
      EvaluarY(Arbol^.Hijos[2],Estado,Resultado);
end;
Procedure EvaluarX(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
begin
      if Arbol^.Hijos[1]<>nil then
      begin
           EvaluarD(Arbol^.Hijos[1],Estado,Resultado);
           EvaluarX(Arbol^.Hijos[2],Estado,Resultado);
      end;
end;
Procedure EvaluarD(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
var resultadoS:real;
begin
      if Arbol^.Hijos[1]^.simb='+' then
      begin
           EvaluarA(Arbol^.Hijos[2],Estado,ResultadoS);
           Resultado:=Resultado+ResultadoS;
      end
      else
      begin
           EvaluarA(Arbol^.Hijos[2],Estado,ResultadoS);
           Resultado:=Resultado-ResultadoS;
      end;
end;
Procedure EvaluarY(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
begin
      if Arbol^.Hijos[1]<>nil then
      begin
           EvaluarE(Arbol^.Hijos[1],Estado,Resultado);
           EvaluarY(Arbol^.Hijos[2],Estado,Resultado);
      end;
end;
Procedure EvaluarE(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
var
  resultadoB:real;
begin
      EvaluarB(Arbol^.Hijos[2],Estado,ResultadoB);
      if Arbol^.Hijos[1]^.simb='*' then
           Resultado:=Resultado*ResultadoB
      else
      begin
      if ResultadoB<>0 then
           Resultado:=Resultado/ResultadoB
           else
           begin
                writeln('No es posible dividir por cero');
                readkey;
           end;
      end;
end;
Procedure EvaluarB(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
begin
      EvaluarC(Arbol^.Hijos[1],Estado,Resultado);
      EvaluarZ(Arbol^.Hijos[2],Estado,Resultado);
end;
Procedure EvaluarZ(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
begin
      if Arbol^.Hijos[1]<>nil then
      begin
           EvaluarF(Arbol^.Hijos[1],Estado,Resultado);
           EvaluarZ(Arbol^.Hijos[2],Estado,Resultado);
      end;
end;
Procedure EvaluarF(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
var
   ResultadoP:real;
begin
      EvaluarC(Arbol^.Hijos[2],Estado,ResultadoP);
      Resultado:=Potencia(Resultado,ResultadoP);
end;
Procedure EvaluarC(Arbol:t_arbol;var Estado:t_estado;var resultado:real);
var
   resultadoM,c,d,l,k:real;
   i:integer;
   B:TStringArray;
begin
      if Arbol^.Hijos[1]^.simb='id' then
      begin
           LeerValor(Estado,Arbol^.hijos[1]^.lexema,Resultado);
      end
      else
      if Arbol^.Hijos[1]^.simb='constreal' then
      begin
           val(Arbol^.Hijos[1]^.lexema,Resultado,i);
           if i<>0 then
           begin
                B:=Arbol^.Hijos[1]^.lexema.split(',');
                val(B[0],c,i);
                val(B[1],d,i);
                k:=-length(B[1]);
                l:=10;
                resultado:=(c+d*Potencia(l,k));
           end;
      end
      else
      if Arbol^.hijos[1]^.simb='(' then
      begin
           EvaluarExparit(Arbol^.Hijos[2],Estado,Resultado);
      end
      else
      if Arbol^.hijos[1]^.simb='-' then
      begin
           EvaluarC(Arbol^.Hijos[2],Estado,ResultadoM);
           Resultado:=(-1)*ResultadoM;
      end
      else
      if Arbol^.hijos[1]^.simb='raiz' then
      begin
           EvaluarExparit(Arbol^.Hijos[3],Estado,ResultadoM);
           Resultado:=sqrt(ResultadoM);
      end;
end;
Procedure EvaluarCond(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
begin
      EvaluarQ(Arbol^.Hijos[1],Estado,cond);
      EvaluarG(Arbol^.Hijos[2],Estado,cond);
end;
Procedure EvaluarQ(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
begin
      EvaluarV(Arbol^.Hijos[1],Estado,cond);
      EvaluarI(Arbol^.Hijos[2],Estado,cond);
end;
Procedure EvaluarG(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
begin
      if Arbol^.Hijos[1]<>nil then
      begin
           EvaluarH(Arbol^.Hijos[1],Estado,cond);
           EvaluarG(Arbol^.Hijos[2],Estado,cond);
      end;
end;
Procedure EvaluarH(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
var
   CondH:boolean;
begin
      EvaluarQ(Arbol^.Hijos[2],Estado,condH);
      cond:=cond or condH;
end;
Procedure EvaluarV(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
begin
     if Arbol^.Hijos[1]^.simb='no' then
     begin
          EvaluarR(Arbol^.Hijos[2],Estado,cond);
          cond:=not cond;
     end
     else
          EvaluarR(Arbol^.Hijos[1],Estado,cond);
end;
Procedure EvaluarI(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
var
   condI:boolean;
begin
     if Arbol^.Hijos[1]<>nil then
     begin
          EvaluarV(Arbol^.Hijos[2],Estado,condI);
          cond:=cond and condI;
     end;
end;
Procedure EvaluarR(Arbol:t_arbol;var Estado:t_estado;var cond:boolean);
var
   resultado1,resultado2:real;
begin
     if Arbol^.Hijos[1]^.simb='[' then
     begin
          EvaluarCond(Arbol^.Hijos[2],Estado,cond);
     end
     else
     begin
          EvaluarExparit(Arbol^.Hijos[1],Estado,resultado1);
          EvaluarExparit(Arbol^.Hijos[3],Estado,resultado2);
          if Arbol^.hijos[2]^.lexema='=' then cond:=resultado1=resultado2
          else
          if Arbol^.hijos[2]^.lexema='<' then cond:=resultado1<resultado2
          else
          if Arbol^.hijos[2]^.lexema='>' then cond:=resultado1>resultado2
          else
          if Arbol^.hijos[2]^.lexema='>=' then cond:=resultado1>=resultado2
          else
          if Arbol^.hijos[2]^.lexema='<=' then cond:=resultado1<=resultado2
          else
          if Arbol^.hijos[2]^.lexema='<>' then cond:=resultado1<>resultado2;
     end;
end;

end.


