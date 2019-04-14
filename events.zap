

	.FUNCT	I-ALARM-RINGING
	CALL	IN-LAB?,HERE
	ZERO?	STACK /FALSE
	PRINTI	"The "
	PRINTD	ALARM
	PRINTR	" continues to ring."


	.FUNCT	GRAB-ATTENTION,X,OBJ=0
	CALL	BAD-AIR?
	ZERO?	STACK \FALSE
	FSET?	X,BUSYBIT \?ELS7
	CALL	TOO-BAD-BUT,X,STR?195
	RFALSE	
?ELS7:	ZERO?	SNARK-ATTACK-COUNT /TRUE
	CALL	DONT-KNOW,X,OBJ
	RFALSE	


	.FUNCT	TELL-HINT,CARDNUM,OBJ,CR?=1
	ZERO?	CR? /?CND1
	CRLF	
?CND1:	PRINTI	"(If you want a clue, find Infocard #"
	DIV	CARDNUM,10
	PRINTN	STACK
	PRINTI	" in your "
	PRINTD	GAME
	PRINTI	" package. Read hidden clue #"
	MOD	CARDNUM,10
	PRINTN	STACK
	PRINTI	" and put """
	PRINTD	OBJ
	PRINTR	""" in the blank space.)"


	.FUNCT	I-LAMP-ON-SCOPE
	CALL	GLOBAL-IN?,VIDEOPHONE,HERE
	ZERO?	STACK /?ELS5
	ZERO?	ALARM-RINGING /FALSE
	FSET?	VIDEOPHONE,ONBIT /FALSE
	CALL	QUEUE,I-LAMP-ON-SCOPE,7
	PUT	STACK,0,1
	CALL	TELL-HINT,82,VIDEOPHONE
	RSTACK	
?ELS5:	ZERO?	SUB-IN-TANK /FALSE
	CALL	QUEUE,I-LAMP-ON-SCOPE,1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	I-SEND-SUB
	FSET?	VIDEOPHONE,ONBIT \FALSE
	ZERO?	WOMAN-ON-SCREEN \FALSE
	CALL	TELL-HINT,81,LOCAL-SUB
	RSTACK	


	.FUNCT	TIP-FOLLOWS-YOU,RM
	ZERO?	TIP-FOLLOWS-YOU? /FALSE
	CALL	IN-LAB?,RM
	ZERO?	STACK /?ELS7
	CALL	IN-LAB?,OLD-HERE
	ZERO?	STACK \FALSE
?ELS7:	CALL	IN-TANK-AREA?,RM
	ZERO?	STACK /?ELS11
	CALL	IN-TANK-AREA?,OLD-HERE
	ZERO?	STACK \FALSE
?ELS11:	EQUAL?	RM,CRAWL-SPACE /FALSE
	EQUAL?	OLD-HERE,RM /FALSE
	SET	'OLD-HERE,RM
	IN?	MICROPHONE,TIP \?ELS20
	MOVE	MICROPHONE,CENTER-OF-LAB
	JUMP	?CND18
?ELS20:	IN?	MICROPHONE-DOME,TIP \?CND18
	MOVE	MICROPHONE-DOME,COMM-BLDG
?CND18:	LOC	TIP
	EQUAL?	RM,SUB,STACK /?CND23
	FCLEAR	TIP,TOUCHBIT
?CND23:	MOVE	TIP,RM
	RTRUE	


	.FUNCT	I-SHARON-GONE,L
	ZERO?	MONSTER-GONE \?CND1
	CALL	QUEUE,I-SHARON-GONE,4
	RFALSE	
?CND1:	CALL	META-LOC,SHARON >L
	REMOVE	SHARON
	CALL	ROB,SHARON,GLOBAL-SHARON
	FCLEAR	FILE-DRAWER,NDESCBIT
	FCLEAR	PAPERS,NDESCBIT
	CALL	SHARON-PASSES-YOU?,L
	ZERO?	STACK /FALSE
	CALL	SUDDENLY-SHARON,L
	PRINTI	"really must go now, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	". I'll see you later."""
	CRLF	
	EQUAL?	HERE,OFFICE \TRUE
	PRINTI	"She leaves through the "
	PRINTD	OFFICE-DOOR
	PRINTR	"."


	.FUNCT	ROB,WHAT,THIEF,N,X
	FIRST?	WHAT >X /?KLU6
?KLU6:	
?PRG1:	ZERO?	X /TRUE
	NEXT?	X >N /?KLU7
?KLU7:	MOVE	X,THIEF
	FCLEAR	X,TAKEBIT
	SET	'X,N
	JUMP	?PRG1


	.FUNCT	SUDDENLY-SHARON,L
	PRINTI	"
Suddenly Sharon "
	EQUAL?	L,HERE /?ELS5
	PRINTI	"passes by and says"
	JUMP	?CND3
?ELS5:	PRINTI	"leaves, saying"
?CND3:	PRINTI	", ""I "
	RTRUE	


	.FUNCT	I-SHARON-TO-HALLWAY,L
	CALL	QUEUE,I-SHARON-TO-HALLWAY,0
	CALL	META-LOC,SHARON >L
	MOVE	SHARON,HALLWAY
	CALL	SHARON-PASSES-YOU?,L
	ZERO?	STACK /?CND1
	CALL	SUDDENLY-SHARON,L
	PRINTI	"must go back to my office now, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"."""
	CRLF	
?CND1:	CALL	I-SHARON,G-REACHED
	RSTACK	


	.FUNCT	I-SHARON,GARG=0,L
	LOC	SHARON >L
	EQUAL?	GARG,G-REACHED \FALSE
	EQUAL?	L,HALLWAY \FALSE
	MOVE	SHARON,OFFICE
	FSET	SHARON,NDESCBIT
	FSET	FILE-DRAWER,NDESCBIT
	FSET	PAPERS,NDESCBIT
	FSET?	VIDEOPHONE,ONBIT \FALSE
	FCLEAR	VIDEOPHONE,ONBIT
	FSET	VIDEOPHONE,MUNGBIT
	CALL	PHONE-OFF
	SET	'SHARON-BROKE-CIRCUIT,TRUE-VALUE
	FSET	CIRCUIT-BREAKER,MUNGBIT
	FSET	CIRCUIT-BREAKER,OPENBIT
	SET	'MONSTER-GONE,TRUE-VALUE
	CALL	IN-LAB?,HERE
	ZERO?	STACK /?CND16
	CRLF	
	PRINTI	"Something's wrong! The picture vanished from your "
	PRINTD	VIDEOPHONE
	PRINTI	" screen, and the sound conked out!
"
	CALL	TIP-SAYS
	PRINTI	"That's strange! Maybe you should use the "
	PRINTD	COMPUTESTOR
	PRINTI	"."""
	CRLF	
