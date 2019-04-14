

	.FUNCT	I-PROMPT-1
	SET	'P-PROMPT,1
	RFALSE	


	.FUNCT	I-PROMPT-2
	ZERO?	P-PROMPT /FALSE
	SET	'P-PROMPT,FALSE-VALUE
	CRLF	
	PRINTI	"(Are you tired of seeing ""What next?"" Well, you won't see it any more.)"
	CRLF	
	EQUAL?	PRSA,V?WAIT-UNTIL,V?WAIT-FOR \?CND9
	CRLF	
?CND9:	CALL	INT,I-PROMPT-2
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	PARSER,PTR=P-LEXSTART,WRD,VAL=0,VERB=0,OF-FLAG=0,LEN,DIR=0,NW=0,LW=0,NUM,SCNT,CNT=-1
?PRG1:	IGRTR?	'CNT,P-ITBLLEN \?ELS5
	JUMP	?REP2
?ELS5:	PUT	P-ITBL,CNT,0
	JUMP	?PRG1
?REP2:	SET	'P-NUMBER,-1
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	SET	'P-ADVERB,FALSE-VALUE
	SET	'P-MERGED,FALSE-VALUE
	SET	'P-WHAT-IGNORED,FALSE-VALUE
	PUT	P-PRSO,P-MATCHLEN,0
	PUT	P-PRSI,P-MATCHLEN,0
	PUT	P-BUTS,P-MATCHLEN,0
	ZERO?	QUOTE-FLAG \?CND8
	EQUAL?	WINNER,PLAYER /?CND8
	SET	'WINNER,PLAYER
	LOC	WINNER
	FSET?	STACK,VEHBIT /?CND8
	LOC	WINNER >HERE
?CND8:	ZERO?	P-CONT /?ELS18
	SET	'PTR,P-CONT
	SET	'P-CONT,FALSE-VALUE
	EQUAL?	PRSA,V?TELL /?CND16
	CRLF	
	JUMP	?CND16
?ELS18:	SET	'WINNER,PLAYER
	SET	'QUOTE-FLAG,FALSE-VALUE
	LOC	WINNER
	FSET?	STACK,VEHBIT /?CND25
	LOC	WINNER >HERE
?CND25:	SET	'SCNT,P-SPACE
?PRG28:	DLESS?	'SCNT,0 \?ELS32
	JUMP	?REP29
?ELS32:	CRLF	
	JUMP	?PRG28
?REP29:	ZERO?	P-PROMPT /?CND35
	ZERO?	P-OFLAG \?CND35
	EQUAL?	P-PROMPT,2 \?ELS42
	PRINTI	"Okay, "
	CALL	PRINT-NAME,FIRST-NAME
	PRINTI	", what do you want to do now?"
	JUMP	?CND40
?ELS42:	PRINTI	"What next?"
?CND40:	CRLF	
?CND35:	PRINTI	">"
	READ	P-INBUF,P-LEXV
?CND16:	GETB	P-LEXV,P-LEXWORDS >P-LEN
	GET	P-LEXV,PTR
	EQUAL?	W?THEN,STACK \?CND51
	ADD	PTR,P-LEXELEN >PTR
	DEC	'P-LEN
?CND51:	LESS?	1,P-LEN \?CND54
	GET	P-LEXV,PTR
	EQUAL?	W?GO,STACK \?CND54
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
	ZERO?	NW /?CND54
	CALL	WT?,NW,PS?VERB,P1?VERB
	ZERO?	STACK /?CND54
	ADD	PTR,P-LEXELEN >PTR
	DEC	'P-LEN
?CND54:	ZERO?	P-LEN \?CND59
	PRINTI	"I beg your pardon?"
	CRLF	
	RFALSE	
?CND59:	SET	'LEN,P-LEN
	SET	'P-DIR,FALSE-VALUE
	SET	'P-NCN,0
	SET	'P-GETFLAGS,0
	PUT	P-ITBL,P-VERBN,0
?PRG64:	DLESS?	'P-LEN,0 \?ELS68
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP65
?ELS68:	GET	P-LEXV,PTR >WRD
	CALL	BUZZER-WORD?,WRD
	ZERO?	STACK \FALSE
	ZERO?	WRD \?THN73
	CALL	NUMBER?,PTR >WRD
	ZERO?	WRD \?THN73
	CALL	NAME?,PTR >WRD
	ZERO?	WRD /?ELS72
?THN73:	EQUAL?	WRD,W?TO \?ELS77
	EQUAL?	VERB,ACT?TELL,ACT?ASK \?ELS77
	SET	'VERB,ACT?TELL
	SET	'WRD,W?QUOTE
	JUMP	?CND75
?ELS77:	EQUAL?	WRD,W?THEN \?CND75
	ZERO?	VERB \?CND75
	PUT	P-ITBL,P-VERB,ACT?TELL
	PUT	P-ITBL,P-VERBN,0
	SET	'WRD,W?QUOTE
?CND75:	EQUAL?	WRD,W?THEN,W?PERIOD /?THN87
	EQUAL?	WRD,W?QUOTE \?ELS86
?THN87:	EQUAL?	WRD,W?QUOTE \?CND89
	ZERO?	QUOTE-FLAG /?ELS94
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?CND89
?ELS94:	SET	'QUOTE-FLAG,TRUE-VALUE
?CND89:	ZERO?	P-LEN /?THN98
	ADD	PTR,P-LEXELEN >P-CONT
?THN98:	PUTB	P-LEXV,P-LEXWORDS,P-LEN
	JUMP	?REP65
?ELS86:	CALL	WT?,WRD,PS?DIRECTION,P1?DIRECTION >VAL
	ZERO?	VAL /?ELS101
	EQUAL?	LEN,1 /?THN104
	EQUAL?	LEN,2 \?ELS107
	EQUAL?	VERB,ACT?WALK /?THN104
?ELS107:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
	EQUAL?	NW,W?THEN,W?QUOTE \?ELS109
	GRTR?	LEN,2 /?THN104
?ELS109:	EQUAL?	NW,W?PERIOD \?ELS111
	GRTR?	LEN,1 /?THN104
?ELS111:	ZERO?	QUOTE-FLAG /?ELS113
	EQUAL?	LEN,2 \?ELS113
	EQUAL?	NW,W?QUOTE /?THN104
?ELS113:	GRTR?	LEN,2 \?ELS101
	EQUAL?	NW,W?COMMA,W?AND \?ELS101
?THN104:	SET	'DIR,VAL
	EQUAL?	NW,W?COMMA,W?AND \?CND116
	ADD	PTR,P-LEXELEN
	PUT	P-LEXV,STACK,W?THEN
?CND116:	GRTR?	LEN,2 /?CND66
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP65
?ELS101:	CALL	WT?,WRD,PS?VERB,P1?VERB >VAL
	ZERO?	VAL /?ELS123
	ZERO?	VERB /?THN126
	EQUAL?	VERB,ACT?NAME \?ELS123
?THN126:	EQUAL?	VERB,ACT?NAME \?CND128
	SET	'P-WHAT-IGNORED,TRUE-VALUE
?CND128:	SET	'VERB,VAL
	PUT	P-ITBL,P-VERB,VAL
	PUT	P-ITBL,P-VERBN,P-VTBL
	PUT	P-VTBL,0,WRD
	MUL	PTR,2
	ADD	STACK,2 >NUM
	GETB	P-LEXV,NUM
	PUTB	P-VTBL,2,STACK
	ADD	NUM,1
	GETB	P-LEXV,STACK
	PUTB	P-VTBL,3,STACK
	JUMP	?CND66
