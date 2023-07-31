Portal_Use_Announcer:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - Using a portal? We all know now! Muhahahaha
        delay: 30s
    events:
        after player uses portal:
        - ratelimit <player> <script.data_key[data.delay]>
        - narrate "<player.name.color[blue]> just used a portal!" targets:<server.online_players>