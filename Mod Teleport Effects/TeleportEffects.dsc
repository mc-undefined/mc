TeleportParticleSound:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - Ever wonder why you see the enderman particles when you teleport? Yeah, that was me.
    events:
        on player teleports:
        - ratelimit <player> 1s
        - playeffect effect:ENDER_SIGNAL at:<context.origin>|<context.destination>
        - playsound sound:ENTITY_ENDERMAN_TELEPORT at:<context.origin>|<context.destination>