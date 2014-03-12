load'mitoolbox.ijs'
floatrand=: ?@$ % ] - 1:
dataset=: 1E5 10 $ 10e3 floatrand 100
bitsToNats histEnt discrete dataset
