#let dnd = smallcaps("Dungeons & Dragons")
#set page(header: align(right, [
  #dnd
]), margin: 3em)
#set text(font: "New Computer Modern")

// Base stats (10 = normal)
#let strength = 14
#let dexterity = 9
#let constitution = 13
#let intelligence = 8
#let wisdom = 16
#let charisma = 18
// Proficiency bonus (e.g. 2 for +2)
#let proficiency_bonus = 2
// Center stat block
#let armor_class = 18
#let initiative = 2
#let speed = 30
// Proficiency (true/false) for Saving Throws
#let prof_save_strength = true
#let prof_save_dexterity = false
#let prof_save_constitution = false
#let prof_save_intelligence = false
#let prof_save_wisdom = false
#let prof_save_charisma = true
// Proficiency (true/false) for Skills
#let prof_skill_acrobatics = true
#let prof_skill_animal = false
#let prof_skill_arcana = true
#let prof_skill_athletics = true
#let prof_skill_deception = false
#let prof_skill_history = false
#let prof_skill_insight = false
#let prof_skill_intimidation = true
#let prof_skill_investigation = false
#let prof_skill_medicine = false
#let prof_skill_nature = false
#let prof_skill_perception = true
#let prof_skill_performance = true
#let prof_skill_persuasion = true
#let prof_skill_religion = false
#let prof_skill_sleight_of_hand = false
#let prof_skill_stealth = true
#let prof_skill_survival = false

#let caption(label) = [
  #set text(6pt, weight: "extrabold")
  #label
]

#grid(columns: (2fr, 3fr), rect(width: 100%, [
  #align(top)[
    TODO

    #caption[CHARACTER NAME]
  ]
]), rect(width: 100%, [
  #grid(columns: (1fr, 1fr, 1fr), [
    TODO

    #caption[CLASS & LEVEL]
  ], [
    TODO

    #caption[BACKGROUND]
  ], [
    TODO

    #caption[PLAYER NAME]
  ])
  #grid(columns: (1fr, 1fr, 1fr), [
    TODO

    #caption[RACE]
  ], [
    TODO

    #caption[ALIGNMENT]
  ], [
    TODO

    #caption[EXPERIENCE POINTS]
  ])
]))

#let modifier_num(stat, proficient) = calc.floor((stat - 10) / 2) + (if proficient { 1 } else { 0 })
#let modifier_fmt(modifier) = if modifier > 0 [+#modifier] else [#modifier]
#let modifier(stat, proficient) = box(modifier_fmt(modifier_num(stat, proficient)))

#let big_number(content) = [
  #text(1.4em, content)
  #v(0.6em, weak: true)
]

#let stat_box(label, stat) = rect(width: 100%, [
  #caption(label)

  #big_number(modifier(stat, false))
  (#stat)
])

#let skill_item(label, stat, proficient: false) = [
  #if proficient [$ballot.x$] else [$ballot$]
  #text(8pt, modifier(stat, proficient)) #caption(label)

]

#let stack_ltr_horizon(label, content) = [
  #stack(dir: ltr, spacing: 5pt, circle(
    inset: 0pt,
    outset: 0pt,
    align(horizon, modifier_fmt(proficiency_bonus)),
  ), align(horizon, caption([PROFICIENCY BONUS])))
]

