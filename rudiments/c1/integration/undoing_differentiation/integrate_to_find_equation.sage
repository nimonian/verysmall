PROBLEM = dict()
SOLUTION = dict()
var('x','c')

b = randint(-5,5)
k = randint(-5,5)
d = randint(-5,5)
x1 = randint(-10,10)
y1 = randint(-10,10)

f(x) = b*x^2 + k*x + d
F(x) = f(x).integrate(x)
Fsubx = latex(F(x)).replace('x','(%s)'%(x1))

# Define the problem

def Problem():
	global PROBLEM
	pretty_print(html('<h3> Problem </h3>'))
	pretty_print(html('<br />'))
	for i in PROBLEM:
		pretty_print(html(PROBLEM[i]))
	pretty_print(html('<br />'))
	return

PROBLEM[1] = 'A curve in the plane satisfies $\\frac{dy}{dx} = %s'%(
	latex(f(x))
	)

PROBLEM[2] = 'You are also given that the point $(%s,%s)$ lies on the curve.'%(
	x1,
	y1
	)

PROBLEM[3] = 'Find the equation of the curve.'

Problem()

# Define the solution

SOLUTION[1] =   '$$ \\int_{a}^{b} %s \\, dx = %s %s $$'%(
                latex(f(x)),
                latex(F(x)),
                '+c'
                )

SOLUTION[2] = 'So $y = %s %s$'%(
	latex(F(x)),
	'+c'
	)

SOLUTION[3] = 'Substituting in $x = %s$ and $y = %s$ gives us $$ %s = %s %s $$ $$ %s = %s %s$$'%(
	x1,
	y1,
	y1,
	Fsubx,
	'+c',
	y1,
	latex(F(x1)),
	'+c'
	)

SOLUTION[4] = 'so that $c = %s'%( latex( y1 - F(x1) ))

c = y1 - F(x1)

SOLUTION[5] = 'Our solution is $$ y =%s$$'%( latex( F(x) +c ) )

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
    if ShowSolution==True:
    	global SOLUTION
        for line in SOLUTION:
			pretty_print(html(SOLUTION[line]))
