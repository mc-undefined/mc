#https://paste.denizenscript.com/View/80568
no_quick_join_world:
    type: world
    debug: false
    events:
        on server prestart:
        - flag server startup_inprog duration:10s
        on player logs in server_flagged:startup_inprog:
        - determine "KICKED:Slow down, server still loading!"
        on server list ping server_flagged:startup_inprog:
        - determine passively "<&c>Server is loading..."
        - determine passively VERSION_NAME:Loading
        - determine passively PROTOCOL_VERSION:999