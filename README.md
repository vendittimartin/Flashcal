# Flashcal 🚀
Final project of syntax and semantics of languages. Development of a new programming language.

# Manual de uso 📖
https://drive.google.com/file/d/1-At6EtAK8By7vXH4KvlH_IH8-01d0r3O/view?usp=sharing

# Tabla de analizador sintáctico ⚙️
https://docs.google.com/spreadsheets/d/1M_WKtZ9H_bf8yUl9GdjUOgki-3VBqD3J/edit?usp=sharing&ouid=112285760863009081068&rtpof=true&sd=true

# Autómatas ⚙️
https://drive.google.com/drive/folders/1e2Myju0pC_Azjvomz43p5peAFZgzxQjQ?usp=sharing

# Gramática Independiente del Contexto inicial ⚙️
Program →  Programa id ;   Variable ;   Body ;
Variable → variables var 
Var → idK | ɛ
K → , idK | ɛ
Body → cuerpo listsent fin
listsent→ listsent Sent ; | ɛ
Sent → Asignación | Lectura |Escritura I If I While
Asignación → id opasig exparit
Lectura → cadena: Leer (id)
Escritura → cadena: Escribir (exparit)
If → si cond { listsent } sino { listsent }   
While → mientras cond { listsent } 
exparit →  constreal | id | exparit + exparit | exparit - exparit | exparit * exparit | exparit / exparit | exparit ^ exparit | ( exparit ) | raiz (exparit) | - exparit
cond → exparit oprel exparit I cond oplog cond | no cond | [cond]
oplog → or I and

# Gramática Independiente del Contexto LL(1) ⚙️
Program →  programa id ;   Variable ;   Body ;
Variable → variables Var
Var → idK | ɛ
K → , idK | ɛ 
Body → cuerpo Listsent fin
Listsent → Sent; Listsent  | ɛ
Sent → Asignación | Cad I If I While
Asignación → id opasig Exparit
Cad → cadena: L
L → Lectura | Escritura
Lectura → leer (id) 
Escritura → escribir (exparit)
If → si Cond { Listsent } sino { Listsent }   
While → mientras Cond { Listsent }
Exparit → AX
X → DX | ɛ
D → + A |  - A
A → BY
Y → EY | ɛ
E → * B |  / B
B → CZ		
Z → FZ | ɛ
F → ^ C 
C → ( Exparit ) | raíz ( Exparit ) | id | constreal | -C
Cond → QG
G → HG | ɛ
H → or Q
Q → VI
V →  no R | R
I → and V | ɛ
R → Exparit oprel Exparit | [Cond]

# Gramática Independiente del Contexto en la forma Backus-Naur ⚙️
<Program>::= “programa” “id” ” ;”   <Variable> “;”  < Body>”;”
<Variable> ::= “variables” <Var>
<Var> ::= “id”<K> | ɛ
<K> ::= “,” “id”<K> | ɛ 
<Body> ::= “cuerpo” <Listsent> “fin”
<Listsent> ::= <Sent>”;” <Listsent>  | ɛ
<Sent> ::= <Asignación> | <Cad> I <If> I <While>
<Asignación> ::= “id” “opasig” <Exparit>
<Cad> ::= “cadena””:” <L>
<L> ::= <Lectura> | <Escritura>
<Lectura> ::= “leer” “(“”id””)” 
<Escritura> ::= “escribir” “(“<Exparit>”)”
<If> ::= “si” <Cond> “{“ <Listsent> “}” “sino” “{“ <Listsent> “}”   
<While> ::= “mientras” <Cond> “{“ <Listsent> “}”
<Exparit> ::= <A><X>
<X> ::= <D><X> | ɛ
<D> ::= “+”<A> | “-”<A>
<A> ::= <B><Y>
<Y> ::= <E><Y> | ɛ
<E> ::= “*”<B> |  “/”<B>
<B> ::= <C><Z>		
<Z> ::= <F><Z> | ɛ
<F> ::= “^”<C> 
<C> ::= “(“ <Exparit> “)” | “raíz” “(“ <Exparit> “)” | “id” | “constrea”l | “-”<C>
<Cond> ::= <Q><G>
<G> ::= <H><G> | ɛ
<H> ::= “or” <Q>
<Q> ::= <V><I>
<V> ::=  “no” <R> | <R>
<I> ::= “and” <V> | ɛ
<R> ::= <Exparit> “oprel” <Exparit> | “[“<Cond>”]”

