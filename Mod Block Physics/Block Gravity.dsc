FallBreak:
    type: world
    enabled: false
    debug: false
    events:
        on entity damaged by cause:
        - ratelimit <player> 2t
        - determine INSTABREAK

FallingBlocks:
    enabled: false
    type: world
    debug: false
    data:
        dyn:
        - Block physics! Falling <&8>dirt!
        - Were adding all kinds of falling materials! Stone, dirt, cobblestone...
    events:
        on fall command:
        - determine passively FULFILLED
        - define location <player.cursor_on[10].center>
        - define material <[location].material>
        - announce "Falling <[material]> @<[location]>"
        - modifyblock <[location]> air
        - spawn falling_block[fallingblock_type=<[material]>] <[location].above>
        #- adjust <entry[block].spawned_entity> fallingblock_hurt_entities:true
        #- adjust <entry[block].spawned_entity> fallingblock_type:<[location].material>
        #- adjust <entry[block].spawned_entity> fallingblock_drop_item:true

        after block physics adjacent:dirt:
        - wait 1t
        - announce "dirt physics update"
        - stop
        - modifyblock <context.location> air
        - spawn falling_block
