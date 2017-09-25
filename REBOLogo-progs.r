; The Turtle is stateful right now, if you run prog after prog. Just FYI.

; spaz-cmds-1 [
;     lt 25 rt 12.5 fd 100 bk 50
;     pu pd pe home hide-turtle show-turtle
;     set-pen-color 0.0.255 clear-screen
;     repeat 15 [fd 10 repeat 3 [left 20 back 3] rt 90]
;     set-bg 175.185.195
; ]

circle-no-draw [
    pen-up
    repeat 180 [fd 2 rt 2]
    set-bg 175.185.195
]

circ-sq-tri [
    ;home clean
    pen-down
    set-pen-color any
    repeat 30 [fd 12 lt 12]
    set-pen-color any
    repeat 4 [repeat 10 [fd 10] rt get right-90]
    rt 120
    set-pen-color any
    repeat 3 [repeat 12 [fd 10] rt 120]
    set-pen-color any
    home
]

bee-dance [
    home clean
    pen-down
    repeat 2 [repeat 30 [fd 12 lt 12] repeat 30 [fd 12 rt 12] lt 90]
    pen-up
]

box-tri-procs [
    home clean
    to box
        pen-down
        set-pen-color any
        repeat 4 [fd 100 rt 90]
    end
    to triangle
        pen-down
        set-pen-color any
        repeat 3 [fd 100 rt 120]
    end
    box
    triangle
    to tri-box
        box
        triangle
    end
    repeat 3 [
        left 90
        tri-box
    ]
    pen-up
    fd 200
    set-heading 180
    tri-box
]


dash-line [
    set-pen-color any
    repeat 10 [pd fd 10 pu fd 10]
]


; bee-dance-2 [
;     home clean
;     ; Going forward and back slows him down so we can watch
;     ; if the pen is up. NOTE: with the new system here, it
;     ; runs fast if run first. After other progs have run, it's
;     ; very slow. Have to look into that.
;     repeat 8 [
;        repeat 360 [fd 1 back 1 fd 1 rt 1]
;        repeat 360 [fd 1 back 1 fd 1 lt 1]
;     ]
; ]


swirls [
    home clean
    set-pen-color any
    pen-down
    repeat 8 [ repeat 8 [fd 20 rt 45] lt 45]
]

; If I run this program a whole bunch of times, eventually REBOL
; will crash and die. Crashes on run 46.
; Clicking too fast causes other issues because I'm not queueing
; up the requests, just calling it directly.
; Fine under View 1.3.
; swirls-2 [
;     set num-swirls (_A: max 4 random 40)
;     set num-sides (_B: max 4 random 40)
;     set side-len (_C: max 10 random 40)
;     home clean
;     hide-turtle
;     show-drawing false
;     set-pen-color (random 200.200.200) ;any
;     pen-down
;     ; Have to put vars in parens to be composed for now.
;     ;(print reduce [_A _B _C]) ; this makes the crash go away.
;     repeat num-swirls [
;         repeat num-sides [
;             fd (side-len) rt (360 / num-sides)
;         ]
;         lt (360 / num-swirls)
;     ]
;     show-drawing true
;     ;show-turtle
; ]

swirls-2 [
    ; You have to put vars in parens to be composed for now.
    set num-swirls (max 4 random 40)
    set num-sides (max 4 random 40)
    set side-len (max 10 random 40)
    home clean
    hide-turtle
    show-drawing false
    set-pen-color (random 200.200.200) ;any
    pen-down
    repeat get :num-swirls [
        repeat get :num-sides [
            fd (side-len) rt (360 / num-sides)
        ]
        lt (360 / num-swirls)
    ]
    show-drawing true
    ;show-turtle
]

just-keep-swirling [
	repeat 10 [
		show-turtle
	    ; You have to put vars in parens to be composed for now.
	    set num-swirls (max 4 random 30)
	    set num-sides (max 4 random 30)
	    set side-len (max 20 random 30)
	    home clean
	    ;hide-turtle
	    ;show-drawing false
	    set-pen-color (random 200.200.200) ;any
	    pen-down
	    repeat get :num-swirls [
	        repeat get :num-sides [
	            fd (side-len) rt (360 / num-sides)
	        ]
	        lt (360 / num-swirls)
	    ]
	    ;show-drawing true
	    ;show-turtle
	    hide-turtle
	    wait 3
	]	
	show-turtle
]


