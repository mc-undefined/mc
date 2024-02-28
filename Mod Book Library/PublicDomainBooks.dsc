Command_Book_Get:
    type: command
    enabled: true
    debug: true
    name: getbook
    description: Gets a book using an id.
    usage: /getbook (book_id) (Book Title) (Author)
    tab completions:
        1: <server.flag[library.books].keys>
        2: <server.flag[library.books].parse_value[get[author]].values>
        3: <server.flag[library.books].parse_value[get[title]].values>
    script:
    # Arg handling
    - define id <context.args.get[1]||null>
    - define author <context.args.get[2]||null>
    - define title <context.args.get[3]||null>
    - if <[id]> == 'null' || <[author]> == 'null' || <[title]> == 'null':
        - narrate "<red>Your arguments contains a failed entry. Args: <context.args.space_separated.color[blue]>"
        - narrate "<yellow>All arguments are needed."
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
                - narrate "Retrieved successful webpage."
            - default:
                - narrate "<red>The webpage had an error:"
                - narrate Result:<&sp><entry[web].result>
                - narrate Failed:<&sp><entry[web].failed>
                - narrate Headers:<&sp><entry[web].headers>
                - narrate Time_ran:<&sp><entry[web].time_ran>
                - narrate Status:<&sp><entry[web].status>
                - stop

    # Read and parse file data.
    - ~fileread path:<[file_name]> save:data
    - define data <entry[data].data.utf8_decode>
    - define text <[data].trim_to_character_set[<[char_set]>].replace_text[<&chr[000D]>].with[<&nl>]>
    - define pages <list>
    - foreach <[text].split_lines_by_width[114].split[<&nl>].sub_lists[14]> as:page:
        - define pages:->:<[page].space_separated>

    # Public Declaration of num books and num shelves.
    - define num_books <[pages].size.div[100]>
    - announce "<blue><player.name.color[gold]> recieved id:<[id].color[gold]> title: <[title].color[gold]> by: <[author].color[gold]> in <[num_books].round.color[gold]> volumes!"
    - announce "Expecting <[num_books].div[6].add[1].round.color[yellow]> book shelves!"

    # Deliver Books
    - foreach <[pages].sub_lists[100]> as:volume:
        - define book_item <item[written_book]>
        - adjust def:book_item book_author:<[author]>
        - adjust def:book_item book_title:<[title]><&sp><[loop_index]>-<[num_books]>
        - adjust def:book_item book_pages:<[volume]>
        - give <[book_item]>


Parse_WebBook_Data:
    type: procedure
    debug: false
    definitions: text
    script:
    - define title "No Title"
    - define set_title false
    - define author "No Author"
    - define set_author false
    - define page_being_written <empty>
    - define pages <list>
    - define page_characters 0
    - define page_characters_max 789
    - define line_width_max 114
    - define page_lines 0
    - define page_lines_max 14
    - define author_characters_max 16
    - define title_characters_max 13
    - define char_set abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890<&sp><&co>.?!
    - define text <[text].trim_to_character_set[<[char_set]>]>
    - define lines <[text].split_lines_by_width[<[line_width_max]>]>
    #- debug "Number of lines in text: <[lines].size>" type:debug
    #- define text <[text].replace_text[<&chr[000D]>].with[<empty>]>
    # This is volume Se
    - foreach <[lines]> as:line:
        - if <[page_characters].is[more].than[<[page_characters_max]>]>||<[page_lines].is[more].than[<[page_lines_max]>]>:
            - define pages:->:<[page_being_written]>
            - define page_being_written <empty>
            - define page_characters:0
            - define page_lines:0
        - define page_characters:+:<[line].length>
        - define page_lines:++
        - define page_being_written "<[page_being_written]><&nl><[line]>"
        # Author and Title Scanning Section. Once Set skips the rest of the matching conditions.
        - choose <[line].split.get[1]>:
            - case "Author:":
               # Sets max Character Length for Author.
                - define author <[line].split.get[2].to[last].space_separated.split[<empty>].get[1].to[<[author_characters_max]>]> if:<[set_author].not>
                - define set_author true
            - case "Title:":
               # Sets max Character Length for Title. -3 to allow book volume number inclusion.
                - define title <[line].split.get[2].to[last].space_separated.split[<empty>].get[1].to[<[title_characters_max]>]> if:<[set_title].not>
                - define set_title true
            - default:
                - foreach next
    - determine <map[title=<[title]>;author=<[author]>;pages=<[pages]>]>

test_webget:
    type: command
    enabled: true
    debug: true
    name: d-book
    description: Gets a book using an id.
    usage: /d-book (book_id)
    script:
    - define id <context.args.get[1]>
    - define web http://aleph.gutenberg.org/cache/epub/<[id]>/pg<[id]>.txt
    - ~webget <[web]> save:book
    - announce Result:<&sp><entry[book].result>
    - announce Failed:<&sp><entry[book].failed>
    - announce Headers:<&sp><entry[book].headers>
    - announce Time_ran:<&sp><entry[book].time_ran>
    - announce Status:<&sp><entry[book].status>

book_write:
    type: command
    enabled: true
    debug: true
    name: w-book
    description: writes a book
    usage: /w-book
    script:
    - define text new|list
    - define book <item[written_book]>
    - adjust def:book book_pages:<[text]>
    - adjust def:book book_author:Newton
    - adjust def:book book_title:5_Law_of_thermos
    - give <[book]>