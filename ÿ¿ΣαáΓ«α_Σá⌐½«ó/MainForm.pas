unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Base64Unit, Mask, ToolEdit,
  CurrEdit, ShellApi, IniFiles;

type
   TWordTriple = Array[0..2] of Word;

type
  TMain = class(TForm)
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    B64Rb: TRadioButton;
    XORRb: TRadioButton;
    GoBtn: TButton;
    ExitBtn: TButton;
    GroupBox1: TGroupBox;
    ProgressBar: TProgressBar;
    Label3: TLabel;
    TypeLb: TLabel;
    Label4: TLabel;
    InLengthLb: TLabel;
    UnGoBtn: TButton;
    VerLb: TLabel;
    Label6: TLabel;
    FileNameEd: TFilenameEdit;
    GroupBox2: TGroupBox;
    OnTopChk: TCheckBox;
    Label5: TLabel;
    OutLengthLb: TLabel;
    Timer: TTimer;
    Label7: TLabel;
    CurrByteLb: TLabel;
    PassEdit: TEdit;
    Label2: TLabel;
    CopyChk: TCheckBox;
    Timer1: TTimer;
    procedure ExitBtnClick(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);
    procedure XORRbClick(Sender: TObject);
    procedure B64RbClick(Sender: TObject);
    procedure UnGoBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public

    procedure ProcessSettings(bLoad: Boolean);

    function MemoryEncrypt(Src: Pointer; SrcSize: Cardinal; Target: Pointer; TargetSize: Cardinal; Key: TWordTriple): boolean;
    function MemoryDecrypt(Src: Pointer; SrcSize: Cardinal; Target: Pointer; TargetSize: Cardinal; Key: TWordTriple): boolean;
    function FileCrypt(InFile, OutFile: String; Key: TWordTriple; Encrypt: Boolean): boolean;


    function AttachToFile(const AFileName: string; MemoryStream: TMemoryStream): Boolean;
    function LoadFromFile(const AFileName: string; MemoryStream: TMemoryStream): Boolean;
    procedure GetFileVersion(FileName: string; var Major1, Major2, Minor1, Minor2: Integer);

    { Public declarations }
  end;

var
  Main:           TMain;
  sAppDir,
  sFilePath:      String;
  iPosition,i:    Cardinal;
  dtKey:          TWordTriple;
  dwFileSize:     Integer;
  bLoaded:        Boolean;

implementation

uses StrUtils;

{$R *.dfm}

procedure TMain.ProcessSettings(bLoad: Boolean);
var
  hIniFile: TIniFile;
  sType:    String;
begin

  hIniFile := TIniFile.Create(sAppDir + 'settings.ini');

  if (bLoad = True) and (bLoaded = False) then
  begin
    sType := hIniFile.ReadString('MAIN','Type','MXOR');
    if sType = 'MXOR' then XORRb.Checked := True;
    if sType = 'B64' then B64Rb.Checked := True;
    OnTopChk.Checked := hIniFile.ReadBool('MAIN','OnTop',True);
    CopyChk.Checked := hIniFile.ReadBool('MAIN','Copy',True);
    PassEdit.Text := hIniFile.ReadString('MAIN','Pass','123456789');
  end
  else if bLoad = False then
  begin
    if B64Rb.Checked = True Then hIniFile.WriteString('MAIN','Type','B64');
    if XORRb.Checked = True Then hIniFile.WriteString('MAIN','Type','MXOR');
    hIniFile.WriteBool('MAIN','OnTop',OnTopChk.Checked);
    hIniFile.WriteBool('MAIN','Copy',CopyChk.Checked);
   hIniFile.WriteString('MAIN','Pass',PassEdit.Text);
  end;

  bLoaded := True;

  hIniFile.Free;

end;


function TMain.MemoryEncrypt(Src: Pointer; SrcSize: Cardinal; Target: Pointer; TargetSize: Cardinal; Key: TWordTriple): boolean;
var
  pIn,pOut:   ^byte;
