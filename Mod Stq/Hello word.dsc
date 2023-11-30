Surprise_loot:
    type: world
    debug: false
    data:
        dyn:
        - Loot stash at x coords
        - Hello, StqticWiki
    events:
        after player joins:
        - wait 10s
        - choose <player.name>:
            - case StqticWiki:
                - narrate "Hello, StqticWiki"

Test_Shoot:
    type: task
    script:
    - foreach <element[arrow].repeat_as_list[10]>:
        - shoot <[value]>
        - wait 1t

Get_far_rand_location:
    type: procedure
    definitions: location|material
    script:
    # Define a cuboid around a point,
    # Get a random location from the cuboid
    # d3fine a cuboid from that point
    # get a spawnable location from there
    - define area <[location].chunk.cuboid.expand[100000]>
    - define random_cuboid <[area].random.chunk.cuboid>
    - define loc <[random_cuboid].spawnable_blocks[<[material]>]>
    - determine <[loc]>