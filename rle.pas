PROGRAM RLE;

PROCEDURE Compressing(inputname, outputname : STRING);
VAR
  inFile, outFile : TEXT;
  single_char, last_single_char, actual_count_char : CHAR;
  count_char : INTEGER;
BEGIN
  
  IF ParamCount > 0 THEN BEGIN
    (*$I-*)
    Assign(inFile, inputname);
    Reset(inFile);
    IF IOResult <> 0 THEN BEGIN
      WriteLn('ERROR');
      HALT;
    END;
    (*$I+*)
  END;

  // Initialize Counter
  count_char := 1;
  actual_count_char := ' ';

  // Initialize Output File
  Assign(outFile, outputname);
  Rewrite(outFile);

  WHILE NOT Eof(inFile) DO BEGIN
    Read(inFile, single_char);

    IF single_char = last_single_char THEN BEGIN
      
      actual_count_char := single_char;
      Inc(count_char);
    END ELSE BEGIN

      IF count_char > 2 THEN BEGIN
        Write(outFile, count_char);
        Write(outFile, single_char);

      END ELSE IF count_char = 1 THEN BEGIN
        Write(outFile, single_char);
      END;
      
      count_char := 1;
      actual_count_char := ' ';
    
    END;

    last_single_char := single_char;
  END;

  Close(outFile);
  Close(inFile);

END;


PROCEDURE Decompressing(inputname, outputname : STRING);
VAR
  inFile, outFile : TEXT;
  single_char, last_char_before_number : CHAR;
  char_number_str : STRING;
  char_number : INTEGER;
  char_counter : INTEGER;
BEGIN

  IF ParamCount > 0 THEN BEGIN
    (*$I-*)
    Assign(inFile, inputname);
    Reset(inFile);
    IF IOResult <> 0 THEN BEGIN
      WriteLn('ERROR');
      HALT;
    END;
    (*$I+*)

   // Initialize Output File
    Assign(outFile, outputname);
    Rewrite(outFile);

    char_number_str := '';
    last_char_before_number := ' ';

    WHILE NOT Eof(inFile) DO BEGIN
      Read(inFile, single_char);
      
      // If number
      IF (Ord(single_char) >= 48) AND (Ord(single_char) <= 57) THEN BEGIN
        char_number_str := char_number_str + single_char;
        
      END ELSE BEGIN
        
        IF Length(char_number_str) > 0 THEN BEGIN
          Val(char_number_str, char_number);
          
          char_counter := 1;

          WHILE char_counter < char_number DO BEGIN
            Write(outFile, last_char_before_number);
            Inc(char_counter);
          END;

          last_char_before_number := ' ';
          char_number_str := '';
          Write(outFile, single_char);
        END ELSE BEGIN
          Write(outFile, single_char);
        END;

        // Reset
        last_char_before_number := single_char;

      END;

    END;

    Close(outFile);
    Close(inFile);

  END;


END;

VAR
  input, output : STRING;
  actual_param : STRING;
BEGIN

IF paramCount <> 0 THEN BEGIN
  IF paramCount = 2 THEN BEGIN
    input := paramStr(1);
    output := paramStr(2);
    Compressing(input, output);
  END ELSE BEGIN
    actual_param := Copy(paramStr(1), 2, Length(paramStr(1)));

    input := paramStr(2);
    output := paramStr(3);
  END;

  IF (actual_param = 'c') OR (actual_param = 'C') THEN BEGIN
    Compressing(input, output);

  END ELSE 
  IF (actual_param = 'd') OR (actual_param = 'D') THEN BEGIN
    Decompressing(input, output);
  END;
END;

END.