wordCounter = word:(word space?)* { return word.length }
word = letter+

letter = [a-zA-Z0-9]

space = [ \t\n\r]*