unit Automatas;
{$codepage UTF-8}


interface

uses
  crt,SysUtils, Tabla, Archivos, tabla_simb, Pantalla;
type
  T_Complex=(Id,ConsRel,Oprel);


Function EsID(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Function EsConsReal(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Function EsOpAsig(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Function EsOprel(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Function EsCad(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Function EsSimboloEsp(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Procedure PalabrasReservadas(var lexema,CompLex:string;var exito:boolean);
Procedure EsCaracter(var Base:T_arch; var control:longint; var Lexema:string; var tabla_s:T_lista;var CompLex:string;var exito:boolean);
Procedure ObtenerSigCompLex(var Base:T_arch; var Control:longint; var CompLex:string; var Lexema:string; var tabla_s:T_lista; var exito:boolean);
Procedure AnalizadorLexico(var arch:t_arch;var control:longint;var complex,lexema:string;var tabla_s:t_lista;var exito:boolean;var caracter:char);

implementation

 
 Function EsID(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
 Const
    q0=0;
    F=[3];
   Type
    Q=0..3;
    Sigma=(Letra,Digito,Otro);
    TDelta=Array[Q,Sigma] of Q;
   Var
    Estado_Actual:Q;
    Delta:TDelta;
    caracter:char;
    nuevo_control:integer;
    lexema_aux:string;

    Function CarASimb (var Car:char):Sigma;
    begin
       Case Car of
            'a'..'z','A'..'Z':CarASimb:=Letra;
            '0'..'9':CarASimb:=Digito;
       else
         CarASimb:=Otro
       end;
    end;
begin
  lexema_aux:='';
  nuevo_control:=control;

  Delta[0,Letra]:=1;
  Delta[0,Digito]:=2;
  Delta[0,Otro]:=2;
  Delta[1,Letra]:=1;
  Delta[1,Digito]:=1;
  Delta[1,Otro]:=3;
  Delta[2,Letra]:=2;
  Delta[2,Digito]:=2;
  Delta[2,Otro]:=2;
  Delta[3,Letra]:=3;
  Delta[3,Digito]:=3;
  Delta[3,Otro]:=3;

  Estado_Actual:=q0;
  while not (Estado_Actual in [2,3])do
         begin
          Recuperar_arch(nuevo_control,caracter);
          Estado_Actual:=Delta[Estado_Actual,CarASimb(caracter)];
          if Estado_Actual=1 then
             begin
             lexema_aux:=lexema_aux+caracter;
             inc(nuevo_control);
             end;
         end;
  if (Estado_Actual in F) then
     begin
      control:=nuevo_control;
      lexema:=lexema_aux;
     end;
  EsID:=Estado_Actual in F;
end;
 Function EsCad(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
    Const
     q0=0;
     F=[5];
    Type
     Q=0..5;
     Sigma=(Letra,Digito,comillas,Otro);
     TDelta=Array[Q,Sigma] of Q;
    Var
     Estado_Actual:Q;
     Delta:TDelta;
     caracter:char;
     nuevo_control:longint;
     lexema_aux:string;

     Function CarASimb (Car:char):Sigma;
     begin
        Case Car of
             'a'..'z', 'A'..'Z':CarASimb:=Letra;
             '0'..'9':CarASimb:=Digito;
             '"':CarAsimb:=Comillas;
        else
          CarASimb:=Otro
        end;
     end;
 begin
   lexema_aux:='';
   nuevo_control:=control;

   Delta[0,Comillas]:=1;
   Delta[0,Letra]:=4;
   Delta[0,Digito]:=4;
   Delta[0,Otro]:=4;
   Delta[1,Comillas]:=3;
   Delta[1,Letra]:=2;
   Delta[1,Digito]:=2;
   Delta[1,Otro]:=2;
   Delta[2,Comillas]:=3;
   Delta[2,Letra]:=2;
   Delta[2,Digito]:=2;
   Delta[2,Otro]:=2;
   Delta[3,Comillas]:=5;
   Delta[3,Letra]:=5;
   Delta[3,Digito]:=5;
   Delta[3,Otro]:=5;
   Delta[4,Comillas]:=4;
   Delta[4,Letra]:=4;
   Delta[4,Digito]:=4;
   Delta[4,Otro]:=4;
   Delta[5,Comillas]:=5;
   Delta[5,Letra]:=5;
   Delta[5,Digito]:=5;
   Delta[5,Otro]:=5;


   Estado_Actual:=q0;
   while not (Estado_Actual in [4,5])do
         begin
           Recuperar_arch(nuevo_control,caracter);
           Estado_Actual:=Delta[Estado_Actual,CarASimb(caracter)];
           if (Estado_Actual=1) or (Estado_Actual=2) or (Estado_Actual=3) then
              begin
              lexema_aux:=lexema_aux+caracter;
              inc(nuevo_control);
              end;
           end;
   if (Estado_Actual in F) then
      begin
         control:=nuevo_control;
         lexema:=lexema_aux;
      end;
   EsCad:=Estado_Actual in F;
 end;

Function EsConsReal(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Const
    q0=0;
    F=[6];
   Type
    Q=0..6;
    Sigma=(Coma,Digito,Otro,Menos);
    TDelta=Array[Q,Sigma] of Q;
   Var
    Estado_Actual:Q;
    Delta:TDelta;
    caracter:char;
    nuevo_control:longint;
    lexema_aux:string;

    Function CarASimb (Car:char):Sigma;
    begin
       Case Car of
            ',':CarASimb:=Coma;
            '0'..'9':CarASimb:=Digito;
            '-':CarASimb:=Menos;
       else
         CarASimb:=Otro
       end;
    end;
begin
  lexema_aux:='';
  nuevo_control:=control;
  Delta[0,Coma]:=4;
  Delta[0,Digito]:=1;
  Delta[0,Menos]:=5;
  Delta[0,Otro]:=4;
  Delta[1,Coma]:=2;
  Delta[1,Digito]:=1;
  Delta[1,Menos]:=6;
  Delta[1,Otro]:=6;
  Delta[2,Coma]:=4;
  Delta[2,Digito]:=3;
  Delta[2,Menos]:=4;
  Delta[2,Otro]:=4;
  Delta[3,Coma]:=6;
  Delta[3,Digito]:=3;
  Delta[3,Menos]:=6;
  Delta[3,Otro]:=6;
  Delta[4,Coma]:=4;
  Delta[4,Digito]:=4;
  Delta[4,Menos]:=4;
  Delta[4,Otro]:=4;
  Delta[5,Coma]:=4;
  Delta[5,Digito]:=1;
  Delta[5,Menos]:=4;
  Delta[5,Otro]:=4;
  Delta[6,Coma]:=6;
  Delta[6,Digito]:=6;
  Delta[6,Menos]:=6;
  Delta[6,Otro]:=6;
  

  Estado_Actual:=q0;
  while not (Estado_Actual in [4,6])do
        begin
          Recuperar_arch(nuevo_control,caracter);
          Estado_Actual:=Delta[Estado_Actual,CarASimb(caracter)];
          if (Estado_Actual=1) or (Estado_Actual=2)  or (Estado_Actual=3) or (Estado_Actual=5)then
             begin
             lexema_aux:=lexema_aux+caracter;
             inc(nuevo_control);
             end;
          end;
  if (Estado_Actual in F) then
     begin
      control:=nuevo_control;
      lexema:=lexema_aux;
     end;
  EsConsReal:=Estado_Actual in F;
end;

Function EsOpRel(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Const
   q0=0;
   F=[5];
  Type
   Q=0..6;
   Sigma=(Mayor,Menor,Igual,Otro);
   TDelta=Array[Q,Sigma] of Q;
  Var
   Estado_Actual:Q;
   Delta:TDelta;
   caracter:char;
   nuevo_control:longint;
   lexema_aux:string;

   Function CarASimb (Car:char):Sigma;
   begin
      Case Car of
           '<':CarASimb:=Mayor;
           '>':CarASimb:=Menor;
           '=':CarASimb:=Igual;

      else
         CarASimb:=Otro
      end;
   end;
   
begin
 lexema_aux:='';
 nuevo_control:=control;
 Delta[0,Mayor]:=2;
 Delta[0,Menor]:=1;
 Delta[0,Igual]:=3;
 Delta[0,Otro]:=6;
 Delta[1,Mayor]:=4;
 Delta[1,Menor]:=5;
 Delta[1,Igual]:=4;
 Delta[1,Otro]:=5;
 Delta[2,Mayor]:=5;
 Delta[2,Menor]:=5;
 Delta[2,Igual]:=4;
 Delta[2,Otro]:=5;
 Delta[3,Mayor]:=5;
 Delta[3,Menor]:=5;
 Delta[3,Igual]:=5;
 Delta[3,Otro]:=5;
 Delta[4,Mayor]:=5;
 Delta[4,Menor]:=5;
 Delta[4,Igual]:=5;
 Delta[4,Otro]:=5;
 Delta[5,Mayor]:=5;
 Delta[5,Menor]:=5;
 Delta[5,Igual]:=5;
 Delta[5,Otro]:=5;
 Delta[6,Mayor]:=6;
 Delta[6,Menor]:=6;
 Delta[6,Igual]:=6;
 Delta[6,Otro]:=6;



 Estado_Actual:=q0;
 while not (Estado_Actual in [5,6])do
       begin
         Recuperar_arch(nuevo_control,caracter);
         Estado_Actual:=Delta[Estado_Actual,CarASimb(caracter)];
         if (Estado_Actual=1) or (Estado_Actual=2) or (Estado_Actual=3) or (Estado_Actual=4) then
            begin
            lexema_aux:=lexema_aux+caracter;
            inc(nuevo_control);
            end;
            end;
 if (Estado_Actual in F) then
    begin
      control:=nuevo_control;
      lexema:=lexema_aux;
     end;
 EsOpRel:=Estado_Actual in F;
end;

Function EsOpAsig(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
Const
   q0=0;
   F=[3];
  Type
   Q=0..4;
   Sigma=(Igual,otro);
   TDelta=Array[Q,Sigma] of Q;
  Var
   Estado_Actual:Q;
   Delta:TDelta;
   caracter:char;
   nuevo_control:longint;
   lexema_aux:string;

   Function CarASimb (Car:char):Sigma;
      begin
       if (Car='=') then
         CarASimb:=Igual
       else
         CarASimb:=Otro
       end;

begin
 lexema_aux:='';
 nuevo_control:=control;

 Delta[0,Igual]:=1;
 Delta[0,Otro]:=4;
 Delta[1,Igual]:=2;
 Delta[1,Otro]:=4;
 Delta[2,Igual]:=3;
 Delta[2,Otro]:=3;
 Delta[3,Igual]:=3;
 Delta[3,Otro]:=3;
 Delta[4,Igual]:=4;
 Delta[4,Otro]:=4;

 Estado_Actual:=q0;
 while not (Estado_Actual in [3,4])do
       begin
         Recuperar_arch(nuevo_control,caracter);
         Estado_Actual:=Delta[Estado_Actual,CarASimb(caracter)];
         if (Estado_Actual=1) or (Estado_Actual=2)  then
            begin
            lexema_aux:=lexema_aux+caracter;
            inc(nuevo_control);
            end;
         end;
 if (Estado_Actual in F) then
    begin
      control:=nuevo_control;
      lexema:=lexema_aux;
     end;
 EsOpAsig:=Estado_Actual in F;
end;

 Procedure PalabrasReservadas(var lexema,CompLex:string;var exito:boolean);
 var
   i:word;
   P_reservada:array[1..10] of string = ('programa','variables','cuerpo','fin','mientras','si','sino','leer','escribir','raiz');
 begin
   exito:=false;
   i:=1;
   while (i<=10) and (exito=false) do
   begin
     if (upcase(Lexema)) = (upcase(P_reservada[i])) then
     begin
          exito:= true;
          CompLex:=Lexema;
     end;
     inc(i);
   end;
 end;

 Function EsSimboloEsp(var Base:T_arch; var control:longint; var Lexema:string):Boolean;
  var
   caracter:char;
   begin
        Recuperar_arch(control,caracter);
        if (caracter=' ')or (caracter=#0) or (caracter=#1) or (caracter=#2) or (caracter=#3) or (caracter=#4) or (caracter=#5) or (caracter=#6) or (caracter=#7) or (caracter=#8) or (caracter=#9) or (caracter=#10) or (caracter=#11) or (caracter=#12) or (caracter=#13) or (caracter=#14)  or (caracter=#15) or (caracter=#16) or (caracter=#17) or (caracter=#18) or (caracter=#19) or (caracter=#20) or (caracter=#21) or (caracter=#22) or (caracter=#23) or (caracter=#24) or (caracter=#25) or (caracter=#26) or (caracter=#27) or (caracter=#28) or (caracter=#29) or (caracter=#30) or (caracter=#31) then
           begin
                inc(control);
                EsSimboloEsp:= true;
           end
           else   if caracter='$' then
                  begin
                       EsSimboloEsp:=true;
                       Lexema:='$';
                  end;
   end;
 Procedure EsCaracter(var Base:T_arch; var control:longint; var Lexema:string; var tabla_s:T_lista;var CompLex:string;var exito:boolean);
  var
    caracter:char;
 Procedure caracterEsp(car:char; var Lexema:string;var tabla_s:T_lista; var CompLex:string; var control:longint);
 begin
  CompLex:=car;
  Lexema:=car;
  agregar_en_tabla_s(Lexema,tabla_s,CompLex);
   inc(control);
 end;
    begin
     Recuperar_arch(control,caracter);
     Case caracter of
                '+':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                '-':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                '*':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                '/':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                '^':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                '(':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                ')':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                '{':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                '}':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                '[':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                ']':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                ';':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                ',':caracterEsp(caracter,lexema,tabla_s,compLex,control);
                ':':caracterEsp(caracter,lexema,tabla_s,compLex,control);
    else
              clrscr;
              writeln('Error');
              exito:=true;
    end;
  end;

Procedure ObtenerSigCompLex(var Base:T_arch; var Control:longint; var CompLex:string; var Lexema:string; var tabla_s:T_lista; var exito:boolean);
var
 bien:boolean;
  begin
          If EsID (Base,control,Lexema) then
             begin
                  PalabrasReservadas(Lexema,CompLex,bien);
                  If not bien then
                     begin
                          CompLex:= 'id';
                          Agregar_en_tabla_s(Lexema,tabla_s,CompLex);

                     end
                     else
                     begin
                         if lexema='fin' then
                         begin
                         exito:=true;
                         end;
                         Agregar_en_tabla_s(Lexema,tabla_s,CompLex);
                     end;
             end
          else if EsConsReal(Base,Control,Lexema) then
                     begin
                          CompLex:= 'ConstReal';
                          Agregar_en_tabla_s(Lexema,tabla_s,CompLex);
                     end
           else if EsOpAsig(Base,Control,Lexema) then
                     begin
                          CompLex:= 'OpAsig';
                          Agregar_en_tabla_s(Lexema,tabla_s,CompLex);
                     end
           else if EsOprel(Base,Control,Lexema) then
                     begin
                          CompLex:= 'OpRel';
                          Agregar_en_tabla_s(Lexema,tabla_s,CompLex);
                     end
           else if EsCad(Base,Control,Lexema) then
           begin
                CompLex:= 'Cad';
                Agregar_en_tabla_s(Lexema,tabla_s,CompLex);
           end
           else if EsSimboloEsp(Base,Control,Lexema) then
           begin
                CompLex:= 'SimboloEsp';
                Agregar_en_tabla_s(Lexema,tabla_s,CompLex);
                end
           else
           Escaracter(base,control,lexema,tabla_s,CompLex,exito);
  end;


Procedure AnalizadorLexico(var arch:t_arch;var control:longint;var complex,lexema:string;var tabla_s:t_lista;var exito:boolean;var caracter:char);
begin
  caracter:=' ';
  exito:=false;
  while not exito do
        begin
          ObtenerSigCompLex(arch,control,complex,lexema,tabla_s,exito);
          recuperar_arch(control,caracter);
        end;

end;


end.
