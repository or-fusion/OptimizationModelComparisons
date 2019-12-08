all:
	- cd pmedian; make
	- cd knapsack; make
	- cd fac; make
	- cd lqcp; make

clean:
	cd pmedian; make clean
	cd knapsack; make clean
	cd fac; make clean
	cd lqcp; make clean