#grid(
  columns: (1fr, 1fr, 1fr),
  // LEFT column - Stat column, and saving throws / skills column
  grid(
    columns: (1fr, 2fr),
    align(center)[
      #stat_box([STRENGTH], strength)
      #stat_box([DEXTERITY], dexterity)
      #stat_box([CONSTITUTION], constitution)
      #stat_box([INTELLIGENCE], intelligence)
      #stat_box([WISDOM], wisdom)
      #stat_box([CHARISMA], charisma)
    ],
    align(
      center,
    )[
      #rect(width: 100%, align(horizon, stack(
        dir: ltr,
        spacing: 5pt,
        rect(height: 1em, width: 1em),
        caption([INSPIRATION]),
      )))

      #rect(width: 100%, stack(dir: ltr, spacing: 5pt, circle(
        inset: 0pt,
        outset: 0pt,
        align(horizon, modifier_fmt(proficiency_bonus)),
      ), align(horizon, caption([PROFICIENCY BONUS]))))

      #rect(
        width: 100%,
        align(
          left,
          [
            #skill_item([Strength], strength, proficient: prof_save_strength)
            #skill_item([Dexterity], dexterity, proficient: prof_save_dexterity)
            #skill_item([Constitution], constitution, proficient: prof_save_constitution)
            #skill_item([Intelligence], intelligence, proficient: prof_save_intelligence)
            #skill_item([Wisdom], wisdom, proficient: prof_save_wisdom)
            #skill_item([Charisma], charisma, proficient: prof_save_charisma)

            #align(center, caption[SAVING THROWS])
          ],
        ),
      )

      #rect(
        width: 100%,
        align(
          left,
          [
            #skill_item([Acrobatics (Dex)], dexterity, proficient: prof_skill_acrobatics)
            #skill_item([Animal Handling (Wis)], wisdom, proficient: prof_skill_animal)
            #skill_item([Arcana (Int)], intelligence, proficient: prof_skill_arcana)
            #skill_item([Athletics (Str)], strength, proficient: prof_skill_athletics)
            #skill_item([Deception (Cha)], charisma, proficient: prof_skill_deception)
            #skill_item([History (Int)], intelligence, proficient: prof_skill_history)
            #skill_item([Insight (Wis)], wisdom, proficient: prof_skill_insight)
            #skill_item([Intimidation (Cha)], charisma, proficient: prof_skill_intimidation)
            #skill_item(
              [Investigation (Int)],
              intelligence,
              proficient: prof_skill_investigation,
            )
            #skill_item([Medicine (Wis)], wisdom, proficient: prof_skill_medicine)
            #skill_item([Nature (Int)], intelligence, proficient: prof_skill_nature)
            #skill_item([Perception (Wis)], wisdom, proficient: prof_skill_perception)
            #skill_item([Performance (Cha)], charisma, proficient: prof_skill_performance)
            #skill_item([Persuasion (Cha)], charisma, proficient: prof_skill_persuasion)
            #skill_item([Religion (Int)], intelligence, proficient: prof_skill_religion)
            #skill_item(
              [Sleight of Hand (Dex)],
              dexterity,
              proficient: prof_skill_sleight_of_hand,
            )
            #skill_item([Stealth (Dex)], dexterity, proficient: prof_skill_stealth)
            #skill_item([Survival (Wis)], wisdom, proficient: prof_skill_survival)

            #align(center, caption[SKILLS])
          ],
        ),
      )
    ],
  ),
  // MIDDLE column
  [
    #rect(width: 100%, align(center + horizon, [

      #grid(
        columns: (1fr, 1fr, 1fr),
        circle(width: 100%, inset: 0pt, align(center, [
          #big_number([#armor_class])
          #caption[ARMOR]

          #caption[CLASS]
        ])),
        rect(width: 100%, [
          #big_number[#initiative]
          #caption[INITIATIVE]
        ]),
        rect(width: 100%, [
          #big_number[#speed]
          #caption[SPEED]
        ]),
      )
      #v(5pt, weak: true)

      #rect(width: 100%, [
        #v(50pt)
        #caption[CURRENT HIT POINTS]
      ])

      #v(5pt, weak: true)

      #rect(width: 100%, [
        #v(50pt)
        #caption[TEMPORARY HIT POINTS]
      ])

      #grid(columns: (1fr, 1fr), rect(width: 100%, [
        TODO .

        #caption[HIT DICE]
      ]), rect(width: 100%, [
        #align(right, [
          #caption[SUCCESSES $ballot$ $ballot$ $ballot$]
          #caption[FAILURES $ballot$ $ballot$ $ballot$]
        ])
        #caption[DEATH SAVES]
      ]))
    ]))

    #rect(width: 100%, align(center, [
      TODO
      #v(75pt)
      #caption[ATTACKS & SPELLCASTING]
    ]))
  ],
)

== Content
#lorem(25)
