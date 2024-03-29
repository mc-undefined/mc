#https://meta.denizenscript.com/Docs/Languages#item%20script%20containers
Item_Script_Name:

    type: item
    data:
        dyn:
        - The new item bag is suppost to hold your items.
        - The item bag can be crafted with 6 lether and string.
    # Must be a valid ItemTag. See 'ItemTag' for more information.
    # | All item scripts MUST have this key!
    material: bundle

    # The 'custom name' can be anything you wish. Use color tags to make colored custom names.
    # | Some item scripts should have this key!
    display name: item bag

    # Lore lines can make items extra unique. This is a list, so multiple entries will result in multiple lores.
    # If using a replaceable tag, they are filled in when the item script is given/created/dropped/etc.
    # | Some item scripts should have this key!
    lore:
    - It holds all your items.

    # Set this to 'true' to allow the item script item to be used in material-based recipe (eg most vanilla recipes).
    # Defaults to false if unspecified.
    # | Most item scripts should exclude this key!
    allow in material recipes: false

    # You can specify flags to be added to the item.
    flags:
      # Each line within the flags section should be a flag name as a key, and the flag value as the value.
      # You can use lists or maps here the way you would expect them to work.
      my_flag: my value

    # You can optionally add crafting recipes for your item script.
    # Note that recipes won't show in the recipe book when you add a new item script, until you either reconnect or use the "resend_recipes" mechanism.
    # | Most item scripts should exclude this key, unless you're specifically building craftable items.
    recipes:
        1:
            # The type can be: shaped, shapeless, stonecutting, furnace, blast, smoker, campfire, or smithing.
            # | All recipes must include this key!
            type: shaped
            # You can optionally specify the quantity to output. The default is 1 (or whatever the item script's quantity is).
            # | Only some recipes should have this key.
            output_quantity: 1
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
            - air|string|air
            - leather|leather|leather
            - leather|leather|leather