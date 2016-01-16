PROBLEM = dict()
SOLUTION = dict()

# Define the variables

var('x')

trigs = [sin(x), cos(x)]
f(x) = choice(trigs)

if f(x) == sin(x):
    finv(x) = arcsin(x)
else:
    finv(x) = arccos(x)

y = randrange(-10,10,1)
y = y/10

xrad = finv(y)
xdeg = xrad*(360/(2*pi))
S = []

if f(x) == sin(x):
    if y == 0:
        S += [-pi,0,pi]
    elif y == 1:
        S += [ -3*pi/2, pi/2 ]
    elif y == -1:
        S += [-pi/2, 3*pi/2]
    elif y > 0:
        S += [-2*pi+xrad, -pi-xrad, xrad, pi-xrad]
    elif y < 0:
        S += [ -pi-xrad, xrad, pi-xrad, 2*pi + xrad ]
elif f(x) == cos(x):
    if y == 0:
        S += [-3*pi/2, -pi/2, pi/2, 3*pi/2]
    elif y == 1:
        S += [-2*pi, 0, 2*pi]
    elif y == -1:
        S += [-pi, pi]
    elif y == 1:
        S += [ -3*pi/2, pi/2 ]
    elif y == -1:
        S += [-pi/2, 3*pi/2]
    if y > 0:
        S += [ -2*pi + xrad, -xrad, xrad, 2*pi-xrad ]
    elif y < 0:
        wedge = pi - xrad
        S += [-pi - wedge, -pi + wedge, pi - wedge, pi + wedge]

m = choice([-3,-2,-1,2,3,4])
c = randint(-10,10)
k = choice([-2,-1,1,2])
        
# Define the problem

def Problem():
	global PROBLEM
	pretty_print(html('<h3> Problem </h3>'))
	pretty_print(html('<br />'))
	for i in PROBLEM:
		pretty_print(html(PROBLEM[i]))
	pretty_print(html('<br />'))
	return

PROBLEM[1] = 'The angle $x$ is measured in degrees.'
PROBLEM[2] = 'Solve the equation $ %s = %s $ for $x$ in the range $[-360,360]$'%(latex((m+k)*f(x)+c), latex(k*f(x) + m*y+c))

Problem()

# Define the solution

SOLUTION[0] = 'First, we need to rearrange this equation into the form $ %s = %s $'%(
    latex(f(x)),
    latex(y)
    )

SOLUTION[1] = 'Next, we take the inverse function of both sides to give $$ %s = %s '%(
    latex(x),
    latex(finv(x)).replace('x',latex(y))
    )

SOLUTION[2] = 'This gives us the fundamental solution $ x = %s $'%(
    '%.6g'%(xdeg.n(100))
    )

solstring =''
for i in range(len(S)):
    solstring += '%.4g'%((S[i]*360/(2*pi)).n(100))
    if i < len(S)-1:
        solstring += ',  '

SOLUTION[3] = 'Using the graph to find other solutions gives us the full solution set: $$\\left\\{ %s \\right\\} $$'%( solstring )

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):
    if ShowSolution==True:
    	global SOLUTION
        for line in SOLUTION:
			pretty_print(html(SOLUTION[line]))
