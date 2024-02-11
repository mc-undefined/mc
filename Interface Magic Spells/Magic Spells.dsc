__MagicSpells_Interface__:
    type: world
    debug: false
    data:
        dyn:
        - Want cooler magic spells feedback! Denizen can interface with it now!
    events:
        after cast command:
        - define text "<player.name.color[blue]> Casts: <context.args.get[1].color_gradient[from=gray;to=red]>"
        - toast <[text]> icon:end_crystal frame:goal targets:<player.location.find_players_within[30]>