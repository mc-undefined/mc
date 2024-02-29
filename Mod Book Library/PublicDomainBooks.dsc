Command_Book_Get:
    type: command
    enabled: true
    debug: false
    name: getbook
    description: Gets a book using an id. https://www.gutenberg.org for Search and Id's
    usage: /getbook (book_id) (Book Title) (Author)
    tab completions:
        1: <server.flag[library.books].keys>
        2: Author
        3: Title
        #<server.flag[library.books].parse_value[get[title]].values>
    script:
    # Arg handling
    - define id <context.args.get[1]||null>
    - define author <context.args.get[2]||null>
    - define title <context.args.get[3]||null>
    - if <[id]> == null || <[author]> == null || <[title]> == null:
        - narrate "<red>Your arguments contains a failed entry. Args: <context.args.space_separated.color[blue]>"
        - narrate "<yellow>All arguments are needed."
        - narrate <yellow><script.data_key[usage]>
        - stop

    # Hardcoded Definitions using arguments.
    - define file_name data/library/books/<[id]>.txt
    - define web http://aleph.gutenberg.org/cache/epub/<[id]>/pg<[id]>.txt
    - define flag library.books.<[id]>
    - define char_set abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890<&sp><&co>.?!<&chr[000D]>_*-<&rb><&lb><&rc><&lc><&lt><&gt>

    # Flag extra server data
    - flag server <[flag]>.title:<[title]>
    - flag server <[flag]>.author:<[author]>
    - flag server <[flag]>.retrieved:<util.time_now>

    # Announce Lag
    - announce "<yellow><player.name.color[blue]> is seeking book: <[title].color[blue]> by <[author].color[blue]>" format:dyn_format
    - announce "<red>This may take a while."

    # Write File if it dosnt exist.
    # If web had issues, return web data.
    - if <util.has_file[<[file_name]>].not>:
        - announce "Book is not in library! Retrieving new book."
        - ~filewrite data:<empty> path:<[file_name]>
        - ~webget <[web]> savefile:plugins\Denizen\<[file_name]> save:web
        - choose <entry[web].status>:
            - case 200:
                - narrate "Webget successful."
            - default:
                - narrate "<red>The webpage had an error:"
                - narrate Result:<&sp><entry[web].result>
                - narrate Failed:<&sp><entry[web].failed>
                - narrate Headers:<&sp><entry[web].headers>
                - narrate Time_ran:<&sp><entry[web].time_ran>
                - narrate Status:<&sp><entry[web].status>
                - stop

    # Read, trim, split file data.
    - ~fileread path:<[file_name]> save:data
    - define data <entry[data].data.utf8_decode>
    - define text <[data].trim_to_character_set[<[char_set]>].replace_text[<&chr[000D]>].with[<&nl>]>
    - define pages <list>
    - foreach <[text].split_lines_by_width[114].split[<&nl>].sub_lists[14]> as:page:
        - define pages:->:<[page].space_separated>

    # Public Declaration of num books and num shelves.
    - define num_books <[pages].size.div[100].round_up>
    - announce "<blue><player.name.color[gold]> recieved id:<[id].color[gold]> title: <[title].color[gold]> by: <[author].color[gold]> in <[num_books].round.color[gold]> volumes!"
    - announce "Expecting <[num_books].div[6].round_up.color[yellow]> book shelves!"

    # Deliver Books
    - foreach <[pages].sub_lists[100]> as:volume:
        - define book_item <item[written_book]>
        - define new_title <[loop_index]>-<[num_books]><&sp><[title]>
        - adjust def:book_item book_author:<[author]>
        - adjust def:book_item book_title:<[new_title].substring[1,16]>
        - adjust def:book_item book_pages:<[volume]>
        - give <[book_item]>