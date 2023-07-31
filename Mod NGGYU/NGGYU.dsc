Loves_Entry:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - Rag1ngW1f3, I love you!
        - Never Gonna Give You Up
    events:
        after player joins:
        - wait 10s
        - choose <player.name>:
            - case Rag1ngW1f3:
                - announce "My love has come back!"
                - narrate "I love you Dear."
            - case Chemical_Datas:
                - announce "Chemical_Datas is back!"
                - narrate "Welcome back Sir!"
            - default:
                - nbs play file:nbs/NGGYU_
        after player dies:
        - nbs play file:nbs/NGGYU_