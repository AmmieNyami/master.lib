; master library - BGM
;
; Description:
;	BGM関連の各種ステータス取得
;
; Function/Procedures:
;	void bgm_read_status(BSTAT *bsp);
;
; Parameters:
;	bsp		BSTAT領域へのポインタ
;
; Returns:
;	none
;
; Binding Target:
;	Microsoft-C / Turbo-C / Turbo Pascal
;
; Running Target:
;	PC-9801V
;
; Requiring Resources:
;	CPU: V30
;
; Notes:
;
;
; Assembly Language Note:
;
;
; Compiler/Assembler:
;	TASM 3.0
;	OPTASM 1.6
;
; Author:
;	femy(淀  文武)		: オリジナル・C言語版
;	steelman(千野  裕司)	: アセンブリ言語版
;
; Revision History:
;	93/12/19 Initial: b_r_stat.asm / master.lib 0.22 <- bgmlibs.lib 1.12

	.186
	.MODEL SMALL
	include func.inc
	include bgm.inc

	.DATA
	EXTRN	glb:WORD	;SGLB

	.CODE
func BGM_READ_STATUS
	mov	BX,SP
	bsp	= (RETSIZE+0)*2
	s_mov	AX,DS
	s_mov	ES,AX
	_les	BX,SS:[BX+bsp]

	;bsp->music = glb.music ? BGM_STAT_ON : BGM_STAT_OFF;
	cmp	glb.SGLB.music,1
	sbb	AX,AX
	inc	AX
	mov	ES:[BX].SBSTAT.bmusic,AX
	;bsp->sound = glb.sound ? BGM_STAT_ON : BGM_STAT_OFF;
	cmp	glb.SGLB.sound,1
	sbb	AX,AX
	inc	AX
	mov	ES:[BX].SBSTAT.bsound,AX
	;bsp->play = glb.rflg ? BGM_STAT_PLAY : BGM_STAT_MUTE;
	cmp	glb.SGLB.rflg,1
	sbb	AX,AX
	inc	AX
	mov	ES:[BX].SBSTAT.bplay,AX
	;bsp->effect = glb.effect ? BGM_STAT_PLAY : BGM_STAT_MUTE;
	cmp	glb.SGLB.effect,1
	sbb	AX,AX
	inc	AX
	mov	ES:[BX].SBSTAT.beffect,AX
	;bsp->repeat = glb.rep ? BGM_STAT_REPT : BGM_STAT_1TIM;
	cmp	glb.SGLB.repsw,1
	sbb	AX,AX
	inc	AX
	mov	ES:[BX].SBSTAT.brepeat,AX
	;bsp->mnum = glb.mnum;
	mov	AX,glb.SGLB.mnum
	mov	ES:[BX].SBSTAT.bmnum,AX
	;bsp->rnum = glb.mcnt;
	mov	AX,glb.SGLB.mcnt
	mov	ES:[BX].SBSTAT.brnum,AX
	;bsp->tempo = glb.tp;
	mov	AX,glb.SGLB.tp
	mov	ES:[BX].SBSTAT.btempo,AX
	;bsp->snum = glb.snum;
	mov	AX,glb.SGLB.snum
	mov	ES:[BX].SBSTAT.bsnum,AX
	;bsp->fnum = glb.scnt;
	mov	AX,glb.SGLB.scnt
	mov	ES:[BX].SBSTAT.bfnum,AX
	ret	(DATASIZE)*2
endfunc
END
