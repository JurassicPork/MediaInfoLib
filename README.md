# MediaInfoLib
MediaInfoLib wrapper for Lazarus - Free pascal

1. Download the library package for your system :   https://mediaarea.net/MediaInfo/Download
2. Use the project which is in the demo folder to try the wrapper file  **MediaInfoDll.pas** in Lazarus
3. The button in the demo project open an openfiledialog to choose the file to analyze.
4. Be sure that the dynamic link library of MediaInfo is in path. 

> // WINDOWS -> **mediainfo.dll**    tested on Windows 10 Lazarus 2.0.10 fpc 3.2
>
> // LINUX -> **libmediainfo.so.0**  tested on Centos 8.1 Lazarus 2.0.10 fpc 3.2
>
> // MAC Darwin -> **libmediainfo.0.dylib**    tested on MacOs 10.15.7 (Catalina)  Lazarus 2.0.10 fpc 3.2

For MAC put the file **libmediainfo.0.dylib** in **$HOME/lib** (create **lib** if not exist) 



