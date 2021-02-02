# Assignment 1
Design: Due Thursday 1/23/20
Final: Due Thursday 2/06/20

## Goal
The goal of this assignment is to 
1. better understand three variations of matrix multiplication
2. write a program in C
3. analyze the impact of the cache on program performance.

## Program statement
Mr. Krabs needs a lightning quick matrix multiplier.

### Back story
Mr. Krabs has three suppliers for crab, lettuce, buns, sauce, etc.
Each charges different amounts for each ingredient.
He also knows how much of each he uses each day.
Sponge Bob told him that to compute the cost for each ingredient on each
day he need only do some matrix multiplication.
Mr. Krabs has hired you (and not the sponge) to implement this matrix
multiplication.

## Analysis
Given a problem statement, an analyst asks questions to better understand
*what* exactly the client's problem is (clients are notorious for not
knowing their own problems!).
In this assignment there are three key questions "What is a matrix?",
"What are the steps one takes to multiply two matrices?", and
"What is the process to select each day's supplier?"


To answer the first question, a programer thinks of a matrix as a two-dimensional array
of numbers.

For the second question, to multiply two matrices involves computing the dot product of
various rows and columns.
Rather than repeat it here, [Wolfram's Matrix Multiply Page describes the process in
detail](http://mathworld.wolfram.com/MatrixMultiplication.html "Wolfram's Matrix Multiply Page").
You may also find it helpful to [do a simple exercise](https://www.mathsisfun.com/algebra/matrix-multiplying.html "Matrix Multiple Exercise") provides
a simple example.


In our case, Mr. Krabs purchased an algorithm for you to implement (from
Plankton's algorithm emporium).
Call this *Version 1*.
In this algorithm the values in the product matrix are computed one by one
using a loop that iterates k times to compute the dot product of row r from
the first matrix and column c from the second.
In pseudo code this is
```
  for each row r
    for each column c
      for each index k
        product[r][c] += A[r,k] * B[k,c]
```

assuming that `product` is initialized to all zeros.


Filling the matrices Mr. Krabs will use into the algorithm above, yields
```
  for each row r = Monday then Tuesday
    for each column c = Sandy then Squidward
       for each index k = Crab then Lettuce
         product[r,c] += usage[r,k] * costs[k,c]
```

The final question is best answered with an example.
Consider the following product.

||| *cost* matrix|||||*usage* matrix||
|---|---|---|---|---|---|---|---|---|
||Crab|Lettuce|||||Sandy|Squidward|
|Mon|8|1||\*||Crab|1.99|1.50|
|Tue|2|9||||Lettuce|2.99|4.50|

Here is a trace each time `product` is updated:
```
  product[Monday][Sandy] += 8 * 1.99          // k = Crab
  product[Monday][Sandy] += 1 * 2.99          // k = Lettuce
  product[Monday][Squidward] += 8 * 1.50      // k = Crab
  product[Monday][Squidward] += 1 * 4.50      // k = Lettuce

  product[Tuesday][Sandy] += 2 * 1.99         // k = Crab
  product[Tuesday][Sandy] += 9 * 2.99         // k = Lettuce
  product[Tuesday][Squidward] += 2 * 1.50     // k = Crab
  product[Tuesday][Squidward] += 9 * 4.50     // k = Lettuce
```

The resulting matrix is:

||Sandy|Squidward|
|---|---|---|
|Mon|18.91|16.50|
|Tue|30.89|43.50|

Here, the product matrix says that Mr. Crabs should order from Squidward on
Monday (because the total cost of 16.50 is less than Sandy's 18.91), while on
Tuesday he should order from Sandy.

So far so good, but, alas, as these things go, there was what has become
known in Bikini Bottom as **the debate**:
1. Patrick said that he knows a better way -- **change the order of the outer
two loops** (this is *Version 2*)
2. Sponge bob said Patrick is wrong, you want to **change the order of the inner
two loops** (this is *Version 3*).

Mr. Krabs threw up his claws and has since decided to task you (he pays well)
with understanding how all three work.

## Design Requirements
Due: Thursday 1/23/20

1. Add *Buns* to the list of supplies Mr. Crabs needs daily, and also add the
day *Wednesday*.  
    * He needs 10 Buns on Monday, 6 on Tuesday, and 3 on Wednesday.  
    * On Wednesday his needs also include 3 Crab and 4 Lettuce.  
    * Sandy charges 0.50 for Buns while Squidward charges 0.60.  

2. Trace the computation of the product as done above using all three versions of
the multiplication algorithm (original, Patrick's, and Sponge Bob's).

3. Record each trace in a simple text file named **Asgn1Design.txt** that begins with the header.
```
 // This is my work
 // <Your Name>
 // CS366\fP
```

Note: Each of the three traces should be labeled with the name of the version and the psudeo code used to produce it.

4. For each of the three traces, use the result to answer the
question "On each day, who should Mr. Crabs purchase supplies from?"

5. At the end of all three traces, weigh in on the debate by explaining which
algorithm is better and why you think so.

### What to hand in
1. Be sure to add, commit, and push your **Asgn1Design.txt** file before the due date for this asignment.
2. Also include a no-more-than-one page summary of [this article about cpu caching](https://www.extremetech.com/extreme/188776-how-l1-and-l2-cpu-caches-work-and-why-theyre-an-essential-part-of-modern-chips "Caching article") in a file called **summary.txt** in this repository.

## Implementation requirements
Due: Thursday 2/06/20

1. Edit mm.c to include with the following *header comment*
```
 // This is my code
 // <Your Name>
 // CS366\fP
```
2. Right after the header comment, include a comment with the machine name,
processor model, cache size, as
well as the sizes of the L1, L2, and L3 caches.  Use the commands `lscpu` and `hostname` to help.  
3. In mm.c, write the body (and appropriate comments) of a function to calculate C = A * B. The function to edit is 
```
void multiply(array A, array B, array C, int n)
```  

4. Create functions `patrick` and `sponge` for the two corresponding variants.
5. You code should generate no warnings or errors when compiles with `gcc -Wall`

### What do hand in
1. Be sure to commit and push mm.c before the due date for this assignment.
2. Include a summary in **matmult.txt** explaining who was right and why you think the order does or does not matter. Include and refer to a copy of your program's output in your explanation.
3. Make sure that you have no commited any "derivable" files (e.g., .o or executable files).
