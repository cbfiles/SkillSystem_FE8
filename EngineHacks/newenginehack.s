	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"newenginehack.c"
@ GNU C17 (devkitARM release 61) version 13.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -O2
	.text
	.align	1
	.p2align 2,,3
	.global	ComputeBattleUnitHitRate
	.syntax unified
	.code	16
	.thumb_func
	.type	ComputeBattleUnitHitRate, %function
ComputeBattleUnitHitRate:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	movs	r3, #21	@ tmp132,
@ newenginehack.c:3: void ComputeBattleUnitHitRate(struct BattleUnit* bu) {
	push	{r4, r5, r6, lr}	@
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	ldrsb	r3, [r0, r3]	@ tmp132,
@ newenginehack.c:6: }
	@ sp needed	@
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	lsls	r4, r3, #1	@ tmp134, tmp132,
	adds	r4, r3, r4	@ tmp136, tmp132, tmp134
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	movs	r3, #72	@ tmp138,
@ newenginehack.c:3: void ComputeBattleUnitHitRate(struct BattleUnit* bu) {
	movs	r5, r0	@ bu, tmp160
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	ldrh	r0, [r0, r3]	@ tmp139,
	ldr	r3, .L3	@ tmp140,
	bl	.L5		@
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	movs	r2, #25	@ tmp142,
	ldrsb	r2, [r5, r2]	@ tmp142,
	lsrs	r3, r2, #31	@ tmp143, tmp142,
	adds	r3, r3, r2	@ tmp144, tmp143, tmp142
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	lsls	r4, r4, #16	@ tmp137, tmp136,
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	asrs	r3, r3, #1	@ tmp147, tmp144,
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	lsrs	r4, r4, #16	@ _3, tmp137,
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	adds	r4, r4, r3	@ tmp149, _3, tmp147
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	movs	r3, #83	@ tmp150,
	ldrsb	r2, [r5, r3]	@ tmp152,
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	adds	r4, r2, r4	@ tmp154, tmp152, tmp149
	adds	r4, r4, r0	@ tmp157, tmp154, tmp161
@ newenginehack.c:5:     bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
	adds	r3, r3, #13	@ tmp158,
	strh	r4, [r5, r3]	@ tmp157, bu_18(D)->battleHitRate
@ newenginehack.c:6: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L4:
	.align	2
.L3:
	.word	GetItemHit
	.size	ComputeBattleUnitHitRate, .-ComputeBattleUnitHitRate
	.global	gEkrBg2QuakeVec
	.bss
	.align	2
	.type	gEkrBg2QuakeVec, %object
	.size	gEkrBg2QuakeVec, 4
gEkrBg2QuakeVec:
	.space	4
	.ident	"GCC: (devkitARM release 61) 13.1.0"
	.text
	.code 16
	.align	1
.L5:
	bx	r3
