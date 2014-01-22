{ ==============================================================================|
  | Project : Ararat Synapse                                       | 001.002.001 |
  |==============================================================================|
  | Content: IP address support procedures and functions                         |
  |==============================================================================|
  | Copyright (c)2006-2010, Lukas Gebauer                                        |
  | All rights reserved.                                                         |
  |                                                                              |
  | Redistribution and use in source and binary forms, with or without           |
  | modification, are permitted provided that the following conditions are met:  |
  |                                                                              |
  | Redistributions of source code must retain the above copyright notice, this  |
  | list of conditions and the following disclaimer.                             |
  |                                                                              |
  | Redistributions in binary form must reproduce the above copyright notice,    |
  | this list of conditions and the following disclaimer in the documentation    |
  | and/or other materials provided with the distribution.                       |
  |                                                                              |
  | Neither the name of Lukas Gebauer nor the names of its contributors may      |
  | be used to endorse or promote products derived from this software without    |
  | specific prior written permission.                                           |
  |                                                                              |
  | THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  |
  | AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    |
  | IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   |
  | ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR  |
  | ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL       |
  | DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR   |
  | SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER   |
  | CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT           |
  | LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    |
  | OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH  |
  | DAMAGE.                                                                      |
  |==============================================================================|
  | The Initial Developer of the Original Code is Lukas Gebauer (Czech Republic).|
  | Portions created by Lukas Gebauer are Copyright (c) 2006-2010.               |
  | All Rights Reserved.                                                         |
  |==============================================================================|
  | Contributor(s):                                                              |
  |==============================================================================|
  | History: see HISTORY.HTM from distribution package                           |
  |          (Found at URL: http://www.ararat.cz/synapse/)                       |
  |============================================================================== }

{ :@abstract(IP adress support procedures and functions) }

{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}
{$Q-}
{$R-}
{$H+}
//{$IFDEF UNICODE}
//{$WARN IMPLICIT_STRING_CAST OFF}
//{$WARN IMPLICIT_STRING_CAST_LOSS OFF}
//{$WARN SUSPICIOUS_TYPECAST OFF}
//{$ENDIF}

Unit SynaIP;

Interface

Uses
  SysUtils;

Type
  TIp6Bytes = Array [0 .. 15] Of Byte;
  TIp6Words = Array [0 .. 7] Of Word;

Function StrToIp6(Value: String): TIp6Bytes;
Function Ip6ToStr(Value: TIp6Bytes): String;
Function StrToIp(Value: String): integer;
Function IpToStr(Value: integer): String;
Function ReverseIP(Value: Ansistring): Ansistring;
Function ReverseIP6(Value: Ansistring): Ansistring;
Function ExpandIP6(Value: Ansistring): Ansistring;

Function CountOfChar(Const Value: String; Chr: char): integer;
Function ReplaceString(Value, Search, Replace: Ansistring): Ansistring;
Function TrimSPLeft(Const s: String): String;
Function TrimSP(Const s: String): String;
Function TrimSPRight(Const s: String): String;
Function SeparateLeft(Const Value, Delimiter: String): String;
Function SeparateRight(Const Value, Delimiter: String): String;
Function FetchBin(Var Value: String; Const Delimiter: String): String;
Function Fetch(Var Value: String; Const Delimiter: String): String;

Implementation

Function StrToIp(Value: String): integer;
Var
  s: String;
  i, x: integer;
Begin
  Result := 0;
  For x := 0 To 3 Do
  Begin
    s := Fetch(Value, '.');
    i := StrToIntDef(s, 0);
    Result := (256 * Result) + i;
  End;
End;

Function IpToStr(Value: integer): String;
Var
  x1, x2: Word;
  y1, y2: Byte;
Begin
  Result := '';
  x1 := Value Shr 16;
  x2 := Value And $FFFF;
  y1 := x1 Div $100;
  y2 := x1 Mod $100;
  Result := inttostr(y1) + '.' + inttostr(y2) + '.';
  y1 := x2 Div $100;
  y2 := x2 Mod $100;
  Result := Result + inttostr(y1) + '.' + inttostr(y2);
End;

Function ExpandIP6(Value: Ansistring): Ansistring;
Var
  n: integer;
  s: Ansistring;
  x: integer;
Begin
  Result := '';
  If Value = '' Then
    Exit;
  x := CountOfChar(Value, ':');
  If x > 7 Then
    Exit;
  If Value[1] = ':' Then
    Value := '0' + Value;
  If Value[length(Value)] = ':' Then
    Value := Value + '0';
  x := 8 - x;
  s := '';
  For n := 1 To x Do
    s := s + ':0';
  s := s + ':';
  Result := ReplaceString(Value, '::', s);
End;

Function StrToIp6(Value: String): TIp6Bytes;
Var
  IPv6: TIp6Words;
  Index: integer;
  n: integer;
  b1, b2: Byte;
  s: String;
  x: integer;
Begin
  For n := 0 To 15 Do
    Result[n] := 0;
  For n := 0 To 7 Do
    IPv6[n] := 0;
  Index := 0;
  Value := ExpandIP6(Value);
  If Value = '' Then
    Exit;
  While Value <> '' Do
  Begin
    If Index > 7 Then
      Exit;
    s := Fetch(Value, ':');
    If s = '@' Then
      Break;
    If s = '' Then
    Begin
      IPv6[Index] := 0;
    End
    Else
    Begin
      x := StrToIntDef('$' + s, -1);
      If (x > 65535) Or (x < 0) Then
        Exit;
      IPv6[Index] := x;
    End;
    Inc(Index);
  End;
  For n := 0 To 7 Do
  Begin
    b1 := IPv6[n] Div 256;
    b2 := IPv6[n] Mod 256;
    Result[n * 2] := b1;
    Result[(n * 2) + 1] := b2;
  End;
End;

Function Ip6ToStr(Value: TIp6Bytes): String;
Var
  i, x: Byte;
  zr1, zr2: Set Of Byte;
  zc1, zc2: Byte;
  have_skipped: Boolean;
  ip6w: TIp6Words;
Begin
  zr1 := [];
  zr2 := [];
  zc1 := 0;
  zc2 := 0;
  For i := 0 To 7 Do
  Begin
    x := i * 2;
    ip6w[i] := Value[x] * 256 + Value[x + 1];
    If ip6w[i] = 0 Then
    Begin
      include(zr2, i);
      Inc(zc2);
    End
    Else
    Begin
      If zc1 < zc2 Then
      Begin
        zc1 := zc2;
        zr1 := zr2;
        zc2 := 0;
        zr2 := [];
      End;
    End;
  End;
  If zc1 < zc2 Then
  Begin
    zr1 := zr2;
  End;
  SetLength(Result, 8 * 5 - 1);
  SetLength(Result, 0);
  have_skipped := False;
  For i := 0 To 7 Do
  Begin
    If Not(i In zr1) Then
    Begin
      If have_skipped Then
      Begin
        If Result = '' Then
          Result := '::'
        Else
          Result := Result + ':';
        have_skipped := False;
      End;
      Result := Result + IntToHex(ip6w[i], 1) + ':';
    End
    Else
    Begin
      have_skipped := True;
    End;
  End;
  If have_skipped Then
    If Result = '' Then
      Result := '::0'
    Else
      Result := Result + ':';

  If Result = '' Then
    Result := '::0';
  If Not(7 In zr1) Then
    SetLength(Result, length(Result) - 1);
  Result := LowerCase(Result);
End;

Function ReverseIP(Value: Ansistring): Ansistring;
Var
  x: integer;
Begin
  Result := '';
  Repeat
    x := LastDelimiter('.', Value);
    Result := Result + '.' + Copy(Value, x + 1, length(Value) - x);
    Delete(Value, x, length(Value) - x + 1);
  Until x < 1;
  If length(Result) > 0 Then
    If Result[1] = '.' Then
      Delete(Result, 1, 1);
End;

Function ReverseIP6(Value: Ansistring): Ansistring;
Var
  ip6: TIp6Bytes;
  n: integer;
  x, y: integer;
Begin
  ip6 := StrToIp6(Value);
  x := ip6[15] Div 16;
  y := ip6[15] Mod 16;
  Result := IntToHex(y, 1) + '.' + IntToHex(x, 1);
  For n := 14 Downto 0 Do
  Begin
    x := ip6[n] Div 16;
    y := ip6[n] Mod 16;
    Result := Result + '.' + IntToHex(y, 1) + '.' + IntToHex(x, 1);
  End;
End;

Function CountOfChar(Const Value: String; Chr: char): integer;
Var
  n: integer;
Begin
  Result := 0;
  For n := 1 To length(Value) Do
    If Value[n] = Chr Then
      Inc(Result);
End;

Function ReplaceString(Value, Search, Replace: Ansistring): Ansistring;
Var
  x, l, ls, lr: integer;
Begin
  If (Value = '') Or (Search = '') Then
  Begin
    Result := Value;
    Exit;
  End;
  ls := length(Search);
  lr := length(Replace);
  Result := '';
  x := Pos(Search, Value);
  While x > 0 Do
  Begin
{$IFNDEF CIL}
    l := length(Result);
    SetLength(Result, l + x - 1);
    Move(Pointer(Value)^, Pointer(@Result[l + 1])^, x - 1);
{$ELSE}
    Result := Result + Copy(Value, 1, x - 1);
{$ENDIF}
{$IFNDEF CIL}
    l := length(Result);
    SetLength(Result, l + lr);
    Move(Pointer(Replace)^, Pointer(@Result[l + 1])^, lr);
{$ELSE}
    Result := Result + Replace;
{$ENDIF}
    Delete(Value, 1, x - 1 + ls);
    x := Pos(Search, Value);
  End;
  Result := Result + Value;
End;

Function TrimSPLeft(Const s: String): String;
Var
  i, l: integer;
Begin
  Result := '';
  If s = '' Then
    Exit;
  l := length(s);
  i := 1;
  While (i <= l) And (s[i] = ' ') Do
    Inc(i);
  Result := Copy(s, i, Maxint);
End;

Function TrimSPRight(Const s: String): String;
Var
  i: integer;
Begin
  Result := '';
  If s = '' Then
    Exit;
  i := length(s);
  While (i > 0) And (s[i] = ' ') Do
    Dec(i);
  Result := Copy(s, 1, i);
End;

Function TrimSP(Const s: String): String;
Begin
  Result := TrimSPLeft(s);
  Result := TrimSPRight(Result);
End;

Function SeparateLeft(Const Value, Delimiter: String): String;
Var
  x: integer;
Begin
  x := Pos(Delimiter, Value);
  If x < 1 Then
    Result := Value
  Else
    Result := Copy(Value, 1, x - 1);
End;

Function SeparateRight(Const Value, Delimiter: String): String;
Var
  x: integer;
Begin
  x := Pos(Delimiter, Value);
  If x > 0 Then
    x := x + length(Delimiter) - 1;
  Result := Copy(Value, x + 1, length(Value) - x);
End;

Function FetchBin(Var Value: String; Const Delimiter: String): String;
Var
  s: String;
Begin
  Result := SeparateLeft(Value, Delimiter);
  s := SeparateRight(Value, Delimiter);
  If s = Value Then
    Value := ''
  Else
    Value := s;
End;

Function Fetch(Var Value: String; Const Delimiter: String): String;
Begin
  Result := FetchBin(Value, Delimiter);
  Result := TrimSP(Result);
  Value := TrimSP(Value);
End;

End.
