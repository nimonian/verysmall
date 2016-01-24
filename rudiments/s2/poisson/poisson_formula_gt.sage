from scipy import stats

# Define the variables
l = randint(5,12)
p1 = N( l/(e^l), digits=4)
p0 = N( 1/e ,digits=4)
# Define the problem
Prob=[]

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

Prob+=['The random variable $X$ has a Poisson distribution with mean $\lambda = %s.$ Find $P(X \geq 2)$.'%(l)]

problem()


# Define the solution
Sol=[]

Sol += ['We will solve this by using the formula. First of all,']

Sol += [''' 
\\begin{align*} P(X\\geq 2)
	& = 1 - P(X \\leq 1) \\\ 
	& = 1 - (P(X = 1) + P(X=0)) \\\ 
	& = 1 - \\left( \\frac{ e^{%s}%s^{1} }{ 1! }  + \\frac{ e^{%s}%s^{0} }{0!} \\right) \\\ 
	& = 1 - \\left( %s + %s \\right) \\\ 
	& = %s \\end{align*} '''%(
		l,
		l,
		l,
		l,
		p1,
		p0,
		1-(p1+p0) )]
	


@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
			pretty_print(html('<br />'))