#import "kal.typ": (
  attacks,
  backstory,
  base_stats,
  bonuses,
  combat,
  equipment,
  features_and_traits,
  money,
  prof_save,
  prof_skill,
  spell,
  title,
)

#import "spell_library.typ": spell_library

#let dnd = smallcaps("Dungeons & Dragons")
#set page(
  header: align(right, [
    #dnd
  ]),
  margin: 3em,
)
#set text(font: "New Computer Modern")

#let caption(label) = [
  #set text(6pt, weight: "extrabold")
  #label
]

#grid(
  columns: (2fr, 3fr),
  rect(width: 100%, [
    #align(top)[
      #title.name

      #caption[CHARACTER NAME]
    ]
  ]),
  rect(width: 100%, [
    #grid(
      columns: (1fr, 1fr, 1fr),
      [
        #title.class (Level #title.level)

        #caption[CLASS & LEVEL]
      ],
      [
        #title.race

        #caption[BACKGROUND]
      ],
      [
        #title.player

        #caption[PLAYER NAME]
      ],
    )
    #grid(
      columns: (1fr, 1fr, 1fr),
      [
        #title.race

        #caption[RACE]
      ],
      [
        #title.alignment

        #caption[ALIGNMENT]
      ],
      [
        #title.experience

        #caption[EXPERIENCE POINTS]
      ],
    )
  ]),
)

#let modifier_num(stat, proficient) = (
  calc.floor((stat - 10) / 2)
    + (if proficient { bonuses.proficiency } else { 0 })
)
#let modifier_fmt(modifier) = if modifier > 0 [+#modifier] else [#modifier]
#let modifier(stat, proficient) = box(modifier_fmt(modifier_num(
  stat,
  proficient,
)))
#let spell_save_dc = (
  8 + modifier_num(base_stats.at(spell.save_dc_ability), true)
)

#let big_number(content) = [
  #text(1.4em, content)
  #v(0.6em, weak: true)
]

#let stat_box(label, stat) = rect(width: 100%, [
  #caption(label)

  #box(height: 16pt, width: 100%, {
    big_number(modifier(stat, false))
  })
  (#stat)
])

#let skill_based_item(label, stat, proficient, sub_label: []) = {
  let ballot-x = box({
    $ballot$
    place(center + horizon, dy: -0.1em)[#str.from-unicode(0x00D7)]
  })
  (
    if proficient [#ballot-x] else [$ballot$],
    [
      #set text(8pt, weight: "regular")
      #modifier(base_stats.at(stat), proficient)
    ],
    [
      #set text(8pt, weight: "regular")
      #label
      #sub_label
    ],
  )
}
#let saving_throw_item(stat) = {
  let stat_labels = (
    strength: "Strength",
    dexterity: "Dexterity",
    constitution: "Constitution",
    intelligence: "Intelligence",
    wisdom: "Wisdon",
    charisma: "Charisma",
  )
  skill_based_item(stat_labels.at(stat), stat, prof_save.at(stat))
}
#let skill_item(skill, stat) = {
  let skill_labels = (
    acrobatics: "Acrobatics",
    animal: "Animal Handling",
    arcana: "Arcana",
    athletics: "Athletics",
    deception: "Deception",
    history: "History",
    insight: "Insight",
    intimidation: "Intimidation",
    investigation: "Investigation",
    medicine: "Medicine",
    nature: "Nature",
    perception: "Perception",
    performance: "Performance",
    persuasion: "Persuasion",
    religion: "Religion",
    sleight_of_hand: "Sleight of Hand",
    stealth: "Stealth",
    survival: "Survival",
  )
  let sub_labels = (
    strength: "Str",
    dexterity: "Dex",
    constitution: "Con",
    intelligence: "Int",
    wisdom: "Wis",
    charisma: "Cha",
  )
  skill_based_item(
    skill_labels.at(skill),
    stat,
    prof_skill.at(skill),
    sub_label: caption([
      (#sub_labels.at(stat))
    ]),
  )
}

