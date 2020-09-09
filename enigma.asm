;Program to simulate ENIGMA Machine

jmp start

;Data
rot1: db 07h, 00h, 03h, 06h, 04h, 01h, 08h, 02h, 05h, 09h
rot2: db 01h, 03h, 06h, 07h, 00h, 05h, 02h, 04h, 08h, 09h
rot3: db 07h, 01h, 02h, 00h, 05h, 03h, 08h, 06h, 04h, 09h

refl: db 07h, 05h, 09h, 04h, 03h, 01h, 08h, 00h, 06h, 02h

post: ds 3

text: ds 1
ciph: ds 1

;Get Settings
start:  in 10h
        ani 0fh
        sta post

        in 11h
        ani 0fh
        sta post+1

        in 12h
        ani 0fh
        sta post+2


;Start ENIGMA
textin: in 13h
        sta text
        sta ciph

;Rotor 1
rota1:  lxi H, post
        inr M
        mov A, M
        cpi 0Ah
        jc next1
        sui 0Ah
        mov M, A
        inx H
        inr M

next1:  mov E, A
        lxi H, rot1
        mov A, L
        adi 0Ah
        mov C, A

        mvi D, 00h
        dad D

        lda ciph
        add L
        cmp C
        jc skip1
        sui 0Ah

skip1:  mov L, A
        mov A, M
        sta ciph

;Rotor 2
rota2:  lxi H, post+1
        mov A, M
        cpi 0Ah
        jc next2
        sui 0Ah
        mov M, A
        inx H
        inr M

next2:  mov E, A
        lxi H, rot2
        mov A, L
        adi 0Ah
        mov C, A

        dad D

        lda ciph
        add L
        cmp C
        jc skip2
        sui 0Ah

skip2:  mov L, A
        mov A, M
        sta ciph

;Rotor 3
rota3:  lxi H, post+2
        mov A, M
        cpi 0Ah
        jc next3
        sui 0Ah
        mov M, A

next3:  mov E, A
        lxi H, rot3
        mov A, L
        adi 0Ah
        mov C, A

        dad D

        lda ciph
        add L
        cmp C
        jc skip3
        sui 0Ah

skip3:  mov L, A
        mov A, M
        sta ciph

;Reflection Module
refl1:  lxi H, refl
        mov A, L
        adi 0Ah
        mov C, A

        lda ciph
        add L
        cmp C
        jc skip4
        sui 0Ah

skip4:  mov L, A
        mov A, M
        sta ciph

;Inverse 1 (Rotor 3)
invr1:  mov B, A
        mvi C, 0ffh

        lxi H, rot3
        mov A, L
        adi 0Ah
        mov D, A

        lxi H, post+2
        mov A, M
        lxi H, rot3
        add L
        mov L, A

comp1:  inr C
        mov E, M

        inx H
        mov A, L
        cmp D
        jc skip5
        sui 0Ah
        mov L, A

skip5:  mov A, E
        cmp B
        jnz comp1
        mov A, C
        sta ciph

;Inverse 2 (Rotor 2)
invr2:  mov B, A
        mvi C, 0ffh

        lxi H, rot2
        mov A, L
        adi 0Ah
        mov D, A

        lxi H, post+1
        mov A, M
        lxi H, rot2
        add L
        mov L, A

comp2:  inr C
        mov E, M

        inx H
        mov A, L
        cmp D
        jc skip6
        sui 0Ah
        mov L, A

skip6:  mov A, E
        cmp B
        jnz comp2
        mov A, C
        sta ciph

;Inverse 3 (Rotor 1)
invr3:  mov B, A
        mvi C, 0ffh

        lxi H, rot1
        mov A, L
        adi 0Ah
        mov D, A

        lxi H, post
        mov A, M
        lxi H, rot1
        add L
        mov L, A

comp3:  inr C
        mov E, M

        inx H
        mov A, L
        cmp D
        jc skip7
        sui 0Ah
        mov L, A

skip7:  mov A, E
        cmp B
        jnz comp3
        mov A, C
        sta ciph

;Show output
        mvi B, 00h
        out 14h
hlt