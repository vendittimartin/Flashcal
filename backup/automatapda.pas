unit AutomataPDA;

interface

uses
  crt, Pila, Tabla, TAS, tabla_simb;

procedure Algoritmo_reconocimiento(var P:T_pila;L:T_lista;TAS:T_matriz);
procedure reconocimiento(var exito,error:boolean;var L:T_lista; var P:T_pila;var X:string; TAS: T_matriz);

implementation

procedure Algoritmo_reconocimiento(var P:T_pila;L:T_lista;TAS:T_matriz);
var
  i:integer;
  X:string;
  exito,error:boolean;
  Variables:array[1..32] of string=('Program','Variable','Var','K','Body','Listsent','Sent','Asignacion','Cad','L','Lectura','Escritura','If','While','Exparit','X','D','A','Y','E','B','Z','F','C','Cond','G','H','Q','V','I','R','S');
  Terminales:array[1..33] of string=('programa','id',';','variables',',','fin','leer','(',')','escribir','si','{','}','sino','mientras','oprel','opasig','+','-','*','/','^','and','no','or','cuerpo','cadena',':','constreal','raiz','[',']','$');
begin
  i:=1;
  exito:=false;
  error:=false;
  X:=Variables[1];
  Apilar(P,'$');
  Apilar(P,X);
  Primero(L);
  while (exito=false) and (error=false) do
   begin
     Reconocimiento(exito,error,L,P,X,TAS);
     writeln('flashazo ',i);
     inc(i);
     //readkey;
   end;
  readkey;
end;

procedure reconocimiento(var exito,error:boolean;var L:T_lista;var P:T_pila;var X:string; TAS: T_matriz);
var
  a:T_dato;
  i,j:integer;
begin
 Desapilar(P,X);
 if Esterminal(X)=true then
 begin
    recuperar_lista(L,a);
    while a.complex='SimboloEsp' do
    begin
      Siguiente(L);
      Recuperar_lista(L,a);
    end;
    if X=a.complex then
    begin
       if X='$' then
       begin
          writeln('Exito');
          exito:=true;
       end
       else
       begin
         Siguiente(L);
       end;
    end
    else
    begin
      writeln('Error terminal');
      error:=true;
      readkey;
    end;
 end
 else
   begin
   recuperar_lista(L,a);
   while a.complex='SimboloEsp' do
    begin
      Siguiente(L);
      Recuperar_lista(L,a);
    end;
   posTAS(X,a.CompLex,i,j);
   if TAS[i,j]='' then
   begin
      writeln('error vacio');
      error:=true;
      readkey;
   end
   else
   if TAS[i,j]<>'eps_ ' then
   begin
      apilar_Variable(P,TAS,X,a.CompLex);
     //agregarHijos();
   end;
   end;
 end;






//Programa hola;
// variables a;
// cuerpo
// a==4;
// fin;                                                                                                                                                                               C         constreal
//         programa                                                                                                                  id                                      B        Z         Z         Z
//         id        id                                                                                                              opasig    opasig              A         Y        Y         Y         Y          Y
//         ;         ;         ;                    variables         id                                        Asignacion  Exparit  Exparit   Exparit   X         X         X        X         X         X          X         X
//         variable  variable  variable  variable   var         var   K     K                cuerpo             ;        ;           ;         ;         ;         ;         ;        ;         ;         ;          ;         ;         ;
//         ;         ;         ;         ;          ;           ;     ;     ;     ;          listsent listsent  Listsent Listsent    Listsent  Listsent  Listsent  Listsent  Listsent Listsent  Listsent  Listsent   Listsent  Listsent  Listsent  Listsent
//         body      body      body      body       body        body  body  body  body  body fin      fin       fin      fin         fin       fin       fin       fin       fin      fin       fin       fin        fin       fin       fin       fin       fin
//Program  ;         ;         ;         ;          ;           ;     ;     ;     ;     ;    ;        ;         ;        ;           ;         ;         ;         ;         ;        ;         ;         ;          ;         ;         ;         ;         ;         ;
//$        $         $         $         $          $           $     $     $     $     $    $        $         $        $           $         $         $         $         $        $         $         $          $         $         $         $         $         $    $

end.

