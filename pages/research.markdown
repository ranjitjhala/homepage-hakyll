---
title: Research
author: Ranjit Jhala
---

# Research

I am interested in Programming Languages and Software Engineering, more
specifically, in techniques for building reliable computer systems. My work
draws from, combines and contributes to methods the areas of Type Systems, Model
Checking, Program Analysis and Automated Deduction.

## Current Projects

<div class="section">

## LiquidHaskell

Liquid Types for Haskell

+ [Code][code-lh], [Book][book-lh], [Blog][blog-lh], [Demo][demo-lh]
+ Papers: [PLDI 19][pldi19a], [POPL 18][popl18], [ICFP 2017][icfp17], [ICFP 2015][icfp15], [ICFP 2014][icfp14], [Haskell 2014][hs14], [ESOP 2013][esop13]

</div>

<div class="section">

## Code Analytics 

Analyzing programs using models learned from interaction-traces

+ [NATE](code-nate), [OOPSLA 2017](oopsla17-nate)
+ [NanoMaly](code-nanomaly), [ICFP 2016](icfp16) 

</div>

<div class="section">

## Pretend Synch.

Verifying Distributed Programs via Sequentialization

+ [[POPL 2019]](/static/pretend_synchrony.pdf)
+ [Code](code-brisk), [OOPSLA 2017](oopsla17-brisk)

</div>


<div class="section">
## Browser Security 

Binding bugs and Timing Channels

+ Papers: [PLDI 2019][pldi19b], [CCS 2018][ccs18], [Oakland 2017][sp17], [Oakland 2015][sp15]

</div>

## Past Projects

<div class="section">
## RefScript

Liquid Types for TypeScript

+ [Code](https://github.com/ucsd-pl/refscript) <!--, [Demo](https://ucsd-progsys.github.io/refscript) -->
+ Papers: [PLDI 2016][pldi16], [ECOOP 2015][ecoop15], [VMCAI 2016][vmcai16]

</div>


<div class="section">
## CSolve

+ [Code](http://goto.ucsd.edu/csolve/csolve-2012-04-24.tar.gz)
+ Papers: [CAV 2012](static/csolve_verifying_c_with_liquid_types.pdf), [PLDI 2012](static/deterministic_parallelism_via_liquid_effects.pdf), [POPL 2010](static/low_level_liquid_types.pdf)
</div>

<div class="section">
## DSolve

+ [Code](https://github.com/ucsd-progsys/dsolve)
+ Papers: [PLDI 2008](static/liquid_types.pdf), [PLDI 2009](static/type-based_data_structure_verification.pdf)
</div>

<div class="section">
## Relay

+ [Code](http://cseweb.ucsd.edu/~jvoung/race/)
+ Papers: [FSE 2007](static/relay.pdf), [PLDI 2008](static/radar.pdf)
</div>

<div class="section">
## Mace/MC

+ [Code](http://www.macesystems.org/mace/)
+ Papers: [PLDI 2007](static/mace.pdf), [NSDI 2007](static/macemc.pdf), [FSE 2010](static/mace-performance.pdf)
</div>

<div class="section">
## Blast

+ [Wikipedia](http://en.wikipedia.org/wiki/BLAST_model_checker)
+ [Linux Driver Verification](http://linuxtesting.org/results/ldv)
+ Papers: [POPL 2002](static/lazy_abstraction.pdf), [POPL 2004](static/abstractions_from_proofs.pdf), [PLDI 2004](static/race_checking_by_context_inference.pdf), [PLDI 2005](static/path_slicing.pdf), [TACAS 2007](static/a_practical_and_complete_approach_to_predicate_refinement.pdf)
</div>



## Monographs

The following monographs are long introductions, suitable for a graduate class:

**Programming With Refinement Types** <br>
Ranjit Jhala, Eric Seidel and Niki Vazou <br>
[PDF](http://ucsd-progsys.github.io/liquidhaskell-tutorial/book.pdf), [Online](http://www.refinement-types.org)<br>

**Software Model Checking** <br>
Ranjit Jhala and Rupak Majumdar<br>
ACM Computing Surveys, Volume 41 Issue 4, October 2009 <br>
[PDF](static/software-model-checking.pdf), [ACM DL](http://dl.acm.org/citation.cfm?id=1592438&dl=ACM&coll=DL&CFID=679753188&CFTOKEN=54082200)

**Program Verification by Lazy Abstraction** <br>
Ranjit Jhala <br>
Ph.D Dissertation, UC Berkeley, 2004 <br>
[PDF](static/jhala-thesis.pdf)

**Formal Methods: Future Directions & Its Transition To Practice** <br>
Ranjit Jhala & Rupak Majumdar (Eds.) <br>
Report compiled from [NSF Workshop](http://goto.ucsd.edu/~rjhala/NSFWorkshop/index.html)
[Summary-PDF](static/nsf-workshop-report-summary.pdf) [Full-PDF](static/nsf-workshop-report-summary.pdf)


## Papers

Below is a list of papers I've written; also at [Google Scholar][scholar], [DBLP][dblp] or [ArXiv][arxiv].

[arxiv]:   http://arxiv.org/find/cs/1/au:+Jhala_R/0/1/0/all/0/1
[scholar]: https://scholar.google.com/citations?user=H3wb878AAAAJ
[dblp]:    http://dblp.uni-trier.de/pers/hd/j/Jhala:Ranjit
[code-lh]: http://github.com/ucsd-progsys/liquidhaskell
[book-lh]: http://www.refinement-types.org
[blog-lh]: http://goto.ucsd.edu/liquid
[demo-lh]: http://ucsd-progsys.github.io/lh-workshop

[pldi19a]: static/lazy_counterfactual_symbolic_execution.pdf
[pldi19b]: static/fact_dsl.pdf
[ccs18]: static/ctfp-ccs18.pdf
[sp17]: static/binding-bugs-sp2017.pdf
[sp15]: static/subnormal.pdf
[popl16]: static/fp-printing-popl16.pdf
[pldi16]: static/refinement_types_for_typescript.pdf
[vmcai16]: http://arxiv.org/pdf/1505.02298v2.pdf
[ecoop15]: static/trust_but_verify.pdf
[icfp15]: static/bounded_refinement_types.pdf
[icfp14]: static/refinement_types_for_haskell.pdf
[icfp17]: static/local_refinement_typing.pdf 
[popl18]: static/refinement_reflection.pdf 
[hs14]:   static/real_world_liquid.pdf
[esop13]: static/abstract_refinement_types.pdf

[oopsla17-brisk]: static/canonical_sequentialization.pdf 
[oopsla17-nate]: static/learning_to_blame.pdf 
[code-nate]: https://github.com/ucsd-progsys/nate
[code-nanomaly]: https://github.com/ucsd-progsys/nanomaly
[code-brisk]: https://github.com/abakst/brisk


