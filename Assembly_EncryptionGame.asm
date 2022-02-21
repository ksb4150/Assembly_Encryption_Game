TITLE ASSEMBLY TEAM PROJECT
INCLUDE Irvine32.inc
INCLUDE macros.inc

.data
; main data
buffer BYTE 300 DUP(0)
Input DWORD ?
Sentence BYTE ?

; quiz 1 data
; caesar
yesol BYTE 55 DUP(0)
random_num DWORD ? ; 암호화 방식 (1~3)
compare_num DWORD ?
secret BYTE 55 DUP(0) ; 공용임ㅋ

; quiz 2 data
arry1 BYTE "works out just as wanted",0
arry2 BYTE "time is gold",0
arry3 BYTE "there are too many assignments",0
arry4 BYTE "it is better late than never",0
arry5 BYTE "you create your opportunities by asking for them",0
randVal1 DWORD ?   ; 랜덤으로 배열을 선택하기 위한 변수
randVal2 DWORD ?   ; 랜덤으로 암호화를 선택하기 위한 변수
buffer2 BYTE 55 DUP(0)   ; 입력받은 문장과 평문 비교를 위한 변수

.code
main PROC
   call Crlf
   mWrite<" =====================Game Start=====================",0ah>
   invoke Sleep,300h
   call Clrscr

   call Crlf
   mWrite<" ========================PRECAUTIONS========================",0ah>
   mWrite<" =                                                         =",0ah>
   mWrite<" = NO.1 '#' is a space writer.                             =",0ah>
   mWrite<" = NO.2 You can't write capital letters.                   =",0ah>
   mWrite<" = NO.3 Don't choose without thinking                      =",0ah>
   mWrite<" =                                                         =",0ah>
   mWrite<" ===========================================================",0ah>
   
   invoke Sleep, 1000h
   call Clrscr

   call Crlf
   mWrite<" Choice the Quiz Number",0ah>
   call Crlf
   mWrite<"1. Quiz     2. Quiz2     3. Exit",0ah>
   call Crlf
   mWrite<"Input the number : ">

   call ReadInt
   mov Input, eax
   invoke Sleep,300h
   call Clrscr 

   .IF input == 1
   call Quiz_one
   .ELSEIF input == 2
   call Quiz_two
   .ELSEIF input == 3
   exit
   .ENDIF

main ENDP

Quiz_one PROC
   mov eax, 0
   mov ecx, LENGTHOF secret
   mov edx, 0
   mov esi, 0

init:
   mov secret[esi], 0
   inc esi
   loop init

   mWrite <"Input the sentence (Under the 50 letters)",0ah>
   mWrite<"Sentence : ">

   mov edx, OFFSET yesol
   mov ecx, SIZEOF yesol
   call ReadString

   call randomize   
   mov eax, 3; eax = 0 ~ 2
   call RandomRange
   inc eax ; eax = 1 ~ 3
   mov random_num, eax
   
   mov ecx, random_num
   cmp ecx, 2
   ja caesar ; ecx > 2
   jb Uniform_substitution_password ; ecx < 2
  ; je vigenere ; ecx = 2
   
caesar:
   mov esi, 0
   mov ecx, LENGTHOF yesol

   C1:
      mov al, yesol[esi]
      add al, 3
      mov secret[esi], al
      inc esi
      .IF yesol[esi]==NULL
      call Crlf
      call Result_Caesar
      .ENDIF
      loop C1

Uniform_substitution_password:
   mov esi, 0
   mov ecx, LENGTHOF yesol

   C2:
     call USP_ING
     loop C2
   
  ; ret
Quiz_one ENDP

Quiz_two PROC   ; 두 번째 퀴즈
   mov eax, 0
   mov ecx, LENGTHOF secret
   mov edx, 0
   mov esi, 0
