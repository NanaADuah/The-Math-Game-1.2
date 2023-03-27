unit NumberGuesser;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Math;

const
  HIGHSCOREMAX = 10;

function NumberGenerator(iLevel: integer): integer;
function QuestionGenerator(iNumber: integer): string;
function CheckAnswer(iAnswer: integer; Output: TRichEdit): string;
function RealMod(x, y: extended): extended;
procedure CountDown(Otheroutput: TRichEdit; Output: TPanel);
procedure UpdateScore;
procedure CreateADirectory;
procedure EnterScore(Name: string; Score: integer);
function CheckWorthiness(iScore: integer): boolean;
procedure SortArray();

var
  QuestionNumber: integer;
  CurrentAnswer: integer;
  AnswerIsCorrect: boolean;
  arrHScore: array [1 .. HIGHSCOREMAX] of string;
  Score: integer;
  Count: integer;
  iOut: integer;

implementation

uses GameNumberGuesser;

// ##############################################################################
procedure SortArray();
var
  i, j, h, icCOUNTER: integer;
  arr, iScoreKeep, iChange: array of integer;
  sKeep: string;
  f: integer;
  SF: Textfile;
  sLocal: string;
begin
  for i := 1 to 10 do
    if arrHScore[i] = '' then
      Dec(icCOUNTER);

  for j := 1 to icCOUNTER - 1 do
    for h := 2 to icCOUNTER do
      if arrHScore[j] > arrHScore[h] then
      begin
        sKeep := arrHScore[h];
        arrHScore[h] := arrHScore[j];
        arrHScore[h] := sKeep;

      end;
  begin
    sLocal := GetCurrentDir + '\Highscores\Highscores.txt';

    assignfile(SF, { 'C:\321 Applications\Highscores\Highscores.txt' } sLocal);
    Rewrite(SF);
    for f := 1 to icCOUNTER do
    begin
      Writeln(arrHScore[f]);
    end;
    closefile(SF);
  end; { writing }
end;

// ##############################################################################
function CheckWorthiness(iScore: integer): boolean;
const
  HIGHT = 5;
var
  i, iPos, ccCounter: integer;
  TFIle: Textfile;
  sTemp: string;
  iLength, j: integer;
  k: integer;
  Measurement: integer;
begin
  Measurement := 10;
  if FileExists('C:\321 Applications\Highscores\Highscores.txt') then
    assignfile(TFIle, 'C:\321 Applications\Highscores\Highscores.txt')
  else
  begin
    CreateADirectory;
    Exit;
  end;

  try
    Reset(TFIle);
    begin
      for i := 1 to HIGHSCOREMAX do
        Readln(TFIle, arrHScore[i]);
      with GuessGame do
        for i := 1 to 10 do
          redDisplay.Lines.Add(arrHScore[i]);
    end;
  finally
    closefile(TFIle);
  end;

  for k := 1 to 10 do
    if arrHScore[k] = '' then
      Dec(Measurement);

  if Measurement < 10 then
  begin
    with GuessGame do
      HighScoreWorthy := true;
  end;

  for j := 1 to Measurement do
  begin
    iPos := Pos(',', arrHScore[j]);
    iLength := Length(arrHScore[j]);
    sTemp := Copy(arrHScore[j], iPos + 1, iLength);
    if StrToInt(sTemp) > iScore then
      Inc(ccCounter);

  end;

  if ccCounter > 2 then
    with GuessGame do
      HighScoreWorthy := true;
end;

// ##############################################################################
procedure EnterScore(Name: string; Score: integer);
var
  SFile: Textfile;
