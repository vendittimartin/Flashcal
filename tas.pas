unit TAS;
{$codepage UTF-8}

interface

uses
  crt,Pila,SysUtils,tipos,arboles,Listas;

var
  Variables:array[1..31] of string=('Program','Variable','Var','K','Body','Listsent','Sent','Asignacion','Cad','L','Lectura','Escritura','If','While','Exparit','X','D','A','Y','E','B','Z','F','C','Cond','G','H','Q','V','I','R');
  Terminales:array[1..33] of string=('programa','id',';','variables',',','fin','leer','(',')','escribir','si','{','}','sino','mientras','oprel','opasig','+','-','*','/','^','and','no','or','cuerpo','cadena',':','constreal','raiz','[',']','$');

type
  T_matriz=array [1..31,1..33] of string;

procedure Cargar_TAS(var TAS:T_matriz);
Function EsTerminal(X:string):boolean;
Procedure apilar_Variable(var P:t_pila;TAS:t_matriz;a:t_dato;var X:t_dato_pila);
Procedure posTAS(X,a:string;var i,j:integer);

implementation

procedure Cargar_TAS(var TAS:T_matriz);
begin
TAS[1,1]:='programa_id_;_Variable_;_Body_;_ ';
TAS[2,4]:='variables_Var_ ';
TAS[3,2]:='id_K_ ';
TAS[3,3]:='eps_ ';
TAS[4,3]:='eps_ ';
TAS[4,5]:=',_id_K_ ';
TAS[5,26]:='cuerpo_ListSent_fin_ ';
TAS[6,2]:='Sent_;_ListSent_ ';
TAS[6,6]:='eps_ ';
TAS[6,7]:='Sent_;_ListSent_ ';
TAS[6,10]:='Sent_;_ListSent_ ';
TAS[6,11]:='Sent_;_ListSent_ ';
TAS[6,13]:='eps_ ';
TAS[6,15]:='Sent_;_ListSent_ ';
TAS[6,27]:='Sent_;_ListSent_ ';
TAS[7,2]:='Asignacion_ ';
TAS[7,11]:='If_ ';
TAS[7,15]:='While_ ';
TAS[7,27]:='Cad_ ';
TAS[8,2]:='id_opasig_Exparit_ ';
TAS[9,27]:='cadena_:_L_ ';
TAS[10,7]:='Lectura_ ';
TAS[10,10]:='Escritura_ ';
TAS[11,7]:='leer_(_id_)_ ';
TAS[12,10]:= 'escribir_(_Exparit_)_ ';
TAS[13,11]:= 'si_Cond_{_Listsent_}_sino_{_Listsent_}_ ';
TAS[14,15]:= 'mientras_Cond_{_Listsent_}_ ';
TAS[15,2]:='A_X_ ';
TAS[15,8]:='A_X_ ';
TAS[15,19]:='A_X_ ';
TAS[15,29]:='A_X_ ';
TAS[15,30]:='A_X_ ';
TAS[16,3]:='eps_ ';
TAS[16,8]:='eps_ ';
TAS[16,9]:='eps_ ';
TAS[16,12]:='eps_ ';
TAS[16,13]:='eps_ ';
TAS[16,16]:='eps_ ';
TAS[16,18]:='D_X_ ';
TAS[16,19]:='D_X_ ';
TAS[16,23]:='eps_ ';
TAS[16,25]:='eps_ ';
TAS[16,32]:='eps_ ';
TAS[17,18]:='+_A_ ';
TAS[17,19]:='-_A_ ';
TAS[18,2]:='B_Y_ ';
TAS[18,8]:='B_Y_ ';
TAS[18,19]:='B_Y_ ';
TAS[18,29]:='B_Y_ ';
TAS[18,30]:='B_Y_ ';
TAS[19,3]:='eps_ ';
TAS[19,8]:='eps_ ';
TAS[19,9]:='eps_ ';
TAS[19,12]:='eps_ ';
TAS[19,13]:='eps_ ';
TAS[19,16]:='eps_ ';
TAS[19,18]:='eps_ ';
TAS[19,19]:='eps_ ';
TAS[19,20]:='E_Y_ ';
TAS[19,21]:='E_Y_ ';
TAS[19,23]:='eps_ ';
TAS[19,25]:='eps_ ';
TAS[19,32]:='eps_ ';
TAS[20,20]:='*_B_ ';
TAS[20,21]:='/_B_ ';
TAS[21,2]:='C_Z_ ';
TAS[21,8]:='C_Z_ ';
TAS[21,19]:='C_Z_ ';
TAS[21,29]:='C_Z_ ';
TAS[21,30]:='C_Z_ ';
TAS[22,3]:='eps_ ';
TAS[22,8]:='eps_ ';
TAS[22,9]:='eps_ ';
TAS[22,12]:='eps_ ';
TAS[22,13]:='eps_ ';
TAS[22,16]:='eps_ ';
TAS[22,18]:='eps_ ';
TAS[22,19]:='eps_ ';
TAS[22,20]:='eps_ ';
TAS[22,21]:='eps_ ';
TAS[22,22]:='F_Z_ ';
TAS[22,23]:='eps_ ';
TAS[22,25]:='eps_ ';
TAS[22,32]:='eps_ ';
TAS[23,22]:='^_C_ ';
TAS[24,2]:='id_ ';
TAS[24,8]:='(_Exparit_)_ ';
TAS[24,19]:='-_C_ ';
TAS[24,29]:='constreal_ ';
TAS[24,30]:='raiz_(_Exparit_)_ ';
TAS[25,2]:='Q_G_ ';
TAS[25,8]:='Q_G_ ';
TAS[25,19]:='Q_G_ ';
TAS[25,22]:='Q_G_ ';
TAS[25,24]:='Q_G_ ';
TAS[25,29]:='Q_G_ ';
TAS[25,30]:='Q_G_ ';
TAS[25,31]:='Q_G_ ';
TAS[26,12]:='eps_ ';
TAS[26,25]:='H_G_ ';
TAS[26,32]:='eps_ ';
TAS[27,25]:='or_Q_ ';
TAS[28,2]:='V_I_ ';
TAS[28,8]:='V_I_ ';
TAS[28,19]:='V_I_ ';
TAS[28,22]:='V_I_ ';
TAS[28,24]:='V_I_ ';
TAS[28,29]:='V_I_ ';
TAS[28,30]:='V_I_ ';
TAS[28,31]:='V_I_ ';
TAS[29,2]:='R_ ';
TAS[29,8]:='R_ ';
TAS[29,19]:='R_ ';
TAS[29,22]:='R_ ';
TAS[29,24]:='no_R_ ';
TAS[29,29]:='R_ ';
TAS[29,30]:='R_ ';
TAS[29,31]:='R_ ';
TAS[30,12]:='eps_ ';
TAS[30,23]:='and_V_ ';
TAS[30,25]:='eps_ ';
TAS[30,32]:='eps_ ';
TAS[31,2]:='Exparit_oprel_Exparit_ ';
TAS[31,8]:='Exparit_oprel_Exparit_ ';
TAS[31,19]:='Exparit_oprel_Exparit_ ';
TAS[31,22]:='Exparit_oprel_Exparit_ ';
TAS[31,29]:='Exparit_oprel_Exparit_ ';
TAS[31,30]:='Exparit_oprel_Exparit_ ';
TAS[31,31]:='[_cond_]_ ';
end;

