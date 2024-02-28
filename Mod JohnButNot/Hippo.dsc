Learning_I_think:
    type: world
    debug: false
    data:
        dyn:
        - There is NOT A <&sq>HIPPO<&sq> in the world.
        - There is A <&sq>HIPPO<&sq> in the world?
        - Maby there is a <&sq>HIPPO<&sq> in the world.
        - I dont think theres a <&sq>HIPPO<&sq> in the world.
        - You are better then <&sq>HIPPO<&sq>.
        - <&sq>HIPPO<&sq> is 20 meters from your location.
        - The <&sq>HIPPO<&sq> hid a tresure at <&sq>5157 61 2416<&sq>

    events:
        after player joins:
        - wait 10s
        - if <player.name> != A_Swift_Arrow:
            - stop
        - stop if:<player.name.is[equals].to[A_Swift_Arrow].not>
        - narrate "HIPPO is NOT 20 meters from your location."

        after server start:
        - modifyblock <location[5157,61,2416,world]> chest
        - define tresure snowball|stick|bone|wooden_shovel|chainmail_chestplate|totem_of_undying
        - give origin:<[tresure]> destination:<location[5157,61,2416,world].inventory>
        # define rand <proc[arrows_random_location].context[<player.location>]>

arrows_RL:
    type: procedure
    definitions: location
    script:
    - define GeneratedChunks <list>
    - repeat 20 from:-10 as:x:
        - repeat 20 from:-10 as:z:
            - if <[location].chunk.add[<[x]>,<[z]>].is_generated>:
                - define GeneratedChunks <[GeneratedChunks].include[<[location].chunk.add[<[x]>,<[z]>]>]>
    - determine <[GeneratedChunks].random.cuboid.spawnable_blocks.random>
