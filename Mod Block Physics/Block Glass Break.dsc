
GlassBreak:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - Glass breaks when you dash into it!
        - Glass is fragile! Stop swinging your tools around it!
        - Ever fall on glass before? Feel free to see the results!
        - I have not implemented shooting glass with sticks and stones. But I think I guess what should happen.
    events:
        #Fails damage by fall check and never runs
        on entity damaged by FALL:
        - define damaged_materials <context.entity.location.below.material>
        - if !<[damaged_materials].contains_all_text[glass]>:
            - stop
        - define blocks <context.entity.location.below.flood_fill[5]>
        - modifyblock <[blocks]> air source:<player>
        - playeffect at:<[blocks]> effect:cloud
        - playsound <[blocks]> sound:block_glass_break
        on player damages block:
        - ratelimit <player> 2t
        - if !<context.material.name.contains_all_text[glass]>:
            - stop
        - define blocks <context.location.flood_fill[5]>
        - modifyblock <[blocks]> <player.location.above.material> source:<player>
        - playeffect at:<[blocks]> effect:cloud
        - playsound <[blocks]> sound:block_glass_break
        after player stops sprinting:
        - ratelimit <player> 2t
        - foreach <player.location>|<player.location.above>:
            - define block <[value]>
            - if !<[block].material.contains_all_text[glass]>:
                - stop
            - define blocks <[block].flood_fill[5]>
            - modifyblock <[blocks]> air source:<player>
            - playeffect at:<[blocks]> effect:cloud
            - playsound <[blocks]> sound:block_glass_break
