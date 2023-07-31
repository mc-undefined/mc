LogChop:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - Have you used an axe lately for chopping wood? Massive industrialization!
        - Using an axe on leaves performs an insta-break
    events:
        on player breaks block with:*_axe:
        - ratelimit <player> 1s
        - if <context.cancelled> || !<context.material.vanilla_tags.contains[logs]>:
            - stop
        - define tool_uses <player.item_in_hand.durability>
        - define uses_left <player.item_in_hand.max_durability.sub[<player.item_in_hand.durability>]>
        - define logs <context.location.flood_fill[<[uses_left]>]>
        - define tool_uses <[tool_uses].add[<[logs].size>]>
        - modifyblock <[logs]> air naturally:<player.item_in_hand> source:<player>
        - inventory adjust slot:hand durability:<[tool_uses]>

        on player damages block with:*_axe:
        - ratelimit <player> 2t
        - if <context.location.material.vanilla_tags.contains[leaves]>:
            - determine INSTABREAK
