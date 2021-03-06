# Define the variables
var('b','X','Y')
k = randint(3,6)
c = randint(1,5)
d = randint(-5,5)
p = randint(1,k-2)
I = [i for i in range(0,k-1)]
I.remove(p)
q = choice(I)
a = randint(1,3)
g(x)=x^(-k)
h(x) = c*x^p + d*x^q
f(x) = (h(x)*g(x)).expand()
F(x) = f(x).integrate(x)
L = limit(F(x)-F(a),x=infinity)

# Define the problem
Prob=[]

Prob+= ['Show that $$\int_{%s}^{\infty} %s\\left(%s\\right) \, dx$$ has a finite value and compute it'%(
	a,
	latex(g(x)),
	latex(h(x)) )]

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

problem()

# Define the solution

Sol=[]

Sol += ['The first step is to replace $\infty$ with $b$ to give: $$ \int_{%s}^{b} %s\\left(%s\\right) $$'%(
	a,
	latex(g(x)),
	latex(h(x)) )]

Sol += ['Now we expand out the function into a form we can integrate: $$ \int_{%s}^{b} %s \, dx $$'%(
	a,
	latex( c*x^(X) + d*x^(Y) ).replace('X',str(p-k)).replace('Y',str(q-k)) )]

Sol += ['Now we carry out the integration to get $$ \\left(%s\\right) - \\left(%s\\right)'%(
	latex(F(b)), 
	latex(F(x)).replace('x','(%s)'%(a)) )]

Sol += ['After simplifying as much as possible, we have $$ %s $$'%(
	latex(F(b)-F(a)) )]

Sol += ['Now, as $b \\rightarrow \\infty$, $$ %s \\longrightarrow %s'%(
	latex(F(b)-F(a)),
	latex(L) )]

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
			pretty_print(html('<br />'))