?CND16:	CALL	SCORE-UPD,-3
	RTRUE	


	.FUNCT	TIP-SAYS,QUIET=0
	PRINTI	"Tip s"
	IN?	TIP,HERE \?ELS5
	PRINTI	"ays"
	JUMP	?CND3
?ELS5:	PRINTI	"houts"
?CND3:	ZERO?	QUIET /?CND12
	PRINTI	" quietly"
?CND12:	PRINTI	", """
	RTRUE	


	.FUNCT	NOT-NOW?,BLY?=1
	ZERO?	BLY? /?ELS5
	ZERO?	BLY-PRIVATELY-DELAY \TRUE
?ELS5:	FSET?	BLY,MUNGBIT /TRUE
	ZERO?	GREENUP-ESCAPE \TRUE
	EQUAL?	HERE,CRAWL-SPACE,SUB /TRUE
	RFALSE


	.FUNCT	I-BLY-PRIVATELY
	ZERO?	SNARK-ATTACK-COUNT \FALSE
	CALL	READY-FOR-SNARK?
	ZERO?	STACK \FALSE
	ZERO?	ZOE-MENTIONED-EVIDENCE \FALSE
	CALL	NOT-NOW?
	ZERO?	STACK /?CND11
	SET	'BLY-PRIVATELY-DELAY,FALSE-VALUE
	CALL	QUEUE,I-BLY-PRIVATELY,7
	RFALSE	
?CND11:	SET	'BLY-PRIVATELY-DELAY,TRUE-VALUE
	MOVE	PRIVATE-MATTER,GLOBAL-OBJECTS
	CRLF	
	PRINTI	"Suddenly "
	PRINTD	BLY
	PRINTI	" "
	CALL	META-LOC,BLY
	EQUAL?	STACK,HERE /?CND16
	MOVE	BLY,HERE
	PRINTI	"comes over and "
?CND16:	ZERO?	BLY-PRIVATELY-COUNT \?ELS23
	PRINTI	"say"
	JUMP	?CND21
?ELS23:	PRINTI	"repeat"
?CND21:	PRINTI	"s, """
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", can we discuss a "
	PRINTD	PRIVATE-MATTER
	PRINTI	" now?"""
	INC	'BLY-PRIVATELY-COUNT
	CALL	YES?
	ZERO?	STACK \?CND32
	CALL	QUEUE,I-BLY-PRIVATELY,7
	RFALSE	
?CND32:	CALL	ASK-BLY-ABOUT-PRIVATE-MATTER
	RTRUE	


	.FUNCT	I-BLY-SAYS,ASKED?=0,L
	ZERO?	ASKED? /?ELS3
	CALL	QUEUE,I-BLY-SAYS,0
	JUMP	?CND1
?ELS3:	CALL	READY-FOR-SNARK?
	ZERO?	STACK \FALSE
	CALL	NOT-NOW?
	ZERO?	STACK /?CND1
	SET	'BLY-PRIVATELY-DELAY,FALSE-VALUE
	CALL	QUEUE,I-BLY-SAYS,7
	RFALSE	
?CND1:	SET	'BLY-PRIVATELY-DELAY,TRUE-VALUE
	CALL	META-LOC,BLY >L
	ZERO?	ASKED? \?THN14
	EQUAL?	L,BLY-OFFICE \?ELS13
	EQUAL?	L,HERE \?ELS13
?THN14:	ZERO?	ASKED? \?CND18
	CRLF	
?CND18:	PRINTI	""""
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	","" says Zoe, ""we could be in danger! The Snark may attack again any time! Would you answer some questions?"""
	CALL	YES?
	ZERO?	STACK \?CND23
	ZERO?	ASKED? \TRUE
	CALL	QUEUE,I-BLY-SAYS,3
	PUT	STACK,0,1
	RFALSE	
?CND23:	PRINTI	"""Can you use the "
	PRINTD	SUB
	PRINTI	" to hunt the "
	PRINTD	GLOBAL-SNARK
	PRINTI	", instead of waiting for it to attack?"""
	CALL	YES?
	ZERO?	STACK /?CND34
	PRINTI	"""Do you wish to arm the "
	PRINTD	SUB
	PRINTI	" for attacking?"""
	CALL	YES?
	ZERO?	STACK /?CND34
	CALL	TELL-HINT,73,CLAW,FALSE-VALUE
	CALL	TELL-HINT,72,DART
	EQUAL?	HERE,DOME-LAB /?CND39
	PRINTI	"
