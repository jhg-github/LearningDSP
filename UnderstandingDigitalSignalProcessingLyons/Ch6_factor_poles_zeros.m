b = [0.0605 0.121 0.0605];
a = [1 -1.194 .436];

fvtool(b,a,'polezero')
[b,a] = eqtflength(b,a);
[z,p,k] = tf2zp(b,a)
zplane(z,p)

roots(b)
roots(a)