init:
   mov secret[esi], 0
   inc esi
   loop init

   call randomize   
   mov eax, 5      ; eax에 0~4까지 랜덤으로 난수 생성
   call RandomRange
   inc eax         ; eax에 1을 더해줘서 1~5까지 범위로 만들어줌
   mov randVal1, eax ; 생성된 난수 randVal1에 저장

   mov eax, 3      ; eax에 0~2까지 랜덤으로 난수 생성
   call RandomRange
   inc eax         ; eax에 1을 더해줘서 1~3까지 범위로 만들어줌
   mov randVal2, eax ; 생성된 난수 randVal2에 저장

   mov ecx, randVal2 
   cmp ecx, 2 ;ecx랑 2랑 비교
   ja Q2_caesar ; ecx > 2일 때 카이사르 암호화로 분기
   jb Q2_Uniform_substitution_password ;ecx < 2일 때 단일치환 암호화로 분기

Q2_caesar:
     
    .IF randVal1 == 1 ;랜덤 난수가 1과 같을 때 실행
         mov esi, 0      ; 문자 하나씩 암호화 시켜주기 위해 esi 0으로 초기화
         mov ecx, LENGTHOF arry1   ; 문장의 길이만큼 암호화 시키기 위해 ecx에 문장 길이 저장
         
       L1:
            mov al, arry1[esi]   
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry1[esi]==NULL
            call Crlf
            call Result2_Caesar   ;암호화된 문장과 암호화 방식 출력 부분으로 불러오기
            call Result2_in1   ;평문과 문장 입력받아 비교하는 부분 불러오기
            .ENDIF
         
         loop L1
            
      .ELSEIF randVal1 == 2   ;랜덤 난수가 2과 같을 때 실행
         mov esi, 0
         mov ecx, LENGTHOF arry2
        
        L2:
            mov al, arry2[esi]
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry2[esi]==NULL
            call Crlf
            call Result2_Caesar   ;암호화된 문장과 암호화 방식 출력 부분으로 불러오기
            call Result2_in2   ;평문과 문장 입력받아 비교하는 부분 불러오기
            .ENDIF
         loop L2

     .ELSEIF randVal1 == 3   ;랜덤 난수가 3과 같을 때 실행
      mov esi, 0
         mov ecx, LENGTHOF arry3
       
          L3:
            mov al, arry3[esi]
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry3[esi]==NULL
            call Crlf
            call Result2_Caesar   ;암호화된 문장과 암호화 방식 출력 부분으로 불러오기
            call Result2_in3   ;평문과 문장 입력받아 비교하는 부분 불러오기
            .ENDIF
         loop L3


       .ELSEIF randVal1 == 4 ;랜덤 난수가 4과 같을 때 실행
         mov esi, 0
         mov ecx, LENGTHOF arry4
        
          L4:
            mov al, arry4[esi]
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry4[esi]==NULL
            call Crlf
            call Result2_Caesar   ;암호화된 문장과 암호화 방식 출력 부분으로 불러오기
            call Result2_in4   ;평문과 문장 입력받아 비교하는 부분 불러오기
            .ENDIF
         loop L4


      .ELSEIF randVal1 == 5   ;랜덤 난수가 5과 같을 때 실행
         mov esi, 0
         mov ecx, LENGTHOF arry5
         
          L5:
            mov al, arry5[esi]
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry5[esi]==NULL
            call Crlf
            call Result2_Caesar   ;암호화된 문장과 암호화 방식 출력 부분으로 불러오기
            call Result2_in5   ;평문과 문장 입력받아 비교하는 부분 불러오기
            .ENDIF
         loop L5
      .ENDIF

Q2_Uniform_substitution_password:   ;단일 치환 암호
      .IF randVal1 == 1 ;랜덤 난수에 따라 문장 암호화
         mov esi, 0
         mov ecx, LENGTHOF arry1

         A1:
           call Q2_USP_ING1 
           loop A1


      .ELSEIF randVal1 == 2 ;랜덤 난수에 따라 문장 암호화
         mov esi, 0
         mov ecx, LENGTHOF arry2

         A2:
           call Q2_USP_ING2
           loop A2

      .ELSEIF randVal1 == 3 ;랜덤 난수에 따라 문장 출력
         mov esi, 0
         mov ecx, LENGTHOF arry3

         A3:
          call Q2_USP_ING3
          loop A3

      .ELSEIF randVal1 == 4 ;랜덤 난수에 따라 문장 출력
         mov esi, 0
         mov ecx, LENGTHOF arry4

         A4:
          call Q2_USP_ING4
          loop A4

      .ELSEIF randVal1 == 5 ;랜덤 난수에 따라 문장 출력
         mov esi, 0
         mov ecx, LENGTHOF arry5

         A5:
          call Q2_USP_ING5
          loop A5

      .ENDIF
   ret
