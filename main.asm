                INCLUDE "vectrex.inc"

Music           EQU     $FD0D
Layer_Count     EQU     3
Star_Count      EQU     8

                ORG     0

                FCC     "g GCE 2020"
                FCB     $80
                FDB     Music
                FCB     $F8,$50,$20,-$40 
                FCC     "HELLO.BIN"
                FCB     $80,0

main            jsr     Wait_Recal
                lda     #$80
                sta     VIA_t1_cnt_lo

                jsr     Intensity_5F
                ldx     #coords
                ldy     #offsets

                lda     #Layer_Count
                sta     i
layer           lda     #Star_Count
                sta     j
star            ldd     ,x++            ; Draw offsetted star
                addb    ,y
                jsr     Moveto_d
                jsr     Dot_here
                jsr     Reset0Int

                dec     j
                bne     star

                lda     ,y              ; Subtract offset by layer counter
                suba    i
                sta     ,y+

                dec     i
                bne     layer

		bra	main

coords          FCB     69,87,-108,4,120,79,27,116,55,-17,-57,16,-57,-80,0,-53
                FCB     30,-78,-91,41,113,-77,53,94,33,-24,116,98,5,-97,-121,-81
                FCB     76,-128,124,42,-4,38,-96,-31,-15,-6,-56,101,-82,-87,35,122

                ORG     $C880

i               RMB     1               ; Layer counter
j               RMB     1               ; Star counter
offsets         RMB     Layer_Count     ; Star layer offset
