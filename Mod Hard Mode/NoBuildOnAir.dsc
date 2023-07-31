No_Build_While_On_Air:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - You cant stand on air while building! This isnt Mnecraft!
        - You can activate no air build by flagging the server build_in_air:true
    events:
        on server start:
        - flag server build_in_air:false if:<server.has_flag[build_in_air].not>
        on block being built:
        - stop if:<list[CREATIVE|ADVENTURE].contains[<player.gamemode>]>
        - if <list[<material[cave_air]>|<material[air]>|<material[void_air]>].contains[<player.standing_on.material||<material[air]>>]> && <server.flag[build_in_air].not>:
            - narrate <script.parsed_key[data.dyn].random> format:DYN_format if:<player.flag[tips]>
            - determine cancelled