just-keep-drawing [
	repeat 10 [
		show-turtle
	    ; You have to put vars in parens to be composed for now.
	    set num-swirls (max 8 random 25)
	    set num-sides (max 4 random 15)
	    set side-len (max 50 random 125)
	    set turn-1 (max 10 random 359)
	    set turn-2 (max 10 random 359)
	    
	    home clean
	    ;hide-turtle
	    ;show-drawing false
	    set-pen-color (random 200.200.200) ;any
	    pen-down
	    repeat get :num-swirls [
	        repeat get :num-sides [
	            fd (side-len) rt (turn-1) ;(360 / num-sides)
	        ]
	        lt get :turn-2 ;(360 / num-swirls)
	    ]
	    ;show-drawing true
	    ;show-turtle
	    hide-turtle
	    wait 3
	]	
	show-turtle
]


; spiral [
;     set num-steps (max 10 random 60)
;     set turn-per-step (max 1 random 4)
;     set move-per-step (max 4 random 20)
;     set turn-amt 0
;     home clean
;     hide-turtle
;     show-drawing false
;     set-pen-color any
;     pen-down
;     ; Have to put vars in parens to be composed for now.
;     repeat num-steps [
;         set turn-amt (turn-amt + turn-per-step)
;         fd (move-per-step)
;     ]
;     show-drawing true
;     show-turtle
; ]

spiro-1 [
    home clean
    repeat 40 [
        pd
        fd 40
        rt 90
        fd 40
        lt 45
        fd 25
        lt 90
        fd 25
        lt 45
        fd 80
        pu
        rt 20
    ]
]

super-circ [
    home clean
    pd
    hide-turtle
    show-drawing false  ; don't show drawing in progress
    repeat 180 [  ; use repeat 180 for a complete circle
        set-pen-color any
        repeat 2 [
            repeat 3 [fd 60 rt 90]
            fd 60
            repeat 3 [bk 120 rt 90]
            back 120
        ]
        rt 1
    ]
    show-drawing true
    show-turtle
]

super-circ-show [
    home clean
    pd
    hide-turtle
    repeat 180 [
        set-pen-color any
        repeat 2 [
            repeat 3 [fd 60 rt 90]
            fd 60
            repeat 3 [bk 120 rt 90]
            back 120
        ]
        rt 1
    ]
]

param-test [
    to poly :side :angle  :count
        repeat get :count [ 
            fd get side
            rt get :angle
            poly (:side) (:angle) (:count - 1) 
        ]
    end
    pen-down
    set-pen-color any
    ;poly 30 12 3
    poly 150 75 8
    ;fd 50 rt 90 fd 50
]

param-test-2 [
    to poly-spi :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             poly-spi (:side - 5) (:angle) (subtract :count 1)
         ]
    end
    pen-down
    set-pen-color any
    poly-spi 100 90 5
]

param-test-3 [
    to poly-spi :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             poly-spi (:side - 5) (:angle) (subtract :count 1)
         ]
    end
    pen-down
    set-pen-color any
    poly-spi 150 90 12
]

penta-spiro-1 [
    to poly-spi :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             poly-spi (:side - 5) (:angle) (subtract :count 1)
         ]
    end
    pen-down
    set-pen-color any
    poly-spi 150 72 7
]

tri-spiro-1 [
    to poly-spi :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             poly-spi (:side - 5) (:angle) (subtract :count 1)
         ]
    end
    pen-up
    set-pen-color any
    ;back 150
    ;rt 90
    ;back 150
    ;lt 90
    lt 90
    fd 125
    rt 90
    pen-down
    repeat 6 [
	    poly-spi 150 120 11
	    set-pen-color any
	    right 60
	]
]

tri-penta-spiro-1 [
	;show-drawing false hide-turtle
    to poly-spi :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             poly-spi (:side - 5) (:angle) (subtract :count 1)
         ]
    end
    pen-up
    set-pen-color any
    lt 90
    fd 125
    rt 90
    ;bk 50
    pen-down
    repeat 6 [
	    poly-spi 150 120 11
	    set-pen-color any
	    right 60
	]
	pen-up rt 60 fd 110 pen-down
    to poly-spi-2 :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             poly-spi-2 (:side - 1) (:angle) (subtract :count 1)
         ]
    end
    set-pen-color any
    poly-spi-2 110 60 14
    pu fd 20 set-heading 0 fd 20
    ;show-turtle
]

