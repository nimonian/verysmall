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

Sol +=[ '''
\\begin{align*} & \\left[%s\\right]_{%s}^{%s} \\\ 
	& = \\left( %s \\right) \\\ 
	& \\qquad - \\left(%s\\right) \\\  
	& = \\left( %s \\right) - \\left( %s \\right) \\\ 
	& = %s \\end{align*} '''%(
		latex(F(x)),
        a,
        b,
		latex(F(x)).replace('x','%s'%('('+str(b)+')')),
 		latex(F(x)).replace('x','%s'%('('+str(a)+')')),
 		latex(F(b)),
		latex(F(a)),
		latex(F(b)-F(a))
        )]

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
			pretty_print(html('<br />'))