unit m_crossdarwin64;

{  Cross compiles from Darwin x86/32 bit to Darwin x86_64 code
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

{ TDarwin64 }

TDarwin64 = class(TCrossInstaller)
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

function TDarwin64.GetLibs(Basepath:string): boolean;
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
function TDarwin64.GetLibsLCL(LCL_Platform: string; Basepath: string): boolean;
begin
  result:=true;
end;
{$endif}

function TDarwin64.GetBinUtils(Basepath:string): boolean;
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

function TDarwin64.GetBinUtils(Basepath:string): boolean;
begin
  result:=inherited;
  if result then exit;
  FBinUtilsPath:='';
  FBinUtilsPrefix:=''; // we have the "native" names, no prefix
  result:=true;
  FBinsFound:=true;
>>>>>>> upstream/master
end;

constructor TDarwin64.Create;
begin
  inherited Create;
<<<<<<< HEAD
  FCrossModuleName:='darwin64';
=======
  FCrossModuleNamePrefix:='TDarwin32';
>>>>>>> upstream/master
  FTargetCPU:='x86_64';
  FTargetOS:='darwin';
  FAlreadyWarned:=false;
  FFPCCFGSnippet:=''; //no need to change fpc.cfg
<<<<<<< HEAD
  infoln('TDarwin64 crosscompiler loading',etDebug);
=======
  ShowInfo;
>>>>>>> upstream/master
end;

destructor TDarwin64.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF Darwin}
{$IFNDEF CPUX86_64}

var
  darwin64:TDarwin64;

initialization
  darwin64:=TDarwin64.Create;
  RegisterExtension(darwin64.TargetCPU+'-'+darwin64.TargetOS,darwin64);
finalization
  darwin64.Destroy;
{$ENDIF}
{$ENDIF}
end.

