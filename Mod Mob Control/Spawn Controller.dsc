MobSpawnSuppression:
    type: world
    enabled: true
    debug: false
    data:
        # spawn reasons
        # https://hub.spigotmc.org/javadocs/spigot/org/bukkit/event/entity/CreatureSpawnEvent.SpawnReason.html
        reasons:
        - BEEHIVE
        - BREEDING
        - BUILD_IRONGOLEM
        - BUILD_SNOWMAN
        - BUILD_WITHER
        - CHUNK_GEN
        - COMMAND
        - CURED
        - CUSTOM
        - DEFAULT
        - DISPENSE_EGG
        - DROWNED
        - DUPLICATION
        - EGG
        - ENDER_PEARL
        - EXPLOSION
        - FROZEN
        - INFECTION
        - JOCKEY
        - LOGHTNING
        - METAMORPHOSIS
        - MOUNT
        - NATURAL
        - NETHER_PORTAL
        - OCELOT_BABY
        - PATROL
        - PIGLIN_ZOMBIE
        - RAID
        - REINFORCEMENTS
        - SHEARED
        - SHOULDER_ENTITY
        - SILVERFISH_BLOCK
        - SLIME_SPLIT
        - SPAWNER
        - SPAWNER_EGG
        - SPELL
        - TRAP
        - VILLAGE_DEFENSE
        - VILLAGE_INVASION
        dyn:
        - Mob Raids use a pool of xp and time.
    events:
        after server start:
        # server data spawn_reasons
        # A way to change the spawn reasons list
        - flag server spawn_reasons:|: if:<server.has_flag[spawn_reasons].not>
        - flag server spawn_reasons_allowed:|: if:<server.has_flag[spawn_reasons_allowed].not>
        - flag server spawn_reasons_denied:|: if:<server.has_flag[spawn_reasons_denied].not>
        on entity spawns:
        #- announce "[<context.reason>] spawns: <context.entity.name>"
        - if <server.flag[spawn_reasons_allowed].contains[<context.reason>]>:
            - stop
        - if <server.flag[spawn_reasons_denied].contains[<context.reason>]>:
            - determine cancelled
        - announce "[<context.reason>] spawns: <context.entity.name>" if:<script.data_key[debug]> format:debugprefix