Quiz_two ENDP

Result_Caesar PROC   
   mWrite<"Encrypted string",0ah>
   mWrite<">>> ">

   mov edx, OFFSET secret
   call Writestring

   call Crlf
   call Crlf
   mWrite<"What is the encryption method used?",0ah>
   mWrite<"1. Caesar",0ah>
   mWrite<"2. Uniform substitution password",0ah>
   mWrite<"3. Vigenere",0ah>
   mWrite<"Input the number : ">

   call ReadInt
   mov compare_num, eax

   .IF compare_num == 1
   call Crlf
   
   mWrite<"Success",0ah>
   
   call Crlf
   
   invoke Sleep,500h
   call Clrscr

   call Que_END
 
   .ELSE
   call Crlf

   mWrite<"Fail",0ah>
   
   call Crlf
   invoke Sleep,500h
   call Clrscr

   call Que_END
   .ENDIF

   ret
Result_Caesar ENDP

Result_USP PROC
   mWrite<"Encrypted string",0ah>
   mWrite<">>> ">

   mov edx, OFFSET secret
   call Writestring

   call Crlf

   mWrite<"What is the encryption method used?",0ah>
   mWrite<"1. Caesar",0ah>
   mWrite<"2. Uniform substitution password",0ah>
   mWrite<"3. Vigenere",0ah>
   mWrite<"Input the number : ">

   call ReadInt
   mov compare_num, eax

   .IF compare_num == 2
   call Crlf
   
   mWrite<"Success",0ah>
   
   call Crlf
   invoke Sleep,500h
   call Clrscr
   
    call Que_END
   .ELSE
   call Crlf
   
   mWrite<"Fail",0ah>
   
   call Crlf
   invoke Sleep,500h
   call Clrscr
   
   call Que_END
   .ENDIF

   ret
Result_USP ENDP

USP_ING PROC
      mov al, yesol[esi]
      .IF al == 97
      mov al, 109
      .ELSEIF al == 98
      mov al, 103
      .ELSEIF al == 100
      mov al, 107
      .ELSEIF al == 101
      mov al, 122
      .ELSEIF al == 102
      mov al, 97
      .ELSEIF al == 103
      mov al, 113
      .ELSEIF al == 104
      mov al, 111
      .ELSEIF al == 105
      mov al, 112
      .ELSEIF al == 106
      mov al, 114
      .ELSEIF al == 107
      mov al, 98
      .ELSEIF al == 108
      mov al, 115
      .ELSEIF al == 109
      mov al, 104
      .ELSEIF al == 110
      mov al, 119
      .ELSEIF al == 111
      mov al, 100
      .ELSEIF al == 112
      mov al, 102
      .ELSEIF al == 113
      mov al, 121
      .ELSEIF al == 114
      mov al, 120
      .ELSEIF al == 115
      mov al, 110
     .ELSEIF al == 116
      mov al, 101
      .ELSEIF al == 117
      mov al, 116
      .ELSEIF al == 118
      mov al, 105
      .ELSEIF al == 119
      mov al, 109
     .ELSEIF al == 120
      mov al, 108
      .ELSEIF al == 121
      mov al, 118
      .ELSEIF al == 122
      mov al, 117
      .ENDIF

      .IF yesol[esi]==NULL
         call Crlf
         call Result_USP
      .ENDIF

      mov secret[esi], al
      inc esi

     ret
USP_ING ENDP

