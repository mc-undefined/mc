ChatCancelGlobal:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - !Global Chat: <element[/chat].color[blue].click_chat[/chat]> [channel]
    events:
        on player chats priority:101:
        - determine passively cancelled