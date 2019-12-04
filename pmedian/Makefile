
all: pmedian pmedian_coek

pmedian: pmedian.cpp
	c++ -O2 pmedian.cpp -o pmedian -I${GUROBI_HOME}/include -L${GUROBI_HOME}/lib/ -lgurobi_c++ -lgurobi81

pmedian_coek: pmedian_coek.cpp
	g++ -std=c++11 -O3 pmedian_coek.cpp -o pmedian_coek -I${COEK_HOME}/include -L${COEK_HOME}/lib/ -lcoek -lipopt -lgfortran -lgurobi_g++5.2 -lgurobi81

run:
	./testgurobi.sh > testgurobi.out 2>&1
	./testpoek.sh > testpoek.out 2>&1
	./testcoek.sh > testcoek.out 2>&1
	./testpyomo.sh > testpyomo.out 2>&1

clean:
	\rm -f pmedian pmedian_coek *.out *.log *.csv
