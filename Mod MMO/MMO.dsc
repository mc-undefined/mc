Skills_Tracker:
    enabled: false
    type: world
    debug: true
    data:
        dyn:
        - We are currently working on writing our own MMO plugin!
    events:
        after player joins:
        - flag player mmo.skills.axe
        - flag player mmo.skills.sword
        - flag player mmo.skills.bow
        - flag player mmo.skills.arrow
        - flag player mmo.skills.crossbow
        - flag player mmo.skills.trident
        - flag player mmo.skills.snowball
        - flag player mmo.skills.fire_charge
        - flag player mmo.skills.magic_item

        - flag player mmo.skills.pickaxe
        - flag player mmo.skills.shovel
        - flag player mmo.skills.hoe

        - flag player mmo.craft.creation
        - flag player mmo.craft.reparation
        - flag player mmo.craft.destruction
        - flag player mmo.craft.cartographing
        - flag player mmo.craft.enchanting
        # Loom Creation Zones,
        - flag player mmo.craft.warding

        - flag player mmo.skills.cartography
        #harvest, bonemeal
        - flag player mmo.skills.farming
        - flag player mmo.skills.fishing
        - flag player mmo.skills.mining
        - flag player mmo.skills.logging
        - flag player mmo.skills.exploration
        - flag player mmo.skills.healing



        - flag player mmo.skills.fly
        - flag player mmo.skills.climb
        - flag player mmo.skills.swim
        - flag player mmo.skills.run
        - flag player mmo.skills.acrobatics

        - flag player mmo.skills.perception
        - flag player mmo.skills.knowledge

        - flag player mmo.skills.speak

        - flag player mmo.magic.element.fire
        - flag player mmo.magic.element.water
        - flag player mmo.magic.element.lightning
        - flag player mmo.magic.element.earth
        - flag player mmo.magic.element.force

        - flag player mmo.magic.school.conjuration
        - flag player mmo.magic.school.necromancy
        - flag player mmo.magic.school.illusion
        - flag player mmo.magic.school.charm
        - flag player mmo.magic.school.divination
        - flag player mmo.magic.school.evocation
        on player breaks block with:*_axe:
        - stop
        - if <player>:
            - flag player test

