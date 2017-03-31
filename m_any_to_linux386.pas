unit m_any_to_linux386;

{ Cross compiles from e.g. Linux 64 bit (or any other OS with relevant binutils/libs) to Linux 32 bit
Copyright (C) 2014 Reinier Olislagers

This library is free software; you can redistribute it and/or modify it
under the terms of the GNU Library General Public License as published by
the Free Software Foundation; either version 2 of the License, or (at your
option) any later version with the following modification:

As a special exception, the copyright holders of this library give you
permission to link this library with independent modules to produce an
executable, regardless of the license terms of these independent modules,and
to copy and distribute the resulting executable under terms of your choice,
provided that you also meet, for each linked independent module, the terms
and conditions of the license of that module. An independent module is a
module which is not derived from or based on this library. If you modify
this library, you may extend this exception to your version of the library,
but you are not obligated to do so. If you do not wish to do so, delete this
exception statement from your version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
for more details.

You should have received a copy of the GNU Library General Public License
along with this library; if not, write to the Free Software Foundation,
Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

{
Debian: adding i386 libs/architecture support on e.g. x64 system
dpkg --add-architecture i386

Adapt (add) for other setups
}

{$mode objfpc}{$H+}

interface

uses
<<<<<<< HEAD
  Classes, SysUtils, m_crossinstaller,fpcuputil,fileutil;

implementation
const
  CrossModuleName='Tany_linux386';
=======
  Classes, SysUtils, m_crossinstaller, fileutil;

implementation
>>>>>>> upstream/master

type

{ Tany_linux386 }
Tany_linux386 = class(TCrossInstaller)
private
  FAlreadyWarned: boolean; //did we warn user about errors and fixes already?
<<<<<<< HEAD
  function TargetSignature: string;
=======
>>>>>>> upstream/master
public
  function GetLibs(Basepath:string):boolean;override;
  {$ifndef FPCONLY}
  function GetLibsLCL(LCL_Platform:string; Basepath:string):boolean;override;
  {$endif}
  function GetBinUtils(Basepath:string):boolean;override;
  constructor Create;
  destructor Destroy; override;
end;

{ Tany_linux386 }
<<<<<<< HEAD
function Tany_linux386.TargetSignature: string;
begin
  result:=FTargetCPU+'-'+TargetOS;
end;
=======
>>>>>>> upstream/master

function Tany_linux386.GetLibs(Basepath:string): boolean;
const
  DirName='i386-linux';
  LibName='libc.so';
begin
<<<<<<< HEAD
=======
  result:=FLibsFound;
  if result then exit;

>>>>>>> upstream/master
  // begin simple: check presence of library file in basedir
  result:=SearchLibrary(Basepath,LibName);

  // first search local paths based on libbraries provided for or adviced by fpc itself
  if not result then
<<<<<<< HEAD
    result:=SimpleSearchLibrary(BasePath,DirName);
=======
    result:=SimpleSearchLibrary(BasePath,DirName,LibName);
>>>>>>> upstream/master

  if not result then
  begin
    {$IFDEF UNIX}
    FLibsPath:='/usr/lib/i386-linux-gnu'; //debian Jessie+ convention
    result:=DirectoryExists(FLibsPath);
    if not result then
<<<<<<< HEAD
    infoln('Tany_linux386: failed: searched libspath '+FLibsPath,etInfo);
=======
    ShowInfo('Searched but not found libspath '+FLibsPath);
>>>>>>> upstream/master
    {$ENDIF}
  end;

  SearchLibraryInfo(result);
<<<<<<< HEAD
  if result then
  begin
    //todo: check if -XR is needed for fpc root dir Prepend <x> to all linker search paths
    FFPCCFGSnippet:=FFPCCFGSnippet+LineEnding+
    '-Fl'+IncludeTrailingPathDelimiter(FLibsPath)+LineEnding+ {buildfaq 1.6.4/3.3.1: the directory to look for the target  libraries}
    '-Xr/usr/lib';//+LineEnding+ {buildfaq 3.3.1: makes the linker create the binary so that it searches in the specified directory on the target system for libraries}
    //'-FL/usr/lib/ld-linux.so.2' {buildfaq 3.3.1: the name of the dynamic linker on the target};
=======

  if result then
  begin
    FLibsFound:=True;
    //todo: check if -XR is needed for fpc root dir Prepend <x> to all linker search paths
    FFPCCFGSnippet:=FFPCCFGSnippet+LineEnding+
    '-Fl'+IncludeTrailingPathDelimiter(FLibsPath)+LineEnding+ {buildfaq 1.6.4/3.3.1: the directory to look for the target  libraries}
    //'-FL/lib/ld-linux.so.2'+LineEnding+ {buildfaq 3.3.1: the name of the dynamic linker on the target ... can also be ld-linux.so.3 (Arch) ... tricky}
    '-Xr/usr/lib'; {buildfaq 3.3.1: makes the linker create the binary so that it searches in the specified directory on the target system for libraries}
>>>>>>> upstream/master
  end;
end;

{$ifndef FPCONLY}
function Tany_linux386.GetLibsLCL(LCL_Platform: string; Basepath: string): boolean;
begin
  // todo: get gtk at least
<<<<<<< HEAD
  result:=true;
=======
  result:=inherited;
>>>>>>> upstream/master
end;
{$endif}

function Tany_linux386.GetBinUtils(Basepath:string): boolean;
const
  DirName='i386-linux';
var
  AsFile: string;
<<<<<<< HEAD
begin
  inherited;
=======
  BinPrefixTry: string;
begin
  result:=inherited;
  if result then exit;
>>>>>>> upstream/master

  AsFile:=FBinUtilsPrefix+'as'+GetExeExt;

  result:=SearchBinUtil(BasePath,AsFile);
<<<<<<< HEAD
=======

>>>>>>> upstream/master
  if not result then
    result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);

  // Also allow for (cross)binutils without prefix
  if not result then
  begin
