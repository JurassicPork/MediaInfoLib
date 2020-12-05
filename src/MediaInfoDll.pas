unit MediaInfoDll;
{$mode objfpc}{$H+}
{
  MediaInfoLib Interface for Lazarus  v 0.1
  from MediaInfoLib (MediaInfo.dll v0.7.7.6) Interface for Delphi
    (c)2008 by Norbert Mereg (Icebob)
    http://MediaArea.net/MediaInfo
}

// Defines how the DLL is called
// Converted to Lazarus  by Jurassic Pork November 2020
// tested with MediaInfoLib v20.09
// WINDOWS -> mediainfo.dll    tested on Windows 10 Lazarus 2.0.10 fpc 3.2
// LINUX -> libmediainfo.so.0  tested on Centos 8.1 Lazarus 2.0.10 fpc 3.2
// MAC Darwin -> libmediainfo.0.dylib  tested on MacOs 10.15.7 (Catalina)  Lazarus 2.0.10 fpc 3.2

interface
 uses   LCLIntf, LCLType, DynLibs;


type TMIStreamKind =
(
    Stream_General,
    Stream_Video,
    Stream_Audio,
    Stream_Text,
    Stream_Other,
    Stream_Image,
    Stream_Menu,
    Stream_Max
);

type TMIInfo =
(
    Info_Name,
    Info_Text,
    Info_Measure,
    Info_Options,
    Info_Name_Text,
    Info_Measure_Text,
    Info_Info,
    Info_HowTo,
    Info_Max
);

type TMIInfoOption =
(
    InfoOption_ShowInInform,
    InfoOption_Reserved,
    InfoOption_ShowInSupported,
    InfoOption_TypeOfValue,
    InfoOption_Max
);

type TMIFileOptions =
(
  FileOptions_Nothing,
  FileOptions_Recursive,
  FileOptions_CloseAll,
  FileOptions_xxNonexx,
  FileOptions_Max
);


var
  LibHandle: THandle = 0;

 {$IFDEF WINDOWS}
  // Unicode methods
  MediaInfo_New:        function  (): THandle stdcall;
  MediaInfo_Delete:     procedure (Handle: THandle) stdcall;
  MediaInfo_Open:       function  (Handle: THandle; File__: PWideChar): Cardinal  stdcall;
  MediaInfo_Close:      procedure (Handle: THandle)  stdcall;
  MediaInfo_Inform:     function  (Handle: THandle; Reserved: Integer): PWideChar  stdcall;
  MediaInfo_GetI:       function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer;   KindOfInfo: TMIInfo): PWideChar  stdcall; //Default: KindOfInfo=Info_Text,
  MediaInfo_Get:        function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PWideChar; KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PWideChar  stdcall; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  MediaInfo_Option:     function  (Handle: THandle; Option: PWideChar; Value: PWideChar): PWideChar stdcall;
  MediaInfo_State_Get:  function  (Handle: THandle): Integer stdcall;
  MediaInfo_Count_Get:  function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer stdcall;
  // Ansi methods
  MediaInfoA_New:       function  (): THandle  stdcall;
  MediaInfoA_Delete:    procedure (Handle: THandle) stdcall;
  MediaInfoA_Open:      function  (Handle: THandle; File__: PAnsiChar): Cardinal stdcall;
  MediaInfoA_Close:     procedure (Handle: THandle)  stdcall;
  MediaInfoA_Inform:    function  (Handle: THandle; Reserved: Integer): PAnsiChar  stdcall;
  MediaInfoA_GetI:      function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer; KindOfInfo: TMIInfo): PAnsiChar  stdcall; //Default: KindOfInfo=Info_Text
  MediaInfoA_Get:       function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PAnsiChar;   KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PAnsiChar  stdcall; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  MediaInfoA_Option:    function  (Handle: THandle; Option: PAnsiChar; Value: PAnsiChar): PAnsiChar  stdcall;
  MediaInfoA_State_Get: function  (Handle: THandle): Integer stdcall;
  MediaInfoA_Count_Get: function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer  stdcall;

  {$ELSE}
  MediaInfo_New:       function  (): THandle  cdecl;
  MediaInfo_Delete:    procedure (Handle: THandle) cdecl;
  MediaInfo_Open:      function  (Handle: THandle; File__: PAnsiChar): Cardinal cdecl;
  MediaInfo_Close:     procedure (Handle: THandle)  cdecl;
  MediaInfo_Inform:    function  (Handle: THandle; Reserved: Integer): PAnsiChar  cdecl;
  MediaInfo_GetI:      function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer; KindOfInfo: TMIInfo): PAnsiChar  cdecl; //Default: KindOfInfo=Info_Text
  MediaInfo_Get:       function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PAnsiChar;   KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PAnsiChar  cdecl; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  MediaInfo_Option:    function  (Handle: THandle; Option: PAnsiChar; Value: PAnsiChar): PAnsiChar  cdecl;
  MediaInfo_State_Get: function  (Handle: THandle): Integer cdecl;
  MediaInfo_Count_Get: function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer  cdecl;
    // Ansi methods
  MediaInfoA_New:       function  (): THandle  cdecl;
  MediaInfoA_Delete:    procedure (Handle: THandle) cdecl;
  MediaInfoA_Open:      function  (Handle: THandle; File__: PAnsiChar): Cardinal cdecl;
  MediaInfoA_Close:     procedure (Handle: THandle)  cdecl;
  MediaInfoA_Inform:    function  (Handle: THandle; Reserved: Integer): PAnsiChar  cdecl;
  MediaInfoA_GetI:      function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer; KindOfInfo: TMIInfo): PAnsiChar  cdecl; //Default: KindOfInfo=Info_Text
  MediaInfoA_Get:       function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PAnsiChar;   KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PAnsiChar  cdecl; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  MediaInfoA_Option:    function  (Handle: THandle; Option: PAnsiChar; Value: PAnsiChar): PAnsiChar  cdecl;
  MediaInfoA_State_Get: function  (Handle: THandle): Integer cdecl;
  MediaInfoA_Count_Get: function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer  cdecl;
  {$ENDIF}


