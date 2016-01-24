from scipy import stats

# Define the variables
l = randint(10,100)
r1 = int(l/2)
r2 = l + r1
r = randint(r1,r2)

p = N((l^r)/((e^l)*factorial(r)),digits=4)

# Define the problem
Prob=[]

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

Prob+=['The random variable $X$ has a Poisson distribution with mean $\lambda = %s$'%(l)]

Prob+=['Find $P(X= %s)$'%(r)]

problem()


# Define the solution
Sol=[]
Sol += ['''
\\begin{align*} P(X= %s) & = \\frac{e^{%s}%s^{%s}{%s!} \\\ 
	& = %s \\end{align*}'''%(
	r,
	latex(-l),
	l,
	r,
	r,
	p
	)]
	


@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
			pretty_print(html('<br />'))