3 : 0''
if. UNAME-:'Linux' do.
NB.  LMI=: '"',~'"',jpath '/home/scott/src/MIToolbox/src/libMIToolbox.so'
  LMI=:'/home/scott/src/MIToolbox/src/libMIToolbox.so'
elseif. UNAME-:'Darwin' do.  NB. I dunno where darwin keeps things any more
  LMI=: '"',~'"',jpath '~addons/math/mitoolbox/libMIToolbox.so'
elseif. do.
  LMI=: '"',~'"',jpath '~addons/math/mitoolbox/libMIToolbox.so', (IF64#'_64'), '.dll'
end.
)


cd=: 15!:0

NB. *x totalcor y
NB. -MI total correlation variant
totalcor=: 4 : 0
 hx=. histEnt x
 hy=. histEnt y
 hxy=. x histJointEnt y
 (hx + hy - hxy ) % <. hx,hy
)

NB. *x mulcor y
NB. -MI multiplicative correlation variant
mulcor=: 4 : 0
 hx=. histEnt x
 hy=. histEnt y
 hxy=. x histJointEnt y
 (hx + hy - hxy ) %  %: hx * hy
)

NB. *x dualcor y
NB. -MI mutual correlation variant
dualcor=: 4 : 0
 hx=. histEnt x
 hy=. histEnt y
 hxy=. x histJointEnt y
 (hx + hy - hxy ) %  hxy
)

NB. *x symcor y
NB. -MI symmetric correlation variant
symcor=: 4 : 0
 hx=. histEnt x
 hy=. histEnt y
 hxy=. x histJointEnt y
 (hx + hy - hxy ) %  hx + hy
)

NB. *<n>discrete vals
NB. -discretizes float vals into n equal width bins (default n to sqrt of sizeof vals)
discrete=: 3 : 0
 nbins=. <. (#y) ^0.5
 nbins discrete (2.2-2.2 + y)
:
 max=. >./>./y
 min=. <./<./y
 width=. (max-min) % x 
 >.(y - min) % width 
)

NB. *bitsToNats bits
NB. -convert bits to nats (for comparison to other packages which use nats)
bitsToNats=: 3 : 0
 y % 1.442695
)

NB. *histEnt data 
NB. -calculates Shannon/Histogram entropy of data 
histEnt =: 3 : 0
 len=.  0 pick $ y
 cmd=. LMI,' calculateEntropy d *d i '
 0 pick cmd cd y;len 
)

NB. *cond histJointEnt data 
NB. -calculates Shannon/Histogram joint entropy of data conditioned on cond 
histJointEnt =: 4 : 0
 len=. 0 pick $ y
 cmd=. LMI,' calculateJointEntropy d *d *d i '
 0 pick cmd cd y;x;len 
)

NB. *cond histMI data 
NB. -calculates Shannon/Histogram MI of data conditioned on cond
histMI =: 4 : 0
 len=. 0 pick $ y
 cmd=. LMI,' calculateMutualInformation d *d *d i '
 0 pick cmd cd y;x;len 
)

NB. *cond histCondMI data 
NB. -calculates Shannon/Histogram conditional MI of data conditioned on cond
histCondMI =: 4 : 0
 len=. 0 pick $ y
 cmd=. LMI,' calculateConditionalMutualInformation d *d *d i '
 0 pick cmd cd y;x;len 
)

NB. *alpha renyiEnt  data
NB. -calculates Renyi entropy on data of order alpha
NB. -remember, alpha must not be 1 for Renyi entropies; in this case
NB. -use the histogram/Shannon entropy. Alpha between 0 and 1 weights
NB. -events more evenly, and as alpha goes to inf, it weights highly probable
NB. -events more heavily.
renyiEnt =: 4 : 0
 'alpha' =. x
 len=. 0 pick $ y
 cmd=. LMI,' calculateRenyiEntropy d d *d i '
 0 pick cmd cd alpha;y;len 
)

NB. *alpha  cond conditionalRenyiEnt data
NB. -calculates Renyi entropy of order alpha for data conditioned on cond
conditionalRenyiEnt =: 4 : 0
 'alpha cond' =.y
 len=. 0 pick $ y
 cmd=. LMI,' calculateConditionalRenyiEntropy d d *d *d i '
 0 pick cmd cd alpha;y;cond;len 
)

NB. *alpha cond jointRenyiEnt data 
NB. -calculates joint Renyi entropy of data conditioned on cond
jointRenyiEnt =: 4 : 0
'alpha second' =.x
 len=. 0 pick $ y
 cmd=. LMI,' calculateJointRenyiEntropy d d *d *d i '
 0 pick cmd cd alpha;y;second;len 
)

NB. *alpha cond renyiMIDiv data 
NB. -calculates Renyi MI divergence of data conditioned on cond
renyiMIDiv =: 4 : 0
 'alpha targ' =. x
 len=. 0 pick $ y
 cmd=. LMI,' calculateRenyiMIDivergence d d *d *d i '
 0 pick cmd cd alpha;y;targ;len 
)

NB. * alpha cond renyiMI data 
NB. -calculates Renyi MI of data conditioned on cond
renyiMI =: 4 : 0
  'alpha targ' =. x
 len=. 0 pick $ y
 cmd=. LMI,' calculateRenyiMIJoint d d *d *d i '
 0 pick cmd cd alpha;y;targ;len 
)


NB. *weight histWeightEnt data 
NB. calculates weighted entropy
histWeightEnt=: 4 : 0
 len=. 0 pick $ y
 cmd=. LMI,' calculateWeightedEntropy d *d *d  i '
 0 pick cmd cd y;x;len 
)

NB. *cond weight histWeightJointEnt data 
NB. calculates weighted conditional entropy
histWeightJointEnt=: 4 : 0
 'targ weight' =. x
 len=. 0 pick $ y
 cmd=. LMI,' calculateWeightedJointEntropy d *d *d *d i '
 0 pick cmd cd y;targ;weight;len 
)

NB. *histWeightCondEnt data cond weight
NB. calculates weighted conditional entropy
histWeightCondEnt=: 4 : 0
 'targ weight' =. x
 len=. 0 pick $ y
 cmd=. LMI,' calculateWeightedConditionalEntropy d *d *d *d i '
 0 pick cmd cd y;targ;weight;len 
)


NB. *targ weight histWeightMI data 
NB. calculates weighted histogram MI  
histWeightMI=: 4 : 0
 'targ weight' =. x
 len=. 0 pick $ y
 cmd=. LMI,' calculateWeightedMutualInformation d *d *d *d i '
 0 pick cmd cd y;targ;weight;len 
)


NB. *targ weight histWeightCondMI data 
NB. calculates weighted histogram conditional MI  
histWeightCondMI=: 4 : 0
 'targ weight' =. x
 len=. 0 pick $ y
 cmd=. LMI,' calculateWeightedConditionalMutualInformation d *d *d *d i '
 0 pick cmd cd y;targ;weight;len 
)
