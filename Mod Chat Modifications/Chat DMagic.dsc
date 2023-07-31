ChatMagic_Prefix:
    # Assign to context prefix, id, suffix, text
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - You can click the id section of a chat line to get extra data!
        - Hovering over name of a player ~should~ give you an action list...
    events:
        on custom event id:Hears_Chat:
        - definemap map:
            prefix_hover: "Click for Actions"
            prefix_click: "/listActions <context.speaker.name>"
            prefix_raw: <server.scoreboard.team[<context.team>].prefix||<context.prefix>>
        - define prefix <[map.prefix_raw].on_hover[<[map.prefix_hover]>].on_click[<[map.prefix_click]>]>
        - determine Output:<[map].deep_with[prefix].as[<[prefix]>]>

ChatMagic_Id:
    # Assign to context prefix, id, suffix, text
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - Clicking the name of a player ~should~ give you an action list...
        - Hovering over the name of a player ~should~ give you an action list...
    events:
        on custom event id:Hears_Chat:
        - definemap map:
            id_hover: "Click to teleport -> <context.speaker.name>"
            id_click: "/tp <player.name> <context.speaker.location.format[bx by bz]>"
            id_raw: <context.speaker.name>
        - define id <[map.id_raw].on_hover[<[map.id_hover]>].on_click[<[map.id_click]>]>
        - determine Output:<[map].deep_with[id].as[<[id]>]>

ChatMagic_Suffix:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - Clicking the suffix in chat ~should~ Change your chat channel!
        - Hovering over the suffix in chat ~should~ Give you the spoken language in what channel!
    events:
        on custom event id:Hears_Chat:
        - definemap map:
            suffix_hover: "Language: <context.speaker.flag[language.speaking].color[yellow]><&nl> <element[Click to Reply].color[blue]>"
            suffix_raw: <server.scoreboard.team[<context.team>].suffix||<context.suffix>>
            suffix_click: "/chat join <context.channel>"
        - define suffix <[map.suffix_raw].on_hover[<[map.suffix_hover]>].on_click[<[map.suffix_click]>]>
        - determine Output:<[map].deep_with[suffix].as[<[suffix]>]>

ChatMagic_Message_Interact:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - Clicking the text in chat ~should~ Change your chat channel!
        - Hovering over the text in chat ~should~ Give you the spoken language!
    events:
        on custom event id:Hears_Chat:
        - definemap map:
            message_hover: "Speaking: <context.language.color[gold]> <&nl>Channel: <context.channel.color[red]>"
            message_raw: <context.message_raw>
            message_click: "@<context.speaker.name> "
        - define message <[map.message_raw].on_hover[<[map.message_hover]>].on_click[<[map.message_click]>]>
        - determine Output:<[map].deep_with[message_raw].as[<[message]>]>

ChatMagic_Message_Gradient:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - Clicking the text in chat ~should~ Change your chat channel!
        - Hovering over the text in chat ~should~ Give you the spoken language!
    events:
        on custom event id:Hears_Chat priority:1:
        - definemap map:
            message_raw: <context.message_raw>
            message_grad_start: <context.speaker.flag[language.speaking_color]||<server.flag[speaking_color_start]>>
            message_grad_end: <context.speaker.flag[language.speaking_color_end]||<server.flag[speaking_color_end]>>
        - define message <[map.message_raw].color_gradient[from=<[map.message_grad_start]>;to=<[map.message_grad_end]>]>
        - determine Output:<[map].deep_with[message_raw].as[<[message]>]>

ChatMagic_Raw_to_Formatted:
    type: world
    debug: false
    enabled: true
    events:
        on custom event id:Hears_Chat priority:10:
        - definemap map:
            message: <context.message_raw>
        - determine Output:<[map]>


ChatMagic_Language_Obfustication:
    type: world
    debug: false
    enabled: true
    data:
        language_unknown: <magic>
        dyn:
        - You can speak other languages and be obfusticated!
        - ./chat language [language] to change your language!
    events:
        after player joins:
        - flag <player> language.speaking:common
        - flag <player> language.known:|:common if:<player.has_flag[language.known].not>
        on custom event id:Hears_Chat:
        - definemap map:
            obfuscate: <context.obfuscate>
        - stop if:<player.flag[language.known].contains[<context.language>]>
        - definemap map:
            obfuscate: true
        - determine Output:<[map]>