""If you want to think it over, we should go to the "
	PRINTD	DOME-LAB
	PRINTI	". Shall we go now?"""
	CALL	YES?
	ZERO?	STACK /?CND34
	PRINTI	"""Okay, let's go.""

"
	IN?	BLACK-BOX,BLY \?CND52
	MOVE	BLACK-BOX,HERE
?CND52:	SET	'WINNER,PLAYER
	CALL	GOTO,DOME-LAB
	ZERO?	STACK /?CND39
	MOVE	BLY,DOME-LAB
?CND39:	
?CND34:	RETURN	2
?ELS13:	CALL	QUEUE,I-BLY-SAYS,3
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	I-TIP-SAYS
	EQUAL?	TIP-SAYS-2,MAGAZINE \?ELS5
	FSET?	MAGAZINE,TOUCHBIT /FALSE
?ELS5:	ZERO?	TIP-SAYS-1 /FALSE
	CALL	META-LOC,MAGAZINE
	EQUAL?	STACK,SUB,CRAWL-SPACE \FALSE
	CALL	TELL-HINT,TIP-SAYS-1,TIP-SAYS-2
	RSTACK	


	.FUNCT	I-TIP-SONAR-PLAN,P
	FSET?	TIP,BUSYBIT \?ELS3
	CALL	QUEUE,I-TIP-SONAR-PLAN,3
	RFALSE	
?ELS3:	ZERO?	SNARK-ATTACK-COUNT \?THN6
	CALL	READY-FOR-SNARK?
	ZERO?	STACK /?CND1
?THN6:	CALL	QUEUE,I-TIP-SONAR-PLAN,0
	RFALSE	
?CND1:	CALL	FIND-FLAG,HERE,PERSON,PLAYER >P
	ZERO?	P \?ELS12
	CALL	TIP-COMES
	RSTACK	
?ELS12:	EQUAL?	P,TIP \?ELS14
	REMOVE	PLAYER
	CALL	FIND-FLAG,HERE,PERSON,TIP >P
	MOVE	PLAYER,HERE
	CALL	TIP-COMES,P
	RSTACK	
?ELS14:	CALL	TIP-COMES,TRUE-VALUE
	RSTACK	


	.FUNCT	MIKE-1-F,OBJ,FOO=0
	ZERO?	FOO \?ELS5
	PRINTI	"""Is "
	PRINTD	OBJ
	PRINTI	" a suspect?"""
	RTRUE	
?ELS5:	PRINTI	"""Do you think "
	PRINTD	OBJ
	PRINTI	" could be the "
	PRINTD	TRAITOR
	PRINTI	"?"""
	RTRUE	


	.FUNCT	TIP-COMES,ALMOST=0
	ZERO?	SIEGEL-TESTED \FALSE
	FSET?	SIEGEL,BUSYBIT /FALSE
	ZERO?	GREENUP-ESCAPE \FALSE
	ZERO?	GREENUP-TRAPPED \FALSE
	ZERO?	GREENUP-CUFFED \FALSE
	EQUAL?	HERE,SUB,CRAWL-SPACE /?THN12
	FSET?	TIP,BUSYBIT \?ELS11
?THN12:	CALL	QUEUE,I-TIP-SONAR-PLAN,3
	RFALSE	
?ELS11:	ZERO?	ALMOST /?CND1
	MOVE	TIP,HERE
	CALL	INT,I-TIP-SONAR-PLAN
	GET	STACK,1 >ALMOST
	GRTR?	ALMOST,-1 /?THN20
	SUB	0,ALMOST
	MOD	STACK,7
	EQUAL?	STACK,2 \FALSE
?THN20:	CALL	TIP-SAYS,TRUE-VALUE
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", I'd like to talk with you alone."""
	CRLF	
	GRTR?	ALMOST,-1 \TRUE
	CALL	QUEUE,I-TIP-SONAR-PLAN,-1
	RTRUE	
?CND1:	CALL	QUEUE,I-TIP-SONAR-PLAN,0
	CRLF	
	ZERO?	BLACK-BOX-EXAMINED \?CND29
	CALL	TELL-HINT,11,BLACK-BOX
?CND29:	MOVE	TIP,HERE
	CALL	TIP-SAYS,TRUE-VALUE
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", did "
	PRINTD	BLY
	PRINTI	" mention any troublemakers among the "
	PRINTD	CREW
	PRINTI	"?"""
	CALL	YES?
	ZERO?	STACK /TRUE
	PRINTI	"""Do you suspect "
	PRINTD	ANTRIM
	PRINTI	" or "
	PRINTD	HORVAK
	PRINTI	" or "
	PRINTD	SIEGEL
	PRINTI	"?"""
	CALL	YES?
	ZERO?	STACK /TRUE
	PRINTI	"""Marv maintains the "
	PRINTD	SONAR-EQUIPMENT
	PRINTI	","" "
	CALL	TIP-SAYS
	PRINTI	"and we'll need it to warn us if the "
	PRINTD	SNARK
	PRINTI	" comes back. Didn't Zoe say something is wrong with it?"""
	CALL	YES?
	ZERO?	STACK /TRUE
	PRINTI	""""
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", do you think someone tampered with it?"""
	CALL	YES?
	ZERO?	STACK /TRUE
	PRINTI	"""Does Marv suspect you've discovered signs of tampering?"""
	CALL	YES?
	ZERO?	STACK \TRUE
	CALL	THIS-IS-IT,TIP-IDEA
	PRINTI	"""Then I have an idea how to trap Marv and find out if he's the "
	PRINTD	TRAITOR
	PRINTI	"!"""
	CRLF	
	RTRUE	


	.FUNCT	REACTION-MAY-BE,PER
	PRINTD	PER
	PRINTI	"'s reaction may be all you need to prove he's NOT the "
	PRINTD	TRAITOR
	PRINTR	". But you'll have to decide for yourself."


	.FUNCT	SIEGEL-BOX
	PRINTR	"It will modulate the sonar's ultrasonic pulses!"""


	.FUNCT	I-SIEGEL-REPORTS
	ZERO?	DOME-AIR-BAD? /?CND1
	CALL	QUEUE,I-SIEGEL-REPORTS,3
	PUT	STACK,0,1
	RFALSE	
