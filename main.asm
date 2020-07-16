                INCLUDE "vectrex.inc"

Music           EQU     $FD0D
Star_Count      EQU     8

                ORG     0

                FCC     "g GCE 2020"
                FCB     $80
                FDB     Music
                FCB     $F8,$50,$20,-$40 
                FCC     "HELLO.BIN"
                FCB     $80,0

                ldx     #coords
                ldb     #Star_Count
randomize       jsr     Random_3
                sta     ,x+
                jsr     Random_3
                sta     ,x+
                decb
                bne     randomize

main            jsr     Wait_Recal
                lda     #$80
                sta     VIA_t1_cnt_lo

                jsr     Intensity_5F
                ldx     #coords
loop            ldd     ,x++
                subb    offset
                jsr     Moveto_d
                jsr     Dot_here
                jsr     Reset0Int

                cmpx    #coords+(Star_Count*2)
                bne     loop

                inc     offset

		bra	main

                ORG     $C880

coords          RMD     Star_Count
offset          RMB     1
