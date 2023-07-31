Command_Sun:
    type: command
    debug: false
    name: sun
    description: Sets world weather to sun.
    usage: /sun (No arguments)
    #aliases:
    #- weather clear
    #permission: server.weather.sun
    permission message: Server command. Need permission.
    tab completions:
        default: StopTyping
    data:
        dyn:
        - ./sun clears the weather.
    script:
    - weather sunny

Command_Storm:
    type: command
    debug: false
    name: storm
    description: Sets world weather to sun.
    usage: /storm (No arguments)
    aliases:
    - rain
    #- weather storm
    #permission: server.weather.storm
    permission message: Server command. Need permission.
    tab completions:
        default: StopTyping
    data:
        dyn:
        - ./storm sets minecraft to stormy.
    script:
    - weather storm

Command_Thunder:
    type: command
    debug: false
    name: thunder
    description: Sets world weather to thunder.
    usage: /thunder (No arguments)
    #aliases:
    #- weather thunder
    #permission: server.weather.thunder
    permission message: Server command. Need permission.
    tab completions:
        default: StopTyping
    data:
        dyn:
        - ./thunder makes the rain and brings the thunder! Mobs durring the day!
    script:
    - weather thunder