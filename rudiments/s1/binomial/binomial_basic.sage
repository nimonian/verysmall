from scipy import stats

# Define the variables

p = choice([0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.10,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5])
p = float('%.2g'%(p))
n = choice([7,8,9,10,11,12,13,14,15,20,25,30,40,50])
B = stats.binom(n,p)

P1=1
P2=1
while any([P1 == 1, P1 == 0, P2==1, P2==0]):
	x1 = randint(2,n-2)
	x2 = randint(x1+2,n)
	P1 = float(B.cdf(x1-1))
	P1 = float('%.4g'%(P1))
	P2 = float(B.cdf(x2))
	P2 = float('%.4g'%(P2))

# Define the problem
Prob=[]

Prob+=[' Given that $ X \\sim B\\left( %s,%s\\right) $, calculate the following: $$ P(%s \leq X \leq %s) $$'%(
	n,
	p,
	x1,
	x2
	 )]

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

problem()

# Define the solution
Sol=[''' We have 
	\\begin{align*}
	n & = %s, \\\ 
	p & = %s, \\\ 
	x_{1} & = %s, \\\ 
	x_{2} & = %s
	\\end{align*}'''%(
	n,
	p,
	x1,
	x2
	)]

Sol+=['Firstly, we can look up $P\\left(X\\leq %s\\right)$ in the tables to give $$ P\\left(X\\leq %s\\right) = %s'%(
	x2,
	x2,
	P2 )]

Sol+=['''Next, we can work out 
	\\begin{align*} P(X < %s) 
		& = P(X \\leq %s)  \\\ 
		& = %s \\\ 
	\\end{align*}
	also by looking in the tables.'''%(
	x1,
	x1-1,
	P1 )]

Sol+=['''Our final answer is therefore
	\\begin{align*} P(%s \\leq X \\leq %s)
		& = P(X \\leq %s) - P(X < %s) \\\ 
		& = %s - %s \\\ 
		& = %s 
		\\end{align*} '''%(
		x1,
		x2,
		x2,
		x1,
		P2,
		P1,
		P2-P1
		)]

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
			pretty_print(html('<br />'))