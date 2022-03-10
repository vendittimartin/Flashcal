unit Archivos;
{$codepage UTF-8}

interface

uses
  crt,Sysutils,tipos;
const
ruta='IDE.txt';

procedure Crear(var arch:t_arch);
procedure Abrir(var arch:t_arch);
procedure Cerrar(var arch:t_arch);
procedure Recuperar_arch(var control:longint; var caracter:char);

implementation

procedure Crear(var arch:t_arch);
begin
 assign(arch,ruta);
 rewrite(arch);
end;

procedure Abrir (var arch:t_arch);
begin
 AssignFile(arch,ruta);
 if not FileExists(ruta)then
 begin
   Rewrite(arch);
   CloseFile(arch);
 end;
  reset(arch);
end;

procedure Cerrar(var arch:t_arch);
begin
 close(arch);
end;

procedure Recuperar_arch(var control:longint; var caracter:char);
var
  arch:T_arch;
begin
Abrir(arch);
seek(arch,control);
read(arch,caracter);
Closefile(arch);
end;



end.
