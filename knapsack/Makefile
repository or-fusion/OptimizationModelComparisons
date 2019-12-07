
all: knapsack knapsack_coek

knapsack: knapsack.cpp
	c++ -O3 knapsack.cpp -o knapsack -I${GUROBI_HOME}/include -L${GUROBI_HOME}/lib/ -lgurobi_c++ -lgurobi81

knapsack_coek: knapsack_coek.cpp
	g++ -std=c++11 -O3 knapsack_coek.cpp -o knapsack_coek  -L${GUROBI_HOME}/lib/ -I${COEK_HOME}/include -L${COEK_HOME}/lib/ -lcoek -lgurobi_g++5.2 -lgurobi81

run:
	./testgurobi.sh > testgurobi.out 2>&1
	./testgurobipy.sh > testgurobipy.out 2>&1
	./testcoek.sh > testcoek.out 2>&1
	./testpoek.sh > testpoek.out 2>&1
	./testpp.sh > testpp.out 2>&1
	./testpyomo1.sh > testpyomo1.out 2>&1

clean:
	\rm -f knapsack knapsack_coek *.out *.log *.csv *.lp