?CND1:	FCLEAR	SIEGEL,BUSYBIT
	IN?	SIEGEL,COMM-BLDG \FALSE
	CALL	MOVE-HERE-NOT-SUB,SIEGEL
	IN?	BLACK-BOX,SONAR-EQUIPMENT /?CND8
	PRINTI	"Suddenly "
	PRINTD	SIEGEL
	PRINTI	" reports: ""The "
	PRINTD	SONAR-EQUIPMENT
	PRINTI	" looks okay to me, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTR	"."""
?CND8:	EQUAL?	HERE,COMM-BLDG \?ELS15
	PRINTI	"Suddenly "
	PRINTD	SIEGEL
	PRINTI	" turns to you"
	JUMP	?CND13
?ELS15:	IN?	TIP,HERE \?CND20
	CALL	TIP-SAYS
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", here comes Marv, and he looks excited!""
"
?CND20:	PRINTI	"Marv comes running up to you"
?CND13:	PRINTI	" with the "
	PRINTD	BLACK-BOX
	PRINTI	" and says: ""Look"
	MOVE	BLACK-BOX,SIEGEL
	ZERO?	SIEGEL-TESTED /?ELS31
	PRINTI	"! I found the same "
	PRINTD	BLACK-BOX
	PRINTI	" on the "
	PRINTD	SONAR-EQUIPMENT
	PRINTR	" again!"""
?ELS31:	SET	'SIEGEL-TESTED,TRUE-VALUE
	PRINTI	" what I found attached to the "
	PRINTD	SONAR-EQUIPMENT
	PRINTI	", "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"! "
	CALL	SIEGEL-BOX
	IN?	TIP,HERE \TRUE
	CALL	TIP-FLASHES
	CALL	REACTION-MAY-BE,SIEGEL
	PRINTI	"
Tip snaps his fingers and says: """
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"! Didn't that article in the "
	PRINTD	MAGAZINE
	PRINTI	" say "
	PRINTD	THORPE
	PRINTI	"'s synthetic sea creatures reacted to ultrasonic pulses in a special way?"""
	CALL	QUEUE,I-TIP-PRIVATELY,1
	PUT	STACK,0,1
	CALL	YES?
	ZERO?	STACK /?ELS46
	PRINTR	"""That's what I thought."""
?ELS46:	PRINTI	"""I think you should check that."""
	CRLF	
	RTRUE	


	.FUNCT	I-TIP-PRIVATELY
	CALL	READY-FOR-SNARK?
	ZERO?	STACK \?THN4
	ZERO?	ANTRIM-CHECKED-SUB /?ELS3
?THN4:	CALL	QUEUE,I-TIP-PRIVATELY,0
	RFALSE	
?ELS3:	FSET?	TIP,BUSYBIT \?CND1
	CALL	QUEUE,I-TIP-PRIVATELY,3
	PUT	STACK,0,1
	RFALSE	
?CND1:	MOVE	TIP,HERE
	CRLF	
	PRINTI	"Tip draws you aside. ""Could I speak to you privately, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"?"""
	CALL	YES?
	ZERO?	STACK \?CND10
	CALL	QUEUE,I-TIP-PRIVATELY,3
	PUT	STACK,0,1
	RFALSE	
?CND10:	PRINTI	"""The Snark could be a synthetic monster created by "
	PRINTD	THORPE
	PRINTI	"!"" he says when you're alone. ""I read about them in that "
	PRINTD	MAGAZINE
	PRINTI	". If I'm right, whoever attached the "
	PRINTD	BLACK-BOX
	PRINTI	" to the "
	PRINTD	SONAR-EQUIPMENT
	PRINTI	" could be working for Thorpe! That way the "
	PRINTD	GLOBAL-SNARK
	PRINTI	" would be lured into attacking the "
	PRINTD	AQUADOME
	PRINTI	"! Do you agree, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"?"""
	CALL	YES?
	ZERO?	STACK \?CND15
	PRINT	RECONSIDER?
	PRINTI	""""
	CRLF	
?CND15:	CALL	MIKE-1-F,ANTRIM,TRUE-VALUE
	CALL	YES?
	ZERO?	STACK \?ELS22
	PRINT	RECONSIDER?
	PRINTI	" In fact "
	JUMP	?CND20
?ELS22:	PRINTI	"""Then "
?CND20:	PRINTI	"why not test him"
	ZERO?	SIEGEL-TESTED /?CND31
	PRINTI	", since you tested "
	PRINTD	SIEGEL
?CND31:	PRINTI	"?"" Tip asks. ""Mick is a laser expert in charge of maintenance on subs at the "
	PRINTD	AQUADOME
	PRINTI	"."""
	CRLF	
	IN?	PRIVATE-MATTER,GLOBAL-OBJECTS \?CND39
	CALL	TELL-HINT,12,OVERHEATING,FALSE-VALUE
	ZERO?	REGULATOR-MSG-SEEN /?CND39
	CALL	TELL-HINT,43,ANTRIM,FALSE-VALUE
?CND39:	CALL	TELL-HINT,22,ANTRIM,FALSE-VALUE
	RSTACK	


	.FUNCT	I-ANTRIM-TO-SUB,STR=0
	CALL	READY-FOR-SNARK?
	ZERO?	STACK \FALSE
	ZERO?	ANTRIM-CHECKED-SUB \FALSE
	ZERO?	STR /?ELS8
	JUMP	?CND1
?ELS8:	CALL	NOT-NOW?,FALSE-VALUE
	ZERO?	STACK /?CND1
	CALL	QUEUE,I-ANTRIM-TO-SUB,3
	RFALSE	
?CND1:	FSET?	VOLTAGE-REGULATOR,MUNGBIT \?ELS14
	CALL	QUEUE,I-ANTRIM-REPORTS,9
	PUT	STACK,0,1
	JUMP	?CND12
?ELS14:	CALL	QUEUE,I-ANTRIM-REPORTS,19
	PUT	STACK,0,1
?CND12:	SET	'ANTRIM-CHECKED-SUB,TRUE-VALUE
	IN?	BLY,HERE \?CND17
	SET	'BLY-HEARD-ANTRIM,TRUE-VALUE
?CND17:	FSET	ANTRIM,BUSYBIT
	ZERO?	STR /?ELS22
	PRINT	STR
	JUMP	?CND20
?ELS22:	PRINTI	"
Suddenly "
	PRINTD	ANTRIM
	IN?	ANTRIM,HERE /?CND30
	PRINTI	" appears and"
