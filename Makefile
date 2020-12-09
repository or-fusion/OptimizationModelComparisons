all:
	- cd sandia; make
	- cd JuMPSupplement; make
	- cd cute; make

gurobi:
	- cd sandia; make gurobi
	- cd JuMPSupplement; make gurobi
	- cd cute; make gurobi

coek:
	- cd sandia; make gurobi
	- cd JuMPSupplement; make gurobi
	- cd cute; make gurobi

clean:
	- cd sandia; make clean; cd ..
	- cd JuMPSupplement; make clean; cd ..
	- cd cute; make clean; cd ..

