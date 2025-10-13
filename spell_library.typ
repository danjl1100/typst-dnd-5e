#let suffix_th(number) = {
  if number == 1 {
    [#(number)st]
  } else if number == 2 {
    [#(number)nd]
  } else if number == 3 {
    [#(number)rd]
  } else {
    [#(number)th]
  }
}

#let at_player_level(player_level) = [
  Player at #suffix_th(player_level) level:
]
#let at_casting_level(casting_level) = [
  // Using #suffix_th(casting_level) level spell slot:
  Cast at #suffix_th(casting_level) level:
]

#let one_increase_5_11_17(number) = {
  if number >= 17 {
    4
  } else if number >= 11 {
    3
  } else if number >= 5 {
    2
  } else {
    1
  }
}

#let spell_library = (
  "Eldritch Blast": (
    level: 0,
    burst_sustained: "burst",
    offense_defense: "offense",
    school: "evocation",
    cast_time: "1 action",
    range: "120 feet",
    components: ("V", "S"),
    duration: "Instantaneous",
    text: [
      A beam of crackling energy streaks toward a creature within range.
      Make a ranged spell attack against the target.
      On a hit, the target takes *1d10* force damage.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        let beams_num = one_increase_5_11_17(player_level)
        let beams = if beams_num == 1 [beam] else [beams]
        if player_level > 0 [
          #at_player_level(player_level) #beams_num #beams of crackling energy
        ]
      }
    ),
  ),
  "Mind Sliver": (
    level: 0,
    burst_sustained: "burst",
    offense_defense: "offense",
    school: "enchantment",
    cast_time: "1 action",
    range: "60 feet",
    components: ("V",),
    duration: "1 round",
    text: [
      You drive a disorienting spike of psychic energy into the mind of one creature you can see within range.
      The target must succeed on an Intelligence saving throw or take *1d6* psychic damage and subtract *1d4* from the next saving throw it makes before the end of your next turn.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        let multiplier = one_increase_5_11_17(player_level)
        if player_level > 0 [
          #at_player_level(player_level) *#(multiplier)d6* psychic damage
        ]
      }
    ),
  ),
  "Toll the Dead": (
    level: 0,
    burst_sustained: "burst",
    offense_defense: "offense",
    school: "necromancy",
    cast_time: "1 action",
    range: "60 feet",
    components: ("V", "S"),
    duration: "Instantaneous",
    text: [
      You point at one creature you can see within range, and the sound of a dolorous bell fills the air around it for a moment.
      The target must succeed on a Wisdom saving throw or take *1d8* necrotic damage.
      If the target is missing any of its hit points, it instead takes *1d12* necrotic damage.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        let multiplier = one_increase_5_11_17(player_level)
        if player_level > 0 [
          #at_player_level(player_level) *#(multiplier)d8 or #(multiplier)d12* necrotic damage
        ]
      }
    ),
  ),
  "Polymorph": (
    level: 6,
    burst_sustained: "sustained",
    offense_defense: "defense",
    school: "transmutation",
    cast_time: "1 action",
    range: "60 feet",
    components: ("V", "S", "M (a caterpillar cocoon)"),
    duration: "Concentration, up to 1 hour",
    text: [
      The spell transforms a creature that you can see within range into a new form.
      An unwilling creature must make a Wisdom saving throw to avoid the effect.
      The spell has no effect on a shapechanger or a creature with 0 hit points.

      The transformation lasts for the duration, or until the target drops to 0 hit points or does.
      The new form can be any beast whose challenge rating is equal to or less than the target's (or the target's level, if it doesn't have a challenge rating).
      The target's game statistics, including mental ability scores, are replaced by the statistics of the chosen beast.
      It retains its alignment and personality.

      The target assumes the hit points of its new form.
      When it reverts to its normal form, the creature returns to the number of hit points it had before it transformed.
      If it reverts as a result of dropping to 0 hit points, any excess damage carries over to its normal form.
      As long as the excess damage doesn't reduce the creature's normal form to 0 hit points, it isn't knocked unconscious.

      The creature is limited in the actions it can perform by the nature of its new form, as it can't speak, cast spells, or take any other action that requires hands or speech.
      The target's gear melds into the new form.
      The creature can't activate, use, wield, or otherwise benefit from any of its equipment.
    ],
  ),
  "Circle of Death": (
    level: 6,
    burst_sustained: "burst",
    offense_defense: "offense",
    school: "necromancy",
    cast_time: "1 action",
    range: "150 feet (60 ft. cube)",
    components: ("V", "S", "M"),
    duration: "Instantaneous",
    text: [
      A sphere of negative energy ripples out from a 60-foot-radius sphere from a point within range.
      Each creature in that area must make a Constitution saving throw.
      A target takes *8d6* necrotic damage on a failed save, or half as much damage on a successful one.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        casting_levels
          .map(level => {
            // every level above 6 adds 2 more d6
            let damage = [#((2 * calc.max(0, level - 6)) + 8)d6]
            if level > 0 [
              #at_casting_level(level) *#damage* necrotic damage
            ]
          })
          .join(linebreak())
      }
    ),
  ),
  // "Find Familiar": (
  //   level: 1,
  //   school: "conjuration (ritual)",
  //   cast_time: "1 hour",
  //   range: "10 feet",
  //   components: ("V", "S", "M"), // (10 gp charcoal, incense, herbs consumed by fire in a brass brazier)
  //   duration: "Instantaneous",
  //   text: [
  //     You gain the service of a familiar, a spirit that takes an animal form you choose: bat, cat, crab, frog (toad), hawk, lizard, octopus, owl, poisonous snake, fish (quipper), rat, raven, sea horse, spider, or weasel.
  //     Appearing in an unoccupied space within range, the familiar has the statistics of the chosen form, though it is a celestial, fey, or fiend (your choice) instead of a beast.
  //     etc....
  //   ],
  // ),
  "Witch Bolt": (
    level: 1,
    burst_sustained: "sustained",
    offense_defense: "offense",
    school: "evocation",
    cast_time: "1 action",
    range: "30 feet",
    components: ("V", "S", "M"),
    duration: "Concentration, up to 1 minute",
    text: [
      A beam of crackling, blue energy lances out toward a creature within range, forming a sustained arc of lighting between you and the target.
      Make a ranged spell attack against that creature.
      On a hit, the target takes *1d12* lighting damage, and on each of your turns for the duration, you can use your action to deal *1d12* lighting damage to the target automatically.
      The spell ends if you use your action to do anything else.
      The spell also ends if the target is ever outside the spell's range or if it has total cover from you.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        casting_levels
          .map(level => {
            let damage = [#(level)d12]
            if level > 0 [
              #at_casting_level(level) *#damage* lighting damage
            ]
          })
          .join(linebreak())
      }
    ),
  ),
  "Mind Spike": (
    level: 2,
    burst_sustained: "burst",
    offense_defense: "defense",
    school: "divination",
    cast_time: "1 action",
    range: "60 feet",
    components: ("S",),
    duration: "Concentration, up to 1 hour",
    text: [
      You reach into the mind of one creature you can see within range.
      The target must make a Wisdom saving throw, taking *3d8* psychic damage on a failed save, or half as much damage on a successful one.
      On a failed save, you also always know the target's location until the spell ends, but only while the two of you are on the same plane of existence.
      While you have this knowledge, the target can't become hidden from you, and if it's invisible, it gains no benefit from that condition against you.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        casting_levels
          .map(level => {
            let damage = [#(calc.max(3, level))d8]
            if level > 0 [
              #at_casting_level(level) *#damage* psychic damage
            ]
          })
          .join(linebreak())
      }
    ),
  ),
  "Shadow Blade": (
    level: 2,
    burst_sustained: "sustained",
    offense_defense: "defense",
    school: "illusion",
    cast_time: "1 action",
    range: "Self",
    components: ("V", "S"),
    duration: "Concentration, up to 1 minute",
    text: [
      You weave together threads of shadow to create a sword of solidified gloom in your hand.
      This magic sword lasts until the spell ends.
      It counts as a single mele weapon with which you are proficient.
      It details *2d8* psychic damage on a hit and has the finesse, light, and thrown properties (range 20/60).
      In addition, when you use the sword to attack a target that is in dim light or darkness, you make the roll with advantage.
      If you drop the weapon or throw it, it dissipates at the end of the turn.
      Thereafter, while the spell persists, you can use a bonus action to cause the sword to reappear in your hand.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        casting_levels
          .map(level => {
            let multiplier = if level >= 5 {
              4
            } else if level >= 3 {
              3
            } else {
              2
            }
            if level > 0 [
              #at_casting_level(level) *#(multiplier)d8* psychic damage
            ]
          })
          .join(linebreak())
      }
    ),
  ),
  "Counterspell": (
    level: 3,
    burst_sustained: "burst",
    offense_defense: "defense",
    school: "abjuration",
    cast_time: "1 reaction, when you take when you see a creature in range casting a spell",
    range: "60 feet",
    components: ("S",),
    duration: "Instantaneous",
    text: [
      You attempt to interrupt a creature in the process of casting a spell.
      If the creature is casting a spell of *#suffix_th(3)* level or lower, its spell fails and has no effect.
      If it is casting a spell of #suffix_th(4) level or higher, make an ability check using your spellcasting ability.
      The DC is 10 + the spell's level.

      On a success, the creature's spell fails and has no effect.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        casting_levels
          .map(level => {
            if level > 0 [
              #at_casting_level(level) *#suffix_th(calc.max(3, level))* level or lower spells fail
            ]
          })
          .join(linebreak())
      }
    ),
  ),
  "Enemies Abound": (
    level: 3,
    burst_sustained: "sustained",
    offense_defense: "offense",
    school: "enchantment",
    cast_time: "1 action",
    range: "120 feet",
    components: ("V", "S"),
    duration: "Concentration, up to 1 minute",
    text: [
      You reach into the mind of one creature you can see and force it to make an Intelligence saving throw.
      A creature automatically succeeds if it is immune to being frightened.
      On a failed save, the target loses the ability to distinguish friend from foe, regarding all creatures it can see as enemies until the spell ends.
      Each time the target takes damage, it can repeat the saving throw, ending the effect on itself on a success.

      Whenever the affected creature chooses another creature as a target, it must choose the target at random amond the creatures it can see within range of the attack, spell, or other ability it's using.
      If an enemy provokes an opportunity attack from the affected creature, the creature must make that attack if it is able to.
    ],
  ),
  "Fear": (
    level: 3,
    burst_sustained: "sustained",
    offense_defense: "offense",
    school: "illusion",
    cast_time: "1 action",
    range: "Self (30-foot cone)",
    components: ("V", "S", "M (white feather or the heart of a hen"),
    duration: "Concentration, up to 1 minute",
    text: [
      You project a phantasmal image of a creature's worst fears.
      Each creature in a 30-foot cone must succeed on a Wisdom saving throw or drop whatever it is holding and become frightened for the duration.
      While frightened by this spell, a creature must take the Dash action and move away from you by the safest available route on each of its turns, unless there is nowhere to move.
      If the creature ends its turn in a location where it doesn't have line of sight to you, the creature can make a Wisdom saving throw.
      On a successful save, the spell ends for that creature.
    ],
  ),
  "Summon Lesser Demons": (
    level: 3,
    burst_sustained: "sustained",
    offense_defense: "offense",
    school: "conjuration",
    cast_time: "1 action",
    range: "60 feet",
    components: (
      "V",
      "S",
      "M (a vial of blood from a humanoid killed within the past 24 hours)",
    ),
    duration: "Concentration, up to 1 hour",
    text: [
      You utter foul words, summoning demons from the chaos of the Abyss.
      Roll a *d6* to determine what appears:
      - 1-2: Two demons of challenge rating 1 or lower
      - 3-4: Four demons of challenge rating 1/2 or lower
      - 5-6: Eight demons of challenge rating 1/4 or lower

      The DM chooses the demons, such as manes or dretches, and you choose the unoccupied spaces you can see within range where they appear.
      A summoned demon disappears when it drops to 0 hit points or when the spell ends.

      The demons are hostile to all creatures, including you.
      Roll initiative for the summoned demons as a group, which has its own turns.
      The demons pursue and attack the nearest non-demons to the best of their ability.

      As part of casting the spell, you can form a circle on the ground with the blood used as a material component.
      The circle is large enough to compass your space.
      While the spell lasts, the summoned demons can't cross the circle or harm it, and they can't target anyone with it.
      Using the material component in this manner consumes it when the spell ends.
    ],
    text_fn: (
      (player_level: 0, casting_levels: 0) => {
        casting_levels
          .map(level => {
            if level >= 8 [
              #at_casting_level(level) summon *three times* as many demons
            ] else if level >= 7 [
              #at_casting_level(level) summon *twice* as many demons
            ] else []
          })
          .join(linebreak())
      }
    ),
  ),
  "Dream": (
    level: 5,
    burst_sustained: "sustained",
    offense_defense: "offense",
    school: "illusion",
    cast_time: "1 minute",
    range: "special",
    components: (
      "V",
      "S",
      "M (a handful of sand, a dab of ink, and a writing quill plucked from a sleeping bird)",
    ),
    duration: "8 hours",
    text: [
      This spell shapes a creature's dreams.
      Choose a creature known to you as the target of this spell.
      The target must be on the same plane of existenence as you.
      Creatures that don't sleep, such as elves, can't be contacted by this spell.
      You, or a willing creature you touch, enters a trance state, acting as a messenger.
      While in the trance, the messenger is aware of their surroundings, but can't take actions or move.

      If the target is asleep, the messenger appears in the target's dreams and can converse with the target as long as it remains asleep, through the duration of the spell.
      The messenger can also shape the environment of the dream, creating landscapes, objects, and other images.
      The messenger can emerge from the trance at any time, ending the effect of the spell early.
      The target recalls the dream perfectly upon waking.
      If the target is awake when you cast the spell, the messenger knows it, and can either end the trance (and the spell) or wait for the target to fall asleep, at which point the messenger appears in the target's dreams.

      You can make the messenger appear monstrous and terrifying to the target.
      If you do, the messenger can deliver a message of no more than ten words and then the target must make a Wisdom saving throw.
      On a failed save, echoes of the phantasmal monstrosity spawn a nightmare that lasts the duration of the target's sleep and prevents the target from gaining any benefit from that rest.
      In addition, when the target wakes up, it takes *3d6* psychic damage.

      If you have a body part, lock of hair, clipping from a nail, or similar portion of the target's body, the target makes its saving throw with disadvantage.
    ],
  ),
  "Evard's Black Tentacles": (
    level: 4,
    burst_sustained: "sustained",
    offense_defense: "offense",
    school: "conjuration",
    cast_time: "1 action",
    range: "90 feet",
    components: (
      "V",
      "S",
      "M (a piece of tentacle from a giant octopus or a giant squid",
    ),
    duration: "Concentration, up to 1 minute",
    text: [
      Squirming, ebony tentacles fill a 20-foot square on ground that you can see within range.
      For the duration, these tentacles turn the ground in the area into difficult terrain.

      When a creature enteres the affected area for the first time on a turn or starts its turn there, the creature must succeed on a Dexterity saving throw or take *3d6* bludgeoning damage and be restrained by the tentacles until the spell ends.
      A creature that starts its turn in the area and is already restrained by the tentacles takes *3d6* bludgeoning damage.

      A creature restrained by the tentacles can use its action action to make a Strength or Dexterity check (its choice) against your spell save DC.
      On a success, it frees itself.
    ],
  ),
  "Dimension Door": (
    level: 4,
    burst_sustained: "burst",
    offense_defense: "defense",
    school: "conjuration",
    cast_time: "1 action",
    range: "500 feet",
    components: ("V",),
    duration: "Instantaneous",
    text: [
      You teleport yourself from your current location to any other spot within range.
      You arrive at exactly the spot desired.
      It can be a place you can see, one you can visualize, or one you can describe by stating distance and direction, such as "200 feet straight downward" or "upward to the northwest at a 45-degree angle, 300 feet".

      You can bring along objects as long as their weight doesn't exceed what you can carry.
      You can also bring one willing creature of your size or smaller who is carrying gear up to its carrying capacity.
      The creature must be within 5 feet of you when you cast this spell.

      If you would arrive in a place already occupied by an object or a creature, you and any creature traveling with you each take *4d6* force damage, and the spell fails to teleport you.
    ],
  ),
  "Finger of Death": (
    level: 7,
    burst_sustained: "burst",
    offense_defense: "offense",
    school: "necromancy",
    cast_time: "1 action",
    range: "60 feet",
    components: ("V", "S"),
    duration: "Instantaneous",
    text: [
      You send negative energy coursing through a creature that you can see within range, causing it searing pain.
      The target must make a Constitution saving throw.
      It takes *7d8 + 30* necrotic damage on a failed save, or half as much damage on a successful one.

      A humanoid killed by this spell rises at the start of your next turn as a zombie that is permanently under your command, following your verbal orders to the best of its ability.
    ],
  ),
  "TEMPLATE": (
    level: 0,
    school: "",
    cast_time: "",
    range: "",
    components: ("",),
    duration: "",
    text: [
      TODO
    ],
    // NOTE: remove if empty
    // text_fn: (
    //   (player_level: 0, casting_levels: 0) => {
    //     // PICK ONE OF:
    //     if player_level > 0 [
    //       #at_player_level(player_level) TODO
    //     ]
    //     casting_levels
    //       .map(level => {
    //         if level > 0 [
    //           #at_casting_level(level) TODO
    //         ]
    //       })
    //       .join(linebreak())
    //   }
    // ),
  ),
)