begin
  if FileExists(GetCurrentDir + '\Highscores\Highscores.txt') then
    assignfile(SFile, GetCurrentDir + '\Highscores\Highscores.txt')
  else
  begin
    CreateADirectory;
    Exit;
  end;
  try
    Append(SFile);
    begin
      Writeln(SFile, #13 + Name + ',' + IntToStr(Score));
    end;
  finally
    closefile(SFile);
  end;
end;

// ##############################################################################
procedure CreateADirectory;
var
  C: string;
begin
  C := GetCurrentDir;

  if DirectoryExists(GetCurrentDir + '\Highscores') then
  begin
    if FileExists(GetCurrentDir + '\Highscores\Highscores.txt') then
      Exit;

  end
  else
  begin
    try
      if CreateDir(GetCurrentDir + '\Highscores') then
        FileCreate(GetCurrentDir + '\Highscores\HighScores.txt');
    except
      Exit;
    end;
  end;

end;

// ##############################################################################
procedure CountDown(Otheroutput: TRichEdit; Output: TPanel);
var
  i: integer;
begin
  // Count := 10;
  Dec(Count);
  Output.Caption := IntToStr(Count);
  if Count = 0 then
  begin
    AnswerIsCorrect := false;
    Otheroutput.SelAttributes.Color := clSilver;
    iOut := 1;
    Otheroutput.Lines.Add('Time''s up! Answer was: ' + IntToStr(CurrentAnswer)
        + '. Click next to continue');
    with GuessGame do
    begin
      iValidate := 1;
      btnAnswer.Enabled := false;
      btnNext.Enabled := true;
      Timer1.Enabled := false;
    end;
  end;
  if Count = 0 then
  begin
    if Score = 0 then
      Score := 0
    else if Score = -1 then
      Score := 0
    else if Score <= 0 then
      Score := 0
    else
      Dec(Score, 2);
    UpdateScore;
  end; { count }
end;

// ##############################################################################
procedure UpdateScore;
begin
  with GuessGame do
    lblScore.Caption := 'Score: ' + IntToStr(Score);
end;

// ##############################################################################
function RealMod(x, y: extended): extended;
begin
  Result := x - y * Trunc(x / y);
end;

// ##############################################################################
function CheckAnswer(iAnswer: integer; Output: TRichEdit): string;
begin
  if iAnswer = CurrentAnswer then
  begin
    Output.SelAttributes.Color := clGreen;
    Result := ':-) You got the correct answer!' + '(Your answer: "' + IntToStr
      (iAnswer) + '")';
    AnswerIsCorrect := true;

    Count := 10;
    Output.Lines.Add(Result);
    Output.SelAttributes.Color := clblue;
    with GuessGame do
    begin
      Timer1.Enabled := false;
      pnlTime.Caption := 'Correct!!';
    end;
    Inc(Score, 4);
    UpdateScore;
    Output.Lines.Add('Click next to continue...');
    with GuessGame do
    begin
      UpdateScore;
      PlayedGame := true;
      btnAnswer.Enabled := false;
      btnNext.Enabled := true;
      btnNext.Visible := true;
    end; { GuessGame }
  end
  else if (iAnswer <> CurrentAnswer) then
  begin
    Output.SelAttributes.Color := clMaroon;
    Result :=
      'Uh oh, that answer isn''t right, please try again.' +
      '(Your Answer: "' + IntToStr(iAnswer) + '")';
    Score := Score - 1;
    UpdateScore;
    AnswerIsCorrect := false;
    Output.Lines.Add(Result);
  end
  else if (iAnswer = StrToInt('')) then
  begin
    Output.SelAttributes.Color := clMaroon;
    Result := 'No answer? Please enter a number';
    AnswerIsCorrect := false;
    Output.Lines.Add(Result);
  end;

end;

// ##############################################################################
function NumberGenerator(iLevel: integer): integer;
var
  i, iNumberG: integer;
begin
  iNumberG := 0;
  case iLevel of
    1 .. 10:
      begin
        for i := 1 to 1000 do
          Result := Random(1000) + 1;
      end; { 1..10 }
    11 .. 20:
      begin
        for i := 1 to 1500 do
          Result := Random(2500) + 1;
      end; { 11..20 }
  end; { case statement }

end;

// ##############################################################################
function QuestionGenerator(iNumber: integer): string;
var
  NumberQuestion, iNumberTester: integer;
  RnQIndex: integer;
  SubT: integer;
  iNTester: real;
  OtherTester: integer;
  Two: extended;
begin
  iNTester := iNumber;
  RnQIndex := RandomRange(1, 5);

  case RnQIndex of
    1:
      begin
        iNTester := RealMod(iNTester, 2);
        if iNTester = 0 then
        begin
          iNumberTester := iNumber div 2;
          Result := 'Half of this number is ' + IntToStr(iNumberTester)
            + ', what is the number?'
        end
        else if RealMod(iNTester, 2) = 0 then
        begin
          if iNumber > 300 then
            SubT := RandomRange(3, 300);
          iNumberTester := iNumber - SubT;
          Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
            + ', what is the number?'
        end
        else { inumber }
        begin
          SubT := RandomRange(1, 50);
          iNumberTester := iNumber - SubT;
          Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
            + ', what is the number?'
        end; { else iNumber }

      end; { 1 }
    2:
      begin
        iNTester := RealMod(iNTester, 2);
        if iNTester = 0 then
        begin
          iNumberTester := iNumber div 2;
          Result := 'Half of this number is ' + IntToStr(iNumberTester)
            + ', what is the number?'
        end
        else if RealMod(iNTester, 2) = 0 then
        begin
          if iNumber > 300 then
            SubT := RandomRange(3, 300);
          iNumberTester := iNumber - SubT;
          Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
            + ', what is the number?'
        end
        else { inumber }
        begin
          SubT := RandomRange(1, 50);
          iNumberTester := iNumber - SubT;
          Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
            + ', what is the number?'
        end;
      end; { 2 }
    3:
      begin
        iNTester := RealMod(iNTester, 2);
        if iNTester = 0 then
        begin
          iNumberTester := iNumber div 2;
          Result := 'Half of this number is ' + IntToStr(iNumberTester)
            + ', what is the number?'
        end
        else if RealMod(iNTester, 2) = 0 then
        begin
          if iNumber > 300 then
            SubT := RandomRange(3, 300);
          iNumberTester := iNumber - SubT;
          Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
            + ', what is the number?'
        end
        else { inumber }
        begin
          SubT := RandomRange(1, 50);
          iNTester := RealMod(iNTester, 2);
          if iNTester = 0 then
            Result := 'Half of this number is ' + FloatToStr(iNTester)
              + ', what is the number?'
          else if RealMod(iNTester, 2) = 0 then
          begin
            if iNumber > 300 then
              SubT := RandomRange(3, 300);
            iNumberTester := iNumber - SubT;
            Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
              + ', what is the number?'
          end
          else { inumber }
          begin
            SubT := RandomRange(1, 50);
            iNumberTester := iNumber - SubT;
            Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
              + ', what is the number?'
          end;
        end;
      end; { 3 }
    4:
      begin
        iNTester := RealMod(iNTester, 2);
        if iNTester = 0 then
        begin
          iNumberTester := iNumber div 2;
          Result := IntToStr(iNumberTester) + '× 2 = ?, what is the number?'
        end
        else if RealMod(iNTester, 2) = 0 then
        begin
          if iNumber > 300 then
            SubT := RandomRange(3, 300);
          iNumberTester := iNumber - SubT;
          Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
            + ', what is the number?'
        end
        else { inumber }
        begin
          SubT := RandomRange(1, 50);
          iNTester := RealMod(iNTester, 2);
          if iNTester = 0 then
          begin
            iNTester := iNumber div 3;
            Result := FloatToStr(iNTester) + ' × 3 = ?, what is the number?'
          end
          else if RealMod(iNTester, 2) = 0 then
          begin
            if iNumber > 300 then
              SubT := RandomRange(3, 300);
            iNumberTester := iNumber - SubT;
            Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
              + ', what is the number?'
          end
          else { inumber }
          begin
            SubT := RandomRange(1, 50);
            iNumberTester := iNumber + SubT;
            Result := IntToStr(iNumberTester) + ' - ' + IntToStr(SubT)
              + ', what is the number?'
          end;
        end;
      end; { 4 }
    5:
      begin
        iNTester := RealMod(iNTester, 2);
        if iNTester = 0 then
        begin
          iNTester := iNumber div 3;
          Result := FloatToStr(iNTester) + ' × 3 = ?, what is the number?'
        end
        else if RealMod(iNTester, 2) = 0 then // if (iNTester mod 2) = 0 then
        begin
          if iNumber > 300 then
            SubT := RandomRange(3, 300);
          iNumberTester := iNumber - SubT;
          Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
            + ', what is the number?'
        end
        else { inumber }
        begin
          SubT := RandomRange(1, 50);
          iNTester := RealMod(iNTester, 2);
          if iNTester = 0 then
          begin
            iNTester := iNumber div 3;
            Result := FloatToStr(iNTester) + ' × 3 = ?, what is the number?'
          end
          else if RealMod(iNTester, 2) = 0 then
          begin
            if iNumber > 300 then
              SubT := RandomRange(3, 300);
            iNumberTester := iNumber - SubT;
            Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
              + ', what is the number?'
          end
          else { inumber }
          begin
            SubT := RandomRange(1, 50);
            iNumberTester := iNumber - SubT;
            Result := IntToStr(iNumberTester) + ' + ' + IntToStr(SubT)
              + ', what is the number?'
          end;
        end;
      end; { 5 }
  end; { case statement }

  if AnswerIsCorrect = true then
  begin
    with GuessGame.btnNext do
      Visible := true;
  end;

end;

end.
