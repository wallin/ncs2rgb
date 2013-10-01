#= require jquery/jquery
#= require convert

$('.ncs input').keydown (e) ->
  return true unless e.keyCode in [38, 40] and @selectionStart?
  ncs = try
    parseNcs($(@).val())
  catch e

  return true unless ncs

  sign = if e.keyCode is 38 then 1 else -1
  caret = @selectionStart
  pos = switch caret
    when 0, 1 then 0
    when 2, 3 then 1
    when 6, 7 then 3
    else null

  newVal = (Math.ceil(ncs[pos]/5.0) * 5) + 5*sign
  newVal = 99 if newVal >= 100
  if pos? and 0 <= newVal < 100
    ncs[pos] = newVal

  $(@).val(ncs2string(ncs))
  @setSelectionRange(caret, caret)

  e.preventDefault()
  return false

setHash = do ->
  timer = null
  set = ->
    c1 = $('#main input').val()
    c2 = $('#second input').val()
    return unless c1
    hash = if $('body').hasClass('compare') and c2 then "#{c1}/#{c2}" else c1
    window.location.hash = hash
  (time = 1000)->
    clearTimeout timer
    timer = setTimeout set, time


$.fn.setColor = ->
  input = $(@).val()
  return if input.length < 6
  $sheet = $(@).closest('.sheet')
  $warning = $sheet.find('.warning')
  try
    hsv = ncs2hsv input
    rgb = hsv2rgb.apply window, hsv
    hex = dec2hex.apply(window, rgb)
    $sheet
    .toggleClass('dark', hsv[2] < 60)
    .css('background-color': "##{hex.join('')}")
    $warning.hide()
    setHash()
  catch e
    $warning.show()

$('.ncs input').keyup ->
  $(@).setColor()

$(window).bind 'hashchange', (val) ->
  colors = window.location.hash.replace('#', '').split('/')
  return unless colors[0]
  $field1 = $('#main input')
  $field2 = $('#second input')
  $('body').toggleClass('compare', !!colors[1])
  return if colors[0] is $field1.val() and colors[1] is $field2.val()
  $field1.val(colors[0]).setColor()
  $field2.val(colors[1]).setColor() if colors[1]


$('.toggle').click ->
  $('body').toggleClass('compare')
  setHash(0)

# Calculate initial input
$('.ncs input').keyup()
$(window).trigger 'hashchange'
