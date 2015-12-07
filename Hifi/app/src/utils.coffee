Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

window.toDashedName = (name) ->
  removeDiacritics(name.toLowerCase()).replace(/\W+/g, " ").replace(/\s+/g, '-')
