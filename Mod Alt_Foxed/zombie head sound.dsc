zombiehead_noise:
    type: world
    enabled: true
    debug: true
    data:
        dyn:
        - Zombie heads makes a zombie sound when equiped.
        #- There are zombie heads that can be crafted.
    events:
        after player scrolls their hotbar item:zombie_head:
        - while <player.item_in_hand.is[equals].to[<item[zombie_head]>]> && <player.if_null[false]>:
            - playsound <player> sound:ENTITY_ZOMBIE_AMBIENT
            - wait <list[1s|2s|10s|30s].random>