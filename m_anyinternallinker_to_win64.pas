unit m_anyinternallinker_to_win64;

{ Cross compiles from Linux, FreeBSD,... to Windows x86_64 code (win64)
Requirements: FPC should have an internal linker
}


{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, m_crossinstaller;

implementation

const
  ARCH='x86_64';
  OS='win64';

type

{ Tanyinternallinker_win64 }

Tanyinternallinker_win64 = class(TCrossInstaller)
private
  FAlreadyWarned: boolean; //did we warn user about errors and fixes already?
public
  function GetLibs(Basepath:string):boolean;override;
<<<<<<< HEAD
  {$ifndef FPCONLY}
  function GetLibsLCL(LCL_Platform:string; Basepath:string):boolean;override;
  {$endif}
=======
>>>>>>> upstream/master
  function GetBinUtils(Basepath:string):boolean;override;
  constructor Create;
  destructor Destroy; override;
end;

{ TWin32 }

function Tanyinternallinker_win64.GetLibs(Basepath:string): boolean;
begin
  result:=FLibsFound;
  if result then exit;
  FLibsPath:='';
  result:=true;
<<<<<<< HEAD
  if (result=false) and (FAlreadyWarned=false) then
  begin
    infoln(ErrorNotFound,etError);
    FAlreadyWarned:=true;
  end;
end;

{$ifndef FPCONLY}
function Tanyinternallinker_win64.GetLibsLCL(LCL_Platform: string; Basepath: string): boolean;
begin
  result:=true;
=======
  FLibsFound:=true;
>>>>>>> upstream/master
end;
{$endif}

function Tanyinternallinker_win64.GetBinUtils(Basepath:string): boolean;
begin
  result:=inherited;
  if result then exit;
  FBinUtilsPath:='';
  FBinUtilsPrefix:=''; // we have the "native" names, no prefix
  result:=true;
  FBinsFound:=true;
end;

constructor Tanyinternallinker_win64.Create;
begin
  inherited Create;
<<<<<<< HEAD
  FCrossModuleName:='anyinternallinker_win64';
  FTargetCPU:='x86_64';
  FTargetOS:='win64';
=======
  FTargetCPU:=ARCH;
  FTargetOS:=OS;
  FCrossModuleNamePrefix:='TAnyinternallinker';
>>>>>>> upstream/master
  FAlreadyWarned:=false;
  FFPCCFGSnippet:=''; //no need to change fpc.cfg
  ShowInfo;
end;

destructor Tanyinternallinker_win64.Destroy;
begin
  inherited Destroy;
end;


var
  Anyinternallinker_win64:Tanyinternallinker_win64;

initialization
  Anyinternallinker_win64:=Tanyinternallinker_win64.Create;
  RegisterExtension(Anyinternallinker_win64.TargetCPU+'-'+Anyinternallinker_win64.TargetOS,Anyinternallinker_win64);
finalization
  Anyinternallinker_win64.Destroy;
end.