?ELS123:	CALL	WT?,WRD,PS?PREPOSITION,0 >VAL
	ZERO?	VAL \?THN133
	EQUAL?	WRD,W?ONE,W?A /?THN137
	CALL	WT?,WRD,PS?ADJECTIVE
	ZERO?	STACK \?THN137
	CALL	WT?,WRD,PS?OBJECT
	ZERO?	STACK /?ELS132
?THN137:	SET	'VAL,0 \?ELS132
?THN133:	GRTR?	P-LEN,1 \?ELS141
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?OF \?ELS141
	EQUAL?	VERB,ACT?MAKE /?ELS141
	ZERO?	VAL \?ELS141
	EQUAL?	WRD,W?ONE,W?A /?ELS141
	SET	'OF-FLAG,TRUE-VALUE
	JUMP	?CND66
?ELS141:	ZERO?	VAL /?ELS145
	ZERO?	P-LEN /?THN148
	ADD	PTR,2
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?THEN,W?PERIOD \?ELS145
?THN148:	LESS?	P-NCN,2 \?CND66
	PUT	P-ITBL,P-PREP1,VAL
	PUT	P-ITBL,P-PREP1N,WRD
	JUMP	?CND66
?ELS145:	EQUAL?	P-NCN,2 \?ELS154
	PRINTI	"(I found too many nouns in that sentence!)"
	CRLF	
	RFALSE	
?ELS154:	INC	'P-NCN
	CALL	CLAUSE,PTR,VAL,WRD >PTR
	ZERO?	PTR /FALSE
	LESS?	PTR,0 \?CND66
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP65
?ELS132:	EQUAL?	WRD,W?CLOSELY \?ELS165
	SET	'P-ADVERB,W?CAREFULLY
	JUMP	?CND66
?ELS165:	EQUAL?	WRD,W?CAREFULLY,W?QUIETLY,W?PRIVATELY /?THN168
	EQUAL?	WRD,W?SLOWLY,W?QUICKLY,W?BRIEFLY \?ELS167
?THN168:	SET	'P-ADVERB,WRD
	JUMP	?CND66
?ELS167:	EQUAL?	WRD,W?OF \?ELS171
	ZERO?	OF-FLAG /?THN175
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?PERIOD,W?THEN \?ELS174
?THN175:	CALL	CANT-USE,PTR
	RFALSE	
?ELS174:	SET	'OF-FLAG,FALSE-VALUE
	JUMP	?CND66
?ELS171:	CALL	WT?,WRD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS180
	JUMP	?CND66
?ELS180:	CALL	CANT-USE,PTR
	RFALSE	
?ELS72:	CALL	UNKNOWN-WORD,PTR
	RFALSE	
?CND66:	SET	'LW,WRD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG64
?REP65:	ZERO?	DIR /?CND185
	SET	'PRSA,V?WALK
	SET	'PRSO,DIR
	SET	'P-WALK-DIR,DIR
	RETURN	TRUE-VALUE
?CND185:	SET	'P-WALK-DIR,FALSE-VALUE
	ZERO?	P-OFLAG /?CND189
	CALL	ORPHAN-MERGE
?CND189:	GET	P-ITBL,P-VERB
	ZERO?	STACK \?CND193
	PUT	P-ITBL,P-VERB,ACT?$CALL
?CND193:	CALL	SYNTAX-CHECK
	ZERO?	STACK /FALSE
	CALL	SNARF-OBJECTS
	ZERO?	STACK /FALSE
	CALL	MANY-CHECK
	ZERO?	STACK /FALSE
	CALL	TAKE-CHECK
	ZERO?	STACK /FALSE
	RTRUE


	.FUNCT	WT?,PTR,BIT,B1=5,OFFSET=P-P1OFF,TYP
	GETB	PTR,P-PSOFF >TYP
	BTST	TYP,BIT \FALSE
	GRTR?	B1,4 /TRUE
	BAND	TYP,P-P1BITS >TYP
	EQUAL?	TYP,B1 /?CND13
	INC	'OFFSET
?CND13:	GETB	PTR,OFFSET
	RSTACK	


	.FUNCT	CLAUSE,PTR,VAL,WRD,OFF,NUM,ANDFLG=0,FIRST??=1,NW,LW=0,?TMP1
	SUB	P-NCN,1
	MUL	STACK,2 >OFF
	ZERO?	VAL /?ELS3
	ADD	P-PREP1,OFF >NUM
	PUT	P-ITBL,NUM,VAL
	ADD	NUM,1
	PUT	P-ITBL,STACK,WRD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND1
?ELS3:	INC	'P-LEN
?CND1:	ZERO?	P-LEN \?CND6
	DEC	'P-NCN
	RETURN	-1
?CND6:	ADD	P-NC1,OFF >NUM
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,NUM,STACK
	GET	P-LEXV,PTR
	EQUAL?	STACK,W?THE,W?A,W?AN \?CND9
	GET	P-ITBL,NUM
	ADD	STACK,4
	PUT	P-ITBL,NUM,STACK
?CND9:	
?PRG12:	DLESS?	'P-LEN,0 \?CND14
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	-1
?CND14:	GET	P-LEXV,PTR >WRD
	CALL	BUZZER-WORD?,WRD
	ZERO?	STACK \FALSE
	ZERO?	WRD \?THN22
	CALL	NUMBER?,PTR >WRD
	ZERO?	WRD \?THN22
	CALL	NAME?,PTR >WRD
	ZERO?	WRD /?ELS21
?THN22:	ZERO?	P-LEN \?ELS26
	SET	'NW,0
	JUMP	?CND24
?ELS26:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
?CND24:	EQUAL?	WRD,W?OF \?CND29
	GET	P-ITBL,P-VERB
	EQUAL?	STACK,ACT?MAKE \?CND29
	PUT	P-LEXV,PTR,W?WITH
	SET	'WRD,W?WITH
?CND29:	EQUAL?	WRD,W?AND,W?COMMA \?ELS36
	SET	'ANDFLG,TRUE-VALUE
	JUMP	?CND17
?ELS36:	EQUAL?	WRD,W?ONE \?ELS38
	EQUAL?	NW,W?OF \?CND17
	DEC	'P-LEN
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND17
?ELS38:	EQUAL?	WRD,W?THEN,W?PERIOD /?THN44
	CALL	WT?,WRD,PS?PREPOSITION
	ZERO?	STACK /?ELS43
	ZERO?	FIRST?? \?ELS43
?THN44:	INC	'P-LEN
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	SUB	PTR,P-LEXELEN
	RETURN	STACK
?ELS43:	ZERO?	ANDFLG /?ELS49
	GET	P-ITBL,P-VERBN
	ZERO?	STACK /?THN52
	CALL	WT?,WRD,PS?DIRECTION
	ZERO?	STACK \?THN52
	CALL	WT?,WRD,PS?VERB
	ZERO?	STACK /?ELS49
?THN52:	SUB	PTR,4 >PTR
	ADD	PTR,2
	PUT	P-LEXV,STACK,W?THEN
	ADD	P-LEN,2 >P-LEN
	JUMP	?CND17
