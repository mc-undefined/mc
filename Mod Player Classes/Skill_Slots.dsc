Skill_Slots:
    # activated skills should be the first on the list
    # class skills should be 1st and 2nd
    type: world
    data:
        dyn:
        - Players have skill slots to add skills! 2 class actions, 1 reaction, 1 class buff, 1 move.
    events:
        on player joins:
        - flag player skills.class_scripts:<list> if:<player.has_flag[skills.class_scripts].not>
        - flag player skills.active_scripts:<list> if:<player.has_flag[skills.active_scripts].not>
        - flag player skills.reaction_scripts:<list> if:<player.has_flag[skills.reaction_scripts].not>
        - flag player skills.move_scripts:<list> if:<player.has_flag[skills.move_scripts].not>
        on entity damaged:
        - run <context.entity.flag[skills.reaction_script].first> if:<context.entity.has_flag[skills.reaction_script]>

Skill_reaction_teleport:
    type: task
    definitions: entity
    script:
    - teleport <[entity]> <[entity].location.to_ellipsoid[5,5,5].spawnable_blocks.random>