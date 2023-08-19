SlidingBlocks:
    enabled: true
    type: world
    debug: false
    data:
        dyn:
        - Block physics! Falling <&8>dirt!
        - Were adding all kinds of falling materials! Stone, dirt, cobblestone...
    blocks:
        #todo: use tags to identify blocks
        #see: https://meta.denizenscript.com/Docs/Events
        dirt:
            to: dirt
            block_burns: .01
            block_fades: .10
            block_falls: 1.00
            block_physics: .10
            block_place: .9
            command: 1.00
            entity_interacts_with_block: .1
            leaves_decay: .1
            liquid_level_changes: .1
            liquid_spreads: .1
        cobblestone:
            to: cobblestone
            block_burns: .01
            block_fades: .10
            block_falls: 1.00
            block_physics: .10
            block_place: .9
            command: 1.00
            entity_interacts_with_block: .1
            leaves_decay: .1
            liquid_level_changes: .1
            liquid_spreads: .1
        stone:
            to: cobblestone
            block_burns: .01
            block_fades: .01
            block_falls: .01
            block_physics: .01
            block_place: .01
            command: 1.00
            entity_interacts_with_block: .01
            leaves_decay: .01
            liquid_level_changes: .01
            liquid_spreads: .01
        sand:
            to: sand
            block_burns: .9
            block_fades: .9
            block_falls: 1.00
            block_physics: .10
            block_place: .1
            command: 1.00
            entity_interacts_with_block: .1
            leaves_decay: .1
            liquid_level_changes: .01
            liquid_spreads: .3
    events:
        after block burns:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: block_burns
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>

        after block fades:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: block_fades
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>

        on block falls:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: block_falls
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>
        #- definemap context:
        #    trigger_event: block_falls
        #    location: <context.location>
        #    material: <context.old_material>
        #- announce "<dark_gray>script[<script.name.color[blue]>] <context.location.simple.color[green]> <context.old_material.name.color[yellow]> <context.new_material.name.color[gold]>"
        #- customevent id:slidingblock context:<[context]>

        after block physics:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: block_physics
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>
        #- definemap context:
        #    trigger_event: block_physics
        #    location: <context.location>
        #    material: <context.new_material>
        #- customevent id:slidingblock context:<[context]>

        on fall command:
        - determine passively FULFILLED
        - foreach <proc[GetAdjacentLocations].context[<player.cursor_on[10]>]>:
            - definemap context:
                trigger_event: command
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>
        # - definemap context:
        #     trigger_event: command
        #     location: <player.cursor_on[10]>
        #     material: <player.cursor_on[10].material>
        # - customevent id:slidingblock context:<[context]>

        after player places block:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: block_place
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>
        # - definemap context:
        #     trigger_event: block_place
        #     location: <context.location>
        #     material: <context.material>
        # - customevent id:slidingblock context:<[context]>

        after entity interacts with block:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: entity_interacts_with_block
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>
        # - definemap context:
        #     trigger_event: entity_interacts_with_block
        #     location: <context.location>
        #     material: <context.location.material>
        # - customevent id:slidingblock context:<[context]>

        after leaves decay:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: leaves_decay
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>
        # - definemap context:
        #     trigger_event: leaves_decay
        #     location: <context.location>
        #     material: <context.material>
        # - customevent id:slidingblock context:<[context]>

        after liquid spreads:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: liquid_spreads
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>

        after liquid level changes:
        - foreach <proc[GetAdjacentLocations].context[<context.location>]>:
            - definemap context:
                trigger_event: liquid_level_changes
                location: <[value]>
                material: <[value].material>
            - customevent id:slidingblock context:<[context]>



        on custom event id:slidingblock:
        - stop if:<script.data_key[blocks.<context.material.name>.<context.trigger_event>].if_null[true]>
        - define chance <script.data_key[blocks.<context.material.name>.<context.trigger_event>]>
        - run slideblock def:<context.location.center>|<script.data_key[blocks.<context.material.name>.to].as[material]> if:<util.random_decimal.is[less].than[<[chance]>]>

GetAdjacentLocations:
    type: procedure
    definitions: location
    script:
    - define locations <list>
    #Origin, -Y, Y, -X, X, -Z, Z
    - foreach <[location]>|<[location].add[0,-1,0]>|<[location].add[0,1,0]>|<[location].add[-1,0,0]>|<[location].add[1,0,0]>|<[location].add[0,0,-1]>|<[location].add[0,0,1]>:
        - define locations:->:<[value]>
    - determine <[locations]>

SlideOptions:
    type: procedure
    definitions: location
    script:
    - define locations <list>
    #Early exit because should fall strait down first
    - determine <list[<[location]>]> if:<[location].below.material.is_solid.not>
    #dose not check above block for slide option.
    - foreach <[location].add[1,0,0]>|<[location].add[-1,0,0]>|<[location].add[0,0,1]>|<[location].add[0,0,-1]>:
        - if <[value].material.is_solid.not> && <[value].below.material.is_solid.not>:
            - define locations:->:<[value]>
    - determine <[locations]>

SlideBlock:
    type: task
    enabled: true
    debug: false
    definitions: location|material
    script:
    - define material <[location].material> if:<[material].if_null[true]>
    - define fall_location <proc[slideoptions].context[<[location]>]>
    - stop if:<[fall_location].is_empty>
    #- announce "script[<script.name.color[blue]>]: <queue.id> size: <queue.size.color[yellow]>" format:debugprefix
    - announce "script[<script.name.color[blue]>]: <context.material.color[gold]> is sliding!" format:debugprefix if:<script.data_key[debug]>
    - modifyblock <[location]> air
    - spawn falling_block[fallingblock_type=<[material]>;fallingblock_hurt_entities=1] <[fall_location].random>