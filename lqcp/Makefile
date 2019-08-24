
all: lqcp lqcp_coek

lqcp: lqcp.cpp
	c++ -O2 lqcp.cpp -o lqcp -I${GUROBI_HOME}/include -L${GUROBI_HOME}/lib/ -lgurobi_c++ -lgurobi81

lqcp_coek: lqcp_coek.cpp
	g++ -std=c++11 -O3 lqcp_coek.cpp -o lqcp_coek -I${COEK_HOME}/include -L${COEK_HOME}/lib/ -lcoek -lipopt -lgfortran -lgurobi_g++5.2 -lgurobi81

run:
	./testgurobi.sh > testgurobi.out 2>&1
	./testpoek.sh > testpoek.out 2>&1
	./testcoek.sh > testcoek.out 2>&1
	./testpyomo.sh > testpyomo.out 2>&1

clean:
	\rm -f lqcp lqcp_coek