function MediaInfoDLL_Load(LibPath: string): boolean;

implementation

function MI_GetProcAddress(Name: PChar; var Addr: Pointer): boolean;
begin
  Addr := GetProcAddress(LibHandle, Name);
  Result := Addr <> nil;
end;

function MediaInfoDLL_Load(LibPath: string): boolean;
begin
  Result := False;

  if LibHandle = 0 then
    LibHandle := LoadLibrary(PChar(LibPath));

  if LibHandle <> 0 then
  begin
   {$IFDEF WINDOWS}
    MI_GetProcAddress('MediaInfo_New',        Pointer(MediaInfo_New));
    MI_GetProcAddress('MediaInfo_Delete',     Pointer(MediaInfo_Delete));
    MI_GetProcAddress('MediaInfo_Open',       Pointer(MediaInfo_Open));
    MI_GetProcAddress('MediaInfo_Close',      Pointer(MediaInfo_Close));
    MI_GetProcAddress('MediaInfo_Inform',     Pointer(MediaInfo_Inform));
    MI_GetProcAddress('MediaInfo_GetI',       Pointer(MediaInfo_GetI));
    MI_GetProcAddress('MediaInfo_Get',        Pointer(MediaInfo_Get));
    MI_GetProcAddress('MediaInfo_Option',     Pointer(MediaInfo_Option));
    MI_GetProcAddress('MediaInfo_State_Get',  Pointer(MediaInfo_State_Get));
    MI_GetProcAddress('MediaInfo_Count_Get',  Pointer(MediaInfo_Count_Get));
    {$ELSE}       // LINUX   MAC DARWIN
    MI_GetProcAddress('MediaInfoA_New',        Pointer(MediaInfo_New));
    MI_GetProcAddress('MediaInfoA_Delete',     Pointer(MediaInfo_Delete));
    MI_GetProcAddress('MediaInfoA_Open',       Pointer(MediaInfo_Open));
    MI_GetProcAddress('MediaInfoA_Close',      Pointer(MediaInfo_Close));
    MI_GetProcAddress('MediaInfoA_Inform',     Pointer(MediaInfo_Inform));
    MI_GetProcAddress('MediaInfoA_GetI',       Pointer(MediaInfo_GetI));
    MI_GetProcAddress('MediaInfoA_Get',        Pointer(MediaInfo_Get));
    MI_GetProcAddress('MediaInfoA_Option',     Pointer(MediaInfo_Option));
    MI_GetProcAddress('MediaInfoA_State_Get',  Pointer(MediaInfo_State_Get));
    MI_GetProcAddress('MediaInfoA_Count_Get',  Pointer(MediaInfo_Count_Get));
    {$ENDIF}
    MI_GetProcAddress('MediaInfoA_New',       Pointer(MediaInfoA_New));
    MI_GetProcAddress('MediaInfoA_Delete',    Pointer(MediaInfoA_Delete));
    MI_GetProcAddress('MediaInfoA_Open',      Pointer(MediaInfoA_Open));
    MI_GetProcAddress('MediaInfoA_Close',     Pointer(MediaInfoA_Close));
    MI_GetProcAddress('MediaInfoA_Inform',    Pointer(MediaInfoA_Inform));
    MI_GetProcAddress('MediaInfoA_GetI',      Pointer(MediaInfoA_GetI));
    MI_GetProcAddress('MediaInfoA_Get',       Pointer(MediaInfoA_Get));
    MI_GetProcAddress('MediaInfoA_Option',    Pointer(MediaInfoA_Option));
    MI_GetProcAddress('MediaInfoA_State_Get', Pointer(MediaInfoA_State_Get));
    MI_GetProcAddress('MediaInfoA_Count_Get', Pointer(MediaInfoA_Count_Get));

    Result := True;
  end;
end;


end.
