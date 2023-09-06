Landslide:
    enabled: true
    type: world
    debug: true
    data:
        dyn:
        - Sliding block physics!
        - New Unstable Materials! Sand, gravel, cobblestone, dirt
    blocks_per_interval: 1t
    blocks_per_increment: 300
    #Operation ~runs for (hardstop * interval)
    #The hard stop just ends the sliding loop after # interations
    invervals_hard_stop: 200

    #
    block_tags:
        #material.vanilla_tags.contains_any[script.data_key[block_tags]]
        logs:
            block_falls: 0.35
        leaves:
            block_falls: 0.99
        dirt:
            block_falls: 0.99
        gravel:
            block_falls: 0.99

    blocks:
        #material.name
        #   to: new material
        #   trigger: percentage <= to 1
        #Determines how stable a block is once it tumbles
        sand:
            to: sand
            block_falls: 0.99
            command: 1.00
        sandstone:
            to: sand
            block_falls: 0.1
            command: 1.00
        dirt:
            to: dirt
            block_falls: 0.99
            command: 1.00
        course_dirt:
            to: course_dirt
            block_falls: 0.99
            command: 1.00
        gravel:
            to: gravel
            block_falls: 0.99
            command: 1.00

    events:
        after server start:
        - flag server sliding_blocks:<list>
        - inject <script> path:load_settings

        after reload scripts:
        - inject <script> path:load_settings

        on block falls:
        # block falls gets called at least 2x. On creation of block and on stop of block.
        # Dont check the fallingblock on initial destabilation
        - stop if:<context.new_material.is_solid.not>
        - definemap context:
            trigger: block_falls
            location: <context.location>
            material: <context.new_material>
        - customevent id:slidingblock context:<[context]> save:sliding
        - determine cancelled if:<entry[sliding].was_cancelled.not>

        on slide command:
        - determine passively FULFILLED
        - definemap context:
            trigger: command
            location: <player.cursor_on[10]>
            material: <player.cursor_on[10].material>
        - narrate "Trying to slide <[context.material]>"
        - customevent id:slidingblock context:<[context]> save:sliding
        - modifyblock <player.cursor_on[10]> air if:<entry[sliding].was_cancelled.not>

        on custom event id:slidingblock:
        - determine cancelled if:<script.data_key[blocks.<context.material.name>.<context.trigger>].if_null[null].is[==].to[null]>
        - determine cancelled if:<util.random_decimal.is[more].than[<script.data_key[blocks.<context.material.name>.<context.trigger>]>]>
        - define locations <proc[slideoptions].context[<context.location>]>
        - determine cancelled if:<[locations].is_empty>
        - flag server sliding_blocks:->:<map[location=<[locations].random>;material=<script.data_key[blocks.<context.material.name>.to].as[material]>]>
        - run slide_queue_consumer

    load_settings:
    - foreach <script.data_key[blocks].keys>:
        - define material <[value]>
        - foreach <script.data_key[blocks.<[value]>].keys>:
            - define key blocks.<[material]>.<[value]>
            - flag server <[key]>:<script.data_key[<[key]>]>
            - announce "<script.name.color[blue]> <[material]> slide chance: <[value]>: <server.flag[<[key]>]>" to_console if:<script.data_key[debug]>
    - foreach <script.data_key[data.blocks]>:
        - adjust <material[<[value]>]> vanilla_tags:<material[<[value]>].vanilla_tags.include[<script.data_key[tag_id]>].deduplicate>
    - flag server blocks_per_interval:<script.data_key[blocks_per_interval]>
    - flag server blocks_per_increment:<script.data_key[blocks_per_increment]>
    - flag server invervals_hard_stop:<script.data_key[invervals_hard_stop]>

Slide_Queue_Consumer:
    type: task
    enabled: true
    debug: false
    speed: instantly
    script:
    - define blocks <server.flag[sliding_blocks]||<list>>
    - define increment <server.flag[blocks_per_increment]>
    - define interval <server.flag[blocks_per_interval]>
    - announce "<script.name.color[blue]> has <server.flag[sliding_blocks].size> blocks with: <[increment]> per: <[interval]>" to_console if:<server.flag[sliding_blocks].size.is[equals].to[0].not>
    - flag server sliding_blocks:<list>
    - while <[blocks].is_empty.not>:
        - foreach <[blocks].first[<[increment]>]>:
            - run slideblock def:<[value].get[location]>|<[value].get[material]>
        - define blocks <[blocks].get[<[increment]>].to[last]||<list>>
        - wait <[interval]>
        #hard stop
        - while stop if:<[loop_index].is[==].to[<server.flag[invervals_hard_stop]>]>

SlideOptions:
    type: procedure
    definitions: location
    script:
    - define locations <list>
    #dose not check above block for slide option.
    - define options 0,0,0|1,0,0|0,0,-1|-1,0,0|0,0,1
    #Early exit because should fall strait down first
    - determine <list[<[location]>]> if:<[location].below.material.is_solid.not>
    - foreach <[options]>:
        - define _loc <[location].add[<[value]>]>
        - define _loc_below <[location].below.add[<[value]>]>
        - define solid_at <[_loc].material.is_solid>
        - define solid_below <[_loc].below.material.is_solid>
        - if <[solid_at].not> && <[solid_below].not>:
            - define locations:->:<[_loc]>
    - determine <[locations]>

SlideBlock:
    type: task
    enabled: true
    debug: true
    definitions: location|material[optional]
    script:
    - define material <[location].material> if:<[material].if_null[null].is[==].to[null]>
    #Is this a repetive action?
    #- modifyblock <[location]> air
    - spawn falling_block[fallingblock_type=<[material]>;fallingblock_hurt_entities=true;fallingblock_drop_item=false] <[location].center>

GetAdjacentLocations:
    type: procedure
    definitions: location
    script:
    - define locations <list>
    #Origin, -Y, Y, -X, X, -Z, Z
    - foreach 0,0,0|0,-1,0|0,1,0|-1,0,0|1,0,0|0,0,-1|0,0,1:
        - define locations:->:<[location].add[value]>
    - determine <[locations]>
