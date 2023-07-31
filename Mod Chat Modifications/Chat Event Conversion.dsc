Chat_Event_Conversion:
    type: world
    debug: false
    enabled: true
    events:
        on player hears sound:
        - choose <context.category>:
            - case VOICE:
                - narrate "<player.name> heard: <context.sound_name>" format:DebugPrefix if:<script.data_key[debug]>
            - default:
                - stop
        - define speaker <server.flag[chat.chatted].last>
        - define message <[speaker].chat_history[1]>
        - define volume <proc[get_volume_from_chat].context[<[message]>]>
        - definemap context:
            sound_key: <context.sound_key>
            sound_name: <context.sound_name>
            category: <context.category>
            is_custom: <context.is_custom>
            source_entity: <context.source_entity||<[speaker]>>
            sound: entity_villager_ambient
            sound_category: voice
            volume: <[volume]>
            distance: <player.location.distance[<[speaker].location>]>
            message: <empty>
            message_raw: <[message]>
            speaker: <[speaker]>
            hearer: <player>
            language: <[speaker].flag[language.speaking]>
            channel: <[speaker].flag[chat.speaking_in]>
            team: <[speaker].scoreboard_team_name>
            prefix: <[speaker].chat_prefix||>
            suffix: <[speaker].chat_suffix||>
            obfuscate: false
            #hearers: <server.online_players_flagged[<[speaker].flag[chat.speaking_in]>]>
        - customevent id:Hears_Chat context:<[context]> save:chat
        - if <entry[chat].was_cancelled>:
            - stop
        - define chat <entry[chat].determination_list.merge_maps>
        - narrate <[context].deep_keys.formatted> from:<[speaker]> format:debugprefix if:<script.data_key[debug]>
        - narrate <[chat].deep_keys.formatted> from:<[speaker]> format:debugprefix if:<script.data_key[debug]>
        - narrate "<[chat.prefix]> <[chat.id]> <[chat.suffix]>: <[chat.obfuscate].if_true[<magic>].if_false[<empty>]||><[chat.message]>" from:<[speaker]>