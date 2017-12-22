# Q-GeneticAlgo

Some functions for defining and running genetic algorithms for fixed length binary
chromosomes. I've included an example usage of the functions.

## GA Operators

### Selection

Culls all chromosomes whose fitness is below the population median.

Potential improvements:

I am intending to make this configurable, such that you will be able to pass a
function which given a list of fitness results must return indices to those which
are intended to survive.

### Crossing

Given a list of chromosomes, pairs them up randomly and for each pair, chooses
a random point along the chromosome and swaps all genes up to that point between
the two chromosomes. Each pair's crossing returns two new chromosomes which are
then added to the working population.

Potential improvements:

This should become configurable, such that you can specify a function which given
two chromosomes will perform some crossing function between them and return a
list of offspring.

The pairing function could change such that more successful chromosomes get
paired more than less successful ones.

### Mutation

Flips a single bit within a given chromosome.

Potential improvements:

Flip multiple bits with some low probability.

## Operator wrappers

### Irradiation

Mutates a given chromosome with a probability given by a defined mutation-rate,
otherwise returns the chromosome as-is.

### Reproduction

For a given pair of chromosomes, crosses them with a probability defined by a
cross-rate, and if they are not crossed, then they reproduce by cloning. Cloned
offspring are guaranteed to have a mutation.

## Evolution

For a given generation, the following algorithm is applied:
1. Each chromosome is executed and its fitness assessed.
2. (Selection) Chromosomes with a fitness below the population median are culled.
3. (Crossing)  Survivors reproduce, mostly by crossing, sometimes by cloning.
4. (Mutation)  All chromosomes are irradiated, causing mutations.

The top level function, evolve, executes the above algorithm iteratively a given
number of times and returns the resulting chromosomes. If at some point the
number of survivors becomes 0 and the population is extinct, this is raised
as 'extinct.
