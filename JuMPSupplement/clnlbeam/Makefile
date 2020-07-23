
#IPOPT_LIBS=-L${IPOPT_HOME}/lib -L${IPOPT_HOME}/include -lipopt -lcoinmumps -lgfortran
IPOPT_LIBS=

all: clnlbeam_coek

clnlbeam_coek: clnlbeam_coek.cpp
	g++ -std=c++17 -O3 clnlbeam_coek.cpp -o clnlbeam_coek -L${GUROBI_HOME}/lib/ -I${COEK_HOME}/include -L${COEK_HOME}/lib/ -lcoek ${IPOPT_LIBS} -lgurobi_g++5.2 -lgurobi90

run:
	./testcoek.sh > testcoek.out 2>&1
	./testpoek.sh > testpoek.out 2>&1
	./testpp.sh > testpp.out 2>&1
	./testpyomo1.sh > testpyomo1.out 2>&1
	./testpyomo2.sh > testpyomo2.out 2>&1

clean:
	\rm -f clnlbeam_coek *.out *.log *.csv *.nl
