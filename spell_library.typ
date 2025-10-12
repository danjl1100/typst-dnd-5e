#let spell_library = (
  "Eldritch Blast": (
    level: 0,
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
      player_level => [
        #let beams_num = if player_level >= 17 {
          4
        } else if player_level >= 11 {
          3
        } else if player_level >= 5 {
          2
        } else {
          1
        }
        #let beams = if beams_num == 1 [beam] else [beams]
        At #player_level level: #beams_num #beams of crackling energy
      ]
    ),
  ),
  "Mind Sliver": (
    level: 0,
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
      player_level => [
        #let damage = if player_level >= 17 {
          [4d6]
        } else if player_level >= 11 {
          [3d6]
        } else if player_level >= 5 { [2d6] } else { [1d6] }
        At #player_level level: *#damage* psychic damage
      ]
    ),
  ),
  "Toll The Dead": (
    level: 0,
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
      player_level => [
        #let damage = if player_level >= 17 {
          [4d8 or 4d12]
        } else if player_level >= 11 {
          [3d8 or 3d12]
        } else if player_level >= 5 {
          [2d8 or 2d12]
        } else {
          [1d8 or 1d12]
        }
        At #player_level level: *#damage* necrotic damage
      ]
    ),
  ),
  "Polymorph": (
    level: 6,
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
  // "Circle of Death": (
  //   level: 6,
  // ),
)