Result2_Caesar PROC   ;암호화된 문장과 암호화 방식 출력 부분으로 불러오기
   mWrite<"Encrypted string",0ah> ;암호화 된 문장입니다.
   mWrite<">>> ">

   mov edx, OFFSET secret
   call Writestring   ;암호화 된 문장 출력
   
   call Crlf

   call Crlf
   mWrite<"The encryption method is Casesar.",0ah> ;암호화 방식은 카이사르 입니다.
   mWrite<"Please enter a statement.",0ah> ;평문을 입력하세요
   mWrite<">>> ">

   ret
Result2_Caesar ENDP

Result2_in1 PROC
   
   mov esi, 0   ;배열 안에 있는 문장의 문자 하나하나 비교위해 초기화
   mov edi, 0   ;이하 동문
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry1      ; 배열 크기만큼 비교
   call ReadString               ; 평문 입력받아 버퍼2 저장
   dec ecx ;문자열 빼줌


   O1:   ;평문이랑 arry1 비교하는 루프

      mov ah, buffer2[esi]   ;버퍼2 문자 하나 ah에 저장
      mov bh, arry1[edi]      ;배열1 문자 하나 bh에 저장
      cmp ah, bh            ;ah아 bh 비교

      jb fail ;ah가 bh보다 작으면 fail로 분기
      ja fail   ;ah가 bh보다 크면 fail로 분기

      inc esi ;다음 문자열 비교 위해 esi 1증가
      inc edi   ;다음 문자열 비교 위해 edi 1증가
      loop O1
      ;루프 종료 후 실행(같으면 계속 실행 되지 않을까 아마도..)
      
      mWrite<"Success",0ah>   ;루프 종료후 성공
      call Crlf
     invoke Sleep,500h
      call Clrscr
    call Que_END

fail: ;문자열 다르면 분기
   call Crlf
   
   mWrite<"Fail", 0ah> ; 다르면 실패
   
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret
Result2_in1 ENDP

Result2_in2 PROC

   mov esi, 0   ;배열 안에 있는 문장의 문자 하나하나 비교위해 초기화
   mov edi, 0   ;이하 동문
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry2         ; 배열 크기만큼 비교
   call ReadString               ; 평문 입력받아 버퍼2 저장
   dec ecx ;문자열 빼줌


   O2:   ;평문이랑 arry2 비교하는 루프

      mov ah, buffer2[esi]   ;버퍼2 문자 하나 ah에 저장
      mov bh, arry2[edi]      ;배열1 문자 하나 bh에 저장
      cmp ah, bh            ;ah아 bh 비교

      jb fail ;ah가 bh보다 작으면 fail로 분기
      ja fail   ;ah가 bh보다 크면 fail로 분기

      inc esi ;다음 문자열 비교 위해 esi 1증가
      inc edi   ;다음 문자열 비교 위해 edi 1증가
      loop O2
      ;루프 종료 후 실행(같으면 계속 실행 되지 않을까 아마도..)
      
      mWrite<"Success",0ah>   ;루프 종료후 성공
      call Crlf
     invoke Sleep,500h
      call Clrscr
   call Que_END

fail: ;문자열 다르면 분기
   call Crlf
   
   mWrite<"Fail", 0ah> ; 다르면 실패
   
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret
Result2_in2 ENDP

Result2_in3 PROC
   
   mov esi, 0   ;배열 안에 있는 문장의 문자 하나하나 비교위해 초기화
   mov edi, 0   ;이하 동문
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry3      ; 배열 크기만큼 비교
   call ReadString               ; 평문 입력받아 버퍼2 저장
   dec ecx ;문자열 빼줌


   O3:   ;평문이랑 arry1 비교하는 루프

      mov ah, buffer2[esi]   ;버퍼2 문자 하나 ah에 저장
      mov bh, arry3[edi]      ;배열1 문자 하나 bh에 저장
      cmp ah, bh            ;ah아 bh 비교

      jb fail ;ah가 bh보다 작으면 fail로 분기
      ja fail   ;ah가 bh보다 크면 fail로 분기

      inc esi ;다음 문자열 비교 위해 esi 1증가
      inc edi   ;다음 문자열 비교 위해 edi 1증가
      loop O3
      ;루프 종료 후 실행(같으면 계속 실행 되지 않을까 아마도..)
      
      mWrite<"Success",0ah>   ;루프 종료후 성공
      call Crlf
     invoke Sleep,500h
      call Clrscr
    call Que_END