begin
  if SrcSize = TargetSize then
  begin
    pIn := Src;
    pOut := Target;
    ProgressBar.Max := SrcSize;
    InLengthLb.Caption := IntToStr(SrcSize) + ' Байт';
    OutLengthLb.Caption := IntToStr(SrcSize) + ' Байт';
    for i := 1 to SrcSize do
    begin
      Application.ProcessMessages;
      iPosition := i;
      pOut^ := pIn^ xor (Key[2] shr 8);
      Key[2] := Byte(pIn^ + Key[2]) * Key[0] + Key[1];
      inc(pIn);
      inc(pOut);
    end;
    Result := True;
  end else
    Result := False;
end;

function TMain.MemoryDecrypt(Src: Pointer; SrcSize: Cardinal; Target: Pointer; TargetSize: Cardinal; Key: TWordTriple): boolean;
var
  pIn,pOut:   ^byte;
begin
  if SrcSize = TargetSize then
  begin
    pIn := Src;
    pOut := Target;
    ProgressBar.Max := SrcSize;
    InLengthLb.Caption := IntToStr(SrcSize) + ' Байт';
    OutLengthLb.Caption := IntToStr(SrcSize) + ' Байт';
    for i := 1 to SrcSize do
    begin
      Application.ProcessMessages;
      iPosition := i;
      pOut^ := pIn^ xor (Key[2] shr 8);
      Key[2] := byte(pOut^ + Key[2]) * Key[0] + Key[1];
      inc(pIn);
      inc(pOut);
    end;
    Result := True;
  end else
    Result := False;
end;

function TMain.FileCrypt(InFile, OutFile: String; Key: TWordTriple; Encrypt: Boolean): boolean;
var
  MIn, MOut: TMemoryStream;
begin
  MIn := TMemoryStream.Create;
  MOut := TMemoryStream.Create;
  try
    MIn.LoadFromFile(InFile);
    MOut.SetSize(MIn.Size);
    if Encrypt then
      Result := MemoryEncrypt(MIn.Memory, MIn.Size, MOut.Memory, MOut.Size, Key)
    else
      Result := MemoryDecrypt(MIn.Memory, MIn.Size, MOut.Memory, MOut.Size, Key);
    MOut.SaveToFile(OutFile);
  finally
    MOut.Free;
    MIn.Free;
  end;
end;

function TMain.AttachToFile(const AFileName: string; MemoryStream: TMemoryStream): Boolean;
var
  aStream: TFileStream;
  iSize: Integer; 
begin 
  Result := False; 
  if not FileExists(AFileName) then 
    Exit; 
  try 
    aStream := TFileStream.Create(AFileName, fmOpenWrite or fmShareDenyWrite); 
    MemoryStream.Seek(0, soFromBeginning); 
    // seek to end of File 
    // ans Ende der Datei Seeken 
    aStream.Seek(0, soFromEnd); 
    // copy data from MemoryStream 
    // Daten vom MemoryStream kopieren 
    aStream.CopyFrom(MemoryStream, 0); 
    // save Stream-Size 
    // die Streamgro?e speichern 
    iSize := MemoryStream.Size + SizeOf(Integer); 
    aStream.Write(iSize, SizeOf(iSize)); 
  finally 
    aStream.Free; 
  end; 
  Result := True; 
end; 

function TMain.LoadFromFile(const AFileName: string; MemoryStream: TMemoryStream): Boolean;
var
  aStream: TFileStream; 
  iSize: Integer; 
begin
  Result := False; 
  if not FileExists(AFileName) then 
    Exit; 

  try 
    aStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite); 
    // seek to position where Stream-Size is saved 
    // zur Position seeken wo Streamgro?e gespeichert 
    aStream.Seek(-SizeOf(Integer), soFromEnd);
    iSize := aStream.Size;
    //aStream.Read(iSize, SizeOf(iSize));
    if iSize > aStream.Size then 
    begin 
      aStream.Free; 
      Exit; 
    end; 
    // seek to position where data is saved 
    // zur Position seeken an der die Daten abgelegt sind 
    aStream.Seek(-iSize, soFromEnd); 
    MemoryStream.SetSize(iSize - SizeOf(Integer)); 
    MemoryStream.CopyFrom(aStream, iSize - SizeOf(iSize)); 
    MemoryStream.Seek(0, soFromBeginning); 
  finally 
    aStream.Free; 
  end; 
  Result := True; 
end;


procedure TMain.GetFileVersion(FileName: string; var Major1, Major2, Minor1, Minor2: Integer);
var
  Info: Pointer;
  InfoSize: DWORD;
  FileInfo: PVSFixedFileInfo;
  FileInfoSize: DWORD;
  Tmp: DWORD;
