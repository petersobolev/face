
; 646 bytes procedural graphics "Face" by Frog //ROi
; for Chaos Constructions'2024
;
; https://enlight.ru/roi
; frog@enlight.ru
;

                include "vectrex.i"

                org     0

                db      "g GCE 2015", $80 	; 'g' is copyright sign
                dw      $F600            	; music from the rom (no music)
                db      $FC, $30, 33, -$13	; height, width, rel y, rel x
                db      "FACE", $80	; app title, ending with $80
                db      0                 	; end of header


loop:
                jsr     Wait_Recal        	; recalibrate CRT, reset beam to 0,0

                lda     #$ff              	; scale (max possible)
                sta     <VIA_t1_cnt_lo

                jsr     Intensity_5F

; eye
                ldd     #(10*256+(-8)) 	; Y,X
                jsr     Moveto_d

                ldd     #(7*256+(-12)) 	; Y,X
                jsr     Draw_Line_d

                ldd     #(1*256+(18)) 	; Y,X
                jsr     Draw_Line_d

; upper eyebrow
                ldd     #(15*256+(-15)) 	; Y,X
                jsr     Moveto_d

                ldd     #(-4*256+(17)) 	; Y,X
                jsr     Draw_Line_d


; text

                ldu     #alltext
                jsr     Print_List_hw


                jsr     Reset0Ref               ; recalibrate crt (x,y = 0)

; draw dots with "motion blur"


                ldy    #(0*256+(1))    ; Y,X
next_dot:
                tfr    y,d

                exg	a,b

                lsla
                lsla
               
                jsr     Intensity_a            ; Sets the intensity of the
                                                ; vector beam to $5f

                lda     #5                      ; load A with number of dots - 1
                sta     Vec_Misc_Count          ; set it as counter for dots
                ldx     #dot_list               ; load the address of dot_list
                jsr     Dot_List

                tfr     y,d    

                negb
                jsr     Moveto_d

                leay    3,Y

                cmpy    #26
                blo     next_dot

                jsr     Intensity_7F


                jsr     Reset0Ref               ; recalibrate crt (x,y = 0)
                lda     #$CE                    ; /Blank low, /ZERO high
                sta     <VIA_cntl               ; enable beam, disable zeroing

                ldd     #(116*256+(-12))         ; Y,X
                jsr     Moveto_d


; start drawing face

                ldb     #$ff
                stb     <VIA_shift_reg     	; pattern


                ldd     #$1881
                stb     <VIA_port_b        	; disable MUX, disable ~RAMP
                sta     <VIA_aux_cntl      	; AUX: shift mode 4. PB7 not timer controlled. PB7 is ~RAMP

                lda     #-50              	; destination Y -86
                sta     <VIA_port_a        	; destination Y to DAC

                decb                      	; b now $80
                stb     <VIA_port_b        	; enable MUX

                clrb
                inc     <VIA_port_b        	; MUX off, only X on DAC now
                stb     <VIA_port_a        	; X to DAC

                lda     #50
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

                incb
                stb     <VIA_port_b        	; MUX disable, ~RAMP enable. Start integration

                nop
                nop

                lda     #37
                sta     <VIA_port_a        	; put X to DAC 

; 10
                ldb    #2            ; 2 cycles
d7a:            decb                   ; 2 cycles
                bpl     d7a             ; 3 cycles

                lda     #30
                sta     <VIA_port_a        	; put X to DAC 

; 10
                ldb    #2            ; 2 cycles
d6a:            decb                   ; 2 cycles
                bpl     d6a             ; 3 cycles

                lda     #27
                sta     <VIA_port_a        	; put X to DAC 

; 10
                ldb    #2            ; 2 cycles
d5a:            decb                   ; 2 cycles
                bpl     d5a             ; 3 cycles

                lda     #25
                sta     <VIA_port_a        	; put X to DAC 

                nop
                nop
                nop
                nop
                nop

                lda     #15
                sta     <VIA_port_a        	; put X to DAC 

                nop
                nop
                nop
                nop
                nop

                lda     #10
                sta     <VIA_port_a        	; put X to DAC 

; 9
                ldb    #2            ; 2 cycles
