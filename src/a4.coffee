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


d3.json 'data.json'
  .get (error, sequences) ->
    seq1 = sequences.dutAquae
    seq2 = sequences.dutBraja
    [seq1Aligned, seq2Aligned] = align seq1, seq2
    console.log (seq1Aligned.map (c) -> if c? then c else ' ').join ' '
    console.log (seq2Aligned.map (c) -> if c? then c else ' ').join ' '
