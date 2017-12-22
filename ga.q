// Given a binary chromasome, flips one of the bits.
mutate:{@[x;rand count x;{"j"$not x}]}

// Given a mutation rate and a chromasome, this returns a potentially
// mutated version of the chromasome.
irradiate:{[mutRate;a]$[mutRate>rand 1f;mutate a;a]}

// Given a list of chromasomes, pairs them up for crossing.
tinder:{
  m:{2 cut neg[x]?x} c:count x;
  $[1=c mod 2;@[m;-1+count m;,;rand c];m]}

// Given two chromasomes, crosses them by choosing a random point along
// the length of the chromasome and swapping all genes up to there.
crs:{(n#/:(y;x)),'(n:rand count x)_/:(x;y)}

// Given two chromasomes and a cross rate, either the two chromasomes
// are crossed to produce two offspring, or they are both cloned and
// mutated to produce two new offspring.
reproduce:{[crsRate;a;b]$[crsRate>rand 1f;crs[a;b];mutate each (a;b)]}

// Given a list of chromasomes and a crsRate, matches them up and executes
// an iteration of crossing on them.
procreate:{raze {reproduce[x;y 0;y 1]}[x;] each y@tinder y}

// Given a GENERATION for a GOAL, produces a (probably) better
// generation by EXECUTEing chromasomes and assessing FITNESS.
nextGeneration:{[crsRate;mutRate;goal;execute;fitness;generation]
  fitv:fitness[goal;] each execute each generation;
  cutoff:med fitv;
  if[cutoff=0w;:generation];
  survivors:generation where fitv>cutoff;
  if[0=count survivors;'extinct];
  irradiate[mutRate;] each survivors,procreate[crsRate;survivors]}

// Given an initial population p, a goal, a crsRate, a mutRate,
// a function for executing a chromasome's instructions and
// a function for assessing a chromasome's fitness and a maximum
// number of iterations to try, iters, tries up to that
// many and returns the resulting chromasomes.
evolve:{[crsRate;mutRate;execute;fitness;goal;iters;p]
  gen:nextGeneration[crsRate;mutRate;goal;execute;fitness;];
  .[{y x/ z}[gen;;];(iters;p);(::)]}
