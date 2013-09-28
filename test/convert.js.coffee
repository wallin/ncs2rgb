describe "Convert", ->
  describe 'ncs2rgb', ->
    it 'converts 0510-G98Y to 119, 10, 95', ->
      expect(ncs2hsv('0510-G98Y')).toEqual [119, 10, 95]

    it 'converts 0510-G to 119, 10, 95', ->
      expect(ncs2hsv('0510-G')).toEqual [120, 10, 95]

    it 'converts 1560-Y40G to 96, 60, 85', ->
      expect(ncs2hsv('1560-Y40G')).toEqual [96, 60, 85]

    it 'converts 1500-N to 0, 0, 85', ->
      expect(ncs2hsv('1500-N')).toEqual [0, 0, 85]

    it 'throws an error for 18240-Y58G', ->
      fn = -> ncs2hsv('18240-Y58G')
      expect(fn).toThrow()

  describe 'hsv2rgb', ->
    it 'converts [96, 60, 85] to [139, 217, 87]', ->
      expect(hsv2rgb(96, 60, 85)).toEqual([139, 217, 87])


  describe 'dec2hex', ->
    it 'converts [139, 217, 87] to [8b, d9, 57]', ->
      expect(dec2hex.apply(window, [139, 217, 87])).toEqual ['8b', 'd9', '57']
