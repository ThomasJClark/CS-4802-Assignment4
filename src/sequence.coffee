# sequence.coffee
# Renders a sequence of letters as colored rectangles.
a4 = a4 ? {}
a4.sequence = (container) ->
  width = 100
  height = 20
  data = []

  xScale = d3.scale.linear()
  colorScale = d3.scale.category20()
    .domain ['A', 'D', 'E', 'F', 'G', 'H', 'I', 'K', 'L', 'M', 'N', 'P', 'Q',
             'R', 'S', 'T', 'V', 'W', 'Y']


  my = () ->
    xScale.domain [0, data.length]
          .range [0, width]

    entries = (container.selectAll '.sequence-entry').data data
    entries.exit().remove()
    entries.enter().append 'rect'
      .attr
        class: 'sequence-entry'

    entries
      .attr
        x: (d, i) -> xScale i
        y:  0
        width: xScale 1
        height: height
        display: (d, i) -> if d? then undefined else 'none'
      .style
        fill: (d, i) -> colorScale d


  # Get/set the SVG group to use
  my.container = (_container) ->
    if _container?
      container = _container
      return my
    else
      return container


  # Get/set the width of the entire sequence
  my.width = (_width) ->
    if _width?
      width = _width
      return my
    else
      return width


  # Get/set the height of the entire sequence
  my.height = (_height) ->
    if _height?
      height = _height
      return my
    else
      return height


  # Get/set the data of the sequence, which is an array of single-character
  # strings corresponding to individual entries  Entries may be undefined,
  # indicating additions or deletions in the sequence, and will not be
  # rendered.
  my.data = (_data) ->
    if _data?
      data = _data
      return my
    else
      return data


  return my
