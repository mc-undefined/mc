helloCrepyRayz:
    type: world
    debug: false
    data:
        dyn:
        - crepy writes script
    events:
        after player joins:
        - wait 10s
        - if <player.name> != CrepyRayz:
            - stop
        - narrate "hello good moring"