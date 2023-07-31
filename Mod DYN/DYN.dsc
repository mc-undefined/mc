DYN_Triggers:
    type: world
    enabled: true
    debug: false
    data:
        delay: 30s
        dyn:
        - When playing sometimes a player will receive a DYN informational.
    events:
        after player joins:
        - if <player.has_flag[tips].not>:
            - flag <player> tips:true
        - run Narrate_Random_Script_Informational
        - narrate "<gray>Your DYN tips: <player.flag[tips]>" format:dyn_format
        - narrate "<gray>Want to disable DYN tips? ./tips [enable|disable]" format:dyn_format
        after player teleports:
        - run Narrate_Random_Script_Informational
        after player changes xp:
        - ratelimit server <script.data_key[data.delay]>
        - run Narrate_Random_Script_Informational

Tips_Enable_Disable:
    type: command
    debug: false
    name: tips
    description: Enable or disable DYN tips.
    tab completions:
        1: true|false
        default: StopTyping
    usage: /tips [true|false]
    data:
        dyn:
        - ./tips [true|false] to stop listening to these crazy helpful fanciful ideas.
    script:
    - choose <context.args.get[1]>:
        - case true:
            - flag <player> tips:true
            - narrate "Turning on your DYN tips."
        - case false:
            - flag <player> tips:false
            - narrate "Turning off your DYN tips."
        - default:
            - narrate "Your current tips state: <player.flag[tips]>"

Narrate_Random_Script_Informational:
    type: task
    enabled: false
    debug: false
    script:
    - if <player.flag[tips].not>:
        - stop
    - narrate <proc[ScriptDYN].random.random>  format:DYN_format

ScriptDYN:
    type: procedure
    debug: false
    script:
    - determine <util.scripts.parse_tag[<[parse_value].parsed_key[data.dyn].if_null[null]>].filter[equals[null].not]>

DYN_Format:
    type: format
    format: <&nl><gold><element[].pad_left[24]><&lb><italic><element[Did you know?].rainbow><gold><&rb><&nl><&2><[text]><&nl>