Function EsTerminal(X:string):boolean;
var
  bien:boolean;
  i:integer;
  Terminales:array[1..33] of string=('programa','id',';','variables',',','fin','leer','(',')','escribir','si','{','}','sino','mientras','oprel','opasig','+','-','*','/','^','and','no','or','cuerpo','cadena',':','constreal','raiz','[',']','$');
begin
  i:=1;
  bien:=false;
  while (i<=33) and (bien=false) do
  begin
     if (upcase(X)=upcase(Terminales[i])) then
     begin
        bien:=true;
     end
        else
     begin
        inc(i);
     end;
  end;
  EsTerminal:=bien;
end;

Procedure apilar_Variable(var P:t_pila;TAS:t_matriz;a:t_dato;var X:t_dato_pila);
var
  Q:t_pila;
  B:TstringArray;
  i,k,l:integer;
  hijo,Y:t_arbol;
  m:string;
begin
  Y:=X.arbol;
  m:='';
  i:=0;
  posTAS(X.simb,a.complex,k,l);
  B:=TAS[k,l].Split('_');
  while B[i]<>' ' do
  begin
    X.simb:=B[i];
    if EsTerminal(X.simb) then
    m:=a.lexema
    else
    m:='';
    Agregar_arbol(hijo,X.simb,m);
    Agregar_hijo(Y,hijo);
    inc(i);
    X.arbol:=hijo;
    Apilar(Q,X);
  end;
  while not pila_vacia(Q) do
  begin
    desapilar(Q,X);
    apilar(P,X);
  end;
end;

Procedure posTAS(X,a:string;var i,j:integer);
var
  Variables:array[1..31] of string=('Program','Variable','Var','K','Body','Listsent','Sent','Asignacion','Cad','L','Lectura','Escritura','If','While','Exparit','X','D','A','Y','E','B','Z','F','C','Cond','G','H','Q','V','I','R');
  Terminales:array[1..33] of string=('programa','id',';','variables',',','fin','leer','(',')','escribir','si','{','}','sino','mientras','oprel','opasig','+','-','*','/','^','and','no','or','cuerpo','cadena',':','constreal','raiz','[',']','$');
begin
  i:=1;
  j:=1;
  while upcase(X)<>upcase(Variables[i]) do
  begin
    inc(i);
  end;
  while upcase(a)<>upcase(Terminales[j]) do
  begin
    inc(j);
  end;
end;

end.




