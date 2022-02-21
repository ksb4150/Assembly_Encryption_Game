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
random_num DWORD ? ; ��ȣȭ ��� (1~3)
compare_num DWORD ?
secret BYTE 55 DUP(0) ; �����Ӥ�

; quiz 2 data
arry1 BYTE "works out just as wanted",0
arry2 BYTE "time is gold",0
arry3 BYTE "there are too many assignments",0
arry4 BYTE "it is better late than never",0
arry5 BYTE "you create your opportunities by asking for them",0
randVal1 DWORD ?   ; �������� �迭�� �����ϱ� ���� ����
randVal2 DWORD ?   ; �������� ��ȣȭ�� �����ϱ� ���� ����
buffer2 BYTE 55 DUP(0)   ; �Է¹��� ����� �� �񱳸� ���� ����

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

Quiz_two PROC   ; �� ��° ����
   mov eax, 0
   mov ecx, LENGTHOF secret
   mov edx, 0
   mov esi, 0
init:
   mov secret[esi], 0
   inc esi
   loop init

   call randomize   
   mov eax, 5      ; eax�� 0~4���� �������� ���� ����
   call RandomRange
   inc eax         ; eax�� 1�� �����༭ 1~5���� ������ �������
   mov randVal1, eax ; ������ ���� randVal1�� ����

   mov eax, 3      ; eax�� 0~2���� �������� ���� ����
   call RandomRange
   inc eax         ; eax�� 1�� �����༭ 1~3���� ������ �������
   mov randVal2, eax ; ������ ���� randVal2�� ����

   mov ecx, randVal2 
   cmp ecx, 2 ;ecx�� 2�� ��
   ja Q2_caesar ; ecx > 2�� �� ī�̻縣 ��ȣȭ�� �б�
   jb Q2_Uniform_substitution_password ;ecx < 2�� �� ����ġȯ ��ȣȭ�� �б�

Q2_caesar:
     
    .IF randVal1 == 1 ;���� ������ 1�� ���� �� ����
         mov esi, 0      ; ���� �ϳ��� ��ȣȭ �����ֱ� ���� esi 0���� �ʱ�ȭ
         mov ecx, LENGTHOF arry1   ; ������ ���̸�ŭ ��ȣȭ ��Ű�� ���� ecx�� ���� ���� ����
         
       L1:
            mov al, arry1[esi]   
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry1[esi]==NULL
            call Crlf
            call Result2_Caesar   ;��ȣȭ�� ����� ��ȣȭ ��� ��� �κ����� �ҷ�����
            call Result2_in1   ;�򹮰� ���� �Է¹޾� ���ϴ� �κ� �ҷ�����
            .ENDIF
         
         loop L1
            
      .ELSEIF randVal1 == 2   ;���� ������ 2�� ���� �� ����
         mov esi, 0
         mov ecx, LENGTHOF arry2
        
        L2:
            mov al, arry2[esi]
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry2[esi]==NULL
            call Crlf
            call Result2_Caesar   ;��ȣȭ�� ����� ��ȣȭ ��� ��� �κ����� �ҷ�����
            call Result2_in2   ;�򹮰� ���� �Է¹޾� ���ϴ� �κ� �ҷ�����
            .ENDIF
         loop L2

     .ELSEIF randVal1 == 3   ;���� ������ 3�� ���� �� ����
      mov esi, 0
         mov ecx, LENGTHOF arry3
       
          L3:
            mov al, arry3[esi]
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry3[esi]==NULL
            call Crlf
            call Result2_Caesar   ;��ȣȭ�� ����� ��ȣȭ ��� ��� �κ����� �ҷ�����
            call Result2_in3   ;�򹮰� ���� �Է¹޾� ���ϴ� �κ� �ҷ�����
            .ENDIF
         loop L3


       .ELSEIF randVal1 == 4 ;���� ������ 4�� ���� �� ����
         mov esi, 0
         mov ecx, LENGTHOF arry4
        
          L4:
            mov al, arry4[esi]
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry4[esi]==NULL
            call Crlf
            call Result2_Caesar   ;��ȣȭ�� ����� ��ȣȭ ��� ��� �κ����� �ҷ�����
            call Result2_in4   ;�򹮰� ���� �Է¹޾� ���ϴ� �κ� �ҷ�����
            .ENDIF
         loop L4


      .ELSEIF randVal1 == 5   ;���� ������ 5�� ���� �� ����
         mov esi, 0
         mov ecx, LENGTHOF arry5
         
          L5:
            mov al, arry5[esi]
            add al, 3
            mov secret[esi], al
            inc esi
            .IF arry5[esi]==NULL
            call Crlf
            call Result2_Caesar   ;��ȣȭ�� ����� ��ȣȭ ��� ��� �κ����� �ҷ�����
            call Result2_in5   ;�򹮰� ���� �Է¹޾� ���ϴ� �κ� �ҷ�����
            .ENDIF
         loop L5
      .ENDIF

