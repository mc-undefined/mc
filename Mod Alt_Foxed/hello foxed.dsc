hellofoxed:
    type: world
    debug: false
    data:
        dyn:
        - alt_foxed write scripts
        - alt_foxed gets rickroled
    events:
        after player breaks diamond_ore:
        - if <player.name> != "Alt_Foxed":
            - stop
        - nbs play file:nbs/NGGYU_