?ELS49:	CALL	WT?,WRD,PS?OBJECT
	ZERO?	STACK /?ELS55
	CALL	WT?,WRD,PS?ADJECTIVE,P1?ADJECTIVE
	ZERO?	STACK /?ELS58
	ZERO?	NW /?ELS58
	CALL	WT?,NW,PS?OBJECT
	ZERO?	STACK /?ELS58
	JUMP	?CND17
?ELS58:	ZERO?	ANDFLG \?ELS62
	EQUAL?	NW,W?AND,W?COMMA /?ELS62
	ADD	NUM,1 >?TMP1
	ADD	PTR,2
	MUL	STACK,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	PTR
?ELS62:	SET	'ANDFLG,FALSE-VALUE
	JUMP	?CND17
?ELS55:	CALL	WT?,WRD,PS?ADJECTIVE
	ZERO?	STACK \?CND17
	CALL	WT?,WRD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS68
	JUMP	?CND17
?ELS68:	CALL	WT?,WRD,PS?PREPOSITION
	ZERO?	STACK /?ELS72
	JUMP	?CND17
?ELS72:	CALL	CANT-USE,PTR
	RFALSE	
?ELS21:	CALL	UNKNOWN-WORD,PTR
	RFALSE	
?CND17:	SET	'LW,WRD
	SET	'FIRST??,FALSE-VALUE
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG12


	.FUNCT	NUMBER?,PTR,CNT,BPTR,CHR,SUM=0,TIM=0,?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,2 >CNT
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,3 >BPTR
?PRG1:	DLESS?	'CNT,0 \?ELS5
	JUMP	?REP2
?ELS5:	GETB	P-INBUF,BPTR >CHR
	EQUAL?	CHR,58 \?ELS10
	SET	'TIM,SUM
	SET	'SUM,0
	JUMP	?CND8
?ELS10:	GRTR?	SUM,9999 /FALSE
	GRTR?	CHR,57 /FALSE
	LESS?	CHR,48 /FALSE
	MUL	SUM,10 >?TMP1
	SUB	CHR,48
	ADD	?TMP1,STACK >SUM
?CND8:	INC	'BPTR
	JUMP	?PRG1
?REP2:	PUT	P-LEXV,PTR,W?NUMBER
	GRTR?	SUM,9999 /FALSE
	ZERO?	TIM /?CND19
	GRTR?	TIM,23 /FALSE
	GRTR?	TIM,19 \?ELS29
	JUMP	?CND25
?ELS29:	GRTR?	TIM,12 /FALSE
	GRTR?	TIM,7 \?ELS33
	JUMP	?CND25
?ELS33:	ADD	12,TIM >TIM
?CND25:	MUL	TIM,60
	ADD	SUM,STACK >SUM
?CND19:	SET	'P-NUMBER,SUM
	RETURN	W?NUMBER


	.FUNCT	ORPHAN-MERGE,CNT=-1,TEMP,VERB,BEG,END,ADJ=0,WRD,?TMP1
	SET	'P-OFLAG,FALSE-VALUE
	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB /?ELS3
	GET	P-OTBL,P-VERB
	EQUAL?	VERB,STACK \FALSE
?ELS3:	EQUAL?	P-NCN,2 /FALSE
	GET	P-OTBL,P-NC1
	EQUAL?	STACK,1 \?ELS9
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP1
	EQUAL?	TEMP,STACK /?THN13
	ZERO?	TEMP \FALSE
?THN13:	ZERO?	ADJ /?ELS17
	ADD	P-LEXV,2
	PUT	P-OTBL,P-NC1,STACK
	ADD	P-LEXV,6
	PUT	P-OTBL,P-NC1L,STACK
	JUMP	?CND1
?ELS17:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC1,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC1L,STACK
	JUMP	?CND1
?ELS9:	GET	P-OTBL,P-NC2
	EQUAL?	STACK,1 \?ELS24
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP2
	EQUAL?	TEMP,STACK /?THN28
	ZERO?	TEMP \FALSE
?THN28:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC2,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC2L,STACK
	SET	'P-NCN,2
	JUMP	?CND1
?ELS24:	ZERO?	P-ACLAUSE /?CND1
	EQUAL?	P-NCN,1 /?ELS37
	SET	'P-ACLAUSE,FALSE-VALUE
	RFALSE	
?ELS37:	GET	P-ITBL,P-NC1 >BEG
	GET	P-ITBL,P-NC1L >END
?PRG40:	EQUAL?	BEG,END \?ELS44
	ZERO?	ADJ /?ELS47
	CALL	ACLAUSE-WIN,ADJ
	JUMP	?CND35
?ELS47:	SET	'P-ACLAUSE,FALSE-VALUE
	RFALSE	
?ELS44:	ZERO?	ADJ \?ELS52
	GET	BEG,0 >WRD
	GETB	WRD,P-PSOFF
	BTST	STACK,PS?ADJECTIVE \?ELS52
	SET	'ADJ,WRD
	JUMP	?CND42
?ELS52:	GETB	WRD,P-PSOFF
	BTST	STACK,PS?OBJECT /?THN57
	EQUAL?	WRD,W?ONE \?CND42
?THN57:	EQUAL?	WRD,P-ANAM,W?ONE \FALSE
	CALL	ACLAUSE-WIN,ADJ
	JUMP	?CND35
?CND42:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG40
?CND35:	
?CND1:	
?PRG64:	IGRTR?	'CNT,P-ITBLLEN \?ELS68
	SET	'P-MERGED,TRUE-VALUE
	RTRUE	
?ELS68:	GET	P-OTBL,CNT
	PUT	P-ITBL,CNT,STACK
	JUMP	?PRG64


	.FUNCT	ACLAUSE-WIN,ADJ
	GET	P-OTBL,P-VERB
	PUT	P-ITBL,P-VERB,STACK
	SET	'P-CCSRC,P-OTBL
	ADD	P-ACLAUSE,1
	CALL	CLAUSE-COPY,P-ACLAUSE,STACK,ADJ
	GET	P-OTBL,P-NC2
	ZERO?	STACK /?ELS2
	SET	'P-NCN,2
?ELS2:	SET	'P-ACLAUSE,FALSE-VALUE
	RTRUE	


	.FUNCT	WORD-PRINT,CNT,BUF
