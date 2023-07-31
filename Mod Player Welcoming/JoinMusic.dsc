JoinMusic:
    type: world
    debug: false
    data:
        dyn:
        - I love hearing music when I join the server! I need more music!
        - One piece you hear is made by a players on the server. Salute <gold>A_Swift_Arrow!
    events:
        after player joins:
        - wait 4s
        - midi file:PhoenixBox.mid if:<player.is_spawned||false>