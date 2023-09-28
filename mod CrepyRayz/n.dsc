helloCrepyRayz:
    type: world
    debug: true
    data:
        dyn:
        - crepy writes script
    events:
        after player joins:
        - wait 10s
        - if <player.name> != CrepyRayz:
            - stop
        - narrate "hello good moring"