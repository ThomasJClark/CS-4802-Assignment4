# sequenceSelect.coffee
# An HTML <select> tag to choose between several different sequences
a4 = a4 ? {}
a4.sequenceSelect = (container) ->
  data = []
  sequence = []
  change = (name, data) ->

  my = () ->
    options = (container.selectAll 'option').data data
    options.exit().remove()
    options.enter().append 'option'

    options
      .attr 'value', (d, i) -> d.data
      .text          (d, i) -> d.name

    container.on 'change', () ->
      change my.sequence()


  # Get/set the <select> tag to use
  my.container = (_container) ->
    if _container?
      container = _container
      return my
    else
      return container


  # Get/set the array of options, which are objects containing a "name" field
  # and a "data" field, corresponding to the name of a sequence and the
  # sequence itself.
  my.data = (_data) ->
    if _data?
      data = _data
      return my
    else
      return data


  # Get/set the function that's called when the selected option changes.  The
  # function is passed the selected sequence data as an argument.
  my.change = (_change) ->
    if _change?
      change = _change
      return my
    else
      return change


  my.sequence = () ->
    return container.node().value


  return my
