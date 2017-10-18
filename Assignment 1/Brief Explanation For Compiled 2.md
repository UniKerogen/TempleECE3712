### This is the brief explanation for the code for Compiled Theory 2 file.

**DS** : the corresponding side length of the differential area that you need or desired.
**bmonth**: pick a month you want to.
**bdate**: pick a date you want to.
**year**: radom year.

##### How does the code work:
It calculate a specific point for the E and then distribute it into X, Y, Z direction using unit vector method.

It uses summation for the differentail area of DS^2 to calculate E. ΔQ will be the ρs*(DS^2). 

**R** would be the distance between those two desired point. By using _(x-x1)^2+(y-y1)^2+(z-z1)^2_ to find the corresponding R^2.

**Unit Vector aR** will be expressed as Vector/|Vector|. So in the code it would be _[(x-x1)ax+(y-y1)ay+(z-z1)az]/[(x-x1)^2+(y-y1)^2+(z-z1)^2]^(1/2)_.

Hence, after some simplification, you wil get each part of the calculation in the code.

##### Each Section Explaination:
1. The first seciton is for general graph generation and also initializing some critical values for this project. 
  It will generate a 3D graph for the two plate. It will also determine whether you bmonth is bigger than bdate or not.
  ![Alt text](https://user-images.githubusercontent.com/28737574/31746829-5e6dd21e-b437-11e7-88e4-55c86e3ed756.png)
2. The second section is the numerical value for several critical numbers.
   ![Alt text](https://user-images.githubusercontent.com/28737574/31746797-3029af9a-b437-11e7-90f3-9e67ad6a16e8.png)
3. The thrid section is about calculation for the first situation. (Refer to the project PDF file). It will generate a 3D graph for the vector.
    ![Alt text](https://user-images.githubusercontent.com/28737574/31746799-3081f1a0-b437-11e7-8da4-b3bcf029211b.png)
4. The fourth section is about calcualtion for the second situation. It will generate a 3D graph for the vector.
5. The fifith section is for user input, it will give out the value for the vector E in x,y,z direction.

##### Miscellaneous:
1. The quiver3 funciton is used to generate the graph for the 3D vector at certain point.
2. X,Y,Z get overwrote for each section of calculation.
3. Graphs generally looks like what they are supposed to be. There could be some parts that need some kind of modification.
