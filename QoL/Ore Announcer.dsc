Ore_Announcer:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - Now you'll know when to raid a player for thier ores! They cant hide what they found now!
        delay: 30s
        tag_id: announce_on_damage
        search_radius: 10
        #Dont forget to have both the blocks list and the color.material.[to,from] set!
        blocks:
        - coal_ore
        - deepslate_coal_ore
        - copper_ore
        - deepslate_copper_ore
        - iron_ore
        - deepslate_iron_ore
        - gold_ore
        - deepslate_gold_ore
        - redstone_ore
        - deepslate_redstone_ore
        - lapis_ore
        - deepslate_lapis_ore
        - emerald_ore
        - deepslate_emerald_ore
        - diamond_ore
        - deepslate_diamond_ore
        - nether_gold_ore
        - ancient_debris
        - nether_quartz_ore
        - dragon_egg
        color:
            coal_ore:
                from: gray
                to: <empty>#363636
            deepslate_coal_ore:
                from: gray
                to: <empty>#888888
            copper_ore:
                from: gray
                to: <empty>#b87333
            deepslate_copper_ore:
                from: gray
                to: <empty>#b87333
            iron_ore:
                from: gray
                to: <empty>#a19d94
            deepslate_iron_ore:
                from: gray
                to: <empty>#a19d94
            gold_ore:
                from: gray
                to: <empty>#ffdf00
            deepslate_gold_ore:
                from: gray
                to: <empty>#ffdf00
            redstone_ore:
                from: gray
                to: red
            deepslate_redstone_ore:
                from: gray
                to: red
            lapis_ore:
                from: gray
                to: blue
            deepslate_lapis_ore:
                from: gray
                to: blue
            emerald_ore:
                from: gray
                to: <empty>#317847
            deepslate_emerald_ore:
                from: gray
                to: <empty>#317847
            diamond_ore:
                from: gray
                to: aqua
            deepslate_diamond_ore:
                from: gray
                to: aqua
            nether_gold_ore:
                from: red
                to: <empty>#ffdf00
            ancient_debris:
                from: maroon
                to: red
            nether_quartz_ore:
                from: red
                to: white
            dragon_egg:
                from: red
                to: gold
    events:
        #after reload scripts:
        #- announce "<script.name.color[blue]>: Tracking <script.data_key[data.blocks].size.color[blue]> blocks" to_ops
        #- announce "<script.name.color[blue]>: You'll need to restart the server to add new blocks to the announce list." to_ops
        #- foreach <script.data_key[data.blocks]>:
        #    - adjust <material[<[value]>]> vanilla_tags:<material[<[value]>].vanilla_tags.include[<script.data_key[data.tag_id]>].deduplicate>
        on server start:
        - announce "<script.name.color[blue]>: Tracking <script.data_key[data.blocks].size.color[blue]> blocks"
        - flag server found_ores:!
        - foreach <script.data_key[data.blocks]>:
            - adjust <material[<[value]>]> vanilla_tags:<material[<[value]>].vanilla_tags.include[<script.data_key[data.tag_id]>].deduplicate>
        after player damages block:
        - stop if:<context.material.vanilla_tags.contains[<script.data_key[data.tag_id]>].not>
        - stop if:<server.has_flag[found_ores.<context.location>]>
        - define blocks <context.location.flood_fill[<script.data_key[data.search_radius]>]>
        - define num <[blocks].size>
        - foreach <[blocks]>:
            - flag server found_ores.<[value]> expire:1h
        - announce "<player.name.color[blue]> <element[has found <[num].color[gold]> <context.material.name>].color_gradient[from=<script.data_key[data.color.<context.material.name>.from].parsed>;to=<script.data_key[data.color.<context.material.name>.to].parsed>]>!"
