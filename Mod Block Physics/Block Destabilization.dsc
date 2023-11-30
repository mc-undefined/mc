Destabilize:
    enabled: true
    type: world
    debug: false
    data:
        dyn:
        - New unstable blocks!
    consumer_ratelimit: 3t
    blocks:
        #material.name
        #   to: new material
        #   trigger: percentage <= to 1
        #Determines how stable a block is once it tumbles
        cobblestone:
            block_falls: 0.99
            places_block: 0.81
        sand:
            block_falls: 0.1
        dirt:
            block_falls: 0.99
    events:
        after player places block:
        - ratelimit server 1t
        - if percentatage:
            - stop
        - definemap context:
            trigger: block_physics
            location: <context.location>
            material: <context.new_material>
            slide_options: <proc[Get_Adjacent_Locations].context[<context.location>].filter_tag[<proc[can_slide_from_to].context[<context.location>|<[filter_value]>]>]>
            fall_time: 0
        - customevent id:slidingblock context:<[context]> save:sliding
        #- determine cancelled if:<entry[sliding].was_cancelled.not>

        # after player places block:
        # - definemap context:
        #     location: <context.location>
        #     material: <context.material>
        #     event: places_block
        # - customevent id:blockdestabilization context:<[context]>

        # after player breaks block:
        # - definemap context:
        #     location: <context.location>
        #     material: <context.material>
        #     event: breaks_block
        # - customevent id:blockdestabilization context:<[context]>

        on custom event id:blockdestabilization:
        - foreach <proc[get_adjacent_locations].context[<context.location>]>:
            - run falling_location def:<[value]>

falling_location:
    type: task
    definitions: location
    script:
    - modifyblock air <[location]>
    - spawn falling_block[fallingblock_type=<[location].material>;fallingblock_hurt_entities=true;fallingblock_drop_item=false] <[location].center>