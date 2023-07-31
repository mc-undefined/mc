Village_Notification:
    type: world
    debug: false
    enabled: true
    events:
        after server start:
        - flag server village.location if:<server.has_flag[village.location].not>
        - flag server new.chunks if:<server.has_flag[new.chunks].not>
        #after villager spawns:
        #- if !<script.data_key[debug]>:
        #    - stop
        #- announce "A new <context.entity.name> was created!" format:DebugPrefix

        after chunk loads ENTITIES entity_type:VILLAGER:
        - foreach <context.entities>:
            - cast GLOWING duration:30s amplifier:10 <[value]> if:(<[value].exists>&&<[value].is_spawned>)

        after VILLAGER added to world:
        - ratelimit server 1t
        - announce "Added a <context.entity.name> into the world!" format:DebugPrefix if:<script.data_key[debug]>
        #- announce "Villager had: <context.entity.has_attribute[Brain.memories]>"
        #- cast GLOWING duration:30s amplifier:10 <context.entity>
