
all: clnlbeam_coek

clnlbeam_coek: clnlbeam_coek.cpp
	g++ -std=c++11 -O3 clnlbeam_coek.cpp -o clnlbeam_coek  -L${GUROBI_HOME}/lib/ -I${COEK_HOME}/include -L${COEK_HOME}/lib/ -lcoek -lgurobi_g++5.2 -lgurobi81

run:
	./testcoek.sh > testcoek.out 2>&1
	./testpoek.sh > testpoek.out 2>&1
	./testpp.sh > testpp.out 2>&1
	./testpyomo1.sh > testpyomo1.out 2>&1
	./testpyomo2.sh > testpyomo2.out 2>&1

clean:
	\rm -f clnlbeam_coek *.out *.log *.csv *.nl
