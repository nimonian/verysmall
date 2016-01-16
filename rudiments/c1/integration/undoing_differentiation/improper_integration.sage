var('x')

a = randint(-5,5)
b = randint(-5,5)
c = randint(-5,5)
d = randint(-5,5)

f(x) = a*x^3 + b*x^2 + c*x + d
F(x) = f(x).integrate(x)

pretty_print(html('<h3> Problem </h3>'))
pretty_print(html('<br />'))

pretty_print(html('Find an expression for $$ \int_{a}^{b} %s \, dx $$'%(latex(f(x)))))

SOLUTION = dict()

SOLUTION[1] =   ' $$ \\int_{a}^{b} %s \\, dx = %s %s $$'%(
                latex(f(x)),
                latex(F(x)),
                '+c'
                )

@interact
def Solution(ShowSolution=checkbox(default=False, label='Solution')):    
    if ShowSolution==True:
        for line in SOLUTION:
            pretty_print(html(
                SOLUTION[line]
                ))