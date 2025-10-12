#let title = (
  name: "Kaladan Grrrmmballhyst",
  class: "Warlock", // Pact of the Chain
  level: 13,
  race: "Dragonborn",
  background: "Charlatan",
  alignment: "Neutral Evil",
  player: "Daniel",
  experience: "",
)

// Base stats (10 = normal)
#let base_stats = (
  strength: 10,
  dexterity: 15,
  constitution: 15,
  intelligence: 8,
  wisdom: 9,
  charisma: 18,
)

// Proficiency (true/false) for Saving Throws
#let prof_save = (
  strength: false,
  dexterity: false,
  constitution: false,
  intelligence: false,
  wisdom: true,
  charisma: true,
)

// Proficiency (true/false) for Skills
#let prof_skill = (
  acrobatics: false,
  animal: false,
  arcana: true,
  athletics: false,
  deception: true,
  history: false,
  insight: false,
  intimidation: false,
  investigation: true,
  medicine: false,
  nature: false,
  perception: true,
  performance: false,
  persuasion: false,
  religion: true,
  sleight_of_hand: true,
  stealth: false,
  survival: false,
)

#let bonuses = (
  // Proficiency bonus (e.g. 2 for +2)
  proficiency: 5,
)

#let combat = (
  // Center stat block
  armor_class: 15, // Dragon Hide
  initiative: 2,
  speed: 30,
  swim: 40,
  movement_note: "breathe underwater",
  hit_point_maximum: 89,
  hit_point_temporary: 10, // daily
  hit_dice: "9x(1d8+2)",
)

#let attacks = (
  list: (
    (name: "Dagger", attack_bonus: "+6", damage: "1d4+2 piercing"),
    (name: "Claws", attack_bonus: "", damage: "1d4 slashing"),
  ),
  extra: [
    Number of Attacks: 1
    - *Breath Weapon* Poison, 15ft cone: 3d6 poison damage (DC16 CON save) OR frighten
    - *Wand of Fear* 7 charges, DC15 WIS 1. flee or grovel (command spell) OR 2. cone
      of fear (60ft cone) 1 min. Each day regain (1d6+1) charges
  ],
)

#let money = (gold: 107)

#let equipment = [
  - Armor of Resistance (Force), studded
  - Backpack
  - Bag of Sand
  - Book
  - Crystal
  - Disguise Kit
  - Forgery Kit
  - Ink
  - Ink pen
  - Knife, small
  - Parchment x10
  - Rope, silk
  - signal whistle
  - Kobald spellbook
  - Creepy Ring (Rolf)
  - "necklace" for Pain
  - antitoxin, poison
  - hand mirror, landscape
]

#let backstory = [
  Brass Metallic Dragon born

  Familiar is a shiny black Cobra that wraps around his shoulders like grotesque
  jewelry: *"Pain"*
]

#let once_per_long_rest = (
  [
    $ballot$ once per long rest
  ],
)

#let spell = (
  // which of `base_stats` to use for spellcasting ability modifier
  casting_levels: (5,),
  save_dc_ability: "charisma",
  slots: (
    (label: "5th Level Spell Slot", count: 3),
    (label: "Polymorph"),
    (label: "Evard's Tentacles"),
    (label: "Circle of Death"),
    (label: "Finger of Death"),
  ),
  cast_by_slot: (
    "Eldritch Blast",
    "Mind Sliver",
    "Toll the Dead",
    "Witch Bolt",
    "Mind Spike",
    "Shadow Blade",
    "Counterspell",
    "Enemies Abound",
    "Fear",
    "Summon Lesser Demons",
    "Dream",
    "Dimension Door",
  ),
  cast_by_feat: (
    "Evard's Black Tentacles": once_per_long_rest,
    "Polymorph": once_per_long_rest,
    "Circle of Death": once_per_long_rest,
    "Finger of Death": once_per_long_rest,
  ),
)

#let features_and_traits = [
  Damage Resistances: force, poison

  === The Fathomless (TCE-072)
  - Patron is the Sea and Unknown Depths
  - Warlock - regain all spell slots after long *or short rest*

  === Pact of the Chain (PHB-107)
  - Find Familiar (Shiny black Cobra) is cast
  - Substitute my attack for Familiar's attack, my reaction for Familiar's reaction

  === Evocations
  - Gift of the Ever-Living ones (XGE-057)
    - if regaining HP within 100ft of familiar, always roll the max amount
  - Investment of the Chain Master (TCE-071)
    - Bonus Action: familiar attack.
    - Use my reaction to give my familiar resistance to an attack
    - If familiar faces a saving throw, use my spell save DC
  - Voice of the Chain Master (PHB-111)
    - Telepathy with familiar, senses (in the same plane) and speak my voice through them (NOT spell casting)
  - Feat: Dragon Fear (XGE-074)
    - Angered -> radiate *MENACE*: +1 to either STR or CONS or CHAR (max 20)
    - Frightened if roar... (see XGE-074)

  - Sculptor of Flesh
    - Cast *Polymorph* once using a warlock spell slot, Once per long rest $ballot$
]
