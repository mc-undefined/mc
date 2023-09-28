on_chem_join_hello_world:
    type: world
    debug: true
    data:
        dyn:
        - chem has a huge brain
        - hello world from the chems test script
    events:
        after player joins:
        - wait 10s
        - if <player.name> != "Chemical_Datas":
            - stop
        - narrate "Hello world!"