fail: ;문자열 다르면 분기
   call Crlf
   mWrite<"Fail", 0ah> ; 다르면 실패
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret

Result2_in3 ENDP

Result2_in4 PROC

      
   mov esi, 0   ;배열 안에 있는 문장의 문자 하나하나 비교위해 초기화
   mov edi, 0   ;이하 동문
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry4      ; 배열 크기만큼 비교
   call ReadString               ; 평문 입력받아 버퍼2 저장
   dec ecx ;문자열 빼줌


   O4:   ;평문이랑 arry1 비교하는 루프

      mov ah, buffer2[esi]   ;버퍼2 문자 하나 ah에 저장
      mov bh, arry4[edi]      ;배열1 문자 하나 bh에 저장
      cmp ah, bh            ;ah아 bh 비교

      jb fail ;ah가 bh보다 작으면 fail로 분기
      ja fail   ;ah가 bh보다 크면 fail로 분기

      inc esi ;다음 문자열 비교 위해 esi 1증가
      inc edi   ;다음 문자열 비교 위해 edi 1증가
      loop O4
      ;루프 종료 후 실행(같으면 계속 실행 되지 않을까 아마도..)
      
      mWrite<"Success",0ah>   ;루프 종료후 성공
      call Crlf
     invoke Sleep,500h
      call Clrscr
    call Que_END

fail: ;문자열 다르면 분기
   call Crlf
   mWrite<"Fail", 0ah> ; 다르면 실패
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret
Result2_in4 ENDP

Result2_in5 PROC
   
   mov esi, 0   ;배열 안에 있는 문장의 문자 하나하나 비교위해 초기화
   mov edi, 0   ;이하 동문
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry5      ; 배열 크기만큼 비교
   call ReadString               ; 평문 입력받아 버퍼2 저장
   dec ecx ;문자열 빼줌


   O:   ;평문이랑 arry1 비교하는 루프

      mov ah, buffer2[esi]   ;버퍼2 문자 하나 ah에 저장
      mov bh, arry5[edi]      ;배열1 문자 하나 bh에 저장
      cmp ah, bh            ;ah아 bh 비교

      jb fail ;ah가 bh보다 작으면 fail로 분기
      ja fail   ;ah가 bh보다 크면 fail로 분기

      inc esi ;다음 문자열 비교 위해 esi 1증가
      inc edi   ;다음 문자열 비교 위해 edi 1증가
      loop O
      ;루프 종료 후 실행(같으면 계속 실행 되지 않을까 아마도..)
      
      mWrite<"Success",0ah>   ;루프 종료후 성공
      call Crlf
     invoke Sleep,500h
      call Clrscr
      call Que_END


fail: ;문자열 다르면 분기
   call Crlf
   mWrite<"Fail", 0ah> ; 다르면 실패
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret
Result2_in5 ENDP
   
Q2_USP_ING1 PROC
          mov al, arry1[esi]
           .IF al == 97
           mov al, 109
           .ELSEIF al == 98
           mov al, 103
           .ELSEIF al == 100
           mov al, 107
           .ELSEIF al == 101
           mov al, 122
           .ELSEIF al == 102
           mov al, 97
           .ELSEIF al == 103
           mov al, 113
           .ELSEIF al == 104
           mov al, 111
           .ELSEIF al == 105
           mov al, 112
           .ELSEIF al == 106
           mov al, 114
           .ELSEIF al == 107
           mov al, 98
           .ELSEIF al == 108
           mov al, 115
           .ELSEIF al == 109
           mov al, 104
           .ELSEIF al == 110
           mov al, 119
           .ELSEIF al == 111
           mov al, 100
           .ELSEIF al == 112
           mov al, 102
           .ELSEIF al == 113
           mov al, 121
           .ELSEIF al == 114
           mov al, 120
           .ELSEIF al == 115
           mov al, 110
           .ELSEIF al == 116
           mov al, 101
           .ELSEIF al == 117
           mov al, 116
           .ELSEIF al == 118
           mov al, 105
           .ELSEIF al == 119
           mov al, 109
           .ELSEIF al == 120
           mov al, 108
           .ELSEIF al == 121
           mov al, 118
           .ELSEIF al == 122
           mov al, 117
           .ENDIF

          .IF arry1[esi]==NULL
               call Crlf
               call Result2_usp
               call Result2_in1
           .ENDIF

           mov secret[esi], al
           inc esi

           ret