Q2_Uniform_substitution_password:   ;���� ġȯ ��ȣ
      .IF randVal1 == 1 ;���� ������ ���� ���� ��ȣȭ
         mov esi, 0
         mov ecx, LENGTHOF arry1

         A1:
           call Q2_USP_ING1 
           loop A1


      .ELSEIF randVal1 == 2 ;���� ������ ���� ���� ��ȣȭ
         mov esi, 0
         mov ecx, LENGTHOF arry2

         A2:
           call Q2_USP_ING2
           loop A2

      .ELSEIF randVal1 == 3 ;���� ������ ���� ���� ���
         mov esi, 0
         mov ecx, LENGTHOF arry3

         A3:
          call Q2_USP_ING3
          loop A3

      .ELSEIF randVal1 == 4 ;���� ������ ���� ���� ���
         mov esi, 0
         mov ecx, LENGTHOF arry4

         A4:
          call Q2_USP_ING4
          loop A4

      .ELSEIF randVal1 == 5 ;���� ������ ���� ���� ���
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

Result2_Caesar PROC   ;��ȣȭ�� ����� ��ȣȭ ��� ��� �κ����� �ҷ�����
   mWrite<"Encrypted string",0ah> ;��ȣȭ �� �����Դϴ�.
   mWrite<">>> ">

   mov edx, OFFSET secret
   call Writestring   ;��ȣȭ �� ���� ���
   
   call Crlf

   call Crlf
   mWrite<"The encryption method is Casesar.",0ah> ;��ȣȭ ����� ī�̻縣 �Դϴ�.
   mWrite<"Please enter a statement.",0ah> ;���� �Է��ϼ���
   mWrite<">>> ">

   ret
Result2_Caesar ENDP

Result2_in1 PROC
   
   mov esi, 0   ;�迭 �ȿ� �ִ� ������ ���� �ϳ��ϳ� ������ �ʱ�ȭ
   mov edi, 0   ;���� ����
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry1      ; �迭 ũ�⸸ŭ ��
   call ReadString               ; �� �Է¹޾� ����2 ����
   dec ecx ;���ڿ� ����


   O1:   ;���̶� arry1 ���ϴ� ����

      mov ah, buffer2[esi]   ;����2 ���� �ϳ� ah�� ����
      mov bh, arry1[edi]      ;�迭1 ���� �ϳ� bh�� ����
      cmp ah, bh            ;ah�� bh ��

      jb fail ;ah�� bh���� ������ fail�� �б�
      ja fail   ;ah�� bh���� ũ�� fail�� �б�

      inc esi ;���� ���ڿ� �� ���� esi 1����
      inc edi   ;���� ���ڿ� �� ���� edi 1����
      loop O1
      ;���� ���� �� ����(������ ��� ���� ���� ������ �Ƹ���..)
      
      mWrite<"Success",0ah>   ;���� ������ ����
      call Crlf
     invoke Sleep,500h
      call Clrscr
    call Que_END

fail: ;���ڿ� �ٸ��� �б�
   call Crlf
   
   mWrite<"Fail", 0ah> ; �ٸ��� ����
   
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret
Result2_in1 ENDP

Result2_in2 PROC

   mov esi, 0   ;�迭 �ȿ� �ִ� ������ ���� �ϳ��ϳ� ������ �ʱ�ȭ
   mov edi, 0   ;���� ����
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry2         ; �迭 ũ�⸸ŭ ��
   call ReadString               ; �� �Է¹޾� ����2 ����
   dec ecx ;���ڿ� ����


   O2:   ;���̶� arry2 ���ϴ� ����

      mov ah, buffer2[esi]   ;����2 ���� �ϳ� ah�� ����
      mov bh, arry2[edi]      ;�迭1 ���� �ϳ� bh�� ����
      cmp ah, bh            ;ah�� bh ��

      jb fail ;ah�� bh���� ������ fail�� �б�
      ja fail   ;ah�� bh���� ũ�� fail�� �б�

      inc esi ;���� ���ڿ� �� ���� esi 1����
      inc edi   ;���� ���ڿ� �� ���� edi 1����
      loop O2
      ;���� ���� �� ����(������ ��� ���� ���� ������ �Ƹ���..)
      
      mWrite<"Success",0ah>   ;���� ������ ����
      call Crlf
     invoke Sleep,500h
      call Clrscr
   call Que_END

