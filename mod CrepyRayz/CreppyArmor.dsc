#https://meta.denizenscript.com/Docs/Languages#item%20script%20containers
Item_Creeper_Helmet:

    type: item

    # Must be a valid ItemTag. See 'ItemTag' for more information.
    # | All item scripts MUST have this key!
    material: netherite_helmet

    # The 'custom name' can be anything you wish. Use color tags to make colored custom names.
    # | Some item scripts should have this key!
    display name: Creeper_helmet

    # Lore lines can make items extra unique. This is a list, so multiple entries will result in multiple lores.
    # If using a replaceable tag, they are filled in when the item script is given/created/dropped/etc.
    # | Some item scripts should have this key!
    lore:
    - creepers dont see you
    - Dont touch me

    # If you want an item to be damaged on creation, you can change its durability.
    # | Most item scripts should exclude this key!
    # durability: 12

    # Each line must specify a valid enchantment name.
    # | Some item scripts should have this key!
    # enchantments:
    # - enchantment_name:level
    # - ...

    # You can specify flags to be added to the item.
   # flags:
      # Each line within the flags section should be a flag name as a key, and the flag value as the value.
      # You can use lists or maps here the way you would expect them to work.
      # my_flag: my value

    # You can optionally add crafting recipes for your item script.
    # Note that recipes won't show in the recipe book when you add a new item script, until you either reconnect or use the "resend_recipes" mechanism.
    # | Most item scripts should exclude this key, unless you're specifically building craftable items.
    recipes:
        1:
            # The type can be: shaped, shapeless, stonecutting, furnace, blast, smoker, campfire, or smithing.
            # | All recipes must include this key!
            type: shaped
            # You must specify the input for the recipe. The below is a sample of a 3x3 shaped recipe. Other recipe types have a different format.
            # You are allowed to have non-3x3 shapes (can be any value 1-3 x 1-3, so for example 1x3, 2x1, and 2x2 are fine).
            # For an empty slot, use "air".
            # By default, items require an exact match. For a material-based match, use the format "material:MaterialNameHere" like "material:stick".
            # To make multiple different items match for any slot, just separate them with slashes, like "stick/stone".
            # To match multiple materials, use "material:a/b/c".
            # You can also make a dynamic matcher using '*', like "material:*_log" to match any log block,
            # or 'test_*' to match any item script that has name starting with 'test_'.
            # Note that to require multiple of an item as an input, the only option is to use multiple slots.
            # A single slot cannot require a quantity of items, as that is not part of the minecraft recipe system.
            # | All recipes must include this key!
            input:
            - netherite_helmet|air|air
            - Item_Creeper_Hide|air|air
            - air|air|air

Item_Creeper_Hide:

    type: item
    material: leather
    display name: Creeper_Hide

    lore:
    - It smells like gunpouder
    - It streches like a balloon

creeper_antargeting_armor:
    type: world
    debug: false
    data:
        dyn:
        - You need Netherite armor and Creeper lether to make Creeper_armor.
        - Did you know that there is now Creeper armor that stops crrepers form targiting you.
    events:
        on creeper targets player:
        - if <player.has_equipped[Item_Creeper_Helmet].not>:
            - stop
        - determine cancelled