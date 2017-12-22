\l ga.q

// Generates a random chromosome for this problem.
randomChromosome:{raze {$[4>c:count x;((4-c)#0),x;x]} each 2 vs/: 7?14}

phenotypes:(0;1;2;3;4;5;6;7;8;9;+;-;*;%;::;::)
generateSymbols:{(phenotypes@/:2 sv/: 4 cut x) except (::)}
// Executes a chromosome's instructions to get an output for this problem.
executechromosome:{
  $[-7h<>type res:@[{eval parse raze string generateSymbols x};x;0N];0N;res]}

// Assesses the fitness of an execution, given a goal
scoreFitness:{[goal;attempt]$[attempt~0N;0f;1+reciprocal abs goal-attempt]}

// Given a goal g for population p, produces a nice table showing the parsed
// expression from each chromosome, its executed value and its fitness.
showPopulationPerformance:{[g;p]
  ex:executechromosome each p;
  ([]
    expression:{raze string generateSymbols x} each p;
    evaluation:ex;
    fitness:scoreFitness[g;ex])}

// For a goal g, a crsRate, mutRate, the size of the initial population n,
// and the maximum number of iterations/generations to search for iMax, produces a
// table of chromosomes which produce expressions whose executed value is as
// close to g as possible.
findExpr:{[crsRate;mutRate;iMax;n;g]
  p:randomChromosome each n#0;
  chromosomes:evolve[crsRate;mutRate;executechromosome;scoreFitness;g;iMax;p];
  showPopulationPerformance[g;chromosomes]}

