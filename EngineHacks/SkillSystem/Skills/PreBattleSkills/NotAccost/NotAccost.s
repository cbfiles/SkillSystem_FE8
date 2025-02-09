@Anathema: enemies in 2 spaces get -10 avoid
.equ NotAccostID, SkillTester+4
.equ gBattleData, 0x203A4D4
.equ gBattleTarget, 0x203A56C
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the "defender"
@r1 is the "attacker"
mov r4, r0
mov r5, r1
mov r0, #0x0
mov r6, r0

@make sure in battle
ldr  r3, =gBattleData
ldrb r3, [r3]
mov  r0, #0x3
tst  r0, r3
beq  Done

ldr r0,=gBattleTarget
cmp r0, r4
bne Done @target stats not calculated yet

@check if target can counter
ldr r0, =gBattleTarget
add r0, #0x52
ldrh r3, [r0]
cmp r3, #0            @if can't counter, skill doesn't apply
beq Done

@skillcheck for defender
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, NotAccostID
.short 0xf800
cmp r0, #0
beq AttackerCheck
b MultiplyDamageLoop

@skillcheck for attacker
AttackerCheck:
mov r0, #0x1
mov r6, r0          @r6 is flag that turns on if in attacker check
ldr r0, SkillTester
mov lr, r0
mov r0, r5 @attacker data
ldr r1, NotAccostID
.short 0xf800
cmp r0, #0
beq Done

MultiplyDamageLoop:
mov r1, r4
add r1, #0x5C  		@defender def
ldrh r2,[r1]		@load it to register

mov r0, r5
add r0,#0x5A		@attacker atk
ldrh r3,[r0]		@load it to register
cmp r2,r3
bge ContinueLoop 	@no damage -> Go to attacker check

sub r3,r2 		    @subtract def from attack
mov r2, r3          @move subtracted value back
lsr r3,#0x1			@divide by two
add r3, r2          @add back for 1.5 multiplication
strh r3,[r0]		@store
mov r0,#0x0
strh r0, [r1]		@make defenders def 0

ContinueLoop:
mov r1, r5
add r1, #0x5C  		@attacker def
ldrh r2,[r1]		@load it to register

mov r0, r4
add r0,#0x5A		@defender atk
ldrh r3,[r0]		@load it to register
cmp r2,r3
bge EndLoop				@no damage -> End

sub r3,r2 		    @subtract def from attack
mov r2, r3          @move subtracted value back
lsr r3,#0x1			@divide by two
add r3, r2          @add back for 1.5 multiplication
strh r3,[r0]		@store
mov r0,#0x0
strh r0, [r1]		@make defenders def 0


EndLoop:
cmp r6, #0x0
beq AttackerCheck   @if flag unset go to attacker check

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
SkillTester:
@POIN SkillTester
@POIN NotAccostID