Q2_USP_ING1 ENDP

Q2_USP_ING2 PROC
          mov al, arry2[esi]
           .IF al == 97
           mov al, 109
           .ELSEIF al == 98
           mov al, 103
           .ELSEIF al == 100
           mov al, 107
           .ELSEIF al == 101
           mov al, 122
           .ELSEIF al == 102
           mov al, 97
           .ELSEIF al == 103
           mov al, 113
           .ELSEIF al == 104
           mov al, 111
           .ELSEIF al == 105
           mov al, 112
           .ELSEIF al == 106
           mov al, 114
           .ELSEIF al == 107
           mov al, 98
           .ELSEIF al == 108
           mov al, 115
           .ELSEIF al == 109
           mov al, 104
           .ELSEIF al == 110
           mov al, 119
           .ELSEIF al == 111
           mov al, 100
           .ELSEIF al == 112
           mov al, 102
           .ELSEIF al == 113
           mov al, 121
           .ELSEIF al == 114
           mov al, 120
           .ELSEIF al == 115
           mov al, 110
           .ELSEIF al == 116
           mov al, 101
           .ELSEIF al == 117
           mov al, 116
           .ELSEIF al == 118
           mov al, 105
           .ELSEIF al == 119
           mov al, 109
           .ELSEIF al == 120
           mov al, 108
           .ELSEIF al == 121
           mov al, 118
           .ELSEIF al == 122
           mov al, 117
           .ENDIF

          .IF arry2[esi]==NULL
               call Crlf
               call Result2_usp
               call Result2_in2
           .ENDIF

           mov secret[esi], al
           inc esi

           ret
Q2_USP_ING2 ENDP

Q2_USP_ING3 PROC
          mov al, arry3[esi]
           .IF al == 97
           mov al, 109
           .ELSEIF al == 98
           mov al, 103
           .ELSEIF al == 100
           mov al, 107
           .ELSEIF al == 101
           mov al, 122
           .ELSEIF al == 102
           mov al, 97
           .ELSEIF al == 103
           mov al, 113
           .ELSEIF al == 104
           mov al, 111
           .ELSEIF al == 105
           mov al, 112
           .ELSEIF al == 106
           mov al, 114
           .ELSEIF al == 107
           mov al, 98
           .ELSEIF al == 108
           mov al, 115
           .ELSEIF al == 109
           mov al, 104
           .ELSEIF al == 110
           mov al, 119
           .ELSEIF al == 111
           mov al, 100
           .ELSEIF al == 112
           mov al, 102
           .ELSEIF al == 113
           mov al, 121
           .ELSEIF al == 114
           mov al, 120
           .ELSEIF al == 115
           mov al, 110
           .ELSEIF al == 116
           mov al, 101
           .ELSEIF al == 117
           mov al, 116
           .ELSEIF al == 118
           mov al, 105
           .ELSEIF al == 119
           mov al, 109
           .ELSEIF al == 120
           mov al, 108
           .ELSEIF al == 121
           mov al, 118
           .ELSEIF al == 122
           mov al, 117
           .ENDIF

          .IF arry3[esi]==NULL
               call Crlf
               call Result2_usp
               call Result2_in3
           .ENDIF

           mov secret[esi], al
           inc esi

           ret
