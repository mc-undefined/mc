
Mod_Walking_Particles:
    type: world
    debug: false
    offset: 1,0,1
    frequency: 1s
    quantity: 10
    data:
        dyn:
        - Walking has a chance to show people a little bit of your internal particle system!
    events:
        after player joins:
        - if <player.has_flag[walk_effect].not>:
            - flag player walk_effect:null
        on player steps on block:
        - ratelimit <player> <script.parsed_key[frequency]>
        - if <player.has_flag[walk_effect]> && <player.flag[walk_effect].is[=].to[null].not>:
            - playeffect effect:<player.flag[walk_effect]> at:<player.location> quantity:<script.parsed_key[quantity]> offset:<script.parsed_key[offset]> save:entry

Walk_Effect:
    type: command
    debug: false
    name: walkeffect
    description: Sets an effect when the player walks.
    aliases:
    - weffect
    usage: /walkeffect [effect]
    tab complete:
    - determine <server.particle_types>
    data:
        dyn:
        - ./walkeffect particle_name to get some walking particles!
        - Only a few walk particles are listed! See: https://minecraft.fandom.com/wiki/Particles
        - Now you can ./walkeffect [SomeOtherParticle]
    script:
    - define arg <context.args.first.if_null[nothing]>
    - define ERROR_RESPONSE "<red>Choose another particle."
    - choose <[arg]>:
        - case LEGACY_FALLING_DUST:
            - narrate <[ERROR_RESPONSE]>
            - stop
        - case nothing:
            - flag <player> walk_effect:!
            - narrate "<&color[blue]>Your current walk effect<white>: <red><[arg]>"
            - stop
    - if <script.data_key[debug]>:
        - narrate "<gray>Argument given to walkeffect: <[arg]>"
    - narrate "<gray>Trying to set your walk effect to<reset>: <red><[arg]>"
    - narrate <gray><script.parsed_key[data.dyn].get[2]>
    - flag <player> walk_effect:<[arg]>