swirl-spiro-1 [
    to poly-spi :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             poly-spi (:side - 5) (:angle) (subtract :count 1)
         ]
    end
    pen-down
    set-pen-color any
    poly-spi 150 75 7
]


penta-spiro-2 [
    to penta-spi-2 :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             penta-spi-2 (:side - 2) (:angle) (subtract :count 1)
         ]
    end
    pen-down
    repeat 6 [
	    set-pen-color any
    	penta-spi-2 50 60 12
    	rt 60
	]
]

sq-spiral-wander [
    to sq-spiral-wander :side :angle :count
         repeat get :count [
             fd get :side
             rt get :angle
             sq-spiral-wander (:side - 2) (:angle) (subtract :count 1)
         ]
    end
    pen-down
    repeat random 12 [
	    set-pen-color any
	    rt random 360
    	sq-spiral-wander 100 90 10
    	;pu
    	lt random 100 fd random 200
    	;pd
	]
]

REBOL [
	cs
	pu
	lt 90
	repeat 50 [fd 5 wait .01]
	rt 90
	repeat 10 [back 10 wait .01]
	pen-down
	set-pen-color blue 
	
	set-pen-width 7
	
	; R
	repeat 20 [fd 10]
	rt 90
	repeat 5 [fd 10]
	repeat 30 [fd 5 rt 6]
	repeat 5 [fd 10]
	fd 5
	rt 180
	repeat 5 [fd 9]
	rt 60
	repeat 12 [fd 10]
	
	lt 60
	pu
	repeat 2 [fd 10]
	pd
	
	; E
	repeat 10 [fd 10]
	repeat 10 [back 10]
	lt 90
	repeat 20 [fd 10]
	rt 90		
	repeat 10 [fd 10]
	repeat 10 [back 10]
	rt 90
	repeat 9 [fd 10]
	lt 90
	repeat 7 [fd 10]

	pu
	repeat 5 [fd 10]
	pd	
	
	; B
	lt 90
	bk 5
	rt 90
	repeat 5 [fd 10]  
	repeat 30 [fd 5 lt 6]
	;repeat 27 [fd 5 lt 6]
	;lt 18
	repeat 5 [fd 10]
	fd 5
	lt 90
	repeat 20 [fd 10]
	lt 90	
	repeat 5 [fd 10]
	repeat 27 [fd 6 lt 6]
	;repeat 5 [fd 10]
	
	pu 
	rt 162
	
	; O 
	set-pen-width 10
	set-pen-color red
	;repeat 2 [fd 10]
	bk 10 lt 90 bk 15
	pd
	repeat 36 [fd 22 rt 10]
	pu rt 90 
	repeat 7 [fd 10]
	lt 90 pd
	repeat 36 [fd 10 rt 10]
	
	; L
	set-pen-width 7
	pu rt 90 
	repeat 15 [fd 10 ]
	pd
	set-pen-color blue 
	lt 90 
	repeat 11 [fd 10]
	repeat 20 [bk 10]
	rt 90
	repeat 11 [fd 10]
	
	pu
	rt 90 fd 25
	set-pen-width 7
	set-pen-color red
	rt 90 bk 8 pd
	repeat 132 [fd 5]
	
	pu
	lt 135
	repeat 45 [fd 18 lt 3]	
	repeat 120  [rt 1]
	repeat 180 [lt 1]
	repeat 30  [fd 5]
	repeat 120  [rt 1]
	repeat 240 [lt 1]
	repeat 30  [fd 5]
	repeat 50  [rt 1]
	repeat 7   [fd 5]
	rt 130
	;pd fd  200
	repeat 5 [repeat 60 [rt 6]]
	repeat 60  [fd 5]
	repeat 60  [bk 5]
	
	set-pen-width 1
	
	
]

; print-REBOL [
; 	pen-down
; 	print "REBOL"
; ]

; type-REBOL [
; 	pen-down
; 	type "REBOL"
; ]

print-and-type [
	fd 250 lt 90 fd 250 rt 90
	repeat 10 [
		pd
		repeat 5 [
			set-pen-color any
			type "REBOL"
			wait .1
		]
		pu
		bk 50 lt 90 fd 565 rt 90
		wait .2
	]
]