**# Semántica de nuestro lenguaje** ⚙️
Program -> programa id ;   Variable ;   Body ;
EvaluarPrograma(Arbol, Estado)
EstadoAgregarVariable(Estado, Arbol.Hijos(2).Lexema) 
		EvaluarVariable(Arbol.Hijos(4), Estado)    
		EvaluarBody(Arbol.Hijos(6), Estado)	

Variable → variables Var
  EvaluarVariable(Arbol, Estado)
	EvaluarVar(Arbol.Hijos(2), Estado)	


Var → idK | ɛ
	EvaluarVar(Arbol, Estado)
		If not produccion=epsilon
			EstadoAgregarVariable(Estado, Arbol.Hijos(1).Lexema)   
			EvaluarK(Arbol.Hijos(2), Estado)

K → , idK | ɛ 
	EvaluarK(Arbol, Estado)
		If not produccion=epsilon
			EstadoAgregarVariable(Estado, Arbol.Hijos(2).Lexema)   
			EvaluarK(Arbol.Hijos(3), Estado)

Body → cuerpo Listsent fin
EvaluarBody(Arbol, Estado)
	EvaluarListsent(Arbol.Hijos(2), Estado)

Listsent → Sent; Listsent  | ɛ
  EvaluarListsent(Arbol,Estado)
	If not produccion=epsilon
		EvaluarSent(Arbol.Hijos(1),Estado)
		EvaluarListsent(Arbol.Hijos(3),Estado)

Sent → Asignación | Cad I If I While
  EvaluarSent(Arbol, Estado)
  	If produccion = Asignación 
		EvaluarAsignación(Arbol.Hijos(1), Estado)
  	If produccion = Cad
EvaluarCad(Arbol.Hijos(1), Estado)
  	If produccion = If
EvaluarIf(Arbol.Hijos(1), Estado)
  	If produccion = While
Evaluarwhile(Arbol.Hijos(1), Estado)

Asignación → id opasig Exparit
EvaluarAsignacion(Arbol, Estado)
EvaluarExparit(Arbol.Hijos(3), Estado, Resultado)
EstadoAsignarValor(Estado, Arbol.Hijos(1).Lexema, Resultado) 

Cad → cadena: L
  EvaluarCad(Arbol, Estado)
	Write(Arbol.Hijos(1).Lexema)
EvaluarL(Arbol.Hijos(3), Estado)

L → Lectura | Escritura
  EvaluarL(Arbol, Estado)
  	If producción = Lectura
		EvaluarLectura(Arbol.Hijos(1), Estado) 
  	If producción = Escritura
		EvaluarEscritura(Arbol.Hijos(1), Estado)
	
Lectura → leer (id) 
EvaluarLectura(Arbol, Estado)
	Readln(X)
	EstadoAsignarValor(Estado, Arbol.Hijos(3).Lexema, Resultado)

Escritura → escribir (exparit)
EvaluarEscritura (Arbol, Estado)
	Write(Arbol.Hijos(3).Lexema)

If→ si Cond { Listsent } sino { Listsent }   
EvaluarIf(Arbol,Estado)
	EvaluarCond(arbol.Hijos(2),Estado, Resultado)
If Resultado then
		EvaluarListsent(arbol.Hijos(4),Estado)
	Else
		EvaluarListsent(arbol.Hijos(8),Estado)
	
While → mientras Cond { Listsent }
EvaluarIWhile(Arbol,Estado)
	EvaluarCond(Arbol.Hijos(2), Estado, Resultado)
	While Resultado do
		EvaluarListsent(Arbol.Hijos(4), Estado)
		EvaluarCond(Arbol.Hijos(2), Estado, Resultado)

Exparit → AX
EvaluarExparit(Arbol, Estado,Resultado)
	EvaluarA (Arbol.Hijos(1), Estado,Resultado)
EvaluarX (Arbol.Hijos(2), Estado,Resultado)

X → DX | ɛ
  EvaluarX (Arbol, Estado,Resultado)
  	If not  produccion = eps
 		EvaluarD (Arbol.Hijos(1), Estado,Resultado)
		EvaluarX (Arbol.Hijos(2), Estado,Resultado)
	
D → + A |  - A
EvaluarD (Arbol, Estado,Resultado)
	If produccion = +A
		EvaluarA (Arbol.Hijos(2), Estado,ResultadoS)
		Resultado:= Resultado + ResultadoS
