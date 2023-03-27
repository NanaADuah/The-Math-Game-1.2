unit HelpSection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, pngimage, AppEvnts;

type
  THelp = class(TForm)
    Panel1: TPanel;
    redHelpText: TRichEdit;
    lblWhatIsTheGameAbout: TLabel;
    lblGameMeaning: TLabel;
    lblPointsEarned: TLabel;
    lblBackgroundColour: TLabel;
    lblFoundBugs: TLabel;
    ProgramIcon: TImage;
    Nana321Logo: TImage;
    ApplicationEvents1: TApplicationEvents;
    procedure lblFoundBugsClick(Sender: TObject);
    procedure lblFoundBugsMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lblFoundBugsMouseLeave(Sender: TObject);
    procedure lblWhatIsTheGameAboutClick(Sender: TObject);
    procedure lblBackgroundColourClick(Sender: TObject);
    procedure lblGameMeaningClick(Sender: TObject);
    procedure lblPointsEarnedClick(Sender: TObject);
    procedure lblBackgroundColourMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lblBackgroundColourMouseLeave(Sender: TObject);
    procedure lblPointsEarnedMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lblPointsEarnedMouseLeave(Sender: TObject);
    procedure lblGameMeaningMouseLeave(Sender: TObject);
    procedure lblGameMeaningMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lblWhatIsTheGameAboutMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure lblWhatIsTheGameAboutMouseLeave(Sender: TObject);
    procedure ApplicationEvents1ActionExecute(Action: TBasicAction;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Help: THelp;

implementation

{$R *.dfm}

procedure THelp.lblWhatIsTheGameAboutClick(Sender: TObject);
begin
  redHelpText.Clear;
  redHelpText.lines.LoadFromFile
    (GetCurrentDir + '/Help/Whatisthegameabout.rtf');
end;

procedure THelp.lblWhatIsTheGameAboutMouseLeave(Sender: TObject);
begin
  lblWhatIsTheGameAbout.Font.Style := [];
end;

procedure THelp.lblWhatIsTheGameAboutMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblWhatIsTheGameAbout.Font.Style := [fsUnderline];
end;

procedure THelp.ApplicationEvents1ActionExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
ApplicationEvents1.OnIdle := nil;
HideCaret(redHelpText.Handle);
redHelpText.ReadOnly := true;
end;

procedure THelp.lblBackgroundColourClick(Sender: TObject);
begin
  redHelpText.Clear;
  redHelpText.lines.LoadFromFile(GetCurrentDir + '/Help/BGColour.rtf');
end;

procedure THelp.lblBackgroundColourMouseLeave(Sender: TObject);
begin
  lblBackgroundColour.Font.Style := [];
end;

procedure THelp.lblBackgroundColourMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblBackgroundColour.Font.Style := [fsUnderline];
end;

procedure THelp.lblFoundBugsClick(Sender: TObject);
begin
  redHelpText.Clear;
  redHelpText.lines.LoadFromFile(GetCurrentDir + '/Help/FoundABug.rtf');
end;

procedure THelp.lblFoundBugsMouseLeave(Sender: TObject);
begin
  lblFoundBugs.Font.Style := [];
end;

procedure THelp.lblFoundBugsMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  lblFoundBugs.Font.Style := [fsUnderline];
end;

procedure THelp.lblGameMeaningClick(Sender: TObject);
begin
  redHelpText.Clear;
  redHelpText.lines.LoadFromFile(GetCurrentDir + '/Help/PointOfGame.rtf');
end;

procedure THelp.lblGameMeaningMouseLeave(Sender: TObject);
begin
  lblGameMeaning.Font.Style := [];
end;

procedure THelp.lblGameMeaningMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  lblGameMeaning.Font.Style := [fsUnderline];
end;

procedure THelp.lblPointsEarnedClick(Sender: TObject);
begin
  redHelpText.Clear;
  redHelpText.lines.LoadFromFile(GetCurrentDir + '/Help/PointsBeingEarned.rtf');
end;

procedure THelp.lblPointsEarnedMouseLeave(Sender: TObject);
begin
  lblPointsEarned.Font.Style := [];
end;

procedure THelp.lblPointsEarnedMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  lblPointsEarned.Font.Style := [fsUnderline];
end;

end.
