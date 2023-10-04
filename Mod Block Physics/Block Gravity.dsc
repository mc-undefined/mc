Landslide:
    enabled: true
    type: world
    debug: true
    data:
        dyn:
        - Blocks that fall now slide!
        - Blocks that fall now shoot out everywhere!
    consumer_ratelimit: 3t
    blocks:
        #material.name
        #   to: new material
        #   trigger: percentage <= to 1
        #Determines how stable a block is once it tumbles
        sand:
            to: sand
            block_falls: 0.99
        sandstone:
            to: sand
            block_falls: 0.1
        dirt:
            to: dirt
            block_falls: 0.99
        course_dirt:
            to: course_dirt
            block_falls: 0.60
        gravel:
            to: gravel
            block_falls: 0.99
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
            fall_time: <context.entity.time_lived.in_seconds>
        - customevent id:slidingblock context:<[context]> save:sliding
        - determine cancelled if:<entry[sliding].was_cancelled.not>

        on custom event id:slidingblock:
        - determine cancelled if:<util.random_decimal.is[more].than[<script.data_key[blocks.<context.material.name>.<context.trigger>]||0.5>]>
        - define locations <proc[slideoptions].context[<context.location>]>
        - determine cancelled if:<[locations].is_empty>
        - flag server sliding_blocks:->:<map[location=<[locations].random>;material=<script.data_key[blocks.<context.material.name>.to].as[material]||null>;fall_time=<context.fall_time>]>
        - run slide_queue_consumer

    load_settings:
    - foreach <script.data_key[blocks].keys>:
        - define material <[value]>
        - foreach <script.data_key[blocks.<[value]>].keys>:
            - define key blocks.<[material]>.<[value]>
            - flag server <[key]>:<script.data_key[<[key]>]>
            - announce "<script.name.color[blue]> <[material]> slide chance: <[value]>: <server.flag[<[key]>]>" to_console if:<script.data_key[debug]>
    - flag server consumer_ratelimit:<script.data_key[consumer_ratelimit]>

Slide_Queue_Consumer:
    type: task
    enabled: true
    debug: false
    speed: instantly
    script:
    - ratelimit server <server.flag[consumer_ratelimit]>
    - define blocks <server.flag[sliding_blocks]||<list>>
    - flag server sliding_blocks:<list>
    #- announce "<script.name.color[blue]> has <[blocks].size> blocks with: <[increment]> per: <[interval]>" to_console if:<[blocks].size.is[equals].to[0].not>
    - foreach <[blocks]>:
        - run slideblock def:<[value].get[location]>|<[value].get[material]>|<[value].get[fall_time]>

SlideOptions:
    type: procedure
    definitions: location[Starting Location]
    script:
    #Early exit because should fall strait down first
    - determine <list[<[location]>]> if:<[location].below.material.is_solid.not>
    - define locations <list>
    #dose not check above or at for block slide option.
    - define options 1,0,0|0,0,-1|-1,0,0|0,0,1
    - foreach <[options]>:
        - define _loc <[location].add[<[value]>]>
        - define solid_at <[_loc].material.is_solid>
        - define solid_below <[_loc].below.material.is_solid>
        - if <[solid_at].not> && <[solid_below].not>:
            - define locations:->:<[_loc]>
    - determine <[locations]>

SlideBlock:
    type: task
    enabled: true
    debug: false
    definitions: location|material[optional]|fall_time
    script:
    - define material <[location].material> if:<[material].if_null[null].is[==].to[null]>
    - if <[fall_time].is[less].than[1]>:
        - spawn falling_block[fallingblock_type=<[material]>;fallingblock_hurt_entities=true;fallingblock_drop_item=false] <[location].center>
    - else:
        - shoot falling_block[fallingblock_type=<[material]>;fallingblock_hurt_entities=true;fallingblock_drop_item=false] origin:<[location].center> destination:<[location].to_cuboid[<[location]>].expand[<[fall_time]>].spawnable_blocks.random.center> height:<[fall_time]>

GetAdjacentLocations:
    type: procedure
    definitions: location[origin point]
    script:
    - define locations <list>
    #Origin, -Y, Y, -X, X, -Z, Z
    - foreach 0,0,0|0,-1,0|0,1,0|-1,0,0|1,0,0|0,0,-1|0,0,1:
        - define locations:->:<[location].add[value]>
    - determine <[locations]>