?CND30:	PRINTI	" says, ""I'm going to check out your new "
	PRINTD	SUB
	PRINTI	", "
?CND20:	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"!"" Mick turns and "
	MOVE	ANTRIM,CRAWL-SPACE
	FSET	ENGINE-ACCESS-HATCH,OPENBIT
	EQUAL?	HERE,SUB,CRAWL-SPACE \?ELS43
	PRINTR	"goes to work."
?ELS43:	EQUAL?	HERE,AIRLOCK \?ELS47
	PRINTI	"climbs aboard the "
	PRINTD	SUB
	PRINTR	"."
?ELS47:	PRINTI	"hurries toward the "
	PRINTD	AIRLOCK
	PRINTR	"."


	.FUNCT	TIP-FLASHES
	IN?	TIP,HERE \FALSE
	ZERO?	TIP-FLASHED /?CND4
	PRINTI	"Once again "
?CND4:	SET	'TIP-FLASHED,TRUE-VALUE
	PRINTI	"Tip flashes you a meaningful glance. "
	RTRUE	


	.FUNCT	I-ANTRIM-REPORTS
	ZERO?	DOME-AIR-BAD? /?CND1
	CALL	QUEUE,I-ANTRIM-REPORTS,3
	RFALSE	
?CND1:	FCLEAR	ANTRIM,BUSYBIT
	CALL	MOVE-HERE-NOT-SUB,ANTRIM
	CRLF	
	ZERO?	ASKED-ANTRIM /?ELS8
	PRINTD	ANTRIM
	PRINTI	" reports back "
	EQUAL?	HERE,SUB,AIRLOCK \?ELS14
	PRINTI	"to you"
	JUMP	?CND12
?ELS14:	PRINTI	"from the "
	PRINTD	AIRLOCK
?CND12:	FSET?	VOLTAGE-REGULATOR,MUNGBIT \?ELS23
	PRINTI	".
""I think I found your "
	PRINTD	OVERHEATING
	PRINTI	" problem. The "
	PRINTD	VOLTAGE-REGULATOR
	PRINTI	" was making the lasers overcharge.
I've adjusted it, but I could replace it. Want me to?"""
	CALL	YES?
	ZERO?	STACK /?CND6
	FCLEAR	VOLTAGE-REGULATOR,MUNGBIT
	JUMP	?CND6
?ELS23:	PRINTI	", looking somewhat puzzled.
"""
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", I ran the "
	PRINTD	ENGINE
	PRINTI	" on full, but it didn't overheat.
The "
	PRINTD	VOLTAGE-REGULATOR
	PRINTI	" PROBABLY got out of adjustment and overcharged the lasers, but it seems okay now. Just to be safe, I installed a new "
	PRINTD	VOLTAGE-REGULATOR
	PRINTI	".
"
	JUMP	?CND6
?ELS8:	ZERO?	BLY-HEARD-ANTRIM \?THN38
	LOC	BLY
	EQUAL?	HERE,SUB,BLY-OFFICE,STACK \?ELS37
?THN38:	PRINTI	"Suddenly "
	JUMP	?CND35
?ELS37:	CALL	MOVE-HERE-NOT-SUB,BLY
	PRINTD	BLY
	PRINTI	" is approaching.
"""
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", did you send "
	PRINTD	ANTRIM
	PRINTI	" to work on the "
	PRINTD	SUB
	PRINTI	"?"" she asks. ""I was just "
	EQUAL?	HERE,BLY-OFFICE /?CND46
	PRINTI	"in my office, "
?CND46:	PRINTI	"checking the "
	PRINTD	STATION-MONITOR
	PRINTI	" to see what each of the crew was doing, and I discovered Mick had gone to the "
	PRINTD	AIRLOCK
	PRINTI	". When I saw him on the "
	PRINTD	STATION-MONITOR
	PRINTI	", he had just come out of the "
	PRINTD	SUB
	PRINTI	"'s hatch.
Wait -- here he is now!""
"
?CND35:	PRINTI	"Mick appears and says, ""I thought maybe you had a problem on the way here, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", so I wanted to check on it. Everything seems to be okay now."""
	CRLF	
?CND6:	CALL	TIP-FLASHES
	FSET?	VOLTAGE-REGULATOR,MUNGBIT \?ELS57
	SET	'TEST-BUTTON-READOUT,TEST-BUTTON-NORMAL
	PRINTI	"It now looks as though "
	PRINTD	ANTRIM
	PRINTI	" can be eliminated as the "
	PRINTD	TRAITOR
	PRINTI	", but you'll want to confirm this by pushing the "
	PRINTD	TEST-BUTTON
	PRINTI	" before you set out again in the "
	PRINTD	SUB
	PRINTI	".
"
	JUMP	?CND55
?ELS57:	CALL	REACTION-MAY-BE,ANTRIM
?CND55:	FCLEAR	VOLTAGE-REGULATOR,MUNGBIT
	CALL	READY-FOR-SNARK?
	ZERO?	STACK \TRUE
	IN?	ESCAPE-POD-UNIT,SUB /TRUE
	CRLF	
	PRINTD	ANTRIM
	PRINTI	" turns away, then stops and says:
"""
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", there's no "
	PRINTD	ESCAPE-POD-UNIT
	PRINTI	" under your seats in the "
	PRINTD	SUB
	PRINTI	". I hear you're planning a new type of unit for the Ultramarine Bioceptor. But the standard unit will fit, and we have one in the "
	PRINTD	DOME-STORAGE
	PRINTI	".
Would you like one installed, just in case? "
	PRINTD	GREENUP
	PRINTI	" and "
	PRINTD	LOWELL
	PRINTI	" could do it in a few minutes. Shall I tell 'em to?"""
	CALL	YES?
	ZERO?	STACK /?CND70
	CALL	META-LOC,LOWELL
	MOVE	ANTRIM,STACK
	CALL	INSTALL-ESCAPE-POD-UNIT,ANTRIM
	RTRUE	
