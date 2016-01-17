from scipy import stats

# Define the variables

p = choice([0.10,0.15,0.2,0.25,0.3,0.35,0.4,0.45])
p = float('%.2g'%(p))
p = 1-p
q = 1-p
n = choice([20,25,30,40,50])
B = stats.binom(n,q)

P1=1
P2=1
x1=1
x2=1
while any([P1==P2, P1 == 1, P1 == 0, P2==1, P2==0, x2-x1<5]):
	x1 = randint(2,n-2)
	x2 = randint(x1+2,n)
	P1 = float(B.cdf(n-x1))
	P1 = float('%.4g'%(P1))
	P2 = float(B.cdf(n-x2))
	P2 = float('%.4g'%(P2))

# Define the problem
Prob=[]

Prob=['You are taking a test, and decide to answer randomly. There are $%s$ questions and the probability of correctly answering each one is $%s$. To see if you have good enough grades, you are interested in the probabilty that you score more than $%s$ but less than $%s$. What is this probability?'%(
	n,
	p,
	x1-1,
	x2+1
	)]

def problem():
    global Prob
    for line in Prob:
        pretty_print(html(line))
    pretty_print(html('<br />'))

problem()

# Define the solution
Sol=[]

Sol+=['In terms of our notation, the problem says $n=%s$, $p=%s$, and we want to find out $$P( %s \leq X \leq %s )$$ Notice how we have interpreted the phrases <em> less than </em> and <em> more than. </em>'%(
	n,
	p,
	x1,
	x2
	)]

Sol+=['''
To change this into a problem about failure, we compare the possible outcomes for $X$ and $Y$, noticing that the vertical pairs must add up to $ %s $
	\\begin{align*}
	X & = %s, %s, \\ldots, %s, %s \\\ 
	Y & = %s, %s, \\ldots, %s, %s \\\ 
	\\end{align*}
'''%(
	n,
	x1,
	x1+1,
	x2-1,
	x2,
	n-x1,
	n-(x1+1),
	n-(x2-1),
	n-x2
	)]

Sol+=['From this we can clearly see that the probability we need is $$P(%s \leq Y \leq %s)'%(
	n-x2,
	n-x1
	)]

Sol+=['We can work this out using the normal methods and looking up the probabilities in the tables for $$Y \sim B(%s,%s)$$'%( n,q )]

y1=n-x2
y2=n-x1

p = float(B.cdf(y2)) - float(B.cdf(y1-1))
p = '%.4g'%(p)

Sol+=['The required solution is $%s$'%(p)]

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
	global Sol
	if ShowSolution==True:
		for line in Sol:
			pretty_print(html(line))
			pretty_print(html('<br />'))