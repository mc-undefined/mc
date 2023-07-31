#Chat channel handling for the server.
Chat_Channel_Broadcast:
    type: world
    debug: true
    enabled: true
    data:
        dyn:
        - When you chat, you make a noise! Try it! <gold><element[whoot!].click_chat[See me Roar!]>
        - Ever want to make a louder noise? Try adding more '!' to your text!
        - Want to be stealthy and still talk? Use full stops.... in your message....
    events:
        after player joins:
        - flag <player> chat.speaking_in:global
        - flag <player> language.speaking_in:common
        after player chats:
        - define locals <player.location.find_players_within[60]>
        - playsound <server.players_flagged[<player.flag[language.speaking_in]>].include[<[locals]>].deduplicate> sound:entity_villager_ambient sound_category:VOICE

Update_Player_Chat:
    type: task
    debug: false
    data:
        dyn:
        - The server will catch you up to date on the last chats in the channels youve joined.
    script:
    # Count speakers
    - definemap speakers_count:
        speakers: <empty>
    - foreach <server.flag[chat.chatted].get[1].to[10]>:
        - define speakers_count.<[value]>:++
        - announce <[value]>_<[speakers_count.<[value]>]>
    - foreach user:
        - define last_heard <player.flag[chat.channel.<[value]>]>
        - define chat_size <server.flag[chat.channel.<[value]>].size>
        - flag player chat.channel.<[value]>:<[chat_size]>
        - narrate "Checking chat channel: <[value]>:<[chat_size]> last_update:<[last_heard]>" format:DebugPrefix if:<script.data_key[debug]>
        - if <[chat_size].is[more].than[<[last_heard]>]>:
            - narrate "Bringing player up to date on channel: <[value]>" format:DebugPrefix if:<script.data_key[debug]>
            - narrate <dark_aqua><server.flag[chat.channel.<[value]>].get[<[last_heard].add[1]>].to[<[chat_size]>].separated_by[<&nl>]>