Skill_Slots:
    # activated skills should be the first on the list
    # class skills should be 1st and 2nd
    type: world
    debug: false
    data:
        dyn:
        - Players have skill slots to add skills! 2 class actions, 1 reaction, 1 class passive, 1 move.
    events:
        on player joins:
        # Scripts items should be in map format:
        # definemap script:
        #   name: [script name]
        #   definitions:
        #       d1: data1
        #       d2: data2
        - flag player skills.class_scripts:<list> if:<player.has_flag[skills.class_scripts].not>
        - flag player skills.active_scripts:<list> if:<player.has_flag[skills.active_scripts].not>
        - flag player skills.reaction_scripts:<list> if:<player.has_flag[skills.reaction_scripts].not>
        - flag player skills.move_scripts:<list> if:<player.has_flag[skills.move_scripts].not>
        on entity damaged:
        - define entity <context.entity>
        - inject <context.entity.flag[skills.reaction_scripts].first[1]> if:<context.entity.has_flag[skills.reaction_scripts]>
        # - determine <[determination]> #how to neatly determine this? Via another Script?

        on custom event id:attack_roll:
        - define roll <proc[roll_dice].context[20]>

roll_Dice:
    type: procedure
    debug: false
    definitions: dice_number[default 20]
    script:
    - determine <util.random.int[1].to[<[dice_number]||20>]>

# I might be able to turn this into a general damage reduction script
Skill_passive_fire_damage:
    type: task
    debug: false
    script:
    - announce "<context.damage_type_map> "
    - choose <context.cause>:
        - case fire:
            - narrate "Fire Damage Handled..."
        - default:
            - stop
    - determine None

Entity_Data:
    type: world
    debug: false
    data:
        class_list:
        - ender
        - creeper
        - villager
        base_scores:
        - constitution
        - strength
        - dexterity
        - intelligence
        - wisdom
        - charmisma
        skills:
        - appraise
        - arcana
        - athletics
        - craft
        - deception
        - diplomacy
        - intimidation
        - linguistics
        - medicine
        - nature
        - occultism
        - performance
        - perception
        - profession
        - religion
        - stealth
        - survival
        - thievery
        saves:
        - fortitude
        - reflex
        - will
        slots_based_stats:
        - hit_points
        - spells
        - skills
    events:
        on entity spawns:
        - stop if:<context.entity.entity_type.is[equals].to[player].not>
        - announce "player spawned!"
        - run <script> path:init_stats
        on entity damaged:
        - stop if:<context.entity.has_flag[stat.ac].not>
        - customevent id:AC
        - determine <entry[event]>
        on custom event id:Ac:
        - announce "entity ac response"
        - determine <context.entity.flag[]>
    init_stats:
    - foreach <script.list_keys[data]>:
        - define stat_type <[value]>
        - announce "looking at stat type: <[stat_type]>"
        - foreach <script.data_key[data.<[stat_type]>]>:
            - define key <[stat_type]>.<[value]>
            - define score <list>
            - choose <[stat_type]>:
                - case base_score:
                    - repeat 3:
                        - define score:->:<proc[roll_dice].context[6]>
                - case skills:
                    - define score:->:1
                - case saves:
                    - define score:->:0
                - default:
                    - foreach next
            - define text "[<script.name.color[blue]>] [<context.entity.entity_type||none>] <[value]> is <[score].sum>"
            - announce <[text]> to_console
            - narrate <[text]>
            #- narrate <[text]> if:<script.data_key[debug]>
            - flag <context.entity> <[key]>:<[score]> if:<context.entity.has_flag[<[key]>].not>


Class_Ender:
    type: world
    debug: false
    data:
        dyn:
        - The Ender class auto teleports on ranged attacks!
        - The Ender class knows where they are being targeted from!
        - The Ender class takes damage in water, rain, and water splash potions!
    events:
        on player animates:
        - stop if:<player.item_in_hand.is[equals].to[air].not>
        - stop
    Reaction_teleport:
    - teleport <[entity]> <[entity].location.to_ellipsoid[5,5,5].spawnable_blocks.random>

Skill_Perception:
    type: world
    debug: false
    data:
        dyn:
        - Perception works by holding still for a few seconds.
        - Perception expands out the longer you stand still and look at an area.
    events:
        on player joins:
        - flag <player> skills.perception.level:0
        on player moves:
        - ratelimit <player> 2s
        - flag <player> skills.perception.level:++
