unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI, pngimage;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    lblSite: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure lblSiteMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lblSiteMouseLeave(Sender: TObject);
    procedure lblSiteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

procedure TAboutBox.lblSiteClick(Sender: TObject);
var
  WebSite: Pwidechar;
begin
  WebSite := Pwidechar(lblSite.Caption);
  ShellExecute(Handle, 'open', WebSite, nil, nil, SW_SHOW);
end;

procedure TAboutBox.lblSiteMouseLeave(Sender: TObject);
begin
  lblSite.Font.Style := [];
  lblSite.Font.Color := clBlack;

end;

procedure TAboutBox.lblSiteMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  lblSite.Font.Style := [fsUnderline];
  lblSite.Font.Color := clBlue;

end;

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  Close;
end;

end.