fail: ;���ڿ� �ٸ��� �б�
   call Crlf
   
   mWrite<"Fail", 0ah> ; �ٸ��� ����
   
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret
Result2_in2 ENDP

Result2_in3 PROC
   
   mov esi, 0   ;�迭 �ȿ� �ִ� ������ ���� �ϳ��ϳ� ������ �ʱ�ȭ
   mov edi, 0   ;���� ����
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry3      ; �迭 ũ�⸸ŭ ��
   call ReadString               ; �� �Է¹޾� ����2 ����
   dec ecx ;���ڿ� ����


   O3:   ;���̶� arry1 ���ϴ� ����

      mov ah, buffer2[esi]   ;����2 ���� �ϳ� ah�� ����
      mov bh, arry3[edi]      ;�迭1 ���� �ϳ� bh�� ����
      cmp ah, bh            ;ah�� bh ��

      jb fail ;ah�� bh���� ������ fail�� �б�
      ja fail   ;ah�� bh���� ũ�� fail�� �б�

      inc esi ;���� ���ڿ� �� ���� esi 1����
      inc edi   ;���� ���ڿ� �� ���� edi 1����
      loop O3
      ;���� ���� �� ����(������ ��� ���� ���� ������ �Ƹ���..)
      
      mWrite<"Success",0ah>   ;���� ������ ����
      call Crlf
     invoke Sleep,500h
      call Clrscr
    call Que_END


fail: ;���ڿ� �ٸ��� �б�
   call Crlf
   mWrite<"Fail", 0ah> ; �ٸ��� ����
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret

Result2_in3 ENDP

Result2_in4 PROC

      
   mov esi, 0   ;�迭 �ȿ� �ִ� ������ ���� �ϳ��ϳ� ������ �ʱ�ȭ
   mov edi, 0   ;���� ����
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry4      ; �迭 ũ�⸸ŭ ��
   call ReadString               ; �� �Է¹޾� ����2 ����
   dec ecx ;���ڿ� ����


   O4:   ;���̶� arry1 ���ϴ� ����

      mov ah, buffer2[esi]   ;����2 ���� �ϳ� ah�� ����
      mov bh, arry4[edi]      ;�迭1 ���� �ϳ� bh�� ����
      cmp ah, bh            ;ah�� bh ��

      jb fail ;ah�� bh���� ������ fail�� �б�
      ja fail   ;ah�� bh���� ũ�� fail�� �б�

      inc esi ;���� ���ڿ� �� ���� esi 1����
      inc edi   ;���� ���ڿ� �� ���� edi 1����
      loop O4
      ;���� ���� �� ����(������ ��� ���� ���� ������ �Ƹ���..)
      
      mWrite<"Success",0ah>   ;���� ������ ����
      call Crlf
     invoke Sleep,500h
      call Clrscr
    call Que_END

fail: ;���ڿ� �ٸ��� �б�
   call Crlf
   mWrite<"Fail", 0ah> ; �ٸ��� ����
   call Crlf
   invoke Sleep,500h
   call Clrscr
   call Que_END

   ret
Result2_in4 ENDP

Result2_in5 PROC
   
   mov esi, 0   ;�迭 �ȿ� �ִ� ������ ���� �ϳ��ϳ� ������ �ʱ�ȭ
   mov edi, 0   ;���� ����
   mov edx, OFFSET buffer2
   mov ecx, SIZEOF arry5      ; �迭 ũ�⸸ŭ ��
   call ReadString               ; �� �Է¹޾� ����2 ����
   dec ecx ;���ڿ� ����


   O:   ;���̶� arry1 ���ϴ� ����

      mov ah, buffer2[esi]   ;����2 ���� �ϳ� ah�� ����
      mov bh, arry5[edi]      ;�迭1 ���� �ϳ� bh�� ����
      cmp ah, bh            ;ah�� bh ��

      jb fail ;ah�� bh���� ������ fail�� �б�
      ja fail   ;ah�� bh���� ũ�� fail�� �б�

      inc esi ;���� ���ڿ� �� ���� esi 1����
      inc edi   ;���� ���ڿ� �� ���� edi 1����
      loop O
      ;���� ���� �� ����(������ ��� ���� ���� ������ �Ƹ���..)
      
      mWrite<"Success",0ah>   ;���� ������ ����
      call Crlf
     invoke Sleep,500h
      call Clrscr
      call Que_END


fail: ;���ڿ� �ٸ��� �б�
   call Crlf
   mWrite<"Fail", 0ah> ; �ٸ��� ����
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