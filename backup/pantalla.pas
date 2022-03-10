unit Pantalla;
{$codepage UTF-8}

interface

uses
  crt, SysUtils;
procedure Mostrar (Lexema,CompLex:string);
implementation

procedure Mostrar (Lexema,CompLex:string);
   begin
    writeln('Lexema: ',Lexema);
    writeln('Componente léxico: ',CompLex);
   end;

end.

