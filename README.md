# CS 4802 Assignment 4 - Thomas Clark

## Design
The visualization shows two horizontal sequences, one on top of the other. Additions are represented by gaps in the top one, and deletions are represented by gaps in the bottom one.  That way, each aligned sequence is just the original sequence pulled apart so that like parts in each of them match up.

The values of each entry in the sequences are represented by different colors, making it immediately obvious with a quick scan which items are the same.

## Free-form Component
### Technical
The sequences can be zoomed in on and panned over simply by scrolling and dragging with the mouse.  This makes it possible to analyze subsequences of extremely long sequences by zooming in on areas of interest.
### Biological
You can select any of 25 possible pairs of sequences (with the sample data provided) and instantly see how they align. This is a useful feature for comparing the alignments of an entire set of sequences to find areas of interest and patterns that occur in more than one alignment.

## Running
1. Build the project using the provided Cakefile
        cake build
2. Run an HTTP server, such as the one included with Python.
        python3 -m http.server
3. View the webpage in Firefox or Chrome at [http://localhost:8000/a4.html](http://localhost:8000/a4.html).
