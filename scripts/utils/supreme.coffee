convertToSupremeSize = (sizeShortHand) ->

  sizeShortHand = sizeShortHand.toLowerCase() if sizeShortHand
  mapping =
    s: 'Small'
    m: 'Medium'
    l: 'Large'
    xl: 'XLarge'

  supremeSize = mapping[sizeShortHand]
  unless supremeSize
    throw new Error "You must choose size in #{Object.keys mapping}"

  return mapping[sizeShortHand]

module.exports =
  convertToSupremeSize: convertToSupremeSize
