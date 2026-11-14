// Common symbols needed in both the main sheet and the character-specific files

#let ballot-o = box(rect(height: 1em, width: 1em))

#let ballot-x = box({
  ballot-o
  place(center + horizon, dy: -0.1em)[#str.from-unicode(0x00D7)]
})

#let ballots(count: 1, used: 0) = {
  [
    #while count > 0 {
      count = count - 1
      if used > count { ballot-x } else { ballot-o }
    }
  ]
}
