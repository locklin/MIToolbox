3 : 0''
if. UNAME-:'Linux' do.
NB.  LMI=: '"',~'"',jpath 'src/MIToolbox/libMIToolbox.so'
LMI=:'/home/scott/src/MIToolbox/libMIToolbox.so'
elseif. UNAME-:'Darwin' do.  NB. I dunno where darwin keeps things any more
  LMI=: '"',~'"',jpath '~addons/math/mitoolbox/libMIToolbox.so'
elseif. do.
  LMI=: '"',~'"',jpath '~addons/math/mitoolbox/libMIToolbox.so', (IF64#'_64'), '.dll'
end.
)


cd=: 15!:0

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
 'data' =. y
 len=.  0 pick $ data
 cmd=. LMI,' calculateEntropy d *d i '
 0 pick cmd cd data;len 
)

NB. *histJointEnt data cond
NB. -calculates Shannon/Histogram joint entropy of data conditioned on cond 
histJointEnt =: 3 : 0
 'data targ' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateJointEntropy d *d *d i '
 0 pick cmd cd data;targ;len 
)

NB. *histMI data cond
NB. -calculates Shannon/Histogram MI of data conditioned on cond
histMI =: 3 : 0
 'data targ' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateMutualInformation d *d *d i '
 0 pick cmd cd data;targ;len 
)

NB. *histCondMI data cond
NB. -calculates Shannon/Histogram conditional MI of data conditioned on cond
histCondMI =: 3 : 0
 'data targ' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateConditionalMutualInformation d *d *d i '
 0 pick cmd cd data;targ;len 
)

NB. *renyiEnt alpha data
NB. -calculates Renyi entropy on data of order alpha
NB. -remember, alpha must not be 1 for Renyi entropies; in this case
NB. -use the histogram/Shannon entropy. Alpha between 0 and 1 weights
NB. -events more evenly, and as alpha goes to inf, it weights highly probable
NB. -events more heavily.
renyiEnt =: 3 : 0
 'alpha data' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateRenyiEntropy d d *d i '
 0 pick cmd cd alpha;data;len 
)

NB. *conditionalRenyiEnt alpha data cond  
NB. -calculates Renyi entropy of order alpha for data conditioned on cond
conditionalRenyiEnt =: 3 : 0
 'alpha data cond' =.y
 len=. 0 pick $ data
 cmd=. LMI,' calculateConditionalRenyiEntropy d d *d *d i '
 0 pick cmd cd alpha;data;cond;len 
)

NB. *jointRenyiEnt alpha data cond
NB. -calculates joint Renyi entropy of data conditioned on cond
jointRenyiEnt =: 3 : 0
'alpha data second' =.y
 len=. 0 pick $ data
 cmd=. LMI,' calculateJointRenyiEntropy d d *d *d i '
 0 pick cmd cd alpha;data;second;len 
)

NB. *renyiMIDiv alpha data cond
NB. -calculates Renyi MI divergence of data conditioned on cond
renyiMIDiv =: 3 : 0
 'alpha data targ' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateRenyiMIDivergence d d *d *d i '
 0 pick cmd cd alpha;data;targ;len 
)

NB. *renyiMI alpha data cond
NB. -calculates Renyi MI of data conditioned on cond
renyiMI =: 3 : 0
  'alpha data targ' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateRenyiMIJoint d d *d *d i '
 0 pick cmd cd alpha;data;targ;len 
)


NB. *histWeightEnt data weight
NB. calculates weighted entropy
histWeightEnt=: 3 : 0
 'data weight' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateWeightedEntropy d *d *d  i '
 0 pick cmd cd data;weight;len 
)

NB. *histWeightJointEnt data cond weight
NB. calculates weighted conditional entropy
histWeightJointEnt=: 3 : 0
 'data targ weight' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateWeightedJointEntropy d *d *d *d i '
 0 pick cmd cd data;targ;weight;len 
)

NB. *histWeightCondEnt data cond weight
NB. calculates weighted conditional entropy
histWeightCondEnt=: 3 : 0
 'data targ weight' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateWeightedConditionalEntropy d *d *d *d i '
 0 pick cmd cd data;targ;weight;len 
)


NB. *histWeightMI data targ weight
NB. calculates weighted histogram MI  
histWeightMI=: 3 : 0
 'data targ weight' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateWeightedMutualInformation d *d *d *d i '
 0 pick cmd cd data;targ;weight;len 
)


NB. *histWeightCondMI data targ weight
NB. calculates weighted histogram conditional MI  
histWeightCondMI=: 3 : 0
 'data targ weight' =. y
 len=. 0 pick $ data
 cmd=. LMI,' calculateWeightedConditionalMutualInformation d *d *d *d i '
 0 pick cmd cd data;targ;weight;len 
)
