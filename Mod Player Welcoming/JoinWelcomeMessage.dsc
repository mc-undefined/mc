WelcomeJoinMessage:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - We give you notifications about server stuff on join.
        - Have you tried our Dynmap link yet? Its given every server join.
    events:
        after server start:
        - flag server "server_info:|:" if:<server.has_flag[server_info].not>
        after player joins:
        - title "title:<blue>Welcome Back <red><player.name>" fade_in:2s fade_out:2s
        - narrate <red><&lb><gold><element[SERVER_MAP].click_url[http://localhost:8123/]><red><&rb> format:center

