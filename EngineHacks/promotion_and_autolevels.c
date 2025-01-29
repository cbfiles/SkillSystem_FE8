#include "gbafe.h"


int XorshiftStatIncrease(int growth, int xorfactor) {
    int result = 0;
    //xorshift
    uint8_t x = xorfactor;
    x ^= x << 3;
    x ^= x >> 5;
    x ^= x << 2;
    x = x >> 2; //growths limited to 0-64
    growth += 18;
    growth += x;
    while (growth > 100) {
        result++;
        growth -= 100;
    }

    return result;
}

int GetAutoleveledStatIncreaseNew(int growth, int levelCount, int factor) {
    return XorshiftStatIncrease((growth * levelCount), factor);
}

int GetUnitRandomResult(struct Unit* unit) { 
    int result = (unit->xPos) << 4;
    result += (unit->yPos);
    result ^= (GetUnitEquippedWeapon(unit));
    return result;
}

void UnitAutolevelLuck(struct Unit* unit, u8 classId) {
 int unitResult = GetUnitRandomResult(unit);
 unit->lck += GetAutoleveledStatIncreaseNew(unit->pClassData->growthLck, 5, unitResult);

}


void UnitAutolevelCore(struct Unit* unit, u8 classId, int levelCount) {
 int unitResult = GetUnitRandomResult(unit);
 if (levelCount) {

        //do the shit based on unit struct
        unit->maxHP += GetAutoleveledStatIncreaseNew(unit->pClassData->growthHP,  levelCount, (unitResult+classId));
        unit->pow   += GetAutoleveledStatIncreaseNew(unit->pClassData->growthPow, levelCount, (unitResult + (1 + classId)));
        unit->skl   += GetAutoleveledStatIncreaseNew(unit->pClassData->growthSkl, levelCount, (unitResult + (2 + classId)));
        unit->spd   += GetAutoleveledStatIncreaseNew(unit->pClassData->growthSpd, levelCount, (unitResult + (3 + classId)));
        unit->lck   += GetAutoleveledStatIncreaseNew(unit->pClassData->growthLck, levelCount, (unitResult + (6 + classId)));
        unit->def   += GetAutoleveledStatIncreaseNew(unit->pClassData->growthDef, levelCount, (unitResult + (4 + classId)));
        unit->res   += GetAutoleveledStatIncreaseNew(unit->pClassData->growthRes, levelCount, (unitResult + (5 + classId)));
    }
}

void UnitApplyBonusLevels(struct Unit* unit, int levelCount) {
    if (levelCount && !UNIT_IS_GORGON_EGG(unit)) {
        if (levelCount > 0)
            UnitAutolevelCore(unit, unit->aiFlags, levelCount);
        else if (levelCount < 0)
            UnitAutolevelPenalty(unit, unit->aiFlags, -levelCount);

        UnitCheckStatCaps(unit);

        unit->curHP = GetUnitMaxHp(unit);
    }
}


void UnitAutolevel(struct Unit* unit) {
    if (UNIT_CATTRIBUTES(unit) & CA_PROMOTED)
        UnitAutolevelCore(unit, unit->pClassData->promotion, 19);

    UnitAutolevelCore(unit, unit->pClassData->number, unit->level - 1);

    UnitAutolevelLuck(unit, unit->pClassData->number);
}

