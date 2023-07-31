Flying_Thrust:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
            - Swinging your fists while gliding and youll get a boost! Beware it costs saturation though.
        delay: 2s
        sat_cost: 4
    events:
        after player animates:
        - ratelimit <player> <script.data_key[data.delay]>
        - if <player.item_in_hand.equals[<item[air]>].not>:
            - stop
        - if <player.gliding>:
            - define new_sat_level <player.saturation.sub[<script.data_key[data.sat_cost]>]>
            - adjust <player> firework_boost:<item[firework_rocket]>
            - adjust <player> saturation:<[new_sat_level]>