#= require jquery/jquery
#= require convert

$('.ncs input').keyup ->
  input = $(@).val()
  return if input.length < 6
  $sheet = $(@).closest('.sheet')
  $warning = $sheet.find('.warning')
  try
    hsv = ncs2hsv input
    rgb = hsv2rgb.apply window, hsv
    hex = dec2hex.apply(window, rgb)
    sum = 0
    sum += v for v in rgb
    $sheet
    .toggleClass('dark', sum < (255*3 / 2))
    .css('background-color': "##{hex.join('')}")
    $warning.hide()
  catch e
    $warning.show()


$('.toggle').click -> $('body').toggleClass('compare')

# Calculate initial input
$('.ncs input').keyup()