?PRG1:	DLESS?	'CNT,0 /TRUE
	GETB	P-INBUF,BUF
	PRINTC	STACK
	INC	'BUF
	JUMP	?PRG1


	.FUNCT	UNKNOWN-WORD,PTR,BUF,?TMP1
	PRINTI	"(I don't know the word """
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	CALL	WORD-PRINT,?TMP1,STACK
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	PRINTR	""".)"


	.FUNCT	CANT-USE,PTR,BUF,?TMP1
	PRINTI	"(Sorry, but I don't understand the word """
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	CALL	WORD-PRINT,?TMP1,STACK
	PRINTI	""" when you use it that way.)"
	CRLF	
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	RETURN	P-OFLAG


	.FUNCT	SYNTAX-CHECK,SYN,LEN,NUM,OBJ,DRIVE1=0,DRIVE2=0,PREP,VERB,?TMP2,?TMP1
	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB \?CND1
	CALL	MISSING-VERB
	RFALSE	
?CND1:	SUB	255,VERB
	GET	VERBS,STACK >SYN
	GETB	SYN,0 >LEN
	ADD	1,SYN >SYN
?PRG4:	GETB	SYN,P-SBITS
	BAND	STACK,P-SONUMS >NUM
	GRTR?	P-NCN,NUM \?ELS8
	JUMP	?CND6
?ELS8:	LESS?	NUM,1 /?ELS10
	ZERO?	P-NCN \?ELS10
	GET	P-ITBL,P-PREP1 >PREP
	ZERO?	PREP /?THN13
	GETB	SYN,P-SPREP1
	EQUAL?	PREP,STACK \?ELS10
?THN13:	SET	'DRIVE1,SYN
	JUMP	?CND6
?ELS10:	GETB	SYN,P-SPREP1 >?TMP1
	GET	P-ITBL,P-PREP1
	EQUAL?	?TMP1,STACK \?CND6
	EQUAL?	NUM,2 \?ELS19
	EQUAL?	P-NCN,1 \?ELS19
	SET	'DRIVE2,SYN
	JUMP	?CND6
?ELS19:	GETB	SYN,P-SPREP2 >?TMP1
	GET	P-ITBL,P-PREP2
	EQUAL?	?TMP1,STACK \?CND6
	CALL	SYNTAX-FOUND,SYN
	RTRUE	
?CND6:	DLESS?	'LEN,1 \?ELS26
	ZERO?	DRIVE1 \?REP5
	ZERO?	DRIVE2 /?ELS29
	JUMP	?REP5
?ELS29:	PRINTI	"(Sorry, but I don't understand. Please reword that or try something else.)"
	CRLF	
	RFALSE	
?ELS26:	ADD	SYN,P-SYNLEN >SYN
	JUMP	?PRG4
?REP5:	ZERO?	DRIVE1 /?ELS42
	GETB	DRIVE1,P-SFWIM1 >?TMP2
	GETB	DRIVE1,P-SLOC1 >?TMP1
	GETB	DRIVE1,P-SPREP1
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?ELS42
	PUT	P-PRSO,P-MATCHLEN,1
	PUT	P-PRSO,1,OBJ
	CALL	SYNTAX-FOUND,DRIVE1
	RSTACK	
?ELS42:	ZERO?	DRIVE2 /?ELS46
	GETB	DRIVE2,P-SFWIM2 >?TMP2
	GETB	DRIVE2,P-SLOC2 >?TMP1
	GETB	DRIVE2,P-SPREP2
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?ELS46
	PUT	P-PRSI,P-MATCHLEN,1
	PUT	P-PRSI,1,OBJ
	CALL	SYNTAX-FOUND,DRIVE2
	RSTACK	
?ELS46:	EQUAL?	VERB,ACT?FIND,ACT?NAME \?ELS50
	PRINTI	"(Sorry, but I can't answer that question.)"
	CRLF	
	RFALSE	
?ELS50:	EQUAL?	WINNER,PLAYER \?ELS57
	CALL	ORPHAN,DRIVE1,DRIVE2
	PRINTI	"(Wh"
	EQUAL?	VERB,ACT?WALK \?ELS64
	PUSH	STR?122
	JUMP	?CND60
?ELS64:	PUSH	STR?123
?CND60:	PRINT	STACK
	PRINTI	" do you want to "
	JUMP	?CND55
?ELS57:	PRINTI	"(Your command was not complete. Next time, type wh"
	EQUAL?	VERB,ACT?WALK \?ELS75
	PUSH	STR?122
	JUMP	?CND71
?ELS75:	PUSH	STR?123
?CND71:	PRINT	STACK
	PRINTI	" you want "
	PRINTD	WINNER
	PRINTI	" to "
?CND55:	CALL	VERB-PRINT
	ZERO?	DRIVE2 /?CND78
	CALL	CLAUSE-PRINT,P-NC1,P-NC1L
?CND78:	ZERO?	DRIVE1 /?ELS86
	GETB	DRIVE1,P-SPREP1
	JUMP	?CND82
?ELS86:	GETB	DRIVE2,P-SPREP2
?CND82:	CALL	PREP-PRINT,STACK
	EQUAL?	WINNER,PLAYER \?ELS92
	SET	'P-OFLAG,TRUE-VALUE
	PRINTI	"?)"
	CRLF	
	RFALSE	
?ELS92:	SET	'P-OFLAG,FALSE-VALUE
	PRINTI	".)"
	CRLF	
	RFALSE	


	.FUNCT	VERB-PRINT,TMP,?TMP1
	GET	P-ITBL,P-VERBN >TMP
	ZERO?	TMP \?ELS5
	PRINTI	"tell"
	RTRUE	
?ELS5:	GETB	P-VTBL,2
	ZERO?	STACK \?ELS9
	GET	TMP,0
	PRINTB	STACK
	RTRUE	
?ELS9:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
	PUTB	P-VTBL,2,0
	RTRUE	


	.FUNCT	ORPHAN,D1,D2,CNT=-1
	PUT	P-OCLAUSE,P-MATCHLEN,0
	SET	'P-CCSRC,P-ITBL
?PRG1:	IGRTR?	'CNT,P-ITBLLEN \?ELS5
	JUMP	?REP2
?ELS5:	GET	P-ITBL,CNT
	PUT	P-OTBL,CNT,STACK
	JUMP	?PRG1
?REP2:	EQUAL?	P-NCN,2 \?CND8
	CALL	CLAUSE-COPY,P-NC2,P-NC2L
?CND8:	LESS?	P-NCN,1 /?CND11
	CALL	CLAUSE-COPY,P-NC1,P-NC1L
?CND11:	ZERO?	D1 /?ELS18
	GETB	D1,P-SPREP1
	PUT	P-OTBL,P-PREP1,STACK
	PUT	P-OTBL,P-NC1,1
	RTRUE	
?ELS18:	ZERO?	D2 /FALSE
	GETB	D2,P-SPREP2
	PUT	P-OTBL,P-PREP2,STACK
	PUT	P-OTBL,P-NC2,1
	RTRUE	


	.FUNCT	CLAUSE-PRINT,BPTR,EPTR,THE?=1,?TMP1
	GET	P-ITBL,BPTR >?TMP1
	GET	P-ITBL,EPTR
	CALL	BUFFER-PRINT,?TMP1,STACK,THE?
	RSTACK	


	.FUNCT	BUFFER-PRINT,BEG,END,CP,NOSP=0,WRD,FIRST??=1,PN=0,?TMP1
?PRG1:	EQUAL?	BEG,END /TRUE
	ZERO?	NOSP /?ELS10
	SET	'NOSP,FALSE-VALUE
	JUMP	?CND8
?ELS10:	PRINTI	" "
?CND8:	GET	BEG,0 >WRD
	EQUAL?	WRD,W?PERIOD \?ELS18
	SET	'NOSP,TRUE-VALUE
	JUMP	?CND3
?ELS18:	EQUAL?	WRD,W?DR \?ELS20
	PRINTI	"Dr."
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS20:	EQUAL?	WRD,W?HIM,W?HER,W?ME \?ELS24
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS24:	CALL	CAPITAL-NOUN?,WRD
	ZERO?	STACK /?ELS26
	CALL	CAPITALIZE,BEG
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS26:	ZERO?	FIRST?? /?CND29
	ZERO?	PN \?CND29
	ZERO?	CP /?CND29
	PRINTI	"the "
?CND29:	ZERO?	P-OFLAG \?THN39
	ZERO?	P-MERGED /?ELS38
?THN39:	PRINTB	WRD
	JUMP	?CND36
?ELS38:	EQUAL?	WRD,W?IT \?ELS42
	CALL	VISIBLE?,P-IT-OBJECT
	ZERO?	STACK /?ELS42
	PRINTD	P-IT-OBJECT
	JUMP	?CND36
?ELS42:	EQUAL?	WRD,W?HER \?ELS46
	CALL	VISIBLE?,P-HER-OBJECT
	ZERO?	STACK /?ELS46
	PRINTD	P-HER-OBJECT
	JUMP	?CND36
?ELS46:	EQUAL?	WRD,W?HIM \?ELS50
	CALL	VISIBLE?,P-HIM-OBJECT
	ZERO?	STACK /?ELS50
	PRINTD	P-HIM-OBJECT
	JUMP	?CND36
?ELS50:	GETB	BEG,2 >?TMP1
	GETB	BEG,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND36:	SET	'FIRST??,FALSE-VALUE
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CAPITALIZE,PTR,?TMP1
	GETB	PTR,3
	GETB	P-INBUF,STACK
	SUB	STACK,32
	PRINTC	STACK
	GETB	PTR,2
	SUB	STACK,1 >?TMP1
	GETB	PTR,3
	ADD	STACK,1
	CALL	WORD-PRINT,?TMP1,STACK
	RSTACK	


	.FUNCT	PREP-PRINT,PREP,SP?=1,WRD
	ZERO?	PREP /FALSE
	ZERO?	SP? /?CND6
	PRINTI	" "
?CND6:	CALL	PREP-FIND,PREP >WRD
	EQUAL?	WRD,W?AGAINST \?ELS14
	PRINTI	"against"
	JUMP	?CND12
?ELS14:	EQUAL?	WRD,W?THROUGH \?ELS18
	PRINTI	"through"
	JUMP	?CND12
?ELS18:	PRINTB	WRD
?CND12:	GET	P-ITBL,P-VERBN
	GET	STACK,0
	EQUAL?	W?SIT,STACK \?CND23
	EQUAL?	W?DOWN,WRD \?CND23
	PRINTI	" on"
?CND23:	GET	P-ITBL,P-VERBN
	GET	STACK,0
	EQUAL?	W?GET,STACK \TRUE
	EQUAL?	W?OUT,WRD \TRUE
	PRINTI	" of"
	RTRUE	


	.FUNCT	CLAUSE-COPY,BPTR,EPTR,INSERT=0,BEG,END
	GET	P-CCSRC,BPTR >BEG
	GET	P-CCSRC,EPTR >END
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,BPTR,STACK
?PRG1:	EQUAL?	BEG,END \?ELS5
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,EPTR,STACK
	RTRUE	
?ELS5:	ZERO?	INSERT /?CND8
	GET	BEG,0
	EQUAL?	P-ANAM,STACK \?CND8
	CALL	CLAUSE-ADD,INSERT
?CND8:	GET	BEG,0
	CALL	CLAUSE-ADD,STACK
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CLAUSE-ADD,WRD,PTR
	GET	P-OCLAUSE,P-MATCHLEN
	ADD	STACK,2 >PTR
	SUB	PTR,1
	PUT	P-OCLAUSE,STACK,WRD
	PUT	P-OCLAUSE,PTR,0
	PUT	P-OCLAUSE,P-MATCHLEN,PTR
	RTRUE	


	.FUNCT	PREP-FIND,PREP,CNT=0,SIZE
	GET	PREPOSITIONS,0
	MUL	STACK,2 >SIZE
?PRG1:	IGRTR?	'CNT,SIZE /FALSE
	GET	PREPOSITIONS,CNT
	EQUAL?	STACK,PREP \?PRG1
	SUB	CNT,1
	GET	PREPOSITIONS,STACK
	RETURN	STACK


	.FUNCT	SYNTAX-FOUND,SYN
	SET	'P-SYNTAX,SYN
	GETB	SYN,P-SACTION >PRSA
	RETURN	PRSA


	.FUNCT	GWIM,GBIT,LBIT,PREP,OBJ,WPREP
	EQUAL?	GBIT,RMUNGBIT \?CND1
	RETURN	ROOMS
?CND1:	SET	'P-GWIMBIT,GBIT
	SET	'P-SLOCBITS,LBIT
	PUT	P-MERGE,P-MATCHLEN,0
	CALL	GET-OBJECT,P-MERGE,FALSE-VALUE
	ZERO?	STACK /?ELS8
	SET	'P-GWIMBIT,0
	GET	P-MERGE,P-MATCHLEN
	EQUAL?	STACK,1 \FALSE
	GET	P-MERGE,1 >OBJ
	PRINTI	"("
	CALL	PREP-PRINT,PREP,FALSE-VALUE
	ZERO?	STACK /?CND16
	CALL	THE?,OBJ
	PRINTI	" "
?CND16:	PRINTD	OBJ
	PRINTI	")"
	CRLF	
	RETURN	OBJ
?ELS8:	SET	'P-GWIMBIT,0
	RFALSE	


	.FUNCT	SNARF-OBJECTS,PTR
	GET	P-ITBL,P-NC1 >PTR
	ZERO?	PTR /?CND1
	GETB	P-SYNTAX,P-SLOC1 >P-SLOCBITS
	GET	P-ITBL,P-NC1L
	CALL	SNARFEM,PTR,STACK,P-PRSO
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /?CND1
	CALL	BUT-MERGE,P-PRSO >P-PRSO
?CND1:	GET	P-ITBL,P-NC2 >PTR
	ZERO?	PTR /TRUE
	GETB	P-SYNTAX,P-SLOC2 >P-SLOCBITS
	GET	P-ITBL,P-NC2L
	CALL	SNARFEM,PTR,STACK,P-PRSI
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /TRUE
	GET	P-PRSI,P-MATCHLEN
	EQUAL?	STACK,1 \?ELS18
	CALL	BUT-MERGE,P-PRSO >P-PRSO
	RTRUE	
?ELS18:	CALL	BUT-MERGE,P-PRSI >P-PRSI
	RTRUE	


	.FUNCT	BUT-MERGE,TBL,LEN,BUTLEN,CNT=1,MATCHES=0,OBJ,NTBL
	GET	TBL,P-MATCHLEN >LEN
	PUT	P-MERGE,P-MATCHLEN,0
?PRG1:	DLESS?	'LEN,0 \?ELS5
	JUMP	?REP2
?ELS5:	GET	TBL,CNT >OBJ
	CALL	ZMEMQ,OBJ,P-BUTS
	ZERO?	STACK /?ELS7
	JUMP	?CND3
?ELS7:	ADD	MATCHES,1
	PUT	P-MERGE,STACK,OBJ
	INC	'MATCHES
?CND3:	INC	'CNT
	JUMP	?PRG1
?REP2:	PUT	P-MERGE,P-MATCHLEN,MATCHES
	SET	'NTBL,P-MERGE
	SET	'P-MERGE,TBL
	RETURN	NTBL


	.FUNCT	SNARFEM,PTR,EPTR,TBL,BUT=0,LEN,WV,WRD,NW
	SET	'P-AND,FALSE-VALUE
	SET	'P-GETFLAGS,0
	SET	'P-CSPTR,PTR
	SET	'P-CEPTR,EPTR
	PUT	P-BUTS,P-MATCHLEN,0
	PUT	TBL,P-MATCHLEN,0
	GET	PTR,0 >WRD
?PRG1:	EQUAL?	PTR,EPTR \?ELS5
	ZERO?	BUT /?ORP9
	PUSH	BUT
	JUMP	?THN6
?ORP9:	PUSH	TBL
?THN6:	CALL	GET-OBJECT,STACK
	RETURN	STACK
?ELS5:	GET	PTR,P-LEXELEN >NW
	CALL	BUZZER-WORD?,WRD
	ZERO?	STACK \FALSE
	EQUAL?	WRD,W?A,W?ONE \?ELS16
	ZERO?	P-ADJ \?ELS19
	SET	'P-GETFLAGS,P-ONE
	EQUAL?	NW,W?OF \?CND3
	ADD	PTR,P-WORDLEN >PTR
	JUMP	?CND3
?ELS19:	SET	'P-NAM,P-ONEOBJ
	ZERO?	BUT /?ORP30
	PUSH	BUT
	JUMP	?THN27
?ORP30:	PUSH	TBL
?THN27:	CALL	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	ZERO?	NW /TRUE
	JUMP	?CND3
?ELS16:	EQUAL?	WRD,W?AND,W?COMMA \?ELS34
	EQUAL?	NW,W?AND,W?COMMA /?ELS34
	SET	'P-AND,TRUE-VALUE
	ZERO?	BUT /?ORP42
	PUSH	BUT
	JUMP	?THN39
?ORP42:	PUSH	TBL
?THN39:	CALL	GET-OBJECT,STACK
	ZERO?	STACK \?CND12
	RFALSE	
?ELS34:	CALL	WT?,WRD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS44
	JUMP	?CND3
?ELS44:	EQUAL?	WRD,W?AND,W?COMMA \?ELS46
	JUMP	?CND3
?ELS46:	EQUAL?	WRD,W?OF \?ELS48
	ZERO?	P-GETFLAGS \?CND12
	SET	'P-GETFLAGS,P-INHIBIT
	JUMP	?CND12
?ELS48:	CALL	WT?,WRD,PS?ADJECTIVE,P1?ADJECTIVE >WV
	ZERO?	WV /?ELS53
	ZERO?	P-ADJ \?ELS53
	SET	'P-ADJ,WV
	SET	'P-ADJN,WRD
	JUMP	?CND3
?ELS53:	CALL	WT?,WRD,PS?OBJECT,P1?OBJECT
	ZERO?	STACK /?CND3
	SET	'P-NAM,WRD
	SET	'P-ONEOBJ,WRD
?CND12:	
?CND3:	EQUAL?	PTR,EPTR /?PRG1
	ADD	PTR,P-WORDLEN >PTR
	SET	'WRD,NW
	JUMP	?PRG1


	.FUNCT	GET-OBJECT,TBL,VRB=1,BTS,LEN,XBITS,TLEN,GCHECK=0,OLEN=0,OBJ,ADJ
	SET	'XBITS,P-SLOCBITS
	GET	TBL,P-MATCHLEN >TLEN
	BTST	P-GETFLAGS,P-INHIBIT /TRUE
	SET	'ADJ,P-ADJN
	ZERO?	P-NAM \?CND4
	ZERO?	P-ADJ /?CND4
	CALL	WT?,P-ADJN,PS?OBJECT,P1?OBJECT
	ZERO?	STACK /?ELS11
	SET	'P-NAM,P-ADJN
	SET	'P-ADJ,FALSE-VALUE
	JUMP	?CND4
?ELS11:	CALL	WT?,P-ADJN,PS?DIRECTION,P1?DIRECTION >BTS
	ZERO?	BTS /?CND4
	SET	'P-ADJ,FALSE-VALUE
	PUT	TBL,P-MATCHLEN,1
	PUT	TBL,1,INTDIR
	SET	'P-DIRECTION,BTS
	RTRUE	
?CND4:	ZERO?	P-NAM \?CND14
	ZERO?	P-ADJ \?CND14
	EQUAL?	P-GETFLAGS,P-ALL /?CND14
	ZERO?	P-GWIMBIT \?CND14
	ZERO?	VRB /FALSE
	CALL	MISSING-NOUN,ADJ
	RFALSE	
?CND14:	EQUAL?	P-GETFLAGS,P-ALL \?THN26
	ZERO?	P-SLOCBITS \?CND23
?THN26:	SET	'P-SLOCBITS,-1
?CND23:	SET	'P-TABLE,TBL
?PRG28:	ZERO?	GCHECK /?ELS32
	CALL	GLOBAL-CHECK,TBL
	JUMP	?CND30
?ELS32:	ZERO?	LIT /?CND36
	FCLEAR	PLAYER,TRANSBIT
	CALL	DO-SL,HERE,SOG,SIR
	FSET	PLAYER,TRANSBIT
?CND36:	CALL	DO-SL,PLAYER,SH,SC
?CND30:	GET	TBL,P-MATCHLEN
	SUB	STACK,TLEN >LEN
	BTST	P-GETFLAGS,P-ALL \?ELS42
	JUMP	?CND40
?ELS42:	BTST	P-GETFLAGS,P-ONE \?ELS44
	ZERO?	LEN /?ELS44
	EQUAL?	LEN,1 /?CND47
	RANDOM	LEN
	GET	TBL,STACK
	PUT	TBL,1,STACK
	PRINTI	"(How about"
	GET	TBL,1
	CALL	PRINTT,STACK
	PRINTI	"?)"
	CRLF	
?CND47:	PUT	TBL,P-MATCHLEN,1
	JUMP	?CND40
?ELS44:	GRTR?	LEN,1 /?THN54
	ZERO?	LEN \?ELS53
	EQUAL?	P-SLOCBITS,-1 /?ELS53
?THN54:	EQUAL?	P-SLOCBITS,-1 \?ELS60
	SET	'P-SLOCBITS,XBITS
	SET	'OLEN,LEN
	GET	TBL,P-MATCHLEN
	SUB	STACK,LEN
	PUT	TBL,P-MATCHLEN,STACK
	JUMP	?PRG28
?ELS60:	ZERO?	LEN \?CND63
	SET	'LEN,OLEN
?CND63:	ZERO?	P-NAM /?ELS68
	ADD	TLEN,1
	GET	TBL,STACK >OBJ
	ZERO?	OBJ /?ELS68
	GETP	OBJ,P?GENERIC
	CALL	STACK,OBJ >OBJ
	ZERO?	OBJ /?ELS68
	EQUAL?	OBJ,NOT-HERE-OBJECT /FALSE
	PUT	TBL,1,OBJ
	PUT	TBL,P-MATCHLEN,1
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RTRUE	
?ELS68:	ZERO?	VRB /?ELS75
	ZERO?	P-NAM /?ELS75
	CALL	WHICH-PRINT,TLEN,LEN,TBL
	EQUAL?	TBL,P-PRSO \?ELS82
	PUSH	P-NC1
	JUMP	?CND78
?ELS82:	PUSH	P-NC2
?CND78:	SET	'P-ACLAUSE,STACK
	SET	'P-AADJ,P-ADJ
	SET	'P-ANAM,P-NAM
	CALL	ORPHAN,FALSE-VALUE,FALSE-VALUE
	SET	'P-OFLAG,TRUE-VALUE
	JUMP	?CND66
?ELS75:	ZERO?	VRB /?CND66
	CALL	MISSING-NOUN,ADJ
?CND66:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RFALSE	
?ELS53:	ZERO?	LEN \?ELS89
	ZERO?	GCHECK /?ELS89
	ZERO?	VRB /?CND92
	SET	'P-SLOCBITS,XBITS
	ZERO?	LIT /?ELS98
	CALL	OBJ-FOUND,NOT-HERE-OBJECT,TBL
	SET	'P-XNAM,P-NAM
	SET	'P-XADJ,P-ADJ
	SET	'P-XADJN,P-ADJN
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	SET	'P-ADJN,FALSE-VALUE
	RTRUE	
?ELS98:	PRINTI	"(It's too dark to see!)"
	CRLF	
?CND92:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RFALSE	
?ELS89:	ZERO?	LEN \?CND40
	SET	'GCHECK,TRUE-VALUE
	JUMP	?PRG28
?CND40:	ZERO?	P-ADJ /?CND106
	ZERO?	P-NAM \?CND106
	PRINT	I-ASSUME
	ADD	TLEN,1
	GET	TBL,STACK
	CALL	PRINTT,STACK
	PRINTI	".)"
	CRLF	
?CND106:	SET	'P-SLOCBITS,XBITS
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RTRUE	


	.FUNCT	MISSING-NOUN,ADJ
	EQUAL?	ADJ,W?NUMBER \?ELS5
	PRINTR	"(Please use units with numbers.)"
?ELS5:	PRINTR	"(I couldn't find enough nouns in that sentence!)"


	.FUNCT	MISSING-VERB
	PRINTR	"(I couldn't find a verb in that sentence!)"


	.FUNCT	MOBY-FIND,TBL,FOO,LEN
	SET	'P-SLOCBITS,-1
	SET	'P-NAM,P-XNAM
	SET	'P-ADJ,P-XADJ
	PUT	TBL,P-MATCHLEN,0
	FIRST?	ROOMS >FOO /?KLU17
?KLU17:	
?PRG1:	ZERO?	FOO \?ELS5
	JUMP	?REP2
?ELS5:	CALL	SEARCH-LIST,FOO,TBL,P-SRCALL
	NEXT?	FOO >FOO /?KLU18
?KLU18:	JUMP	?PRG1
?REP2:	GET	TBL,P-MATCHLEN >LEN
	ZERO?	LEN \?CND8
	CALL	DO-SL,LOCAL-GLOBALS,1,1
?CND8:	GET	TBL,P-MATCHLEN >LEN
	ZERO?	LEN \?CND11
	CALL	DO-SL,ROOMS,1,1
?CND11:	GET	TBL,P-MATCHLEN >LEN
	EQUAL?	LEN,1 \?CND14
	GET	TBL,1 >P-MOBY-FOUND
	RETURN	LEN
?CND14:	RETURN	LEN


	.FUNCT	WHICH-PRINT,TLEN,LEN,TBL,OBJ,RLEN
	SET	'RLEN,LEN
	PRINTI	"(Which"
	ZERO?	P-OFLAG \?THN6
	ZERO?	P-MERGED \?THN6
	ZERO?	P-AND /?ELS5
?THN6:	PRINTI	" "
	PRINTB	P-NAM
	JUMP	?CND3
?ELS5:	EQUAL?	TBL,P-PRSO \?ELS11
	CALL	CLAUSE-PRINT,P-NC1,P-NC1L,FALSE-VALUE
	JUMP	?CND3
?ELS11:	CALL	CLAUSE-PRINT,P-NC2,P-NC2L,FALSE-VALUE
?CND3:	PRINTI	" do you mean,"
?PRG16:	INC	'TLEN
	GET	TBL,TLEN >OBJ
	CALL	PRINTT,OBJ
	EQUAL?	LEN,2 \?ELS22
	EQUAL?	RLEN,2 /?CND23
	PRINTI	","
?CND23:	PRINTI	" or"
	JUMP	?CND20
?ELS22:	GRTR?	LEN,2 \?CND20
	PRINTI	","
?CND20:	DLESS?	'LEN,1 \?PRG16
	PRINTR	"?)"


	.FUNCT	GLOBAL-CHECK,TBL,LEN,RMG,RMGL,CNT=0,OBJ,OBITS,FOO
	GET	TBL,P-MATCHLEN >LEN
	SET	'OBITS,P-SLOCBITS
	GETPT	HERE,P?GLOBAL >RMG
	ZERO?	RMG /?CND1
	PTSIZE	RMG
	SUB	STACK,1 >RMGL
?PRG4:	GETB	RMG,CNT >OBJ
	CALL	THIS-IT?,OBJ,TBL
	ZERO?	STACK /?CND6
	CALL	OBJ-FOUND,OBJ,TBL
?CND6:	IGRTR?	'CNT,RMGL \?PRG4
?CND1:	GETPT	HERE,P?PSEUDO >RMG
	ZERO?	RMG /?CND12
	PTSIZE	RMG
	DIV	STACK,4
	SUB	STACK,1 >RMGL
	SET	'CNT,0
?PRG15:	MUL	CNT,2
	GET	RMG,STACK
	EQUAL?	P-NAM,STACK \?ELS19
	SET	'LAST-PSEUDO-LOC,HERE
	MUL	CNT,2
	ADD	STACK,1
	GET	RMG,STACK
	PUTP	PSEUDO-OBJECT,P?ACTION,STACK
	GETPT	PSEUDO-OBJECT,P?ACTION
	SUB	STACK,5 >FOO
	GET	P-NAM,0
	PUT	FOO,0,STACK
	GET	P-NAM,1
	PUT	FOO,1,STACK
	CALL	OBJ-FOUND,PSEUDO-OBJECT,TBL
	JUMP	?CND12
?ELS19:	IGRTR?	'CNT,RMGL \?PRG15
?CND12:	GET	TBL,P-MATCHLEN
	EQUAL?	STACK,LEN \FALSE
	SET	'P-SLOCBITS,-1
	SET	'P-TABLE,TBL
	CALL	DO-SL,GLOBAL-OBJECTS,1,1
	SET	'P-SLOCBITS,OBITS
	GET	TBL,P-MATCHLEN
	ZERO?	STACK \FALSE
	EQUAL?	PRSA,V?WALK-TO /?THN37
	EQUAL?	PRSA,V?THROUGH,V?SMELL,V?SEARCH-FOR /?THN37
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?LEAVE /?THN37
	EQUAL?	PRSA,V?FOLLOW,V?FIND,V?EXAMINE \FALSE
?THN37:	CALL	DO-SL,ROOMS,1,1
	RSTACK	


	.FUNCT	DO-SL,OBJ,BIT1,BIT2,BITS
	ADD	BIT1,BIT2
	BTST	P-SLOCBITS,STACK \?ELS5
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCALL
	RSTACK	
?ELS5:	BTST	P-SLOCBITS,BIT1 \?ELS12
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCTOP
	RSTACK	
?ELS12:	BTST	P-SLOCBITS,BIT2 \TRUE
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCBOT
	RSTACK	


	.FUNCT	SEARCH-LIST,OBJ,TBL,LVL,FLS
	FIRST?	OBJ >OBJ \FALSE
?PRG6:	EQUAL?	LVL,P-SRCBOT /?CND8
	GETPT	OBJ,P?SYNONYM
	ZERO?	STACK /?CND8
	CALL	THIS-IT?,OBJ,TBL
	ZERO?	STACK /?CND8
	CALL	OBJ-FOUND,OBJ,TBL
?CND8:	EQUAL?	LVL,P-SRCTOP \?THN18
	FSET?	OBJ,SEARCHBIT /?THN18
	FSET?	OBJ,SURFACEBIT \?CND13
?THN18:	FIRST?	OBJ \?CND13
	EQUAL?	OBJ,PLAYER,LOCAL-GLOBALS /?CND13
	FSET?	OBJ,SURFACEBIT \?ELS24
	PUSH	P-SRCALL
	JUMP	?CND20
?ELS24:	FSET?	OBJ,SEARCHBIT \?ELS26
	PUSH	P-SRCALL
	JUMP	?CND20
?ELS26:	PUSH	P-SRCTOP
?CND20:	CALL	SEARCH-LIST,OBJ,TBL,STACK >FLS
?CND13:	NEXT?	OBJ >OBJ /?PRG6
	RTRUE	


	.FUNCT	THIS-IT?,OBJ,TBL,SYNS,?TMP1
	FSET?	OBJ,INVISIBLE /FALSE
	ZERO?	P-NAM /?ELS5
	GETPT	OBJ,P?SYNONYM >SYNS
	PTSIZE	SYNS
	DIV	STACK,2
	SUB	STACK,1
	CALL	ZMEMQ,P-NAM,SYNS,STACK
	ZERO?	STACK /FALSE
?ELS5:	ZERO?	P-ADJ /?ELS9
	GETPT	OBJ,P?ADJECTIVE >SYNS
	ZERO?	SYNS /FALSE
	PTSIZE	SYNS
	SUB	STACK,1
	CALL	ZMEMQB,P-ADJ,SYNS,STACK
	ZERO?	STACK /FALSE
?ELS9:	ZERO?	P-GWIMBIT /TRUE
	FSET?	OBJ,P-GWIMBIT /TRUE
	RFALSE	


	.FUNCT	OBJ-FOUND,OBJ,TBL,PTR
	GET	TBL,P-MATCHLEN >PTR
	ADD	PTR,1
	PUT	TBL,STACK,OBJ
	ADD	PTR,1
	PUT	TBL,P-MATCHLEN,STACK
	RTRUE	


	.FUNCT	TAKE-CHECK
	GETB	P-SYNTAX,P-SLOC1
	CALL	ITAKE-CHECK,P-PRSO,STACK
	ZERO?	STACK /FALSE
	GETB	P-SYNTAX,P-SLOC2
	CALL	ITAKE-CHECK,P-PRSI,STACK
	RSTACK	


	.FUNCT	ITAKE-CHECK,TBL,BITS,PTR,OBJ,TAKEN
	GET	TBL,P-MATCHLEN >PTR
	ZERO?	PTR /TRUE
	BTST	BITS,STAKE \TRUE
?PRG8:	DLESS?	'PTR,0 /TRUE
	ADD	PTR,1
	GET	TBL,STACK >OBJ
	EQUAL?	OBJ,IT \?ELS17
	SET	'OBJ,P-IT-OBJECT
	JUMP	?CND15
?ELS17:	EQUAL?	OBJ,HER \?ELS19
	SET	'OBJ,P-HER-OBJECT
	JUMP	?CND15
?ELS19:	EQUAL?	OBJ,HIM \?CND15
	SET	'OBJ,P-HIM-OBJECT
?CND15:	IN?	OBJ,WINNER /?PRG8
	SET	'PRSO,OBJ
	FSET?	OBJ,TRYTAKEBIT \?ELS27
	SET	'TAKEN,TRUE-VALUE
	JUMP	?CND25
?ELS27:	CALL	ITAKE,FALSE-VALUE
	EQUAL?	STACK,TRUE-VALUE \?ELS29
	SET	'TAKEN,FALSE-VALUE
	JUMP	?CND25
?ELS29:	SET	'TAKEN,TRUE-VALUE
?CND25:	ZERO?	TAKEN /?ELS34
	BTST	BITS,SHAVE \?ELS34
	PRINTI	"(You aren't holding"
	EQUAL?	OBJ,NOT-HERE-OBJECT \?ELS41
	PRINTI	" that!)"
	CRLF	
	RFALSE	
?ELS41:	CALL	PRINTT,OBJ
	PRINTI	"!)"
	CRLF	
	RFALSE	
?ELS34:	ZERO?	TAKEN \?PRG8
	PRINTI	"(taking"
	CALL	THE-PRSO-PRINT
	ZERO?	ITAKE-LOC /?CND52
	PRINTI	" from "
	PRINTD	ITAKE-LOC
?CND52:	PRINTI	" first)"
	CRLF	
	JUMP	?PRG8


	.FUNCT	MANY-CHECK,LOSS=0,TMP,?TMP1
	GET	P-PRSO,P-MATCHLEN
	GRTR?	STACK,1 \?ELS3
	GETB	P-SYNTAX,P-SLOC1
	BTST	STACK,SMANY /?ELS3
	SET	'LOSS,1
	JUMP	?CND1
?ELS3:	GET	P-PRSI,P-MATCHLEN
	GRTR?	STACK,1 \?CND1
	GETB	P-SYNTAX,P-SLOC2
	BTST	STACK,SMANY /?CND1
	SET	'LOSS,2
?CND1:	ZERO?	LOSS /TRUE
	PRINTI	"(You can't use more than one "
	EQUAL?	LOSS,2 \?CND18
	PRINTI	"in"
?CND18:	PRINTI	"direct object with """
	GET	P-ITBL,P-VERBN >TMP
	ZERO?	TMP \?ELS27
	PRINTI	"tell"
	JUMP	?CND25