If produccion = -A
		EvaluarA (Arbol.Hijos(2), Estado,ResultadoR)
Resultado:= Resultado + ResultadoR

A → BY
EvaluarA (Arbol, Estado,Resultado)
	EvaluarB (Arbol.Hijos(1), Estado,Resultado)
EvaluarY (Arbol.Hijos(2), Estado,Resultado)


Y → EY | ɛ
EvaluarY (Arbol, Estado,Resultado)
	If not produccion = eps
		EvaluarE (Arbol.Hijos(1), Estado,Resultado)
EvaluarY (Arbol.Hijos(2), Estado,Resultado)

E → * B |  / B
EvaluarE (Arbol, Estado,Resultado)
	If produccion =  *B 
		EvaluarB (Arbol.Hijos(2), Estado,ResultadoB)
Resultado:=Resultado*ResultadoB
	If produccion =  /B 
		EvaluarB (Arbol.Hijos(2),Estado,ResultadoB)
Resultado:=Resultado/ResultadoB

B → CZ	
EvaluarB(Arbol,Estado,Resultado)
	EvaluarC(Arbol.Hijos(1), Estado,Resultado)
	EvaluarZ(Arbol.Hijos(2), Estado,Resultado)
	
Z → FZ | ɛ
EvaluarZ (Arbol, Estado,Resultado)
	If not produccion =  eps
		EvaluarF (Arbol.Hijos(1), Estado,Resultado)
		EvaluarZ (Arbol.Hijos(2), Estado,Resultado)

F → ^ C 
EvaluarF (Arbol, Estado,Resultado)

	EvaluarC(Arbol.Hijos(2),Estado,Resultado)

C → ( Exparit ) | raíz ( Exparit ) | id | constreal | -C
EvaluarC (Arbol, Estado,Resultado)
If produccion =  ( Exparit ) 
			EvaluarExparit (Arbol.Hijos(2), Estado,Resultado)
	If produccion = raíz ( Exparit ) 

			EvaluarExparit (Arbol.Hijos(3), Estado,Resultado)
If produccion = id 
		EstadoAsignarValor(Estado, Arbol.Hijos(1).Lexema, Resultado)
If produccion = constreal
		EstadoAsignarValor(Estado, Arbol.Hijos(1).Lexema, Resultado)
If produccion =  -C 
		EvaluarC (Arbol.Hijos(2), Estado,ResultadoC)
Resultado= -1 * ResultadoC

Cond → QG
EvaluarCond (Arbol, Estado)
	EvaluarQ(Arbol.Hijos(1),Estado,ResultadoQ)
	EvaluarG(Arbol.Hijos(2),Estado,ResultadoG)
	If G<>eps then
		Resultado:=ResultadoQ or ResultadoG
 
G → HG | ɛ
EvaluarG (Arbol, Estado)
	If not produccion = eps
		EvaluarH(Arbol.Hijos(1),Estado)
		EvaluarG(Arbol.Hijos(2),Estado)

H → or Q
EvaluarH (Arbol, Estado)
	EvaluarQ(Arbol.Hijos(2),Estado)

Q → VI
EvaluarQ (Arbol, Estado,ResultadoQ)
	EvaluarV(Arbol.Hijos(1),Estado,ResultadoB)
EvaluarI(Arbol.Hijos(2),Estado,ResultadoV)
If I<>eps then 
Resultado:=ResultadoB and ResultadoV

V →  no R | R
EvaluarV (Arbol, Estado,Resultado)
	If produccion = no R
		EvaluarR(Arbol.Hijos(2),Estado,ResultadoB)
		Resultado:= not(ResultadoB)
	If produccion = R
		EvaluarR (Arbol.Hijos(1),Estado,ResultadoB)

I → and V | ɛ
EvaluarI (Arbol, Estado,Resultado)
	If not produccion = eps
		EvaluarV(Arbol.Hijos(2),Estado,ResultadoV)

R → Exparit oprel Exparit | [Cond]
EvaluarR (Arbol, Estado,ResultadoB)
If produccion =  Exparit oprel Exparit
			EvaluarExparit (Arbol.Hijos(1), Estado,ResultadoA)
			EvaluarExparit (Arbol.Hijos(3), Estado,ResultadoB)
			ResultadoB:=ResultadoA oprel ResultadoB
If produccion = [Cond]
		EvaluarExparit (Arbol.Hijos(2), Estado)
