try:
    # if old_html ist not yet defined
    old_html == None
except NameError:
    # set it to the current html function
    old_html = html
    # and define a wrapper
    def html(*args):
        pretty_print(old_html(*args))

var('y')
var('x')

L = range(1,11)
k1 = 2*Integer(choice(L))
k2 = 2*Integer(choice(L))

L = range(1,6)
m1 = Integer(choice(L))
m2 = Integer(choice(L))
n1 = Integer(choice(L))
n2 = Integer(choice(L))

num(x) = k1*x^m1*y^n1
den(x) = k2*x^m2*y^n2

html('<h3> Problem </h3> Simplify as much as possible the fraction $$ \\frac{%s}{%s} $$'%( latex(num(x)), latex(den(x)) ))
html('<br />')

@interact
def Hint(ShowHint=checkbox(default=False, label='Hint')):
    if ShowHint==True:
        html('Write the numerator and denominator as a product of lots of factors multiplied together and cancel the common factors.')
        
@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):    
    if ShowSolution==True:
        html('In the simplest form, this fraction is $$%s$$'%( latex(num(x)/den(x)) ))