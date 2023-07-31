Command_Dawn:
    type: command
    debug: false
    name: dawn
    description: Sets time of day to 0.
    tab completions:
        default: StopTyping
    usage: /dawn
    data:
        dyn:
        - ./dawn sets the time of day to 0t.
    script:
    - narrate "Setting time of day to 0t"
    - time 0t

Command_Day:
    type: command
    debug: false
    name: day
    description: Sets time of day to 1000t.
    tab completions:
        default: StopTyping
    usage: /day
    data:
        dyn:
        - ./Day sets the time of day to 1000t.
    script:
    - narrate "Setting time of day to 1000t"
    - time 1000t


Command_Noon:
    type: command
    debug: false
    name: noon
    description: Sets time of day to 12000.
    tab completions:
        default: StopTyping
    usage: /noon
    data:
        dyn:
        - At ./noon is highest the sun will be in the day.
    script:
    - narrate "Setting time of day to 6000t"
    - time 6000t

Command_Evening:
    type: command
    debug: false
    name: evening
    description: Sets time of day to 11834.
    tab completions:
        default: StopTyping
    usage: /evening
    data:
        dyn:
        - At ./evening is when the moom appears on the horizon
    script:
    - narrate "Setting time of day to 11834t"
    - time 11834t

Command_Dusk:
    type: command
    debug: false
    name: dusk
    description: Sets time of day to 12000.
    tab completions:
        default: StopTyping
    usage: /dusk
    data:
        dyn:
        - ./dusk is roughly == to ./time set sunset
    script:
    - narrate "Setting time of day to 12000t"
    - time 12000t

Command_Night:
    type: command
    debug: false
    name: night
    description: Sets time of day to 13000.
    tab completions:
        default: StopTyping
    usage: /night
    data:
        dyn:
        - ./night is the beginning of Minecraft night.
    script:
    - narrate "Setting time of day to 13000t"
    - time 13000t

Command_MidNight:
    type: command
    debug: false
    name: midnight
    description: Sets time of day to 18000.
    tab completions:
        default: StopTyping
    usage: /midnight
    data:
        dyn:
        - The moon is its fullest at ./midnight
    script:
    - narrate "Setting time of day to 18000t"
    - time 18000t