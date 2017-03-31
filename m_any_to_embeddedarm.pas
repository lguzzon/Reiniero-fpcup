unit m_any_to_embeddedarm;
{ Cross compiles from any platform with correct binutils to Embedded ARM
Copyright (C) 2015 Alf

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
Setup: based on cross binaries from
<<<<<<< HEAD
http://svn2.freepascal.org/svn/fpcbuild/binaries/i386-win32/
=======
http://svn.freepascal.org/svn/fpcbuild/binaries/i386-win32/
>>>>>>> upstream/master
with binutils 2.22

Add a cross directory under the fpcup "root" installdir directory (e.g. c:\development\cross, and e.g. regular fpc sources in c:\development\fpc)
Then place the binaries in c:\development\cross\bin\arm-embedded
Binaries include
arm-embedded-ar.exe
arm-embedded-as.exe
arm-embedded-ld.exe
arm-embedded-objcopy.exe
arm-embedded-objdump.exe
arm-embedded-strip.exe
}

{$mode objfpc}{$H+}

interface

uses
<<<<<<< HEAD
  Classes, SysUtils, m_crossinstaller, fpcuputil, fileutil;
=======
  Classes, SysUtils, m_crossinstaller, fileutil, fpcuputil;
>>>>>>> upstream/master

implementation
type

{ TAny_Embeddedarm }
TAny_Embeddedarm = class(TCrossInstaller)
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

{ TAny_Embeddedarm }
<<<<<<< HEAD
function TAny_Embeddedarm.TargetSignature: string;
begin
  result:=FTargetCPU+'-'+TargetOS;
end;
=======
>>>>>>> upstream/master

function TAny_Embeddedarm.GetLibs(Basepath:string): boolean;
const
  DirName='arm-embedded';
begin
  // Arm-embedded does not need libs by default, but user can add them.

<<<<<<< HEAD
  // search local paths based on libbraries provided for or adviced by fpc itself
  result:=SimpleSearchLibrary(BasePath,DirName);
=======
  result:=FLibsFound;
  if result then exit;

  // search local paths based on libbraries provided for or adviced by fpc itself
  result:=SimpleSearchLibrary(BasePath,DirName,'');
>>>>>>> upstream/master

  if result then
  begin
    //todo: check if -XR is needed for fpc root dir Prepend <x> to all linker search paths
    FFPCCFGSnippet:=FFPCCFGSnippet+LineEnding+
    '-Fl'+IncludeTrailingPathDelimiter(FLibsPath) {buildfaq 1.6.4/3.3.1:  the directory to look for the target  libraries};
<<<<<<< HEAD
    infoln('Tany_embeddedarm: found libspath '+FLibsPath,etInfo);
=======
    ShowInfo('Found libspath '+FLibsPath);
>>>>>>> upstream/master
  end;
  if not result then
  begin
    //libs path is optional; it can be empty
<<<<<<< HEAD
    infoln('Tany_embeddedarm: libspath ignored; it is optional for this cross compiler.',etInfo);
    FLibsPath:='';
    result:=true;
  end;
=======
    ShowInfo('Libspath ignored; it is optional for this cross compiler.');
    FLibsPath:='';
    result:=true;
  end;
  FLibsFound:=True;
>>>>>>> upstream/master
end;

{$ifndef FPCONLY}
function TAny_Embeddedarm.GetLibsLCL(LCL_Platform: string; Basepath: string): boolean;
begin
  // todo: get gtk at least, add to FFPCCFGSnippet
<<<<<<< HEAD
  infoln('todo: implement lcl libs path from basepath '+BasePath,etdebug);
  result:=true;
=======
  ShowInfo('Todo: implement lcl libs path from basepath '+BasePath,etdebug);
  result:=inherited;
>>>>>>> upstream/master
end;
{$endif}

function TAny_Embeddedarm.GetBinUtils(Basepath:string): boolean;
const
  DirName='arm-embedded';
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

  // Start with any names user may have given
  AsFile:=FBinUtilsPrefix+'as'+GetExeExt;

  result:=SearchBinUtil(BasePath,AsFile);
<<<<<<< HEAD

  if not result then
    result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);
=======
  if not result then result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);
>>>>>>> upstream/master

  {$ifdef unix}
  // User may also have placed them into their regular search path:
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
  {$endif unix}

  // Now also allow for arm-none-eabi- binutilsprefix (e.g. launchpadlibrarian)
  if not result then
  begin
