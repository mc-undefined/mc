
Custom_Script_Name:

    type: custom

    # Use 'inherit' to make this custom script container inherit from another custom object.
    inherit: player

    # This adds default field 'some_field' with initial value of 'some_value'.
    mana: 100

    # List additional fields here...

    # Use 'tags' to define scripted tags on the object.
    # Tags are subject to the same rules as procedure scripts:
    # NEVER change any external state. Just determine a value. Nothing else should change from the script.
    tags:

        # This would be read like <[my_object].my_tag>
        spells:
        # Perform any logic here, and 'determine' the result.
        - determine ma

        # list additional tags here...

    # Use 'mechanisms' to define scripted mechanisms on the object.
    # Note that these should only ever determine a new object,
    # with NO CHANGES AT ALL outside the replacement determined object.
    # (Same rules as tags and procedure scripts).
    mechanisms:

        # This would be used like custom@Custom_Script_Name[my_mech=3]
        my_mech:
        - adjust <context.this> true_value:<context.value.mul[2]> save:new_val
        - determine <entry[new_val].result>

        # list additional mechanisms here...