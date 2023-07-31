Chunk_Generation_Notification:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - The server will notify everyone when new chunks are generating. Check the action bar for updates.
        delay: 10s
    events:
        after server start:
        - flag server number_of_new_chunks_generated:0
        after chunk loads for the first time:
        - flag server number_of_new_chunks_generated:++
        - ratelimit server <script.data_key[data.delay]>
        - define rate <server.flag[number_of_new_chunks_generated]>
        - flag server number_of_new_chunks_generated:!
        - actionbar "<&color[dark_gray]>New Chunks are generating! @about: <gold><[rate]>/<script.data_key[data.delay]>" targets:<server.online_players>