?CND70:	PRINTR	"""I sure hope you don't need it."""


	.FUNCT	INSTALL-ESCAPE-POD-UNIT,PER,X=0,?TMP1
	PRINTI	"""Okay"
	LOC	LOWELL >?TMP1
	LOC	GREENUP
	EQUAL?	HERE,?TMP1,STACK \?CND3
	PRINTI	", we'll install it"
?CND3:	PRINTI	"."""
	CRLF	
	LOC	SYRINGE
	EQUAL?	STACK,LOWELL,GREENUP,ESCAPE-POD-UNIT \?CND10
	SET	'X,TRUE-VALUE
?CND10:	ZERO?	X /?ELS17
	LOC	ESCAPE-POD-UNIT
	EQUAL?	STACK,LOWELL,GREENUP,DOME-STORAGE \?ELS17
	CALL	SCORE-OBJ,ESCAPE-POD-UNIT
	MOVE	GREENUP,SUB
	MOVE	LOWELL,SUB
	FSET	GREENUP,BUSYBIT
	FSET	LOWELL,BUSYBIT
	MOVE	ESCAPE-POD-UNIT,LOWELL
	MOVE	SYRINGE,GREENUP
	FSET	SYRINGE,MUNGBIT
	CALL	QUEUE,I-LOWELL-REPORTS,12
	PUT	STACK,0,1
	RTRUE	
?ELS17:	PRINTI	"But "
	CALL	HE-SHE-IT,PER
	MOVE	PER,HERE
	PRINTI	" returns a moment later and says, ""We can't find the "
	ZERO?	X /?ELS28
	PRINTD	ESCAPE-POD-UNIT
	JUMP	?CND26
?ELS28:	PRINTD	SYRINGE
?CND26:	PRINTR	"."""


	.FUNCT	I-LOWELL-REPORTS
	CALL	NOT-NOW?,FALSE-VALUE
	ZERO?	STACK /?CND1
	CALL	QUEUE,I-LOWELL-REPORTS,3
	RFALSE	
?CND1:	MOVE	ESCAPE-POD-UNIT,SUB
	FCLEAR	ESCAPE-POD-UNIT,TAKEBIT
	FSET	ESCAPE-POD-UNIT,OPENBIT
	MOVE	SYRINGE,ESCAPE-POD-UNIT
	SET	'TEST-BUTTON-READOUT,TEST-BUTTON-POD
	MOVE	GREENUP,HERE
	MOVE	LOWELL,HERE
	FCLEAR	GREENUP,BUSYBIT
	FCLEAR	LOWELL,BUSYBIT
	PRINTI	"
Suddenly "
	PRINTD	GREENUP
	PRINTI	" and "
	PRINTD	LOWELL
	PRINTI	" report back from the "
	EQUAL?	HERE,AIRLOCK \?ELS8
	PRINTD	SUB
	JUMP	?CND6
?ELS8:	PRINTD	AIRLOCK
?CND6:	CALL	SAID-TO,LOWELL
	PRINTI	".
""That "
	PRINTD	ESCAPE-POD-UNIT
	PRINTI	" is in place, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTR	","" says Amy. ""Bill installed the part under your pilot's seat, and I installed the rest."""


	.FUNCT	I-ANALYSIS
	FCLEAR	HORVAK,BUSYBIT
	FSET	SYRINGE,TAKEBIT
	CALL	MOVE-HERE-NOT-SUB,HORVAK
	ZERO?	STACK /?ELS5
	CRLF	
	FSET?	SYRINGE,MUNGBIT /?ELS10
	PRINTI	"Suddenly "
	PRINTD	HORVAK
	PRINTI	" appears. ""I couldn't find anything unusual about the "
	PRINTD	SYRINGE
	PRINTR	"."""
?ELS10:	SET	'GREENUP-GUILT,TRUE-VALUE
	PRINTD	HORVAK
	PRINTI	"'s face is grim and pale as he reports the result of his analysis.
"
	CALL	PERFORM,V?ASK-ABOUT,HORVAK,SYRINGE
	IN?	TIP,HERE \FALSE
	PRINTI	"
Tip turns to you with a gasp. ""Holy smoke, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTR	"! That's exactly what would have happened once you warmed up the pilot's seat enough to trigger the sensor relay!"""
?ELS5:	CALL	QUEUE,I-ANALYSIS,2
	RFALSE	


	.FUNCT	I-SYNTHESIS
	FCLEAR	HORVAK,BUSYBIT
	MOVE	DART,HORVAK
	FCLEAR	DART,TRYTAKEBIT
	FSET	DART,TAKEBIT
	FCLEAR	DART,NDESCBIT
	FCLEAR	DART,MUNGBIT
	CALL	THIS-IS-IT,DART
	CALL	SAID-TO,HORVAK
	PRINTI	"Doc Horvak "
	CALL	MOVE-HERE-NOT-SUB,HORVAK,STR?197,STR?198
	PRINTI	" holding an aquatic dart gun. "
	IN?	HORVAK,HERE /?CND5
	PRINTI	"He shouts from outside, "
?CND5:	PRINTI	"""Okay, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", I've made a special 'trank' to use against an A.H.-type organism! It's loaded in the dart gun. What shall I do with it?"""
	CRLF	
	CALL	SCORE-OBJ,DART
	RTRUE	


	.FUNCT	MOVE-HERE-NOT-SUB,PER,HERE-STR=0,NOT-HERE-STR=0
	IN?	PER,HERE \?CND1
	ZERO?	HERE-STR /TRUE
	PRINT	HERE-STR
	RTRUE	
?CND1:	LOC	PER
	CALL	THROUGH-ROOF?,STACK
	ZERO?	STACK /?CND10
	FSET	AIRLOCK-ROOF,OPENBIT
?CND10:	EQUAL?	PER,SHARON \?CND15
	FCLEAR	SHARON,NDESCBIT
	FCLEAR	FILE-DRAWER,NDESCBIT
	FCLEAR	PAPERS,NDESCBIT
