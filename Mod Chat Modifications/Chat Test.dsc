Chat_Test:
    type: world
    debug: false
    enabled: false
    data:
        dyn:
        - Still working on the chat system!
    events:
        on custom event id:Hears_Chat:
        - definemap test:
            narrate: nubs
        - determine Output:<[test]>