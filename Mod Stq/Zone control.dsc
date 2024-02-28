
Avre_tresspass:
    type: world
    debug: false
    data:
        dyn:
        - StqticWiki's dominion, Don't trepass.
        - Protection and taxes, to whos benefit remains unsaid.

    events:
        after player walks in:Avre:
        - ratelimit <player> 10s
        - choose <player.name>:
            - case StqticWiki:
                - ratelimit <player> 1h
                - narrate "Welcome home."
            - default:
                - define location <player.location.chunk.cuboid.shrink_one_side[0,400,0].expand_one_side[0,50,0].get_spawnable_blocks.random>
                - teleport <player> <[location]>
                - narrate "You've trespassed against Avre, as result you've been transported. To leave, ./cast gate"