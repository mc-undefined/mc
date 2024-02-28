Learning_I_think:
    type: world
    debug: false
    data:
        Location: <location[5157,61,2416,world]>

        ItemRange:
            min: 6
            max: 19

        LootPool:
        - snowball
        - stick
        - bone
        - wooden_shovel
        - chainmail_cheastplate
        - totem_of_undying
        - sand
        - gold_ingot
        - iron_ingot
        - netherite_ingot

        #
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
        - if <server.flag[servertreasure].exists>:
            - stop
        - run CreateServerTresure def.Location:<script.data_key[data.Location]> def.min:<script.data_key[data.ItemRange.min]> def.max:<script.data_key[data.ItemRange.max]> def.LootPool:<script.data_key[Data.LootPool]>

        after player closes inventory:
        - if inv.not:
            - stop
        - modifyblock <server.flag[servertreasure]> air
        - flag server ServerTreasure:!

CreateServerTresure:
    type: task
    definitions: Location|min|max|LootPool
    script:
    - define tresure <list>
    - define RandomChestLocation <proc[arrows_rl].context[<[Location]>]>
    - flag server ServerTreasure:<[RandomChestLocation]>
    - repeat <util.random.int[<[min]>].to[<[max]>]>:
        - define tresure:->:<[LootPool].random>
    - modifyblock <server.flag[servertreasure]> chest
    - give <[tresure]> to:<[RandomChestLocation].inventory>

arrows_RL:
    type: procedure
    definitions: location
    debug: false
    script:
    - define GeneratedChunks <list>
    - repeat 20 from:-10 as:x:
        - repeat 20 from:-10 as:z:
            - if <[location].chunk.add[<[x]>,<[z]>].is_generated>:
                - define GeneratedChunks <[GeneratedChunks].include[<[location].chunk.add[<[x]>,<[z]>]>]>
    - determine <[GeneratedChunks].random.cuboid.spawnable_blocks.random>