?CND15:	ZERO?	NOT-HERE-STR /?CND18
	PRINT	NOT-HERE-STR
?CND18:	EQUAL?	HERE,CRAWL-SPACE,SUB \?ELS28
	ZERO?	SUB-IN-TANK /?ELS31
	MOVE	PER,NORTH-TANK-AREA
	RFALSE	
?ELS31:	MOVE	PER,AIRLOCK
	RFALSE	
?ELS28:	MOVE	PER,HERE
	RTRUE	


	.FUNCT	I-GREENUP-ESCAPE
	CALL	QUEUE,I-GREENUP-ESCAPE,-1
	PUT	STACK,0,1
	INC	'GREENUP-ESCAPE
	EQUAL?	3,GREENUP-ESCAPE \?ELS3
	MOVE	GREENUP,AIRLOCK
	CRLF	
	PRINTI	"Greenup has reached the top of the wall and is climbing down the ladder into the "
	PRINTD	AIRLOCK
	PRINTI	". In a moment he'll reach the floor and head for the "
	PRINTD	SUB
	PRINTI	"."
	CRLF	
	RFALSE	
?ELS3:	EQUAL?	4,GREENUP-ESCAPE \?ELS7
	CRLF	
	PRINTI	"Greenup is scrambling aboard the "
	PRINTD	SUB
	PRINTI	". Tip groans. ""There's no way to stop him now, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"! All he has to do is open the "
	PRINTD	AIRLOCK-HATCH
	PRINTI	" and shove off!"""
	CRLF	
	CALL	TELL-HINT,52,AIRLOCK-ELECTRICITY,FALSE-VALUE
	RTRUE	
?ELS7:	EQUAL?	9,GREENUP-ESCAPE \FALSE
	FCLEAR	AIRLOCK-ROOF,OPENBIT
	FSET	AIRLOCK-HATCH,OPENBIT
	SET	'AIRLOCK-FULL,TRUE-VALUE
	CALL	QUEUE,I-SNARK-ATTACKS,1
	PRINTI	"
Better not raise any false hopes. As the "
	PRINTD	SUB
	PRINTI	" glides out, a pall of gloom settles over the "
	PRINTD	AQUADOME
	PRINTI	". All hands sense that there's little hope, that Greenup has scuttled their last chance of fighting off another attack by the "
	PRINTD	GLOBAL-SNARK
	PRINTI	".
A "
	PRINTD	VIDEOPHONE
	PRINTI	" call to "
	PRINTD	IU-GLOBAL
	PRINTI	" confirms that no other subs are available for a rescue expedition, even if there were time. And a general S.O.S. to any craft in the vicinity isn't answered."
	CALL	FINISH
	RFALSE	


	.FUNCT	GREENUP-CUFF
	SET	'GREENUP-ESCAPE,0
	SET	'GREENUP-TRAPPED,FALSE-VALUE
	CALL	QUEUE,I-GREENUP-ESCAPE,0
	MOVE	GREENUP,GALLEY
	FSET	GREENUP,MUNGBIT
	SET	'GREENUP-CUFFED,TRUE-VALUE
	PRINTI	"Knowing he's trapped, "
	PRINTD	GREENUP
	PRINTI	" gives up without a fight. "
	PRINTD	BLY
	PRINTI	" orders him handcuffed to a pipe in the "
	PRINTD	GALLEY
	PRINTI	"."
	CRLF	
	CALL	SCORE-OBJ,GLOBAL-GREENUP
	RTRUE	


	.FUNCT	I-POISON-JAB
	EQUAL?	HERE,SUB \FALSE
	IN?	ESCAPE-POD-UNIT,SUB \FALSE
	FSET?	SYRINGE,MUNGBIT \FALSE
	IN?	SYRINGE,ESCAPE-POD-UNIT \FALSE
	CRLF	
	PRINTI	"A sudden jab in your right buttock makes you realize that the "
	PRINTD	SYRINGE
	PRINTI	" in the "
	PRINTD	ESCAPE-POD-UNIT
	PRINTI	" has been activated, even though no alarm sounded.
You realize that the "
	PRINTD	SYRINGE
	PRINTI	" did NOT contain a stimulant. Instead of feeling more alert, you're already feeling doomed.
The truth is that you have been fatally poisoned, and the promising career of a brilliant young inventor will be cut short.
An investigation into your death would reveal that the "
	PRINTD	ESCAPE-POD-UNIT
	PRINTI	" under your seat had been tampered with.
A body-heat sensor had been substituted for the electronic monitor, and a wire was connected from the sensor to the "
	PRINTD	SYRINGE
	PRINTI	". The stimulant in the "
	PRINTD	SYRINGE
	PRINTI	" had been replaced with arsenic stolen from the "
	PRINTD	CHEMICAL-SUPPLY-SHELVES
	PRINTI	" of the "
	PRINTD	DOME-LAB
	PRINTI	".
As soon as you heated up your pilot's seat, the sensor triggered the "
	PRINTD	SYRINGE
	PRINTI	", and it injected you with the poison.
Most regrettable!"
	CALL	FINISH
	RSTACK	


	.FUNCT	I-TIP-REPORTS,B,D
	FSET?	BLY,MUNGBIT \?CND1
	CALL	QUEUE,I-TIP-REPORTS,3
	RFALSE	
?CND1:	EQUAL?	HERE,CRAWL-SPACE \?ELS8
	MOVE	TIP,SUB
	JUMP	?CND6
?ELS8:	MOVE	TIP,HERE
?CND6:	FCLEAR	TIP,BUSYBIT
	SET	'TIP-FOLLOWS-YOU?,TRUE-VALUE
	SET	'FINE-SONAR,TRUE-VALUE
	MOVE	FINE-GRID,SUB
	FCLEAR	FINE-GRID,TAKEBIT
	CALL	TIP-SAYS
	PRINTI	"All set, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"! The "
	PRINTD	FINE-GRID
	PRINTI	" is installed on both the "
	PRINTD	SONARSCOPE
	PRINTI	" and the "
	PRINTD	THROTTLE
	GET	ON-SUB,0
	EQUAL?	BAZOOKA,STACK /?PRD13
	PUSH	0
	JUMP	?PRD14
