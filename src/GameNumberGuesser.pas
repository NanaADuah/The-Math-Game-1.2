unit GameNumberGuesser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, pngimage, Menus, ScreenTips;

type
  TGuessGame = class(TForm)
    redDisplay: TRichEdit;
    Panel1: TPanel;
    btnNext: TBitBtn;
    btnAnswer: TBitBtn;
    btnHelp: TBitBtn;
    btnPlay: TButton;
    rgpGroup: TRadioGroup;
    Label1: TLabel;
    lblScore: TLabel;
    pnlTime: TPanel;
    Timer1: TTimer;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Settings1: TMenuItem;
    About1: TMenuItem;
    ViewHelp1: TMenuItem;
    N1: TMenuItem;
    AboutMathGame1: TMenuItem;
    pnlPaused: TPanel;
    btnPaused: TButton;
    tmrPauseFlicker: TTimer;
    btnResume: TBitBtn;
    BackgroundColour1: TMenuItem;
    ResetButton1: TMenuItem;
    Debug1: TMenuItem;
    Timer2: TTimer;
    Timer3: TTimer;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnAnswerClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnPausedClick(Sender: TObject);
    procedure btnResumeClick(Sender: TObject);
    procedure tmrPauseFlickerTimer(Sender: TObject);
    procedure AboutMathGame1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure ViewHelp1Click(Sender: TObject);
    procedure BackgroundColour1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResetButton1Click(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
  private
    { Private declarations }
    iStartUp: integer;
  public
    iNumLevel: integer;
    PlayedGame, HighScoreWorthy: Boolean;
    iValidate: integer; { validate answer button }
    iNQ: integer; { next question }
    iCounter: integer; { Counter for ResetButton failure, limited to 3 }

    { Public declarations }
  end;

var
  GuessGame: TGuessGame;

implementation

uses NumberGuesser, ABOUT, HelpSection, BGColour;
{$R *.dfm}

procedure TGuessGame.AboutMathGame1Click(Sender: TObject);
begin
  if iStartUp = 1 then
  begin
    btnPaused.OnClick(self);
  end;
  AboutBox.ShowModal;
end;

procedure TGuessGame.BackgroundColour1Click(Sender: TObject);
begin
  BGColor.ShowModal;
end;

procedure TGuessGame.btnAnswerClick(Sender: TObject);
var
  iAnswer: string;
begin
  try
    iAnswer := (InputBox('Answer', 'What''s the answer?', ''));
    if iAnswer = '' then
    begin
      if Count <> 0 then
        redDisplay.Lines.Add('No answer? :-(')
      else
        exit;
    end
    else

      except
        begin
          if Count <> 0 then
          begin
            redDisplay.SelAttributes.Color := clred;
            redDisplay.Lines.Add(
              'Oops, seems like you entered invalid text, please try again.');
            UpdateScore;
          end
          else
            exit;
        end;
      end;
    if not(pnlTime.Caption = '0') then

      CheckAnswer(strtoint(iAnswer), redDisplay);
  end;

  procedure TGuessGame.btnHelpClick(Sender: TObject);
  begin
    Help.ShowModal;
  end;

  procedure TGuessGame.btnNextClick(Sender: TObject);
  begin
    redDisplay.Clear;
    redDisplay.SelAttributes.Size := 14;
    redDisplay.SelAttributes.Style := [fsUnderline];
    redDisplay.Lines.Add('Easy math');
    iValidate := 0;

    Timer1.Enabled := true;
    btnPlay.OnClick(self);

  end;

  procedure TGuessGame.btnPausedClick(Sender: TObject);
  begin
    iStartUp := 0;
    pnlPaused.Visible := true;
    tmrPauseFlicker.Enabled := true;

    if btnNext.Enabled = true then
      iNQ := 1
    else
      iNQ := 0;

    btnNext.Enabled := false

      ;
    Timer1.Enabled := false;
    pnlTime.Caption := 'Game is paused';
    { if iValidate = 1  then
      btnAnswer.Enabled := true
      else }
    btnAnswer.Enabled := false;
    with btnPaused do
    begin
      Enabled := false;
      Visible := false;
    end;

    pnlPaused.Visible := true;

    with btnResume do
    begin
      Enabled := true;
      Visible := true;
    end;

  end;

  procedure TGuessGame.btnPlayClick(Sender: TObject);
  var
    iNum: integer;
    sQuestion: string;

  begin
    iStartUp := 1;
    UpdateScore;
    Count := 11;
    case rgpGroup.ItemIndex of
      0:
        iNumLevel := 5;
      1:
        iNumLevel := 15;
    end;

    with ResetButton1 do
    begin
      Visible := true;
      Enabled := true;
    end;

    btnPlay.Visible := false;

    with btnResume do
    begin

      Caption := 'Resume';
    end;

    with pnlTime do
    begin
      Visible := true;
      Caption := '';
    end;
    with lblScore do
    begin
      UpdateScore;
      Visible := true;
      // Caption := 'Score: 0';
    end;

    with btnPaused do
    begin
      Visible := true;
      Enabled := true;
      Caption := 'Pause'
    end;

    with btnNext do
    begin
      Visible := true;
      Enabled := false;
      Caption := 'Next question';
    end; { btnNext }
    with btnHelp do
    begin
      Visible := true;
      Enabled := true;
      Caption := 'Help';
    end; { btnHelp }
    with btnAnswer do
    begin
      Visible := true;
      Enabled := true;
      Caption := 'Answer';
    end; { btnAnswer }

    with rgpGroup do
    begin
      Visible := true;
    end; { rgpGroup }

    iNum := NumberGenerator(iNumLevel);

    sQuestion := QuestionGenerator(iNum); // NumberGenerator(iNumLevel));
    CurrentAnswer := iNum;
    redDisplay.Lines.Add(sQuestion);
    // Label1.Caption := (IntToStr(CurrentAnswer));
    // CountDown(redDisplay,pnlTime);
    PlayedGame := true;
    Timer1.Enabled := true;
  end;

  procedure TGuessGame.btnResumeClick(Sender: TObject);
  begin
    if iValidate = 1 then
      btnAnswer.Enabled := false;
    with btnResume do
    begin
      Enabled := false;
      Visible := false;

      if iNQ = 1 then
        btnNext.Enabled := true
      else
        btnNext.Enabled := false;

    end;
    with btnPaused do
    begin
      Enabled := true;
      Caption := 'Pause';
      Visible := true;

    end;

    with pnlPaused do
    begin
      Visible := false;
    end;

    tmrPauseFlicker.Enabled := false;
    if iOut = 1 then
    begin
      Timer1.Enabled := false;
      btnAnswer.Enabled := false;
      pnlTime.Caption := 'Game resumed...';
    end
    else
    begin
      Timer1.Enabled := true;

      btnAnswer.Enabled := true;
    end;
  end;

  procedure TGuessGame.Button1Click(Sender: TObject);
  begin
  end;

  { //--//--//--//--//--//--//--//--//--//--     btnLetsPlay }

  procedure TGuessGame.FormActivate(Sender: TObject);
  begin
    iStartUp := 0;
  end;

  procedure TGuessGame.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  var
    sName: string;
    iScore: integer;
  begin
    if Score = 0 then
      PlayedGame := false;
    Timer1.Enabled := false;
    if CheckWorthiness(Score) = true then
      HighScoreWorthy := true;
    if (PlayedGame and HighScoreWorthy) = true then
    begin
      sName := InputBox('Score', 'Please enter your name:', '');
      iScore := Score;
      EnterScore(sName, iScore);
    end;
  end;

  procedure TGuessGame.FormCreate(Sender: TObject);
  begin
    Randomize;
  end;

  procedure TGuessGame.FormShow(Sender: TObject);
  begin
    CreateADirectory;
    Score := 0;
    iOut := 0;
    PlayedGame := false;
    lblScore.Visible := false;
    Label1.Visible := false;
    pnlTime.Visible := false;
    btnHelp.Visible := false;
    btnNext.Visible := false;
    btnAnswer.Visible := false;
    redDisplay.ReadOnly := true;
    rgpGroup.Visible := false; ;
    btnPlay.SetFocus;
    redDisplay.Clear;
    redDisplay.SelAttributes.Size := 14;
    redDisplay.SelAttributes.Style := [fsUnderline];
    redDisplay.Lines.Add('Easy math');
  end;

  procedure TGuessGame.ResetButton1Click(Sender: TObject);
  begin

    btnPlay.OnClick(self);
    btnNext.OnClick(self);
    btnPaused.Enabled := true;
    btnResume.Enabled := false;
    btnResume.Visible := false;

    Inc(iCounter);

    pnlTime.Caption := 'Buttons reset: [02]';
  end;

  procedure TGuessGame.Settings1Click(Sender: TObject);
  begin
    if iCounter = 2 then
      ResetButton1.Enabled := false;

  end;

  procedure TGuessGame.Stop1Click(Sender: TObject);
begin
btnNext.Enabled := false;
btnAnswer.Enabled := false;
btnResume.Enabled := false;

end;

procedure TGuessGame.Timer1Timer(Sender: TObject);
  begin
    CountDown(redDisplay, pnlTime);

    if pnlTime.Caption = '7' then
      btnPaused.Enabled := false;

    if pnlTime.Caption = '0' then
      btnPaused.Enabled := true;
  end;

  procedure TGuessGame.Timer2Timer(Sender: TObject);
begin
if (btnNext.Enabled=false) AND (btnPaused.Enabled=false) AND (btnAnswer.Enabled = false) AND (btnResume.Enabled= false) then
begin
Timer3.Enabled := true;
//Label2.Alignment :=
  Label2.Caption := 'Bug[01] : Reset button in Settings -> Debug -> "Reset Buttons" menu';
end;
end;

procedure TGuessGame.Timer3Timer(Sender: TObject);
begin
Timer2.Enabled := false;
Label2.Caption := '';
Timer3.Enabled := false;
end;

procedure TGuessGame.tmrPauseFlickerTimer(Sender: TObject);
  begin

    with pnlPaused do
    begin
      if ShowCaption = true then
        ShowCaption := false
      else if ShowCaption = false then

        ShowCaption := true;
    end;

  end;

  procedure TGuessGame.ViewHelp1Click(Sender: TObject);
  begin
    btnHelp.OnClick(self);
  end;

end.