squiggle [
	pen-down
	to squiggle
		forward 100
		right 135
		forward 40                        
		right 120
		forward 60
		right 15
	end
	repeat 40 [squiggle rt 20]
]

feynman [
	
	set-pen-width 2
	bk 200 rt 90 fd 200 lt 90
	pd
	lt 20
	fd 200
	rt 40 
	fd 200 
	bk 200
	lt 50
	repeat 4 [
		repeat 30 [fd 1 lt 4]
		repeat 30 [fd 1 rt 4]
	] 
	rt 10 fd 200 bk 200
	lt 140
	fd 200
	pu
	
	wait 5
	cs
	
	set-pen-width 2
	pd
	rt 20
	bk 200 fd 200 
	lt 40
	bk 200 fd 200 
	rt 80
	repeat 4 [
		repeat 30 [fd 1 lt 4]
		repeat 30 [fd 1 rt 4]
	] 
		
	wait 5
	cs
	
	set-pen-width 2
	pd
	rt 180
	rt 20
	bk 200 fd 200 
	lt 40
	bk 200 fd 200 
	rt 80
	repeat 4 [
		repeat 30 [fd 1 lt 4]
		repeat 30 [fd 1 rt 4]
	] 
	
]

; feynman [
; 	to electron
; 		fd 100 
; 		lt 90 fd 25 rt 120 fd 50 rt 60 fd 50 rt 120 fd 25 rt 90
; 		fd 100
; 	end
; 	to positron
; 		fd 100 
; 		lt 90 fd 25 rt 120 fd 50 rt 60 fd 50 rt 120 fd 25 rt 90
; 		fd 100
; 	end
; 	to photon
; 		repeat 4 [
; 			repeat 30 [fd 1 lt 4]
; 			repeat 30 [fd 1 rt 4]
; 		] 
; 	end
; ]


; impressive [
; 	to design 
; 		clean
; 		home
; 		pen-up
; 		;window
; 		repeat 5 [
; 			fd 64.65 pd 
; 			;set xy pos
; 			wheel pos ; get :xy
; 			pu bk 64.25 rt 72
; 		]
; 		pu home rt 36 fd 24.5 rt 198 pd
; 		centerpiece 46 143.4
; 	end
; 	to wheel :init-pos
; 		rt 54 repeat 4 [pentpiece get :init-pos]
; 		pd lt 36
; 		repeat 5 [tripiece get :init-pos]
; 		lt 36
; 		repeat 5 [pd rt 72 fd 28 pu bk 28]
; 		lt 54
; 	end
; 	to tripiece :init-pos
; 		repeat 1 [
; 			set tri-old-heading heading
; 			pd bk 2.5
; 			tripolyr 31.5
; 			pu set-pos (:init-pos) set-heading get :tri-old-heading
; 			pd bk 2.5
; 			tripolyl 31.5
; 			pu set-pos (:init-pos) set-heading get :tri-old-heading
; 			lt 72
; 		]
; 	end
; 	to pentpiece :init-pos
; 		repeat 1 [ 
; 			set pent-old-heading heading
; 			pu fd 29 pd
; 			repeat 5 [fd 18 rt 72]
; 			pentr 18 75
; 			pu set-pos (:init-pos) set-heading get :pent-old-heading
; 			fd 29 pd
; 			repeat 5 [fd 18 rt 72]
; 			pentl 18 75
; 			pu set-pos (:init-pos) set-heading get :pent-old-heading
; 			lt 72		
; 		]
; 	end
; 	to pentl :side :ang
; 		repeat 1 [
; 			if (:side < 2) [stop]
; 			fd (:side)
; 			lt (:ang)
; 			pentl (:side - .38) :ang
; 		]
; 	end
; 	to pentr :side :ang
; 		repeat 1 [
; 			if (:side < 2) [stop]
; 			fd (:side)
; 			rt (:ang)
; 			pentl (:side - .38) :ang
; 		]
; 	end
; 	to tripolyr :side
; 		repeat 1 [
; 			if (:side < 4) [stop]
; 			fd (:side)
; 			rt 111
; 			fd (:side / 1.78)
; 			rt 111
; 			fd (:side / 1.3)
; 			rt 146
; 			tripolyr (:side * .75)
; 	]
; 	end
; 	to tripolyl :side
; 		repeat 1 [
; 			if (:side < 4) [stop]
; 			fd (:side)
; 			lt 111
; 			fd (:side / 1.78)
; 			lt 111
; 			fd (:side / 1.3)
; 			lt 146
; 			tripolyl (:side * .75)
; 		]
; 	end

; 	to centerpiece :s :a
; 		repeat 1 [
; 			fd get :s
; 			lt get :a
; 			if (:s < 7.5) [stop]
; 			centerpiece (:s - 1.2) get :a
; 		]
; 	end
; 	
; 	design

; 	
; ]


