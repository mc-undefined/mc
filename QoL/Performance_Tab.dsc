On_Player_Tab_Performance_Data:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - Server TPS, Player Location, Known Spells, Active Spells, Spell Time Remaining, Target Names
        rows: 10
        colums: 3
    events:
        after server start:
        - flag server server_tps_display_uuid:<util.random_uuid>
        - announce "[<script.name.color[blue]>] Usage of this command requires denizen config setting [allow_restricted_settings:true]"
        after player joins:
        - tablist add uuid:<server.flag[server_tps_display_uuid]> name:<server.recent_tps.parse_tag[<[parse_value].round_down_to_precision[1]>].comma_separated>
        - while <player.if_null[false]>:
            #- narrate "tab item updated"
            - tablist update uuid:<server.flag[server_tps_display_uuid]> display:<server.recent_tps.parse_tag[<[parse_value].round_down_to_precision[1]>].comma_separated>
            - wait 2s
        #on player receives tablist update:
        #- narrate "Tablist updated"
