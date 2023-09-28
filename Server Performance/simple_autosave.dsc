autosaver_world:
    type: world
    debug: false
    events:
        on delta time minutely every:30:
        - announce to_console Autosaving...
        - adjust server save
        - adjust server save_citizens