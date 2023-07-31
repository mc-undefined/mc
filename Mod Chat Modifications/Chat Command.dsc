ChatCommand:
    type: command
    debug: false
    name: chat
    description: Subscribes or unsubscribes to a chat channel.
    usage: /chat [join|leave] [channel]
    #aliases:
    # - private
    # - pm
    #- channel
    #permission:
    permission message: How do you not have permission? Contact an admin and notify them.
    tab completions:
        1: join|leave|
        2: <player.flag[chat.channel].deep_keys>
        default: StopTyping
    data:
        dyn:
        - The server utilizes specialized channels to communicate on. Think walkie talkie. <gold><element[/chat].on_click[/chat ].type[suggest]> <reset>or, <gold><element[/channel].on_click[/channel ].type[suggest]>
    script:
    - define action <context.args.get[1].if_null[null]>
    - define channel <context.args.get[2].if_null[null]>
    - define speaking_in <player.flag[chat.speaking_in]>
    - define channels <player.flag[chat.channel].deep_keys>
    - choose <[action]>:
        - case join:
            - flag server chat.channel.<[channel]> if:<server.has_flag[chat.channel.<[channel]>].not>
            - flag <player> chat.speaking_in:<[channel]>
            - flag <player> chat.channel.<[channel]>:1
            - narrate "<blue>You've joined channel: <red><[channel]>"
            - run Update_Player_Chat
        - case leave:
            - if <[channels].contains[<[channel]>]>:
                - flag <player> chat.channel.<[channel]>:!
                - flag <player> chat.speaking_in:global
                - narrate "<blue>You've left channel: <red><[channel]>"
                - narrate "<blue>You've joined channel: <red><[speaking_in]>"
            - else:
                - narrate "<blue>You need to join the channel before you can leave it."
        - default:
            - narrate "Did you mean: <list[join|leave].closest_to[<[action]>]>?"
    - narrate "<element[Your speaking in:].color[blue]> <[speaking_in].color[red]>"
    - narrate "<element[Your current channels:].color[blue]> [<[channels].formatted.color[red]>]"

LanguageCommand:
    type: command
    debug: false
    name: language
    description: Changes the language your speaking with. If others hear a language they dont speak, it obfusticates the chat.
    usage: /language [language]
    permission message: How do you not have permission? Contact an admin and notify them.
    tab completions:
        1: <player.flag[language.known]>
        default: StopTyping
    data:
        dyn:
        - <element[/language].color[gold].on_click[/language].type[suggest]> to speak with.
    script:
    - define language <context.args.get[1].if_null[null]>
    - define languages <player.flag[language.known]>
    - define speaking <player.flag[language.speaking]>
    - if <[languages].contains[<[language]>]>:
        - flag <player> language.speaking:<[language]>
    - else:
        - narrate "Did you mean? <[languages].closest_to[<[language]>]>"
    - narrate "<element[Your speaking with:].color[blue]> <[language].color[red]>"
    - narrate "<element[Your known languages:].color[blue]> [<[languages].formatted.color[red]>]"