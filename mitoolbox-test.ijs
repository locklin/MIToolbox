load'mitoolbox.ijs'
floatrand=: ?@$ % ] - 1:
dataset=: 1E5 10 $ 10e5 floatrand 100
bitsToNats histEnt discrete dataset
a=: discretize 1e6 10 $ ?10e6#0
mi=.({."1 a) histMI  }."1 a
hx =. histEnt }."1 a
hy =. histEnt {."1 a
hxy=. ({."1 a) histJointEnt  }."1 a
mi - hx + hy - hxy
