ncsRegex = /^(\d{2})(\d{2})\-([bgryn])(\S*)/i
ncsRegexHue = /(\d{2})([bgry])/i

hueMap =
  r: 0
  y: 60
  g: 120
  b: 240

window.parseNcs = (input) ->
  input = input.toLowerCase()
  throw('Invalid NCS') unless parts = input.toLowerCase().match ncsRegex
  [v, s, p1, rest] = parts[1..]
  if rest
    if huePart = rest.match ncsRegexHue
      [h, p2] = huePart[1..]
    else
      throw('Invalid NCS')

  [
    parseInt(v, 10)
    parseInt(s, 10)
    p1
    parseInt(h, 10)
    p2
  ]

window.ncs2string = (ncs) ->
  rv = [
    zeroPad(ncs[0])
    zeroPad(ncs[1])
    '-'
    ncs[2].toUpperCase()
  ]
  if ncs[3]? and ncs[4]?
    rv.push(zeroPad(ncs[3]), ncs[4].toUpperCase())
  rv.join('')

window.ncs2hsv = (input) ->
  [v, s, p1, h, p2] = parseNcs(input)

  if p1 is 'n'
    s = 0
  v = 100 - v

  if p1 and p2
    h = parseInt(h, 10) / 100
    p1 = hueMap[p1]
    p2 = hueMap[p2]
    h = Math.round(p1*h + p2*(1-h))
  else if p1 isnt 'n'
    h = hueMap[p1]
  else
    h = 0

  [h, s, v]

# http://axonflux.com/handy-rgb-to-hsl-and-rgb-to-hsv-color-model-c
window.hsv2rgb = (h, s, v) ->
  h /= 360
  s /= 100
  v /= 100
  i = Math.floor(h * 6)
  f = h * 6 - i
  p = v * (1 - s)
  q = v * (1 - f * s)
  t = v * (1 - (1 - f) * s)
  switch i % 6
    when 0
      r = v
      g = t
      b = p
    when 1
      r = q
      g = v
      b = p
    when 2
      r = p
      g = v
      b = t
    when 3
      r = p
      g = q
      b = v
    when 4
      r = t
      g = p
      b = v
    when 5
      r = v
      g = p
      b = q
  [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)]

window.zeroPad = (number) ->
  number = number + ""
  if number.length is 1 then "0#{number}" else "#{number}"

window.dec2hex = (numbers...) ->
  for c in numbers
    zeroPad(c.toString(16))