// TODO was this meant to be generic?
#let stack_ltr_horizon(label, content) = [
  #stack(
    dir: ltr,
    spacing: 5pt,
    circle(inset: 0pt, outset: 0pt, align(horizon, modifier_fmt(
      proficiency_bonus,
    ))),
    align(horizon, caption([PROFICIENCY BONUS])),
  )
]

#let fmt_money(label, key) = [
  #caption[#label]
  #money.at(key, default: [])
]

#grid(
  columns: (1fr, 1fr, 1fr),
  // LEFT column - Stat column, and saving throws / skills column
  grid(
    columns: (1fr, 2fr),
    align(center)[
      #stat_box([STRENGTH], base_stats.strength)
      #stat_box([DEXTERITY], base_stats.dexterity)
      #stat_box([CONSTITUTION], base_stats.constitution)
      #stat_box([INTELLIGENCE], base_stats.intelligence)
      #stat_box([WISDOM], base_stats.wisdom)
      #stat_box([CHARISMA], base_stats.charisma)
    ],
    align(center)[
      #rect(width: 100%, align(horizon, stack(
        dir: ltr,
        spacing: 5pt,
        rect(height: 1em, width: 1em),
        caption([INSPIRATION]),
      )))

      #rect(width: 100%, stack(
        dir: ltr,
        spacing: 5pt,
        circle(inset: 0pt, outset: 0pt, align(horizon, modifier_fmt(
          bonuses.proficiency,
        ))),
        align(horizon, caption([PROFICIENCY BONUS])),
      ))

      #rect(width: 100%, [
        #grid(
          columns: (auto, auto, 1fr), align: (left, right, left), inset: 1pt,
          row-gutter: 5pt,
          ..(
            saving_throw_item("strength"),
            saving_throw_item("dexterity"),
            saving_throw_item("constitution"),
            saving_throw_item("intelligence"),
            saving_throw_item("wisdom"),
            saving_throw_item("charisma"),
          ).flatten()
        )

        #align(center, caption[SAVING THROWS])
      ])

      #rect(width: 100%, [
        #grid(
          columns: (auto, auto, 1fr), align: (
            left,
            right,
            left,
          ), // middle column right-aligned
          inset: 1pt,
          row-gutter: 5pt,
          ..(
            skill_item("acrobatics", "dexterity"),
            skill_item("animal", "wisdom"),
            skill_item("arcana", "intelligence"),
            skill_item("athletics", "strength"),
            skill_item("deception", "charisma"),
            skill_item("history", "intelligence"),
            skill_item("insight", "wisdom"),
            skill_item("intimidation", "charisma"),
            skill_item("investigation", "intelligence"),
            skill_item("medicine", "wisdom"),
            skill_item("nature", "intelligence"),
            skill_item("perception", "wisdom"),
            skill_item("performance", "charisma"),
            skill_item("persuasion", "charisma"),
            skill_item("religion", "intelligence"),
            skill_item("sleight_of_hand", "dexterity"),
            skill_item("stealth", "dexterity"),
            skill_item("survival", "wisdom"),
          ).flatten()
        )

        #align(center, caption[SKILLS])
      ])
    ],
  ),
  // MIDDLE column
  [
    #rect(width: 100%, align(center + horizon, [

      #grid(
        columns: (1fr, 1fr, 1fr),
        circle(width: 100%, inset: 0pt, align(center, [
          #big_number([#combat.armor_class])
          #caption[ARMOR]
          #linebreak()
          #caption[CLASS]
        ])),
        rect(width: 100%, [
          #big_number(modifier_fmt(combat.initiative))
          #caption[INITIATIVE]
        ]),
        rect(width: 100%, [
          #big_number[#combat.speed]
          #caption[SPEED]
        ]),
        grid.cell(colspan: 2, rect(width: 100%, [
          #combat.movement_note
        ])),
        rect(width: 100%, [
          #caption[SWIM] #combat.swim
        ]),
      )
      #v(5pt, weak: true)

      #rect(width: 100%, [
        #caption[Hit point maximum: #combat.hit_point_maximum]

        #align(left, [#(combat.hit_point_maximum + combat.hit_point_temporary)])
        #v(20pt)
        #caption[CURRENT HIT POINTS]
      ])

      #v(5pt, weak: true)

      #rect(width: 100%, [
        #align(left, [#combat.hit_point_temporary])

        #caption[TEMPORARY HIT POINTS]
      ])

      #grid(
        columns: (1fr, 1fr),
        rect(width: 100%, [
          #combat.hit_dice

          #caption[HIT DICE]
        ]),
        rect(width: 100%, [
          #align(right, [
            #caption[SUCCESSES $ballot$ $ballot$ $ballot$]
            #caption[FAILURES $ballot$ $ballot$ $ballot$]
          ])
          #caption[DEATH SAVES]
        ]),
      )
    ]))

    #rect(
      width: 100%,
      align(
        center,
        [
          #grid(
            columns: 3, stroke: 0.5pt, inset: 5pt, caption([*NAME*]), caption([*ATK*]), caption([*DAMAGE/TYPE*]), ..(
              attacks
                .list
                .map(row => ([*#row.name*], row.attack_bonus, row.damage))
                .flatten()
            ),
          )

          #align(left, attacks.extra)
          #caption[ATTACKS & SPELLCASTING]
        ],
      ),
    )

    #rect(width: 100%, [
      #fmt_money("CP", "copper")

      #fmt_money("SP", "silver")

      #fmt_money("EP", "electrum")

      #fmt_money("GP", "gold")

      #fmt_money("PP", "platinum")

      #align(center, [
        #caption[TREASURE]
      ])
    ])
  ],
  // RIGHT column
  [
    #rect(width: 100%, [
      Spell Save DC: #spell_save_dc

      #for slot in spell.slots [
        #let (label, count) = slot
        #label
        #while count > 0 {
          count = count - 1
          $ballot$
        }

      ]

      #align(center, [#caption[SPELL SLOTS]])
    ])
    #rect(width: 100%, [
      #equipment
      #align(center, [#caption[EQUIPMENT]])
    ])
    #rect(width: 100%, [
      #backstory
      #align(center, [#caption[CHARACTER BACKSTORY]])
    ])
  ],
)