void ApplyUnitDefaultPromotion(struct Unit* unit) {
    const struct ClassData* promotedClass = GetClassData(unit->pClassData->promotion);
    const struct ClassData* baseClass = GetClassData(unit->pClassData->number);
    int baseClassId = unit->pClassData->number;
    int promClassId = promotedClass->number;

    int i;
    int add;

    // Apply stat ups
    
    add = promotedClass->baseHP - baseClass->baseHP;
    if (add < 0) add = 0;
    unit->maxHP += add;

    if (unit->maxHP > promotedClass->maxHP)
        unit->maxHP = promotedClass->maxHP;

    add = promotedClass->basePow - baseClass->basePow;
    if (add < 0) add = 0;
    unit->pow += add;

    if (unit->pow > promotedClass->maxPow)
        unit->pow = promotedClass->maxPow;

    add = promotedClass->baseSkl - baseClass->baseSkl;
    if (add < 0) add = 0;
    unit->skl += add;

    if (unit->skl > promotedClass->maxSkl)
        unit->skl = promotedClass->maxSkl;

    add = promotedClass->baseSpd - baseClass->baseSpd;
    if (add < 0) add = 0;
    unit->spd += add;

    if (unit->spd > promotedClass->maxSpd)
        unit->spd = promotedClass->maxSpd;

    add = promotedClass->baseDef - baseClass->baseDef;
    if (add < 0) add = 0;
    unit->def += add;

    if (unit->def > promotedClass->maxDef)
        unit->def = promotedClass->maxDef;

    add = promotedClass->baseRes - baseClass->baseRes;
    if (add < 0) add = 0;
    unit->res += add;

    if (unit->res > promotedClass->maxRes)
        unit->res = promotedClass->maxRes;

    // Remove base class' base wexp from unit wexp
    for (i = 0; i < 8; ++i)
        unit->ranks[i] -= unit->pClassData->baseRanks[i];

    // Update unit class
    unit->pClassData = promotedClass;

    // Add promoted class' base wexp to unit wexp
    for (i = 0; i < 8; ++i) {
        int wexp = unit->ranks[i];

        wexp += unit->pClassData->baseRanks[i];

        if (wexp > WPN_EXP_S)
            wexp = WPN_EXP_S;

        unit->ranks[i] = wexp;
    }

    // If Pupil -> Shaman promotion, set Anima rank to 0
    if (baseClassId == 0x3E && promClassId == 0x2D)
        unit->ranks[5] = 0;

    unit->level = 1;
    unit->exp   = 0;

    add = promotedClass->baseHP - baseClass->baseHP;
    if (add < 0) add = 0;
    unit->curHP += add;

    if (unit->curHP > GetUnitMaxHp(unit))
        unit->curHP = GetUnitMaxHp(unit);
}

void ApplyUnitPromotion(struct Unit* unit, u8 classId) {
    const struct ClassData* promotedClass = GetClassData(classId);
    const struct ClassData* baseClass = GetClassData(unit->pClassData->number);
    int baseClassId = unit->pClassData->number;
    int promClassId = promotedClass->number;

    int i;
    int add;

    // Apply stat ups
    
    add = promotedClass->baseHP - baseClass->baseHP;
    if (add < 0) add = 0;
    unit->maxHP += add;

    if (unit->maxHP > promotedClass->maxHP)
        unit->maxHP = promotedClass->maxHP;

    add = promotedClass->basePow - baseClass->basePow;
    if (add < 0) add = 0;
    unit->pow += add;

    if (unit->pow > promotedClass->maxPow)
        unit->pow = promotedClass->maxPow;

    add = promotedClass->baseSkl - baseClass->baseSkl;
    if (add < 0) add = 0;
    unit->skl += add;

    if (unit->skl > promotedClass->maxSkl)
        unit->skl = promotedClass->maxSkl;

    add = promotedClass->baseSpd - baseClass->baseSpd;
    if (add < 0) add = 0;
    unit->spd += add;

    if (unit->spd > promotedClass->maxSpd)
        unit->spd = promotedClass->maxSpd;

    add = promotedClass->baseDef - baseClass->baseDef;
    if (add < 0) add = 0;
    unit->def += add;

    if (unit->def > promotedClass->maxDef)
        unit->def = promotedClass->maxDef;

    add = promotedClass->baseRes - baseClass->baseRes;
    if (add < 0) add = 0;
    unit->res += add;

    if (unit->res > promotedClass->maxRes)
        unit->res = promotedClass->maxRes;

    // Remove base class' base wexp from unit wexp
    for (i = 0; i < 8; ++i)
        unit->ranks[i] -= unit->pClassData->baseRanks[i];

    // Update unit class
    unit->pClassData = promotedClass;

    // Add promoted class' base wexp to unit wexp
    for (i = 0; i < 8; ++i) {
        int wexp = unit->ranks[i];

        wexp += unit->pClassData->baseRanks[i];

        if (wexp > WPN_EXP_S)
            wexp = WPN_EXP_S;

        unit->ranks[i] = wexp;
    }

    // If Pupil -> Shaman promotion, set Anima rank to 0
    if (baseClassId == 0x3E && promClassId == 0x2D)
        unit->ranks[5] = 0;

    unit->level = 1;
    unit->exp   = 0;

    add = promotedClass->baseHP - baseClass->baseHP;
    if (add < 0) add = 0;
    unit->curHP += add;

    if (unit->curHP > GetUnitMaxHp(unit))
        unit->curHP = GetUnitMaxHp(unit);
}

//assemble into lyn event whenever for vanillahack