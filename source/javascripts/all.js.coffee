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

$('.ncs input').keyup ->
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
  catch e
    $warning.show()


$('.toggle').click -> $('body').toggleClass('compare')

# Calculate initial input
$('.ncs input').keyup()