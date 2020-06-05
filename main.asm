Music           EQU     $FD0D
Wait_Recal	EQU	$F192


                ORG     0

                FCC     "g GCE 2020"
                FCB     $80
                FDB     Music
                FCB     $F8,$50,$20,-$40 
                FCC     "HELLO.BIN"
                FCB     $80,0

main		jsr     Wait_Recal
		bra	main