d4a:            decb                   ; 2 cycles
                bpl     d4a             ; 3 cycles


                lda     #5
                sta     <VIA_port_a        	; put X to DAC 


                nop

                lda     #3
                sta     <VIA_port_a        	; put X to DAC 

                nop

                lda     #-5
                sta     <VIA_port_a        	; put X to DAC 

                nop

                lda     #-13
                sta     <VIA_port_a        	; put X to DAC 

                nop

                lda     #-18
                sta     <VIA_port_a        	; put X to DAC 

; 14
                ldb    #3            ; 2 cycles
d3a:            decb                   ; 2 cycles
                bpl     d3a             ; 3 cycles


                lda     #0        ; nose top
                sta     <VIA_port_a        	; put X to DAC 

                nop
           
                lda     #10
                sta     <VIA_port_a        	; put X to DAC 
            
                nop

                lda     #20
                sta     <VIA_port_a        	; put X to DAC 

                nop
                nop

                lda     #30
                sta     <VIA_port_a        	; put X to DAC 

                nop
                nop

                lda     #40
                sta     <VIA_port_a        	; put X to DAC 

                nop
                nop

                lda     #45
                sta     <VIA_port_a        	; put X to DAC 

                nop
                nop

                lda     #55
                sta     <VIA_port_a        	; put X to DAC 

; 15
                ldb    #3            ; 2 cycles
d2a:            decb                   ; 2 cycles
                bpl     d2a             ; 3 cycles


                lda     #20
                sta     <VIA_port_a        	; put X to DAC 

                nop
                nop
                nop

                lda     #-20
                sta     <VIA_port_a        	; put X to DAC 





                lda     #-60
                sta     <VIA_port_a        	; put X to DAC 


                lda     #-80
                sta     <VIA_port_a        	; put X to DAC 

                lda     #-127
                sta     <VIA_port_a        	; put X to DAC 

                lda     #-80
                sta     <VIA_port_a        	; put X to DAC 

                lda     #-60                                ; nose bottom
                sta     <VIA_port_a        	; put X to DAC 


                lda     #10                                            
                sta     <VIA_port_a        	; put X to DAC 

                lda     #50                                            
                sta     <VIA_port_a        	; put X to DAC 

                lda     #40                                            
                sta     <VIA_port_a        	; put X to DAC 

; 6                
                ldb    #1            ; 2 cycles
d1a:            decb                   ; 2 cycles
                bpl     d1a             ; 3 cycles


                lda     #0                                            
                sta     <VIA_port_a        	; put X to DAC 


                lda     #-100                                            
                sta     <VIA_port_a        	; put X to DAC 

                lda     #-80                                            
                sta     <VIA_port_a        	; put X to DAC 

                nop


; line between lips (to the left)




                ldd     #$1881
                stb     <VIA_port_b        	; disable MUX, disable ~RAMP
                sta     <VIA_aux_cntl      	; AUX: shift mode 4. PB7 not timer controlled. PB7 is ~RAMP

                lda     #-13              	; destination Y 
                sta     <VIA_port_a        	; destination Y to DAC

                decb                      	; b now $80
                stb     <VIA_port_b        	; enable MUX

                clrb
                inc     <VIA_port_b        	; MUX off, only X on DAC now
                stb     <VIA_port_a        	; X to DAC

             
                incb
                stb     <VIA_port_b        	; MUX disable, ~RAMP enable. Start integration

                lda     #-127
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)
                nop

    
; line between lips (to the right)




                ldd     #$1881
                stb     <VIA_port_b        	; disable MUX, disable ~RAMP
                sta     <VIA_aux_cntl      	; AUX: shift mode 4. PB7 not timer controlled. PB7 is ~RAMP

                lda     #-1              	; destination Y 
                sta     <VIA_port_a        	; destination Y to DAC

                decb                      	; b now $80
                stb     <VIA_port_b        	; enable MUX

                clrb
                inc     <VIA_port_b        	; MUX off, only X on DAC now
                stb     <VIA_port_a        	; X to DAC

             
                incb
                stb     <VIA_port_b        	; MUX disable, ~RAMP enable. Start integration

                lda     #127
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)
                nop



