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
// Proficiency (true/false) for Saving Throws
#let prof_save_str = true
#let prof_save_dex = false
#let prof_save_con = false
#let prof_save_int = false
#let prof_save_wis = false
#let prof_save_cha = true
// Proficiency (true/false) for Skills
#let prof_skill_str = true
#let prof_skill_dex = false
#let prof_skill_con = true
#let prof_skill_int = true
#let prof_skill_wis = false
#let prof_skill_cha = false

= Character
#grid(columns: (2fr, 3fr), align(top)[
  CHARACTER NAME
], [
  #grid(columns: (1fr, 1fr, 1fr), [
    CLASS & LEVEL
  ], [
    BACKGROUND
  ], [
    PLAYER NAME
  ])
  #grid(columns: (1fr, 1fr, 1fr), [
    RACE
  ], [
    ALIGNMENT
  ], [
    EXPERIENCE POINTS
  ])
])

= Stats

#let caption(label) = [
  #set text(6pt, weight: "extrabold")
  #label
]
#let modifier_num(stat, proficient) = calc.floor((stat - 10) / 2) + (if proficient { 1 } else { 0 })
#let modifier_fmt(modifier) = if modifier > 0 [+#modifier] else [#modifier]
#let modifier(stat, proficient) = box(modifier_fmt(modifier_num(stat, proficient)))

#let stat_box(label, stat) = rect(width: 100%, [
  #caption(label)

  #text(1.4em, modifier(stat, false))
  #v(0.6em, weak: true)
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

#grid(columns: (1fr, 2fr, 3fr, 3fr), align(center)[
  #stat_box([STRENGTH], strength)
  #stat_box([DEXTERITY], dexterity)
  #stat_box([CONSTITUTION], constitution)
  #stat_box([INTELLIGENCE], intelligence)
  #stat_box([WISDOM], wisdom)
  #stat_box([CHARISMA], charisma)
], align(center)[
  #rect(width: 100%, stack(
    dir: ltr,
    spacing: 5pt,
    rect(height: 1em, width: 1em),
    caption([INSPIRATION]),
  ))

  #rect(width: 100%, stack(dir: ltr, spacing: 5pt, circle(
    inset: 0pt,
    outset: 0pt,
    align(horizon, modifier_fmt(proficiency_bonus)),
  ), align(horizon, caption([PROFICIENCY BONUS]))))

  #rect(width: 100%, align(left, [
    #skill_item([Strength], strength, proficient: prof_save_str)
    #skill_item([Dexterity], dexterity, proficient: prof_save_dex)
    #skill_item([Constitution], constitution, proficient: prof_save_con)
    #skill_item([Intelligence], intelligence, proficient: prof_save_int)
    #skill_item([Wisdom], wisdom, proficient: prof_save_wis)
    #skill_item([Charisma], charisma, proficient: prof_save_cha)

    #align(center, caption[SAVING THROWS])
  ]))
])

== Content
#lorem(25)
