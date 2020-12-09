
#IPOPT_LIBS=-L${IPOPT_HOME}/lib -L${IPOPT_HOME}/include -lipopt -lcoinmumps -lgfortran
IPOPT_LIBS=

all: pmedian pmedian_coek

pmedian: pmedian.cpp
	c++ -O3 pmedian.cpp -o pmedian -I${GUROBI_HOME}/include -L${GUROBI_HOME}/lib/ -lgurobi_c++ -lgurobi90

pmedian_coek: pmedian_coek.cpp
	g++ -std=c++17 -O3 pmedian_coek.cpp -o pmedian_coek  -L${GUROBI_HOME}/lib/ -I${COEK_HOME}/include -L${COEK_HOME}/lib/ -lcoek ${IPOPT_LIBS} -lgurobi_g++5.2 -lgurobi90

run:
	./testgurobi.sh > testgurobi.out 2>&1
	./testgurobipy.sh > testgurobipy.out 2>&1
	./testcoek.sh > testcoek.out 2>&1
	./testpoek.sh > testpoek.out 2>&1
	./testpp.sh > testpp.out 2>&1
	./testpyomo1.sh > testpyomo1.out 2>&1

clean:
	\rm -f pmedian pmedian_coek *.out *.log *.csv *.lp
