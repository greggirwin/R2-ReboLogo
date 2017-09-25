REBOL [
	File:	%REBOLogo.r
	Title:  "REBOLogo - Logo in REBOl"
	Author: "Gregg Irwin"
	Email:	gregg@pointillistic.com
	Copyright: "Copyright © 2001-2005 Pointillistic Software. All Rights Reserved"
]

random/seed now/precise

progs: load/all %rebologo-progs.r

right-90: 90	; lookup test-var


logo: context [
	val: val-2: 0
	world-canvas: turtle-face: none
	repeat-block: copy []
	rep-blks: []
	stack: make block! 32
	two-pi: 2 * pi
	draw-cmds: make block! 1000
	;append draw-cmds [line-join round line-cap round]
	append draw-cmds [line-cap square]
	routines: copy []
	lit-quote: to-lit-word {"}
	user-proc: none
	user-proc-args: make block! 10

	colors: [
		red 	255.0.0
		green	0.255.0
		blue	0.0.255
		yellow	255.255.0
		magenta 255.0.255
		cyan	0.255.255
		any 	[random 255.255.255]
	]

	begins-with?: func [s val][return (copy/part s (length? val)) = val]

	push: func [value] [insert tail stack :value]
	pop:  func [value] [remove back tail stack]

	degrees-from-radians: func [radians[number!]] [
		(radians * 180) / pi
	]
	radians-from-degrees: func [degrees[number!]] [
		(pi * degrees) / 180
	]

	parse-set-arg-code: func [args[block!] /local result arg] [
		result: make block! length? args
		;bind args 'val
		foreach arg args [
			append result reduce ['set arg]
		]
		;print mold/only result
		return result
	]

	turtle-face-draw: func [
		"Returns the draw effect commands used to draw the turtle's body and head."
		/local head-xy
	][
		head-xy: 0x0
		head-xy/x: ((sine turtle/get-heading) * 8) + 12
		head-xy/y: ((negate cosine turtle/get-heading) * 8) + 12
		[pen 0.0.0 fill-pen 0.255.0 circle 12x12 6 circle head-xy 4]
	]

	clear-screen: does [
		clear head draw-cmds
		append draw-cmds [line-cap square]
		;turtle/home
	]

	turtle: make object! [
		;------------------;
		;  Turtle Compass  ;
		;------------------;
		;		 0		   ;
		;				   ;
		; 270	 T	   90  ;
		;				   ;
		;		180 	   ;
		;------------------;
		heading:	radians-from-degrees 270	; see also: set-heading
		pen-state:	'up    ; up down erase	(to erase draw with pen-color: back-color)
		pen-color:	0.0.0
		pen-width:  1
		location:	320x240
		previous-location: 320x240
		hiding: 	false	 ; This this sounds more fun than "hidden". :)
		; We need to store the xy pair for the turtle in decimal values or rounding
		; will screw us up big time.
		loc-x: 320.0
		loc-y: 240.0
		show-drawing: true

		append draw-cmds compose [pen 0.0.0 line (previous-location) (location)]

		get-heading: does [
			(degrees-from-radians heading) - 270
		]
		set-heading: func [degrees[number!]] [
			; Normally a 0 heading would point us to the right
			; but we want a 0 heading to point us straight up
			; (to match Logo more closely). We add an offset
			; of 270 degrees to achieve this.
			heading: radians-from-degrees((degrees // 360) + 270)
			;heading: radians-from-degrees (degrees + 270)
			;If heading > two-pi [heading: heading - two-pi]
			;If heading < negate two-pi [heading: heading + two-pi]
			if not turtle/hiding [show-turtle]
		]

		move: func [distance [number!]] [
			;print ["move" distance]
			; Store current cooridnates
			previous-location: location
			; Calculate new coordinates
			;location/x: location/x + (distance * (cosine/radians heading))
			;location/y: location/y + (distance * (sine/radians heading))
			;turtle-face/offset: location
			loc-x: loc-x + (distance * (cosine/radians heading))
			loc-y: loc-y + (distance * (sine/radians heading))
			turtle-face/offset: to-pair compose [(to-integer loc-x) (to-integer loc-y)]
			location: :turtle-face/offset
			if not turtle/hiding [show turtle-face]
			; Draw line if neccessary
			if turtle/pen-state <> 'up [
				append draw-cmds reduce turtle-face/offset
				;print mold draw-cmds
				world-canvas/effect: reduce [to-word 'draw :draw-cmds]
				if turtle/show-drawing [show world-canvas]
			]
			;wait .05
			wait 0
		]
		
		type: func [text] [
			if turtle/pen-state <> 'up [
				append draw-cmds reduce [
					'font 'bold32
					'text turtle-face/offset 'anti-aliased text
				]
				;print mold draw-cmds
				world-canvas/effect: reduce [to-word 'draw :draw-cmds]
				if turtle/show-drawing [show world-canvas]
			]
			;wait .05
			wait 0
		]

		turn: func [degrees[number!]] [
			;print ["turn" degrees]
			; We get a slightly different result using set-heading this way.
			; Look at the left-side corners of the box using the test prog.
			;set-heading get-heading + degrees
			heading: heading + (radians-from-degrees degrees)
			If heading > two-pi [heading: heading - two-pi]
			If heading < negate two-pi [heading: heading + two-pi]
			if all [turtle/show-drawing (not turtle/hiding)] [show-turtle]
		]

		circle-left: func [radius[number!]] [
		]
		circle-right: func [radius[number!]] [
		]
		arc-left: func [radius[number!] degrees[number!]] [
		]
		arc-right: func [radius[number!] degrees[number!]] [
		]

		show-turtle: does [
			turtle-face/effect/draw: turtle-face-draw
			show turtle-face
		]

		home: does [
			turtle/set-heading 0
			turtle/previous-location: set-pos world-canvas/size / 2
		]

		set-pos: func [pos [pair!]] [
			turtle/location: pos
			turtle/loc-x: pos/x
			turtle/loc-y: pos/y
			turtle-face/offset: to-pair compose [(pos/x) (pos/y)]
			if not turtle/hiding [show-turtle]
			pos
		]
	]

	
	parms: copy []
	params: [
		(clear parms)
		any [
			set parm get-word! (append parms parm)
		]
	]

	value=: [
		set val number! 
		| 'pos (val: as-pair turtle/loc-x turtle/loc-y)
		| 'heading (val: turtle/get-heading) 
		| 'random set val number! (val: random val)
		| 'get set val [word! | get-word!] (val: get val)
		| set val get-word! (val: get val)
		;| [set val [paren! | block!] (val: do val)]
	]	
	
	text=: [set =text any-string!]
	bold32: make face/font [style: 'bold size: 32]

	
	; Items that need numeric arguments should be modified to look for
	; expressions also so the results of math ops can feed them.
	rules: [
		some [
			['forward | 'fd] value= (turtle/move val) |
			['back | 'bk]	 value= (turtle/move negate val) |
			['right | 'rt]	 value= (turtle/turn val) |
			['left | 'lt]	 value= (turtle/turn negate val) |
			'set-heading value= (turtle/set-heading val) |
			['pen-up | 'pu]    (
				;if turtle/pen-state <> 'up [
				;	 append draw-cmds compose (turtle/previous-location)
				;]
				turtle/pen-state: 'up
			)	|
			['pen-down | 'pd]  (
				turtle/pen-state: 'down
				;append draw-cmds compose [pen (turtle/pen-color) line]
				append draw-cmds compose [line (turtle/location)]
			) |
			['pen-erase | 'pe] (
				turtle/pen-state: 'erase
				append draw-cmds compose [pen world-canvas/color line]
			) |
			['set-pen-color | 'set-pc] set val [tuple! | word!] (
				; We "do" our color because it may be evaluted (e.g. random)
				val: either (type? val) = tuple! [val][do select colors val]
				turtle/pen-color: val ;either (type? val) = tuple! [val][do select colors val]
				append draw-cmds compose [pen (val) line (turtle/location)]
			) |
			['set-pen-width | 'set-pw] value= (
				turtle/pen-width: val 
				append draw-cmds compose [line-width (val) line (turtle/location)]
			) |
			['set-background-color | 'set-bg] set val [tuple! | word!] (
				; We "do" our color because it may be evaluted (e.g. random)
				world-canvas/color: either (type? val) = tuple! [val][do select colors val]
				show world-canvas
			) |
			['set-position | 'set-pos] value= (
				turtle/set-pos val
			) |
			['hide-turtle | 'ht] (
				turtle/hiding: true
				hide turtle-face
			) |
			['show-turtle | 'st] (
				turtle/hiding: false
				show turtle-face
			) |
			'home  (turtle/home) |
			'clean (
				clear head draw-cmds
			) |
			['clear-screen | 'cs] (
				clear head draw-cmds 
				turtle/home
			) |
			'show-drawing set val word! (
				turtle/show-drawing: either val = 'true [true][false]
			) |
 			[['wait | 'sleep] [value= | set val time!]] (
 				wait val
 			) |
			
 			[set cmd ['print | 'pr | 'type] [text= | value= (=text: form val)]] (
 				use [lay face sz] [
 					lay: layout [face: text =text font bold32]
 					sz: size-text face
 					face: lay: none
	 				turtle/type =text
	 				turtle/set-pos add turtle/location either cmd = 'type 
	 					[as-pair sz/x 0] [as-pair 0 sz/y]
				]
 			) |
			
; 			['if value= set then block!] (
; 				if val [do then]
; 			) |
; 			
; 			'stop (break) |
			
			;'circle-left  set val number! |
			;'circle-right set val number! |
			;'arc-left	set val number! set val-2 number! |
			;'arc-right set val number! set val-2 number! |
			;'add set val number! set val-2 number! (push add val val-2) |
			;['subtract | 'sub] set val number! set val-2 number! (push subtract val val-2) |
			;['multiply | 'mul] set val number! set val-2 number! (push multiply val val-2) |
			;['divide | 'div] set val number! set val-2 number! (push divide val val-2) |
			
			; TO CHAIR  :thesize
            ; REPEAT 4 [FD :thesize  RT 90] FD :thesize FD :thesize
            ; END
            ; With the above, why can't we use [some get-word!] (did I ever
            ; try that?) to collect the parameter list. 
            ; You may also be able to do this (e.g in Elica):
            ;   TO :x greater-than :y ...
            ; which is called like this
            ;   if 5 greater-than

			'to set val word! params proc-mark: thru 'end end-mark: (
				; OK, now we have the routine information, and we dynamically
				; add the routine name to the our rule block and put the
				; associated code in there as well, so the parser automatically
				; exectutes them as if they were native. Could it also be
				; extended, albeit with more syntax required, to handle routines
				; with parameters and return values?
				; Note that this is kind of an odd way to tackle it but, hey,
				; trying new things is part of the game, right? It isn't a
				; scalable approach, but it's fun to see that you can create
				; routines this way, using the original data structure of
				; parse rules in place of a separate one for user-defined items.
				user-proc: copy/part proc-mark back end-mark
				append routines val
				append/only routines to-block user-proc
				
				user-proc-args: :parms
								
				append select rules 'some reduce compose/deep [
					to-word "|" to-lit-word val
				]
				foreach arg user-proc-args [
					append select rules 'some reduce ['set to word! arg 'value=]
				]
				append select rules 'some reduce compose/deep [
					to-paren [
						parse (reduce [user-proc]) rules
					]
				]
				;print mold rules
			) |
			'repeat value= set repeat-block block! (
				; 13-May-2002 Added ability to define vars with SET and then
				; added the GET code here to retrieve them. NOT TESTED BEYOND
				; ONE VERY SIMPLE EXAMPLE SO FAR!!!
				if word? val [val: get val]
				; If we didn't allow nested repeat blocks, this would be simpler.
				; Since we do, we have to push them on a stack (of sorts).
				append rep-blks val
				;print [mold compose/deep repeat-block]
				append/only rep-blks repeat-block
				; Can I safely use val as my repeat counter? Also, ct gets re-used
				; at each level of nesting. Hmmm.
				;repeat ct first back back tail rep-blks [
				;repeat ct first skip tail rep-blks -2 [
				repeat ct val [
					;print ["repeat count" ct]
					;print ["parsing repeat block" ct mold last rep-blks]
					; Should we call parse directly here? Do-prog doesn't give us
					; any real advantage in this simple implementation.
					parse compose last rep-blks rules
					;do-prog last rep-blks
				]
				; Remove the last repeat count and block.
				clear back back tail rep-blks
			)
			;| lit-quote set val word!
			;| 'word set val string set val-2 string! (push join val val-2)

			;| 'set set word word! set val [number! | series!] (set word val)
			;| 'get set word lit-word! (get word)

			; Added 13-May-2002 Largely untested. Word values (i.e. variables)
			; are only implemented in REPEAT handler right now.
			| 'set set word word! set val number!  (
				set word val
				append select rules 'some reduce compose/deep [
					to-word "|" to-lit-word word
				]
				append select rules 'some reduce compose/deep [
					to-paren [(val)]
				]
				;print mold rules
			)
		]
	]
	;-- This is the end of the parsing rules


	;-- This is what you call to execute a Logo program.
	do-prog: func [prog [block!]] [
		ok: parse prog rules
		if not ok [
			alert "Error parsing program."
		]
	]

	;-- This is the world layout where the turtle will roam.
	;-- REBOL is slow to redraw the world (i.e. show world-canvas) and the
	;	size of the world directly affects the speed. Smaller faces redraw
	;	much faster than larger ones.
	world: compose/deep [
		size 800x600 ;640x480
		at 0x0
		prog-list: text-list 125x350 data sort extract progs 2 [
			do-prog compose select progs prog-list/picked
			show world-canvas
		]
		button "Clear" [
			clear-screen
			show world-canvas
		]
		button "Home" [turtle/home]
		button "Quit" [quit]
		button "Save" [save/png %drawing.png to image! world-canvas]
		at 400x300 ;320x240
		turtle-face: image 25x25 effect [
			draw [pen 0.0.0 fill-pen 0.255.0 circle 12x12 6 circle 12x4 4]
		]
	]

	world-canvas: layout world
	turtle/home
	
]

view center-face logo/world-canvas


