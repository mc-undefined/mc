#https://meta.denizenscript.com/Docs/Search/enchant
Glidarian_Thrust_Enchantment:
    type: enchantment
    id: Glidarian_Thrust
    slots:
    - chest
    rarity: RARE
    category: ARMOR
    full_name: Glidaurian_Thrust <context.level>
    min_level: 1
    max_level: 1
    min_cost: <context.level.mul[1]>
    max_cost: <context.level.mul[1]>
    treasure_only: false
    is_curse: true
    is_tradable: false
    is_discoverable: true
    is_compatible: <context.enchantment_key.advanced_matches[minecraft:lure|minecraft:luck*]>
    can_enchant: <context.item.advanced_matches[elytra]>
    damage_bonus: 0.0
    damage_protection: <tern[<context.cause.is[==].to[freeze]>].pass[1].fail[<tern[<context.cause.is[==].to[fall]>].pass[2].fail[0]>]>
    # Triggered after an enchanted armor is used to defend against an attack.
    # Also fires if an entity is holding a weapon with this enchantment while being hit.
    # Has <context.attacker> (EntityTag), <context.victim> (EntityTag), and <context.level>.
    # | Some enchantment scripts should have this key.
    after hurt:
    - narrate "You got hurt by <context.attacker.name> and protected by a level <context.level> enchantment!"