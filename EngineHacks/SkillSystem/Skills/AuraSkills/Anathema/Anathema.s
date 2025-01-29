@Anathema: enemies in 2 spaces get -10 avoid
.equ AuraSkillCheck, SkillTester+4
.equ AnathemaID, AuraSkillCheck+4
.equ gBattleData, 0x203A4D4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@make sure in battle
ldr  r3, =gBattleData
ldrb r3, [r3]
mov  r0, #0x3
tst  r0, r3
beq  Done

@check range
ldr r0,=gBattleData
ldrb r0,[r0,#2] @range
cmp r0,#1
bne  Done

@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, AnathemaID
mov r2, #3 @are enemies
mov r3, #1 @range
.short 0xf800
cmp r0, #0
beq Done

@does enemy have skill, if enemy has skill then leave
@check for skill
ldr r0, SkillTester
mov lr, r0
mov r0, r5
ldr r1, AnathemaID
.short 0xf800
cmp r0, #0
bne Done



@then apply avoid -20, atk -2, def -2
mov r0, r4
add     r0,#0x62    @Move to the attacker's avoid.
ldrh    r3,[r0]     @Load the attacker's avoid into r3.
sub     r3,#0x14    @subtract 20 from the attacker's avoid
strh    r3,[r0]     @Store attacker avoid

sub r0, #0x8
ldrh    r3,[r0]     @Load the attacker's atk into r3.
sub     r3,#0x2    @subtract 2 from the attacker's atk
strh    r3,[r0]     @Store attacker atk

add r0, #0x2
ldrh    r3,[r0]     @Load the attacker's df into r3.
sub     r3,#0x2    @subtract 2 from the attacker's def
strh    r3,[r0]     @Store attacker def

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
SkillTester:
@POIN SkillTester
@POIN AuraSkillCheck
@WORD AnathemaID 