<<<<<<< HEAD
    FBinUtilsPrefix:='';
    AsFile:=FBinUtilsPrefix+'as'+GetExeExt;
    result:=SearchBinUtil(BasePath,AsFile);
    if not result then
      result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);
  end;

  {$IFDEF UNIX}
  if not result then { try /usr/local/bin/<dirprefix>/ }
    result:=SearchBinUtil('/usr/local/bin/'+DirName,
      AsFile);

  if not result then { try /usr/local/bin/ }
    result:=SearchBinUtil('/usr/local/bin',
      AsFile);

  if not result then { try /usr/bin/ }
    result:=SearchBinUtil('/usr/bin',
      AsFile);

  if not result then { try /bin/ }
    result:=SearchBinUtil('/bin',
      AsFile);
  {$ENDIF}

  SearchBinUtilsInfo(result);
  if result then
  begin
    // Configuration snippet for FPC
    FFPCCFGSnippet:=FFPCCFGSnippet+LineEnding+
    '-FD'+IncludeTrailingPathDelimiter(FBinUtilsPath)+LineEnding+ {search this directory for compiler utilities}
    '-XP'+FBinUtilsPrefix+LineEnding {Prepend the binutils names};
=======
    BinPrefixTry:='';
    AsFile:=BinPrefixTry+'as'+GetExeExt;
    result:=SearchBinUtil(BasePath,AsFile);
    if not result then result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);
    if result then FBinUtilsPrefix:=BinPrefixTry;
  end;

  SearchBinUtilsInfo(result);

  if result then
  begin
    FBinsFound:=true;
    // Configuration snippet for FPC
    FFPCCFGSnippet:=FFPCCFGSnippet+LineEnding+
    '-FD'+IncludeTrailingPathDelimiter(FBinUtilsPath)+LineEnding+ {search this directory for compiler utilities}
    '-XP'+FBinUtilsPrefix {Prepend the binutils names}
    {$ifdef MSWINDOWS}
    +LineEnding+'-Tlinux'; {target operating system}
    {$endif}
    ;
>>>>>>> upstream/master
  end;
end;

constructor Tany_linux386.Create;
begin
  inherited Create;
<<<<<<< HEAD
  FCrossModuleName:='any_linux386';
=======
>>>>>>> upstream/master
  FBinUtilsPrefix:='i386-linux-';
  FBinUtilsPath:='';
  FFPCCFGSnippet:='';
  FLibsPath:='';
  FTargetCPU:='i386';
  FTargetOS:='linux';
  FAlreadyWarned:=false;
<<<<<<< HEAD
  infoln('Tany_linux386 crosscompiler loading',etDebug);
=======
  ShowInfo;
>>>>>>> upstream/master
end;

destructor Tany_linux386.Destroy;
begin
  inherited Destroy;
end;

var
  any_linux386:Tany_linux386;

initialization
  any_linux386:=Tany_linux386.Create;
  RegisterExtension(any_linux386.TargetCPU+'-'+any_linux386.TargetOS,any_linux386);
finalization
  any_linux386.Destroy;

end.

