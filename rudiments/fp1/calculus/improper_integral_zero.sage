# Define the variables

var('A','B','C')

P = [-3,-2,-1,1,2,3]
Q = [1,2,3]

k=[1,1,1]

while k[1]==k[2] or k[0]+k[1]==-1 or k[0]+k[2]==-1:
	p = [choice(P) for i in range(3)]
	q = [choice(Q) for i in range(3)]
	k = [p[i]/q[i] for i in range(3)]

k[0] = -abs(k[0])
f(x) = x^k[0]
g(x) = x^k[1]
h(x) = x^k[2]

b = choice(Q)

r(x) = f(x).mul(g(x)+h(x))

R(x) = r(x).integrate(x)

L = lim(R(b) - R(x),x=0, dir='plus')

# Define the problem

Prob = []

Prob+=['Determine whether the integral $$\\int_{0}^{%s} %s \, dx$$ has a finite value and, if so, compute this value'%(
	b,
	latex(r(x)) )]

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

problem()

# Define the solution

Sol=[]

Sol=['First of all, we substitute the $0$ with the symbol $a$: $$ \\int_{a}^{%s} %s \, dx$$'%(
	b,
	latex(r(x)) )]

Sol+=['We need the function in index form before we can possibly integrate it: $$ \\int_{a}^{%s} %s\\left(%s + %s\\right) \, dx'%(
	b,
	latex(x^A).replace('A',latex(k[0])),
	latex(x^B).replace('B',latex(k[1])),
	latex(x^C).replace('C',latex(k[2])) )]

Sol+=['Now multiply out: $$ \\int_{a}^{%s} %s + %s \, dx $$'%(
	b,
	latex(x^(A)).replace('A',latex(k[0]+k[1])),
	latex(x^(A)).replace('A',latex(k[0]+k[2])) )]

Sol+=['We can now do the integration: $$ \\left[ %s+%s \\right]_{a}^{%s} $$'%(
	latex(x^(A)/(k[0]+k[1]+1)).replace('A',latex(k[0]+k[1]+1)),
	latex(x^(A)/(k[0]+k[2]+1)).replace('A',latex(k[0]+k[2]+1)),
	b
	)]

Sol+=['Which gives us: $$ \\left( %s \\right) - \\left( %s \\right) $$'%(
	latex(R(b).simplify()),
	latex(R(x)).replace('x','a') )]

Sol+=['$$=%s$$'%(
	latex(R(b)-R(x)).replace('x','a') )]

if L == infinity or L == -infinity:
	Sol+=['There is a term in $a$ with a greater power in the denominator, and so the limit is $%s$ as $a\\rightarrow 0'%(latex(L))]
else:
	Sol+=['All terms involving $a$ have greater powers in the numerator, and so the limit is $%s$ as $a\\rightarrow 0'%(latex(L))]
@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
			pretty_print(html('<br />'))