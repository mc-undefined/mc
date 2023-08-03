#User Chat Event Logging
#Just log that a player chatted.
ChatHistory:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - Chat history is stored diferently now. Just record that a player chatted. Look at what was said later.
    events:
        after server start:
        - flag server chat.chatted:|:<list>    if:<server.has_flag[chat.chatted].not>
        on player chats:
        - flag server chat.chatted:|:<player>