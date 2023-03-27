program Game;

uses
  Forms,
  GameNumberGuesser in 'GameNumberGuesser.pas' {GuessGame},
  NumberGuesser in 'NumberGuesser.pas',
  ABOUT in 'ABOUT.pas' {AboutBox},
  HelpSection in 'HelpSection.pas' {Help},
  BGColour in 'BGColour.pas' {BGColor};

{$E .exe}

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Game Guesser';
  Application.CreateForm(TGuessGame, GuessGame);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(THelp, Help);
  Application.CreateForm(TBGColor, BGColor);
  Application.Run;
end.
