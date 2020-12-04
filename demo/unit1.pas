unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Variants, MediaInfoDll;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  HandleMI: PtrUint;
  {$IFDEF WINDOWS}
  To_Display: WideString;
  CR: WideString;
  filename: Widestring;
  {$ELSE}
  To_Display: String;
  CR: String;
  filename: String;
  {$ENDIF}

begin
  CR:=Chr(13) + Chr(10);
  {$IF  defined(WINDOWS)}
  if (MediaInfoDLL_Load('mediainfo.dll')=false) then
  begin
      Memo1.Text := 'Error while loading mediainfo.dll';
      exit;
  end;
  {$ELSEIF defined(DARWIN)}
    if (MediaInfoDLL_Load('libmediainfo.0.dylib')=false) then
  begin
      Memo1.Text := 'Error while loading libmediainfo.0.dylib';
      exit;
  end;
  {$ELSE }     // Linux
  if (MediaInfoDLL_Load('libmediainfo.so.0')=false) then
  begin
      Memo1.Text := 'Error while loading libmediainfo.so.0';
      exit;
  end;
  {$ENDIF}
  To_Display := MediaInfo_Option (0, 'Info_Version', '') + CR;
  if OpenDialog1.Execute then
    begin
      filename := OpenDialog1.Filename;

      HandleMI := MediaInfo_New();
      To_Display := To_Display + 'Open' + CR;
      {$IFDEF WINDOWS}
      To_Display := To_Display + format('%d', [MediaInfo_Open(HandleMI, PWideChar(filename))]);
      {$ELSE}
       To_Display := To_Display + format('%d', [MediaInfo_Open(HandleMI, PChar(filename))]);
      {$ENDIF}

      To_Display := To_Display + CR + CR + 'Inform with Complete=false' + CR;
      MediaInfo_Option (HandleMI, 'Complete', '');
      To_Display := To_Display + MediaInfo_Inform(HandleMI, 0);

      To_Display := To_Display + CR + CR + 'Inform with Complete=true' + CR;
      MediaInfo_Option (HandleMI, 'Complete', '1');
      To_Display := To_Display + MediaInfo_Inform(HandleMI, 0);

      To_Display := To_Display + CR + CR + 'Custom Inform' + CR;
      MediaInfo_Option (HandleMI, 'Inform', 'General;Example : FileSize=%FileSize%');
      To_Display := To_Display + MediaInfo_Inform(HandleMI, 0);
      MediaInfo_Option (HandleMI, 'Inform', '');
      //To_Display := To_Display + CR + CR + 'GetI with Stream=General and Parameter:=17' + CR;
      //To_Display := To_Display + MediaInfo_GetI(HandleMI, Stream_General, 0, 17, Info_Text);
      //
      //To_Display := To_Display + CR + CR + 'Count_Get with StreamKind=Stream_Audio' + CR;
      //To_Display := To_Display + format('%d', [MediaInfo_Count_Get(HandleMI, Stream_Audio, -1)]);
      //
      //To_Display := To_Display + CR + CR + 'Get with Stream:=General and Parameter=^AudioCount^' + CR;
      //To_Display := To_Display + MediaInfo_Get(HandleMI, Stream_General, 0, 'AudioCount', Info_Text, Info_Name);
      //
      //To_Display := To_Display + CR + CR + 'Get with Stream:=Audio and Parameter=^StreamCount^' + CR;
      //To_Display := To_Display + MediaInfo_Get(HandleMI, Stream_Audio, 0, 'StreamCount', Info_Text, Info_Name);
      //
      To_Display := To_Display + CR + CR + 'Get with Stream:=General and Parameter=^FileSize^' + CR;
      To_Display := To_Display + MediaInfo_Get(HandleMI, Stream_General, 0, 'FileSize', Info_Text, Info_Name);

      To_Display := To_Display + CR + CR + 'Close' + CR;
      MediaInfo_Close(HandleMI);
      MediaInfo_Delete(HandleMI);
      Memo1.Text := To_Display;

    end;


end;

end.