Q2_USP_ING3 ENDP

Q2_USP_ING4 PROC
          mov al, arry4[esi]
           .IF al == 97
           mov al, 109
           .ELSEIF al == 98
           mov al, 103
           .ELSEIF al == 100
           mov al, 107
           .ELSEIF al == 101
           mov al, 122
           .ELSEIF al == 102
           mov al, 97
           .ELSEIF al == 103
           mov al, 113
           .ELSEIF al == 104
           mov al, 111
           .ELSEIF al == 105
           mov al, 112
           .ELSEIF al == 106
           mov al, 114
           .ELSEIF al == 107
           mov al, 98
           .ELSEIF al == 108
           mov al, 115
           .ELSEIF al == 109
           mov al, 104
           .ELSEIF al == 110
           mov al, 119
           .ELSEIF al == 111
           mov al, 100
           .ELSEIF al == 112
           mov al, 102
           .ELSEIF al == 113
           mov al, 121
           .ELSEIF al == 114
           mov al, 120
           .ELSEIF al == 115
           mov al, 110
           .ELSEIF al == 116
           mov al, 101
           .ELSEIF al == 117
           mov al, 116
           .ELSEIF al == 118
           mov al, 105
           .ELSEIF al == 119
           mov al, 109
           .ELSEIF al == 120
           mov al, 108
           .ELSEIF al == 121
           mov al, 118
           .ELSEIF al == 122
           mov al, 117
           .ENDIF

          .IF arry4[esi]==NULL
               call Crlf
               call Result2_usp
               call Result2_in4
           .ENDIF

           mov secret[esi], al
           inc esi

           ret
Q2_USP_ING4 ENDP

Q2_USP_ING5 PROC
          mov al, arry5[esi]
           .IF al == 97
           mov al, 109
           .ELSEIF al == 98
           mov al, 103
           .ELSEIF al == 100
           mov al, 107
           .ELSEIF al == 101
           mov al, 122
           .ELSEIF al == 102
           mov al, 97
           .ELSEIF al == 103
           mov al, 113
           .ELSEIF al == 104
           mov al, 111
           .ELSEIF al == 105
           mov al, 112
           .ELSEIF al == 106
           mov al, 114
           .ELSEIF al == 107
           mov al, 98
           .ELSEIF al == 108
           mov al, 115
           .ELSEIF al == 109
           mov al, 104
           .ELSEIF al == 110
           mov al, 119
           .ELSEIF al == 111
           mov al, 100
           .ELSEIF al == 112
           mov al, 102
           .ELSEIF al == 113
           mov al, 121
           .ELSEIF al == 114
           mov al, 120
           .ELSEIF al == 115
           mov al, 110
           .ELSEIF al == 116
           mov al, 101
           .ELSEIF al == 117
           mov al, 116
           .ELSEIF al == 118
           mov al, 105
           .ELSEIF al == 119
           mov al, 109
           .ELSEIF al == 120
           mov al, 108
           .ELSEIF al == 121
           mov al, 118
           .ELSEIF al == 122
           mov al, 117
           .ENDIF

          .IF arry5[esi]==NULL
               call Crlf
               call Result2_usp
               call Result2_in5
           .ENDIF

           mov secret[esi], al
           inc esi

           ret
Q2_USP_ING5 ENDP

Result2_usp PROC
   mWrite<"Encrypted string",0ah>
   mWrite<">>> ">
   
   mov edx, OFFSET secret
   call Writestring

   call Crlf
   call Crlf
   mWrite<"The encryption method is Uniform substitution password.",0ah>
   mWrite<"Please enter a statement.",0ah>
   mWrite<">>> ">

   ret
Result2_usp ENDP

Que_END PROC
   mWrite<"1. Continue    2. Stop  "
   
   call Crlf
   mWrite<"Input the number : ">

   call ReadInt
   mov Input, eax
   invoke Sleep,300h
   call Clrscr 

   .IF input == 1
   jmp main
   .ELSEIF input == 2
    exit
   .ENDIF

   ret
Que_END ENDP
exit

END main