greek-key-1 [
	lt 90
	fd 200
	rt 90
	set-pen-width 3
	pd
	to key :sz
		; have to put these in a block so they don't get composed
		; on the intial load.
		repeat 1 [
			fd :sz       rt 90 fd :sz       rt 90
			fd (:sz / 2) rt 90 fd (:sz / 2) lt 90
			fd (:sz / 2) lt 90 fd :sz       lt 90
		]
	end
	to key-20   key 20   end
	to key-40   key 40   end
	repeat 5 [key-20]
]

greek-key-heart-1 [
	to key :sz
		; have to put these in a block so they don't get composed
		; on the intial load.
		repeat 1 [
			fd :sz       rt 90 fd :sz       rt 90
			fd (:sz / 2) rt 90 fd (:sz / 2) lt 90
			fd (:sz / 2) lt 90 fd :sz       lt 90
		]
	end
	to key-20   key 20   end
	to key-40   key 40   end
	to turn-key :sz :ang
		; have to put these in a block so they don't get composed
		; on the intial load.
		repeat 1 [
			fd :sz       
			rt 90 
			repeat 4 [fd (:sz / 4) rt (:ang / 4)]
			rt 90
			fd (:sz / 2) rt 90 fd (:sz / 2) lt 90
			fd (:sz / 2) lt 90 
			repeat 4 [fd (:sz / 4) rt (:ang / 4)]
			lt 90
		]
	end

	bk 200
	set-pen-width 4
	pd
	lt 125
	hide-turtle

	;repeat 8 [key-20]
	;;repeat 11 [key-20 rt 20]
	;repeat 11 [turn-key 20 12]

	show-drawing false

	repeat 9 [key-20]
	;repeat 11 [key-20 rt 20]
	repeat 11 [turn-key 20 8]
	lt 4 ; extra touch of turn
	fd 30
	lt 90 
	repeat 11 [turn-key 20 8]
	lt 5
	repeat 9 [key-20]
	;key 20
	;set-pen-color red
	rt 5 fd 15 rt 95 fd 10

	show-drawing true
]

greek-key-heart-2 [
	to key :sz
		; have to put these in a block so they don't get composed
		; on the intial load.
		repeat 1 [
			fd :sz       rt 90 fd :sz       rt 90
			fd (:sz / 2) rt 90 fd (:sz / 2) lt 90
			fd (:sz / 2) lt 90 fd :sz       lt 90
		]
	end
	to key-20   key 20   end
	to key-40   key 40   end
	to turn-key :sz :ang
		; have to put these in a block so they don't get composed
		; on the intial load.
		repeat 1 [
			fd :sz       
			rt 90 
			repeat 4 [fd (:sz / 4) rt (:ang / 4)]
			rt 90
			fd (:sz / 2) rt 90 fd (:sz / 2) lt 90
			fd (:sz / 2) lt 90 
			repeat 4 [fd (:sz / 4) rt (:ang / 4)]
			lt 90
		]
	end

	;set-bg white
	;clean
	bk 200
	set-pen-width 4
	pd
	lt 125
	hide-turtle

	;repeat 8 [key-20]
	;;repeat 11 [key-20 rt 20]
	;repeat 11 [turn-key 20 12]

	show-drawing false

	repeat 7 [key-20 lt 2]
	repeat 12 [turn-key 20 8]
	lt 4 ; extra touch of turn
	fd 30
	lt 90 
	repeat 12 [turn-key 20 8]
	lt 5
	repeat 7 [key-20 lt 2]
	;key 20
	;set-pen-color red
	;rt 5 fd 15 rt 95 fd 10

	show-drawing true
]