?ELS27:	ZERO?	P-OFLAG /?ELS31
	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND25
?ELS31:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND25:	PRINTI	"""!)"
	CRLF	
	RFALSE	


	.FUNCT	ZMEMQ,ITM,TBL,SIZE=-1,CNT=1
	ZERO?	TBL /FALSE
	LESS?	SIZE,0 /?ELS6
	SET	'CNT,0
	JUMP	?CND4
?ELS6:	GET	TBL,0 >SIZE
?CND4:	
?PRG9:	GET	TBL,CNT
	EQUAL?	ITM,STACK /TRUE
	IGRTR?	'CNT,SIZE \?PRG9
	RFALSE	


	.FUNCT	ZMEMQB,ITM,TBL,SIZE,CNT=0
?PRG1:	GETB	TBL,CNT
	EQUAL?	ITM,STACK /TRUE
	IGRTR?	'CNT,SIZE \?PRG1
	RFALSE	


	.FUNCT	ZMEMQBIT,ITM,TBL,SIZE,CNT=0,X
?PRG1:	GETB	TBL,CNT >X
	FSET?	X,ITM \?ELS5
	RETURN	X
?ELS5:	IGRTR?	'CNT,SIZE \?PRG1
	RFALSE	


	.FUNCT	PRSO-PRINT,PTR
	PRINTI	" "
	PRINTD	PRSO
	RTRUE	


	.FUNCT	THE-PRSO-PRINT
	CALL	THE?,PRSO
	CALL	PRSO-PRINT
	RSTACK	


	.FUNCT	PRSI-PRINT,PTR
	PRINTI	" "
	PRINTD	PRSI
	RTRUE	


	.FUNCT	THE-PRSI-PRINT
	CALL	THE?,PRSI
	CALL	PRSI-PRINT
	RSTACK	

	.ENDI
