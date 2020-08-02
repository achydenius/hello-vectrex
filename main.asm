                INCLUDE "vectrex.inc"

Layer_Count     EQU     4
Star_Count      EQU     8

                ORG     0

                FCC     "g GCE 2020"
                FCB     $80
                FDB     0
                FCB     $F8,$50,$20,-$40 
                FCC     "HELLO.BIN"
                FCB     $80,0

main            jsr     Wait_Recal
                lda     #$80
                sta     VIA_t1_cnt_lo

                ldx     #coords
                ldy     #offsets

                lda     #Layer_Count
                sta     i

                ; Loop through star layers
layer           lda     #Star_Count
                sta     j

                ; Set layer intensity
                ldu     #intensities
                ldb     i
                decb
                lda     b,u

                jsr     Intensity_a

                ; Loop through individual stars
star            ldd     ,x++
                addb    ,y
                jsr     Moveto_d
                jsr     Dot_here
                jsr     Reset0Int

                dec     j
                bne     star

                ; Subtract offset by layer counter
                lda     ,y
                suba    i
                sta     ,y+

                dec     i
                bne     layer

		bra	main

coords          FCB     69,87,-108,4,120,79,27,116,55,-17,-57,16,-57,-80,0,-53
                FCB     30,-78,-91,41,113,-77,53,94,33,-24,116,98,5,-97,-121,-81
                FCB     76,-128,124,42,-4,38,-96,-31,-15,-6,-56,101,-82,-87,35,122
                FCB     -73,26,21,-65,42,-24,19,99,-82,69,34,-5,20,-34,-32,-33
intensities     FCB     $1F,$3F,$5F,$7F

                ORG     $C880

i               RMB     1               ; Layer counter
j               RMB     1               ; Star counter
offsets         RMB     Layer_Count     ; Star layer offset