<<<<<<< HEAD
    FBinutilsPrefix:='arm-none-eabi-';
    AsFile:=FBinUtilsPrefix+'as'+GetExeExt;
    result:=SearchBinUtil(FBinUtilsPath,AsFile);
    if not result then
      result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);
  end;


  {$ifdef unix}
  // User may also have placed them into their regular search path:
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
  {$endif unix}

  // Now also allow for empty binutilsprefix:
  if not result then
  begin
    FBinutilsPrefix:='';
    AsFile:=FBinUtilsPrefix+'as'+GetExeExt;
    result:=SearchBinUtil(FBinUtilsPath,AsFile);
    if not result then
      result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);
  end;

  {$ifdef unix}
  // User may also have placed them into their regular search path:
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
  {$endif unix}

  SearchBinUtilsInfo(result);
  if not result then
  begin
    {$ifdef mswindows}
    infoln(FCrossModuleName+ ': suggestion for cross binutils: the crossfpc binutils (arm-embedded) at http://svn.freepascal.org/svn/fpcbuild/binaries/i386-win32/.',etInfo);
    {$else}
    infoln(FCrossModuleName+ ': suggestion for cross binutils: the crossfpc binutils (arm-embedded) at https://launchpad.net/gcc-arm-embedded.',etInfo);
=======
    BinPrefixTry:='arm-none-eabi-';
    AsFile:=BinPrefixTry+'as'+GetExeExt;
    result:=SearchBinUtil(BasePath,AsFile);
    if not result then result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);
    if result then FBinUtilsPrefix:=BinPrefixTry;
  end;

  // Now also allow for empty binutilsprefix:
  if not result then
  begin
    BinPrefixTry:='';
    AsFile:=BinPrefixTry+'as'+GetExeExt;
    result:=SearchBinUtil(BasePath,AsFile);
    if not result then result:=SimpleSearchBinUtil(BasePath,DirName,AsFile);
    if result then FBinUtilsPrefix:=BinPrefixTry;
  end;

  SearchBinUtilsInfo(result);

  if not result then
  begin
    {$ifdef mswindows}
    ShowInfo('Suggestion for cross binutils: the crossfpc binutils (arm-embedded) at http://svn.freepascal.org/svn/fpcbuild/binaries/i386-win32/.');
    {$else}
    ShowInfo('Suggestion for cross binutils: the crossfpc binutils (arm-embedded) at https://launchpad.net/gcc-arm-embedded.');
>>>>>>> upstream/master
    {$endif}
    FAlreadyWarned:=true;
  end
  else
  begin
<<<<<<< HEAD
=======
    FBinsFound:=true;
>>>>>>> upstream/master
    { for Teensy 3.0 and 3.1 and 3.2 add
    -Cparmv7em ... -Wpmk20dx256XXX7

    for NXP LPC 2124 add
    -Cparmv4

    for mbed add
    -Cparmv7m
    }

    if StringListStartsWith(FCrossOpts,'-Cp')=-1 then
    begin
      FCrossOpts.Add('-Cparmv7em'); // Teensy default
<<<<<<< HEAD
      infoln(FCrossModuleName+ ': did not find any -Cp architecture parameter; using -Cparmv7em (Teensy default).',etInfo);
=======
      ShowInfo('Did not find any -Cp architecture parameter; using -Cparmv7em (Teensy default).');
>>>>>>> upstream/master
    end;

    // Configuration snippet for FPC
    //http://wiki.freepascal.org/Setup_Cross_Compile_For_ARM#Make_FPC_able_to_cross_compile_for_arm-embedded
    FFPCCFGSnippet:=FFPCCFGSnippet+LineEnding+
    '-FD'+IncludeTrailingPathDelimiter(FBinUtilsPath)+LineEnding+ {search this directory for compiler utilities}
    '-XP'+FBinUtilsPrefix; {Prepend the binutils names}
  end;
end;

constructor TAny_Embeddedarm.Create;
begin
  inherited Create;
<<<<<<< HEAD
  FCrossModuleName:='TAny_EmbeddedArm';
=======
>>>>>>> upstream/master
  FBinUtilsPrefix:='arm-embedded-'; //crossfpc nomenclature; module will also search for android crossbinutils
  FBinUtilsPath:='';
  FFPCCFGSnippet:=''; //will be filled in later
  //FCompilerUsed:=ctInstalled;
  FLibsPath:='';
  FTargetCPU:='arm';
  FTargetOS:='embedded';
  FAlreadyWarned:=false;
<<<<<<< HEAD
  infoln(FCrossModuleName+ ': crosscompiler loading',etDebug);
=======
  ShowInfo;
>>>>>>> upstream/master
end;

destructor TAny_Embeddedarm.Destroy;
begin
  inherited Destroy;
end;

var
  Any_Embeddedarm:TAny_Embeddedarm;

initialization
  Any_Embeddedarm:=TAny_Embeddedarm.Create;
  RegisterExtension(Any_Embeddedarm.TargetCPU+'-'+Any_Embeddedarm.TargetOS,Any_Embeddedarm);
finalization
  Any_Embeddedarm.Destroy;
end.

