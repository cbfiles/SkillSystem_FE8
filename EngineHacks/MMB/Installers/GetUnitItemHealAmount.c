int GetUnitItemHealAmount(struct Unit* unit, int item) {
    int result = 0;

    switch (GetItemIndex(item)) {

    case ITEM_STAFF_HEAL:
    case ITEM_STAFF_PHYSIC:
    case ITEM_STAFF_FORTIFY:
    case ITEM_VULNERARY:
    case ITEM_VULNERARY_2:
        result = 10;
        break;

    case ITEM_STAFF_MEND:
        result = 20;
        break;

    case ITEM_STAFF_RECOVER:
    case ITEM_ELIXIR:
        result = 80;
        break;

    } // switch (GetItemIndex(item))

    if (GetItemAttributes(item) & IA_STAFF) {
        result += GetUnitPower(unit);

        if (result > 80)
            result = 80;
    }

    return result;
}
