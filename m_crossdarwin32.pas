unit m_crossdarwin32;

{ Cross compiles from Darwin x86_64 code to Darwin x86/32 bit
}


{$mode objfpc}{$H+}

interface

uses
<<<<<<< HEAD
  Classes, SysUtils, m_crossinstaller, fpcuputil;

implementation
const
  ErrorNotFound='An error occurred getting cross compiling binutils/libraries.'+LineEnding+
    'todo: specify what exactly is missing';
=======
  Classes, SysUtils, m_crossinstaller;

implementation
>>>>>>> upstream/master

type

{ TDarwin32 }

TDarwin32 = class(TCrossInstaller)
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

{ TDarwin32 }

function TDarwin32.GetLibs(Basepath:string): boolean;
begin
<<<<<<< HEAD
  FLibsPath:='';
  result:=true;
  if (result=false) and (FAlreadyWarned=false) then
  begin
    infoln(ErrorNotFound,etError);
    FAlreadyWarned:=true;
  end;
end;

{$ifndef FPCONLY}
function TDarwin32.GetLibsLCL(LCL_Platform: string; Basepath: string): boolean;
begin
  result:=true;
end;
{$endif}

function TDarwin32.GetBinUtils(Basepath:string): boolean;
begin
  inherited;
  FBinUtilsPath:='';
  FBinUtilsPrefix:=''; // we have the "native" names, no prefix
  result:=true;
  if (result=false) and (FAlreadyWarned=false) then
  begin
    infoln(ErrorNotFound,etError);
    FAlreadyWarned:=true;
  end;
=======
  result:=FLibsFound;
  if result then exit;
  FLibsPath:='';
  result:=true;
  FLibsFound:=true;
end;

function TDarwin32.GetBinUtils(Basepath:string): boolean;
begin
  result:=inherited;
  if result then exit;
  FBinUtilsPath:='';
  FBinUtilsPrefix:=''; // we have the "native" names, no prefix
  result:=true;
  FBinsFound:=true;
>>>>>>> upstream/master
end;

constructor TDarwin32.Create;
begin
  inherited Create;
<<<<<<< HEAD
  FCrossModuleName:='Darwin32';
=======
  FCrossModuleNamePrefix:='TDarwin64';
>>>>>>> upstream/master
  FTargetCPU:='i386';
  FTargetOS:='darwin';
  FAlreadyWarned:=false;
  FFPCCFGSnippet:=''; //no need to change fpc.cfg
<<<<<<< HEAD
  infoln('TDarwin32 crosscompiler loading',etDebug);
=======
  ShowInfo;
>>>>>>> upstream/master
end;

destructor TDarwin32.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF Darwin}
{$IFDEF CPUX86_64}

var
  Darwin32:TDarwin32;

initialization
  Darwin32:=TDarwin32.Create;
  RegisterExtension(Darwin32.TargetCPU+'-'+Darwin32.TargetOS,Darwin32);
finalization
  Darwin32.Destroy;
{$ENDIF}
{$ENDIF}
end.

