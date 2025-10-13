/// DecideBulletPattern()
/// Returns a bullet spawner object depending on enemies in the current battle
function DecideBulletPattern() {
    var _enemyKeys = [];
    for (var i = 0; i < array_length(enemyUnits); i++) {
        array_push(_enemyKeys, enemyUnits[i].enemyKey);
    }

    // --- Single enemy patterns ---
    if (array_length(_enemyKeys) == 1) {
        switch (_enemyKeys[0]) {
            case "tree_test": return obj_Bullet_Formation_Tree; // custom pattern for Tree
            case "bug_test":  return obj_Bullet_Formation_Bug;  // custom pattern for Bug
            // Add more single enemies here
            default:          return obj_Bullet_Formation_Rain; // fallback
        }
    }

    // --- Two-enemy combinations ---
    if (array_length(_enemyKeys) == 2) {
        if (array_contains(_enemyKeys, "tree_test") && array_contains(_enemyKeys, "bug_test"))
            return obj_Bullet_Formation_TreeBug; // unique pattern for Tree+Bug combo
        // Add more combos here
        else
            return obj_Bullet_Formation_Rain; // fallback
    }

    // --- Three or more enemies (optional combos) ---
    if (array_length(_enemyKeys) >= 3) {
        // Example: if you want a unique pattern for 3+ specific enemies
        if (array_contains(_enemyKeys, "tree_test") && array_contains(_enemyKeys, "bug_test") && array_contains(_enemyKeys, "slime_test"))
            return obj_Bullet_Formation_TripleCombo;
        else
            return obj_Bullet_Formation_Rain;
    }

    // --- Default fallback ---
    return obj_Bullet_Formation_Rain;
}