#set page(header: [])
#pagebreak()

== Features and Traits
#features_and_traits

#pagebreak()

#set page(columns: 2)

#place(top + center, scope: "parent", float: true, [
  == Spellbook
])

#let lookup_spell(name) = {
  let spell_elem = spell_library.at(name)
  spell_elem.name = name
  spell_elem
}
#let render_spell(s, extras: ()) = {
  let (
    name,
    level,
    school,
    cast_time,
    range,
    components,
    duration,
    text,
  ) = s
  [
    #grid(
      columns: 2,
      row-gutter: 5pt,
      column-gutter: 2pt,
      grid.cell(colspan: 2, [
        === *#name* #emph[level #level - #school]
      ]),
      ..extras.map(c => grid.cell(colspan: 2, c)),
      [Casting Time:], cast_time,
      [Range:], range,
      [Components:], components.join(", "),
      [Duration:], duration,
      grid.cell(colspan: 2, [
        #text
        #linebreak()
        #if "text_fn" in s {
          s.at("text_fn")(
            player_level: title.level,
            casting_levels: spell.casting_levels,
          )
        } else []
      ]),
    )
  ]
}

#if "cast_by_slot" in spell {
  let spells_by_level = (:)
  for name in spell.cast_by_slot {
    let spell_elem = lookup_spell(name)
    let level = str(spell_elem.level) // key must be a string
    if level not in spells_by_level { spells_by_level.insert(level, ()) }
    spells_by_level.at(level).push(spell_elem)
  }
  for (level, spell_elems) in spells_by_level
    .pairs()
    .sorted(key: p => p.at(0)) {
    if level == "0" {
      [== *Cantrips*]
    } else {
      [== *Level #level*]
    }
    spell_elems
      .sorted(key: p => p.name)
      .map(render_spell)
      .join([

      ])
  }
}

#if "cast_by_feat" in spell {
  pagebreak()
  [== *Spells from Features*]
  for (name, conditions) in spell.cast_by_feat [
    #render_spell(lookup_spell(name), extras: conditions)
  ]
}

== Content
#lorem(25)
