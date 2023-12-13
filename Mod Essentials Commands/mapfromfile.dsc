Command_Map:
    type: command
    enabled: true
    debug: false
    name: map
    description: Gets some map image data.
    usage: /map (file_location)
    tab complete:
    - determine <util.list_files[/images].include[<util.list_files[/images/downloaded/]>]>
    script:
    - if !<util.list_files[/images].contains[<context.args.get[1]>]>:
        - narrate "<gray>Could not find the file locally."
        - stop
    - else:
        - narrate "<gray>Found file locally. "
    - map new:world image:<context.args.get[1]> resize save:img
    - give filled_map[map=<entry[img].created_map>]