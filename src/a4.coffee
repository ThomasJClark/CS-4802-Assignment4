# Determine the optimal alignment of two sequences using the Needleman–Wunsch
# algorithm.
#
# @param {Array} seq1 The first sequence of n elements
# @param {Array} seq1 The second sequence of m elements
# @returns {Array} Two arrays.  The first array is seq1, but with undefined
#   elements where there are insertions, and the second array is seq2 but with
#   undefined elements where there are deletions.
align = (seq1, seq2) ->
  # Initialize the matrix to all 0's
  mat = ((0 for j in [0..seq2.length]) for i in [0..seq1.length])

  # For each pairing of items in the two sequences, compute the maximum score
  # of a substitution, insertion, or deletion.
  for i in [1..seq1.length]
    for j in [1..seq2.length]
      mat[i][j] = Math.max mat[i-1][j-1] + (seq1[i-1] is seq2[j-1]), mat[i-1][j], mat[i][j-1]

  [seq1Aligned, seq2Aligned] = [[], []]

  # Starting with the last entry in the matrix, trace backward through
  # operations that could precede each pair of entries until we reach the first
  # entry of each sequence.
  [i, j] = [seq1.length, seq2.length]
  until i is 0 and j is 0
    if i > 0 and mat[i][j] is mat[i-1][j]
      seq1Aligned.unshift seq1[--i]
      seq2Aligned.unshift undefined
    else if j > 0 and mat[i][j] is mat[i][j-1]
      seq1Aligned.unshift undefined
      seq2Aligned.unshift seq2[--j]
    else
      seq1Aligned.unshift seq1[--i]
      seq2Aligned.unshift seq2[--j]

  return [seq1Aligned, seq2Aligned]

$ ->
  # Update the SVG based on the currently selected sequences
  update = () ->
    [aligned1, aligned2] = align sequenceSelect1.sequence(), sequenceSelect2.sequence()
    sequence1.data aligned1
    sequence2.data aligned2
    sequence1()
    sequence2()

  container = d3.select '#container'

  # Adjust the scale on each sequence to zoom in or out
  zoom = () ->
    sequence1Transform = d3.transform sequence1.container().attr 'transform'
    sequence2Transform = d3.transform sequence2.container().attr 'transform'
    sequence1Transform.scale[0] = d3.event.scale
    sequence2Transform.scale[0] = d3.event.scale
    sequence1.container().attr 'transform', sequence1Transform.toString()
    sequence2.container().attr 'transform', sequence2Transform.toString()

  # Adjust the translation of each sequence to allow dragging
  drag = () ->
    sequence1Transform = d3.transform sequence1.container().attr 'transform'
    sequence2Transform = d3.transform sequence2.container().attr 'transform'
    sequence1Transform.translate[0] += d3.event.dx
    sequence2Transform.translate[0] += d3.event.dx
    sequence1.container().attr 'transform', sequence1Transform.toString()
    sequence2.container().attr 'transform', sequence2Transform.toString()

  svg = container.append 'svg'
    .attr
      width: 1024
      height: 200
    .style
      display: 'block'
      'pointer-events': 'all'
    .call (d3.behavior.zoom().scaleExtent [0.5, 100]).on 'zoom', zoom
    .call d3.behavior.drag().on 'drag', drag

  sequence1 = a4.sequence()
    .width 1022
    .height 100
    .container (svg.append 'g').attr
      transform: 'translate(1, 0)'
      class: 'sequence'

  sequence2 = a4.sequence()
    .width 1022
    .height 100
    .container (svg.append 'g').attr
      transform: 'translate(1, 100)'
      class: 'sequence'

  sequenceSelect1 = a4.sequenceSelect()
    .container container.append 'select'
    .change (d) -> update()

  sequenceSelect2 = a4.sequenceSelect()
    .container container.append 'select'
    .change (d) -> update()

  d3.json 'data.json'
    .get (error, data) ->
      sequences = data.sequences

      sequenceSelect1.data sequences
      sequenceSelect2.data sequences
      sequenceSelect1()
      sequenceSelect2()

      update()