begin
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Tmp);

  if InfoSize = 0 then
    //Файл не содержит информации о версии
  else
  begin
    GetMem(Info, InfoSize);
    try
      GetFileVersionInfo(PChar(FileName), 0, InfoSize, Info);
      VerQueryValue(Info, '\', Pointer(FileInfo), FileInfoSize);
      Major1 := FileInfo.dwFileVersionMS shr 16;
      Major2 := FileInfo.dwFileVersionMS and $FFFF;
      Minor1 := FileInfo.dwFileVersionLS shr 16;
      Minor2 := FileInfo.dwFileVersionLS and $FFFF;
    finally
      FreeMem(Info, FileInfoSize);
    end;
  end;
end;

procedure TMain.ExitBtnClick(Sender: TObject);
begin
	Close;
end;

procedure TMain.GoBtnClick(Sender: TObject);
const
  Base64MaxLength = 72;
var
  base64String,
  sPass:          String;
  hFile,
  iPass:          Integer;
  base64File:     TextFile;
  xFile:          TFileStream;

  Buf:            Array[0..2] Of Byte;
  Base64:         TBase64;

begin

  try
    if PassEdit.Enabled = True then
    begin
      iPass := StrToInt(PassEdit.Text);
      sPass := IntToStr(iPass);
    end;

  except
    Raise Exception.Create('Введите ЧИСЛОВОЙ пароль!');
  end;

  sFilePath := StringReplace(FileNameEd.Text,'"','',[rfReplaceAll]);

	if not FileExists(sFilePath) then
  	Raise Exception.Create('Файла не существует!');



  if B64Rb.Checked = True then
  begin
    base64String:='';
    TypeLb.Caption := 'Base64 (encoding)';

    // шифруем
    hFile:=FileOpen(sFilePath,fmOpenRead);
    dwFileSize := GetFileSize(hFile,nil);
    InLengthLb.Caption := IntToStr(dwFileSize) + ' Байт';
    ProgressBar.Max := GetFileSize(hFile,nil);
    ProgressBar.Position := 0;
    AssignFile(base64File,sFilePath + '.b64');
    Rewrite(base64File);
    FillChar(Buf,SizeOf(Buf),#0);
    Application.ProcessMessages;
    repeat
      ProgressBar.Position := ProgressBar.Position + 3;
      Base64.ByteCount:=FileRead(hFile,Buf,SizeOf(Buf));
      Move(Buf,Base64.ByteArr,SizeOf(Buf));
      base64String:=base64String+CodeBase64(Base64);
      if Length(base64String)=Base64MaxLength then
      begin {If Length}
        Writeln(base64File,base64String);
        base64String:='';
      end;  {If Length}
    until Base64.ByteCount < 3;
    Writeln(base64File,base64String);
    CloseFile(base64File);
    FileClose(hFile);
    hFile:=FileOpen(sFilePath + '.b64',fmOpenRead);
    OutLengthLb.Caption := IntToStr(GetFileSize(hFile,nil)) + ' Байт';
    FileClose(hFile);
    TypeLb.Caption := 'Base64';
  end
  else if XORRb.Checked = true then
  begin
    TypeLb.Caption := 'MXOR (encoding)';
    dtKey[0] := abs(iPass) div 666;
    dtKey[1] := abs(iPass) XOR 666;
    dtKey[2] := abs(iPass) AND 666;

    ProgressBar.Position := 0;
    if CopyChk.Checked = True then
    begin
      DeleteFile(sFilePath+'.mxr');
      FileCrypt(sFilePath,sFilePath+'.mxr',dtKey,TRUE)
    end
    else
      FileCrypt(sFilePath,sFilePath,dtKey,TRUE);
    TypeLb.Caption := 'MXOR';
  end;
end;


procedure TMain.XORRbClick(Sender: TObject);
begin
  if XORRb.Checked = True then TypeLb.Caption := 'MXOR';
  PassEdit.Enabled := XORRb.Checked;
  CopyChk.Enabled := XORRb.Checked;
end;

procedure TMain.B64RbClick(Sender: TObject);
begin
  if B64Rb.Checked = True then TypeLb.Caption := 'Base64';
  PassEdit.Enabled := not B64Rb.Checked;
  CopyChk.Enabled := not B64Rb.Checked;
end;

procedure TMain.UnGoBtnClick(Sender: TObject);
var
  base64File:     TextFile;
  xFile:          TFileStream;
  xChar:          Char;
  BufStr,
  base64String,
  xStr,sPass:     String;
  Base64:         TBase64;
  MXORFile:       TFileStream;
  hFile,
  iPass,
  iFileSize:      Integer;
begin

  try
   if PassEdit.Enabled = True then
   begin
    iPass := StrToInt(PassEdit.Text);
    sPass := IntToStr(iPass);
   end;
  except
    Raise Exception.Create('Введите ЧИСЛОВОЙ пароль!');
  end;

  sFilePath := StringReplace(FileNameEd.Text,'"','',[rfReplaceAll]);

  if not FileExists(sFilePath) then
  	Raise Exception.Create('Файла не существует!');

  if B64Rb.Checked = True then
  begin
    base64String:='';
    TypeLb.Caption := 'Base64 (decoding)';

    // дешифруем
    hFile:=FileOpen(sFilePath,fmOpenRead);
    InLengthLb.Caption := IntToStr(GetFileSize(hFile,nil)) + ' Байт';
    FileClose(hFile);
    AssignFile(base64File,sFilePath);
    Reset(base64File);
    hFile:=FileCreate(sFilePath + '.orig');
    ProgressBar.Max := FileSize(base64File);
    Application.ProcessMessages;
    while not EOF(base64File) do
    begin {While Not EOF}
      ProgressBar.Position := ProgressBar.Position + 1;
      Readln(base64File,BufStr);
      while Length(BufStr) > 0 do
      begin {While Length}
        base64String:=Copy(BufStr,1,4);
        Delete(BufStr,1,4);
        Base64:=DecodeBase64(base64String);
        FileWrite(hFile,Base64.ByteArr,Base64.ByteCount);
      end;  {While Length}
    end;  {While Not EOF}

    OutLengthLb.Caption := IntToStr(GetFileSize(hFile,nil)) + ' Байт';
    FileClose(hFile);
    CloseFile(base64File);
    TypeLb.Caption := 'Base64'
  end
  else if XORRb.Checked = true then
  begin
    TypeLb.Caption := 'MXOR (decoding)';
    dtKey[0] := abs(iPass) div 666;
    dtKey[1] := abs(iPass) XOR 666;
    dtKey[2] := abs(iPass) AND 666;

    if CopyChk.Checked = True then
    begin
      DeleteFile(sFilePath+'.orig');
      FileCrypt(sFilePath,sFilePath+'.orig',dtKey,FALSE)
    end
    else
      FileCrypt(sFilePath,sFilePath,dtKey,FALSE);
    TypeLb.Caption := 'MXOR';
  end;
end;

procedure TMain.FormShow(Sender: TObject);
var
  iMajor1,iMajor2,iMinor1,iMinor2: Integer;
begin

  sAppDir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  GetFileVersion(Application.ExeName,iMajor1,iMajor2,iMinor1,iMinor2);

  try
    VerLb.Caption :='v' + IntToStr(iMajor1) + '.' +
                        IntToStr(iMajor2) + '.' +
                        IntToStr(iMinor1) + '.' +
                        IntToStr(iMinor2);
  except
    VerLb.Caption := 'n/a';
  end;

  ProcessSettings(True);

  if ParamStr(1) <> '' then FileNameEd.Text := ParamStr(1);

end;

procedure TMain.TimerTimer(Sender: TObject);
begin
  ProgressBar.Position := iPosition;
  CurrByteLb.Caption := IntToStr(iPosition);
end;

procedure TMain.Label6Click(Sender: TObject);
begin
  //ShellExecute(Handle, 'open', 'http://www.web-segment.ru', nil, '', SW_NORMAL);
  ShellExecute(Handle, nil, 'http://www.web-segment.ru', nil, nil, SW_SHOW);

 // WinExec('http://www.web-segment.ru',SW_SHOW);
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ProcessSettings(False);
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  bLoaded := False
end;

procedure TMain.Timer1Timer(Sender: TObject);
begin
  if OnTopChk.Checked = True then FormStyle := fsStayOnTop
  else FormStyle := fsNormal;
end;

end.
