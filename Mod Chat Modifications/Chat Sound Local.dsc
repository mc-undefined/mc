Chat_Sound_Local:
    type: world
    debug: false
    enabled: false
    # (max_range + curve_slope^(-( x + inital_data_shift)) )^-1
    max_range: 5
    curve_slope: 2 # Puts +-5 '!' to be heard at around ~.06 to ~4.7 chunks distant.
    inital_expected_volume: 1 # The Expected data shift
    data:
        dyn:
        - If you hear the villager ambient sound it might mean a player is speaking in your area.
    events:
        on player chats:
        - define volume <proc[get_volume_from_chat].context[<context.message>]>
        - playsound <player.location> sound:entity_villager_ambient sound_category:VOICE volume:<[volume]>

Sigmoid:
    # Sigmoid Curve
    # (max_range^-1 + curve_slope^(-( distance + inital_data_shift)) )^-1
    # max_range: 5
    # curve_slope: 2 # We want it to max out a little slower
    # inital_expected_volume: 1 # The Expected data shift
    type: procedure
    debug: false
    definitions: distance|max_range|curve_slope|inital_expected_volume
    script:
    - define exponet <[distance].add[<[inital_expected_volume]>]>
    - define curve_slope <[curve_slope].power[<[exponet].mul[-1]>]>
    - determine <[max_range].power[-1].add[<[curve_slope]>].power[-1]>

Get_Volume_From_Chat:
    type: procedure
    debug: false
    definitions: text|max_range|curve_slope|inital_expected_volume
    script:
    - define max_range <[max_range]||5>
    - define curve_slope <[curve_slope]||2>
    - define inital_expected_volume <[inital_expected_volume]||1>
    - define increases <[text].to_list.find_all_matches[*!*].size>
    - define decreases <[text].to_list.find_all_matches[*.*].size>
    - define total <[increases].sub[<[decreases]>]>
    - determine <proc[sigmoid].context[<[total]>|<[max_range]>|<[curve_slope]>|<[inital_expected_volume]>]>