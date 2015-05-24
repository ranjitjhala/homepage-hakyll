---
title: Research
author: Ranjit Jhala
---

# Research

I am interested in Programming Languages and Software Engineering, more
specifically, in techniques for building reliable computer systems. My work
draws from, combines and contributes to methods the areas of Type Systems, Model
Checking, Program Analysis and Automated Deduction.

<div class="section">
Current Projects
================

+ [Liquid Haskell](http://github.com/ucsd-progsys/liquidhaskell)
+ [Refined TypeScript](https://github.com/ucsd-pl/refscript)
+ [Fixpoint Horn-Clause Solver](https://github.com/ucsd-progsys/liquid-fixpoint)
+ [Data Timing Channels](subnormal-oakland)

</div>

<div class="section">
Past Projects
=============

+ DSolve
+ Relay 
+ Mace/MC
+ Blast 
+ Vampyre

</div>


Papers
======

Below is a list of my papers. For co-authors and such:

+ [Google Scholar][scholar]
+ [DBLP][dblp]


<div class="section">
## 2015

**Generalization Bounds**    

Mark D. Reid     
To appear in the [Encyclopedia of Machine Learning](http://www.springer.com/computer/ai/book/978-0-387-30768-8), 
November, 2010.    
{ [PDF (Pre-print)][bounds] | [BibTeX]() }

 <div class="bibtex">
### BibTeX
	@incollection{Reid:2010a,
	 Author = {Reid, Mark D.},
	 Booktitle = {Encyclopedia of Machine Learning},
	 Editor = {Sammut, C. and Webb, G.},
	 Publisher = {Springer},
	 Title = {Generalization Bounds},
	 Volume = {XXVI},
	 Year = {2010}}
 </div>

**Squinting at a Sea of Dots: Visualising
Australian Readerships using Statistical Machine Learning**     
[Julieanne Lamond][julieanne] and Mark D. Reid   
Resourceful Reading: The New Empiricism, eResearch and Australian Literary Culture    
{ [BibTeX]() }

 <div class="abstract">
### Abstract
We propose a novel hybrid loss for multiclass and structured prediction problems that is a convex combination of a log loss for Conditional Random Fields (CRFs) and a multiclass hinge loss for Support Vector Machines (SVMs). We provide a sufficient condition for when the hybrid loss is Fisher consistent for classification. This condition depends on a measure of dominance between labels--specifically, the gap between the probabilities of the best label and the second best label. We also prove Fisher consistency is necessary for parametric consistency when learning models such as CRFs. We demonstrate empirically that the hybrid loss typically performs least as well as--and often better than--both of its constituent losses on a variety of tasks, such as human action recognition. In doing so we also provide an empirical comparison of the efficacy of probabilistic and margin based approaches to multiclass and structured prediction.
 </div>

 <div class="bibtex">
### BibTeX
	@incollection{Lamond:2010,
	 Address = {Sydney},
	 Author = {Lamond, Julieanne V. and Reid, Mark D.},
	 Booktitle = {Resourceful Reading: The New Empiricism, eResearch and Australian Literary Culture},
	 Editor = {Bode, Katherine and Dixon, Robert},
	 Pages = {223--239},
	 Publisher = {Sydney University Press},
	 Title = {Squinting at a Sea of Dots: Visualising Australian Readerships using Statistical Machine Learning},
	 Year = {2010}}
 </div>

</div>

[scholar]: https://scholar.google.com/citations?user=H3wb878AAAAJ
[dblp]:    http://dblp.uni-trier.de/pers/hd/j/Jhala:Ranjit


<script type="text/javascript" src="/js/jquery.js"> </script>
<script type="text/javascript">
	$(document).ready(function(){
		$("a:contains('BibTeX')").click(function(event) { 
			$(this).parent().nextAll(".bibtex").first().slideToggle("fast"); });

		$("a:contains('BibTeX')").toggle(
			function(){ $(this).text("Hide BibTeX") },
			function(){ $(this).text("BibTeX") }
		);

		$("a:contains('Abstract')").click(function(event) { 
			$(this).parent().nextAll(".abstract").first().slideToggle("fast"); });

		$("a:contains('Abstract')").toggle(
			function(){ $(this).text("Hide Abstract") },
			function(){ $(this).text("Abstract") }
		);

	});
</script>


