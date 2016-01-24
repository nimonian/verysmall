from scipy import stats

L = []
for i in range(8):
	L += [(6 + 0.5*i).n(digits=2)]
for i in range(10,16):
	L += [i]

l = choice(L)
r0 = randint(1,16)
r1 = randint(r0+5,25)
P = stats.poisson(l)
p0 = N(P.cdf(r0), digits=4)
p1 = N(P.cdf(r1), digits=4)
while any([p0==0, p1==0, p0==1, p1==1, p0==p1]):
	l = choice(L)
	r0 = randint(1,16)
	r1 = randint(r0+5,25)
	P = stats.poisson(l)
	p0 = N(P.cdf(r0), digits=4)
	p1 = N(P.cdf(r1), digits=4)

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

Prob = []

Prob+=['The random variable $X$ has a Poisson distribution with mean $\lambda = %s.$ Find $P(%s < X \leq %s)$.'%(l,r0,r1)]

problem()


# Define the solution
Sol=[]

Sol += ['We will solve this by looking up $\\lambda = %s $ in the tables'%(
	l )]

Sol += ['We must be very careful with the inequality signs. In this case, we need to find $$ P(X \\leq %s) - P(X \\leq %s) $$ and so we will look up $x = %s$ and $x=%s$ in the tables.'%(
	r1,
	r0,
	r1,
	r0  )]

Sol += ['The solution is $$ %s - %s = %s $$'%(
	p1,
	p0,
	p1-p0  )]

Sol += ['Provided your answer is within 0.0001 of this you are fine.']


@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
			pretty_print(html('<br />'))