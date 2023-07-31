__MagicSpells_Interface__:
    type: world
    debug: false
    data:
        dyn:
        - Want cooler magic spells feedback! Denizen can interface with it now!
    events:
        on server prestart:
        - advancement id:Magic title:Magic icon:<item[fire_charge]> "description:<magic>Cast Magic"

        after cast command:
        - define targets <player.location.find_players_within[30]>
        - advancement grant:<[targets]> id:Magic
        - wait 1s
        - advancement revoke:<[targets]> id:Magic
        after magicspells entity completes spell:
        - title fade_in:1s fade_out:1s targets:<context.caster.location.find_players_within[30]> "subtitle:<context.caster.name.color[blue]> casts <context.spell_name.color[green]>"
