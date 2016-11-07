using OrdinaryDiffEq

f = (t,u) -> u
prob = ODEProblem(f,1/2)
analytic = (t,u0) -> u0*exp(t)

sol =solve(prob::ODEProblem,Euler();dt=1//2^(4))

sol2 =solve(prob::ODEProblem,Vern9();dt=1//2^(10))

prob2 = ODEProblem(f,1/2,analytic=analytic)
sol3 =solve(prob_ode_linear,Euler();dt=1//2^(4))

appxtrue!(sol,sol2)

sol4 =solve(prob::ODEProblem,Euler();dt=1//2^(4))
test_sol = TestSolution(sol2)
appxtrue!(sol4,test_sol)

sol5 =solve(prob::ODEProblem,Euler();dt=1//2^(4))
test_sol = TestSolution(sol2.u)
appxtrue!(sol5,test_sol)

sol.appxtrue == true && sol.errors[:L2] ≈ 0.018865798306718855 && sol.errors[:L2] ≈ sol4.errors[:L2]
