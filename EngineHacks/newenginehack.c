#include "gbafe.h"

void ComputeBattleUnitHitRate(struct BattleUnit* bu) {
	//test
    bu->battleHitRate = (bu->unit.skl * 3) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
}