?PRD13:	PUSH	1
?PRD14:	SET	'B,STACK
	GET	ON-SUB,1
	EQUAL?	DART,STACK /?PRD15
	PUSH	0
	JUMP	?PRD16
?PRD15:	PUSH	1
?PRD16:	SET	'D,STACK
	ZERO?	B \?THN20
	ZERO?	D /?CND17
?THN20:	PRINTI	" -- and so "
	ZERO?	B /?ELS26
	ZERO?	D /?ELS26
	PRINTI	"are"
	JUMP	?CND24
?ELS26:	PRINTI	"is"
?CND24:	ZERO?	D /?CND35
	PRINTI	" the "
	PRINTD	DART
?CND35:	ZERO?	B /?CND41
	ZERO?	D /?CND41
	PRINTI	" and"
?CND41:	ZERO?	B /?CND17
	PRINTI	" the "
	PRINTD	BAZOOKA
?CND17:	PRINTI	"! Let's shove off and find the "
	PRINTD	GLOBAL-SNARK
	PRINTR	"!"""


	.FUNCT	USE-FEWER-TURNS
	PRINTI	"

(You'll probably do better if you restart and use fewer turns next time.)"
	RTRUE	


	.FUNCT	I-SNARK-ATTACKS
	ZERO?	SNARK-ATTACK-COUNT \?CND1
	ZERO?	SUB-IN-DOME \?ELS6
	EQUAL?	JOYSTICK-DIR,P?SE /?THN10
	LESS?	SUB-LON,0 \?ELS18
	SUB	0,SUB-LON
	JUMP	?CND14
?ELS18:	PUSH	SUB-LON
?CND14:	LESS?	SONAR-RANGE,STACK /?CND7
	LESS?	SUB-LAT,0 \?ELS25
	SUB	0,SUB-LAT
	JUMP	?CND21
?ELS25:	PUSH	SUB-LAT
?CND21:	LESS?	SONAR-RANGE,STACK /?CND7
?THN10:	CALL	QUEUE,I-SNARK-ATTACKS,3
	RFALSE	
?CND7:	PRINTI	"A call comes on the "
	EQUAL?	HERE,SUB,CRAWL-SPACE \?ELS32
	PRINTD	SONARPHONE
	JUMP	?CND30
?ELS32:	PRINTD	VIDEOPHONE
?CND30:	PRINTI	" from the "
	PRINTD	AQUADOME
	PRINTI	": the "
	PRINTD	GLOBAL-SNARK
	PRINTI	" is attacking and destroying it! You're too late!"
	CALL	USE-FEWER-TURNS
	CALL	FINISH
	JUMP	?CND1
?ELS6:	CALL	QUEUE,I-SNARK-ATTACKS,-1
	PUT	STACK,0,1
?CND1:	INC	'SNARK-ATTACK-COUNT
	EQUAL?	1,SNARK-ATTACK-COUNT \?ELS47
	MOVE	SIEGEL,COMM-BLDG
	MOVE	TIP,HERE
	PRINTI	"
Suddenly an alarm rings through the "
	PRINTD	AQUADOME
	PRINTI	"! "
	PRINTD	SIEGEL
	PRINTI	" yells over the squawk box:
""Now hear this! Two blips have appeared on the "
	PRINTD	SONAR-EQUIPMENT
	PRINTI	"! No definite form, but they're large, and they're coming closer."
	PRINTI	"""
"
	CALL	TIP-SAYS
	PRINTI	"One of them must be the "
	PRINTD	GLOBAL-SNARK
	PRINTI	"!"" "
	EQUAL?	HERE,SUB,CRAWL-SPACE,AIRLOCK \?ELS57
	FSET?	AIRLOCK-HATCH,OPENBIT \?CND55
	FCLEAR	AIRLOCK-HATCH,OPENBIT
	PRINTI	"The "
	PRINTD	AIRLOCK-HATCH
	PRINTI	" closes in defense."
	JUMP	?CND55
?ELS57:	CALL	GLOBAL-IN?,WINDOW,HERE
	ZERO?	STACK /?ELS67
	PRINTI	"""Look out the "
	JUMP	?CND65
?ELS67:	PRINTI	"""Let's find a "
?CND65:	PRINTD	WINDOW
	PRINTI	", "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	"!"""
?CND55:	CRLF	
	RETURN	2
?ELS47:	EQUAL?	2,SNARK-ATTACK-COUNT \?ELS79
	PRINTI	"
Even as you try this, the undersea nightmare takes shape!
""Holy spaghetti! LOOK at that thing!"" cries Tip.
A hideous creature, with bulblike eyes near its snout, rears out of the murk, its tentacles flailing the "
	PRINTD	GLOBAL-WATER
	PRINTI	"! In this moment of terror, the "
	PRINTD	GLOBAL-SNARK
	PRINTI	" seems as big as a house, and it's just outside the "
	PRINTD	AQUADOME
	PRINTI	"!"
	CRLF	
	RETURN	2
?ELS79:	EQUAL?	3,SNARK-ATTACK-COUNT \FALSE
	PRINTI	"
No more time for that! The "
	PRINTD	SNARK
	PRINTI	" has flopped down on the "
	PRINTD	AQUADOME
	PRINTI	"! There's a sound like thunder as the plastic hemisphere cracks under the impact! The crew's screams of fear are drowned by the roar of the sea!
The Atlantic Ocean is pouring into the "
	PRINTD	AQUADOME
	PRINTI	"! And your last thought, before a zillion tons of "
	PRINTD	GLOBAL-WATER
	PRINTI	" crushes you to jelly, is ""Oh gosh! I wonder if I shut off the Bunsen burner in the lab?"""
	CALL	USE-FEWER-TURNS
	CALL	FINISH
	RSTACK	

	.ENDI
