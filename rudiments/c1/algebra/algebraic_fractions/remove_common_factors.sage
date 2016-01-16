try:
    # if old_html ist not yet defined
    old_html == None
except NameError:
    # set it to the current html function
    old_html = html
    # and define a wrapper
    def html(*args):
        pretty_print(old_html(*args))

L = range(-3,4)

L.remove(0)
a = Integer(choice(L))
b = Integer(choice(L))
L.remove(b)
c = Integer(choice(L))

m = Integer(choice([0,1,2]))
n = Integer(choice([1,2,3]))
k1 = Integer(choice([1,2]))
k2 = Integer(choice([1,2]))
k2 = k1*k2

f(x) = k1*x^m*(x-a)*(x-b)
f(x) = f(x).expand()
g(x) = k2*x^n*(x-a)*(x-c)
g(x) = g(x).expand()

F = f(x).coefficients(sparse=False)
G = g(x).coefficients(sparse=False)

i = 0
for c in F:
    if c == 0:
        i += 1
    else:
        break
gdf = GCD(F) * x^i
f1(x) = f(x)/gdf
f1(x) = f1(x).rational_simplify()

j = 0
for c in G:
    if c == 0:
        j += 1
    else:
        break
gdg = GCD(G) * x^j
g1(x) = g(x)/gdg
g1(x) = g1(x).rational_simplify()

html('<h3> Problem </h3> Factorise the following expression by removing common factors: $$ %s $$'%( latex(g(x)) ))
html('<br />')

@interact
def Midpoint(ShowHint=checkbox(default=False, label='Hint')):
    if ShowHint==True:
        html('There is a common factor of $%s$ in each term'%(latex(gdg)))
        
@interact
def Midpoint(ShowSolution=checkbox(default=False, label='Solution')):    
    global f1, g1
    if ShowSolution==True:
        string2 = latex(g(x))
        string2 = '%s \\left( %s \\right)'%(latex(gdg),latex(g1(x)))
        html('There is a common factor of $ %s $ so we may rewrite the expression as $ %s $'%( latex(gdg), string2 ))
        html('<br />')
        html('You should check your work by multiplying out again (in your head, if you like)')
