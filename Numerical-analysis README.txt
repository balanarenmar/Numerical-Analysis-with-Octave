Fixed-Point Iteration
To find a solution to p = g(p) given an initial approximation p0:
INPUT initial approximation p0; tolerance TOL; maximum number of iterations N0.
OUTPUT approximate solution p or message of failure.
Step 1 Set i=1.
Step 2 While i ≤ N0 do Steps 3 – 6.
	Step 3 Set p = g(p0).  (Compute pi.)
	Step 4 If |p-p0| < TOL then
		OUTPUT(p); (The procedure was successful.)
		STOP.
	Step 5 Set i = i + 1.
	Step 6 Set p0 = p. (Update p0.)
	Step 7 OUTPUT (‘The method failed after N0 iterations, N0 =’, N0);
		The procedure was unsuccessful.)
		STOP.

-------------------------------------------------------------------

Bisection
To find a solution to f(x) = 0 given the continuous function f on the interval [a,b], where f(a) and f(b)  have opposite signs:
INPUT endpoints a,b; tolerance TOL; maximum number of iterations N0.
OUTPUT approximate solution p or message of failure.
Step 1 Set i = 1;
FA = f(a)
Step 2 While i ≤ N0 do Steps 3 – 6.
	Step 3 Set p = a + (b - a) / 2; (Compute pi.)
		FP = f(p).
	Step 4 if FP = 0 or (b – a) / 2 < TOL then
		OUTPUT (p); (Procedure completed successfully.)
		STOP.
	Step 5 Set i = i + 1.
	Step 6 If FA ⦁ FP > 0 then set a = p; (Compute ai,bi.)
					FA = FP
				else set b = p. (FA is unchanged.)
Step 7 OUTPUT (‘Method failed after N0 iterations, N0 =’, No);
	(The procedure was unsuccessful.)
	STOP.

-------------------------------------------------------------------

Secant
To find a solution to f(x) = 0 given initial approximations p0 and p1:
INPUT initial approximations p0, p1; tolerance TOL; maximum number of iterations N0.
OUTPUT approximate solution p or message of failure.
Step 1 Set i = 2;
		q0 = f(p0);
		q1 = f(p1).
Step 2 While i ≤ N0 do Steps 3 – 6.
	Step 3 Set p = p1 – q1 (p1 – p0) / (q1 – q0). (Compute pi.)
	Step 4 If |p-p1| < TOL then
		OUTPUT (p); (The procedure was successful.)
		STOP.
	Step 5 set i = i + 1.
Step 6 Set p0 = p1; (Update p0, q0, p1, q1.)
	q0 = q1;
	p1 = p;
	q1 = f(p).
Step 7 OUTPUT (‘The method failed after N0 iterations, N0 =’, No);
	(The procedure was unsuccessful.)
	STOP.

-------------------------------------------------------------------

Gaussian Elimination
To solve the n x n linear system
			E1 : a11x1 + a12x2 + … + a1nxn = a1,n+1
			E2 : a21x1 + a22x2 + … + a2nxn = a2,n+1
			En : an1x1 + an2x2 + … + annxn = an,n+1
INPUT number of unknowns and equations n; augmented matrix A = [aij], where 1 ≤ i ≤ n and 1 ≤ j ≤ n+1.
OUTPUT solution x1,x2,…,xn or message that the linear system has no unique solution.
Step 1 For i = 1,…,n – 1 do Steps 2 – 4. (Elimination process.)
	Step 2 Let p be the smallest integer with I ≤ p ≤ n and api ≠ 0.
		If no integer p can be found
			Then OUTPUT (‘no unique solution exists’);
				STOP.
	Step 3 If p ≠ I then perform (Ep) ↔ (Ei).
	Step 4 For j = i + 1,…,n do Steps 5 and 6.
		Step 5 Set mji = aji / aii.
		Step 6 Perform (Ej – mjiEi) → (Ej);
	Step 7 If ann = 0 then OUTPUT (‘no unique solution exists’);
				STOP.
	Step 8 Set xn = an,n+1 / ann. (Start backward substitution.)
	Step 9 For i = n – 1,…,1 set xi = [aj,n + 1 - ∑nj=i+1 aijxj / aii.
	Step 10 OUTPUT (x1,…,xn); (Procedure completed successfully.)
		STOP.


