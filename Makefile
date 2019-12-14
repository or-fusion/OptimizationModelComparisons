all:
	- cd clnlbeam; make
	- cd fac; make
	- cd knapsack; make
	- cd lqcp; make
	- cd nqueens; make
	- cd pmedian; make

clean:
	cd clnlbeam; make clean
	cd fac; make clean
	cd knapsack; make clean
	cd lqcp; make clean
	cd nqueens; make clean
	cd pmedian; make clean

