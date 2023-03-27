unit BGColour;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TBGColor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    rbOriginal: TRadioButton;
    rbBlack: TRadioButton;
    rbSilver: TRadioButton;
    rbCream: TRadioButton;
    rbTeal: TRadioButton;
    rbSkyBlue: TRadioButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure rbOriginalClick(Sender: TObject);
    procedure rbBlackClick(Sender: TObject);
    procedure rbSilverClick(Sender: TObject);
    procedure rbSkyBlueClick(Sender: TObject);
    procedure rbCreamClick(Sender: TObject);
    procedure rbTealClick(Sender: TObject);
  private
    { Private declarations }
    iColour: integer;
  public
    { Public declarations }
  end;

var
  BGColor: TBGColor;

implementation

uses GameNumberGuesser;
{$R *.dfm}

procedure TBGColor.Button1Click(Sender: TObject);
begin
  case iColour of
    1:
      begin
        with GuessGame do
        begin
          Color := clBtnFace;
          rgpGroup.Color := clBtnFace;
          pnlTime.Color := clBlack;
        end;
      end;
    2:
      begin
        with GuessGame do
        begin
          Color := clBlack;
          rgpGroup.Color := clWhite;
          pnlTime.Font.Color := clWhite;
        end;

      end;
    3:
      begin
        with GuessGame do
        begin
          Color := clSilver;
          rgpGroup.Color := clBtnFace;
          pnlTime.Font.Color := clBlack;
        end;
      end;
    4:
      begin
        with GuessGame do
        begin
          Color := clSkyBlue;
          rgpGroup.Color := clBtnFace;
          pnlTime.Font.Color := clBlack;
        end;
      end;
    5:
      begin
        with GuessGame do
        begin
          Color := clCream;
          rgpGroup.Color := clBtnFace;
          pnlTime.Font.Color := clBlack;
        end;
      end;
    6:
      begin
        with GuessGame do
        begin
          Color := clTeal;
          rgpGroup.Color := clBtnFace;
          pnlTime.Font.Color := clBlack;
        end;
      end;
  end;

  close;
end;

procedure TBGColor.rbBlackClick(Sender: TObject);
begin
  iColour := 2;
end;

procedure TBGColor.rbCreamClick(Sender: TObject);
begin
  iColour := 5;
end;

procedure TBGColor.rbOriginalClick(Sender: TObject);
begin
  iColour := 1;
end;

procedure TBGColor.rbSilverClick(Sender: TObject);
begin
  iColour := 3;
end;

procedure TBGColor.rbSkyBlueClick(Sender: TObject);
begin
  iColour := 4;
end;

procedure TBGColor.rbTealClick(Sender: TObject);
begin
  iColour := 6;
end;

end.