; lower part of face

                 ;           clr     <VIA_shift_reg  	; Blank beam in VIA shift register
       


                ldd     #$1881
                stb     <VIA_port_b        	; disable MUX, disable ~RAMP
                sta     <VIA_aux_cntl      	; AUX: shift mode 4. PB7 not timer controlled. PB7 is ~RAMP

                lda     #-30              	; destination Y 
                sta     <VIA_port_a        	; destination Y to DAC

                decb                      	; b now $80
                stb     <VIA_port_b        	; enable MUX

                clrb
                inc     <VIA_port_b        	; MUX off, only X on DAC now
                stb     <VIA_port_a        	; X to DAC

                lda     #100
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

                incb
                stb     <VIA_port_b        	; MUX disable, ~RAMP enable. Start integration

                lda     #20
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)



; 16
                ldb    #3            ; 2 cycles
d1:             decb                   ; 2 cycles
                bpl     d1             ; 3 cycles




                lda     #-20
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

                nop
                nop
                nop
                nop

                lda     #-43
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)



; 9
                ldb    #2            ; 2 cycles
d2:             decb                   ; 2 cycles
                bpl     d2             ; 3 cycles


                lda     #20
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

; 9
                ldb    #2            ; 2 cycles
d3:             decb                   ; 2 cycles
                bpl     d3             ; 3 cycles


                lda     #5
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

; 9
                ldb    #2            ; 2 cycles
d4:             decb                   ; 2 cycles
                bpl     d4             ; 3 cycles

                lda     #0
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

                nop
                nop
                nop

                lda     #-10
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

; 9
                ldb    #2            ; 2 cycles
d5:             decb                   ; 2 cycles
                bpl     d5             ; 3 cycles

                lda     #-30
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

; 9
                ldb    #2            ; 2 cycles
d6:             decb                   ; 2 cycles
                bpl     d6             ; 3 cycles

                lda     #-85
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

; 7
                ldb    #1            ; 2 cycles
d7:             decb                   ; 2 cycles
                bpl     d7             ; 3 cycles



                ldb     #$81              	; ramp off, MUX off
                stb     <VIA_port_b

                lda     #$98
                sta     <VIA_aux_cntl      	; restore usual AUX setting (enable PB7 timer, SHIFT mode 4)

                clr     <VIA_shift_reg  	; Blank beam in VIA shift register





                jsr     Reset0Ref               ; recalibrate crt (x,y = 0)
                lda     #$CE                    ; /Blank low, /ZERO high
                sta     <VIA_cntl               ; enable beam, disable zeroing

                ldd     #(32*256+(-17))         ; Y,X
                jsr     Moveto_d



; pupil

                ldb     #$ff
                stb     <VIA_shift_reg     	; pattern


                ldd     #$1881
                stb     <VIA_port_b        	; disable MUX, disable ~RAMP
                sta     <VIA_aux_cntl      	; AUX: shift mode 4. PB7 not timer controlled. PB7 is ~RAMP

                lda     #-50              	; destination Y -86
                sta     <VIA_port_a        	; destination Y to DAC

                decb                      	; b now $80
                stb     <VIA_port_b        	; enable MUX

                clrb
                inc     <VIA_port_b        	; MUX off, only X on DAC now
                stb     <VIA_port_a        	; X to DAC

                lda     #0
                sta     <VIA_port_a        	; put X to DAC  (it's before RAMP enable to avoid straight line chunk)

                incb
                stb     <VIA_port_b        	; MUX disable, ~RAMP enable. Start integration

                nop
                nop

                lda     #-23
                sta     <VIA_port_a        	; put X to DAC 

                nop
                nop

                lda     #-48
                sta     <VIA_port_a        	; put X to DAC 

                nop


                ldb     #$81              	; ramp off, MUX off
                stb     <VIA_port_b

                lda     #$98
                sta     <VIA_aux_cntl      	; restore usual AUX setting (enable PB7 timer, SHIFT mode 4)

                clr     <VIA_shift_reg  	; Blank beam in VIA shift register




                bra     loop

; Text lines
; height, width, rel y, rel x, string, eol ($80)

alltext:
                db      $fb,$20,0,-113,'FACE',$80
                db      $fc,$20,30,-113,'646 BYTES',$80
                db      $fc,$20,14,-113,'BY FROG',$80
                db      $fc,$20,-4,-113,'FOR CC',$27,'2024',$80
                db      0

dot_list:
                db       100,60                 ; several dots, relative
                db      -20, 40                 ; position, Y, X
                db       -30, -10
                db       -50, 30
                db       -50, -40
                db       -25, 10
