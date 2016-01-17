# Define the variables

P = ZZ['x']
n = randint(2,5)
k = randint(2,4)
f = P.random_element(degree=n, x=-9, y=9)

# Define the problem

Prob = []

Prob += ['Compute the following:']

Prob += ['$$\int %s \, dx$$'%(
        latex(f) )]

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

problem()

# Define the solution

Sol = []

Sol += ['$$ %s $$'%(
        latex(f(x).integrate(x)) )]

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
		pretty_print(html('<br />'))