Command_WebGet:
    type: command
    enabled: false
    debug: false
    name: webget
    description: Gets some webdata.
    usage: /webget (notable_location)
    script:
    - ~webget <context.args.get[1]> save:web
    - announce <entry[web].result>