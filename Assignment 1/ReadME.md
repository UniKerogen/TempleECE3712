##### Matlab Project on Electrostatics.

###### Using the discrete summation solution in MATLAB of the integral form of Coulomb’s Law with discrete charges ΔQ from the surface charge density ρ S and surface area ΔS, determine the resulting E at a point P(x,y,z)

**Project 1 Theory 1** is not working as expected due to calculation error. The user input function section can still work.

**Project 1 Theory 2** has the proper setup. However, the calculation is not not working.

**Project 1 Branch 1** is the calculation for Theory 2 on Plate 1. In order to run this part, **_RUN_** Theory 2 first.

**Project 1 Branch 2** is the calculation for Theory 2 on Plate 2. In order to run this part, **_RUN_** Theory 2 first.

**Project 1 MagEZSurface** is the calculation for the magnitude for Electric Field on certain Z-axis point. 
  The result will be displayed in a 3D graph.
  
**Project 1 Subplot 1** is plotting vector of Electric Field on certain Z-axis point and certain Y-axis point.
  It could need some work. Graph should be reasonable. **_RUN_** Theory 2 first.

**Project 1 Subplot 2** is plotting vector of Electric Field on certain Z-axis point and certain X-axis point.
  It could need some work. Graph should be reasonable. **_RUN_** Theory 2 first.
  
**Project 1 Compiled Theory 2** is the combination of the code mentioned above. It works. Once change the DS to a much smaller number, it will take a while to generate the result as there are much more number for it to compile.



~~How to get a functional code:
1.  Use the first part from the Theory 2 till the nasty for loop.
2.  Get the section of the input for the Theory 1 and attach it behind.
    The actual calculation is the calculation inside the first for loop in Branch 1.
3.  Get the calcualtion branch from Branch 1 and attach it behind.
    Make sure you change the Y and Z inside the compiled function. Also get rid of the clf. Change the figure(3) into figure(2).
4.  Get the calculation branch from Branch 2 and attach it behind.
    Make sure you change the X and Z inside the compiled function. Also get rid of the clf.
5.  Comment the output function (disp and fprintf).
6.  Get the graphing function from Subplot 1 & 2 and attach it behind to each calculation (Step 3 & 4).~~

