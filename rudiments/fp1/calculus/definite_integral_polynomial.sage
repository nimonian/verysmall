# Define the variables

P = ZZ['x']
n = randint(2,3)
f = P.random_element(degree=n, x=-9, y=9)
F(x) = f(x).integrate(x)
a = randint(-5,4)
b = randint(a,5)

# Define the problem

Prob = []

Prob += ['Compute the following (your answer should be a number):']

Prob += ['$$\\int_{%s}^{%s} %s \\, dx$$'%(
        a,
        b,
        latex(f) )]

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

problem()

# Define the solution

Sol = []

Sol += ['$$ \\left[%s\\right]_{%s}^{%s} $$'%(
        latex(F(x)),
        a,
        b )]

Sol += ['$$= \\left( %s \\right)'%(
	latex(F(x)).replace('x','%s'%('('+str(b)+')')) )]

Sol += ['$$\\qquad - \\left(%s\\right)$$'%(
	latex(F(x)).replace('x','%s'%('('+str(a)+')')) )]

Sol += ['$$= \\left( %s \\right) - \\left( %s \\right)$$'%(
	latex(F(b)),
	latex(F(a)) )]



Sol += ['$$= %s $$'%(
	latex(F(b)-F(a)) )]

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
		pretty_print(html('<br />'))