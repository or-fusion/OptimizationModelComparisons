
all: facility facility_coek

facility: facility.cpp
	c++ -O2 facility.cpp -o facility -I${GUROBI_HOME}/include -L${GUROBI_HOME}/lib/ -lgurobi_c++ -lgurobi81

facility_coek: facility_coek.cpp
	g++ -std=c++11 -g facility_coek.cpp -o facility_coek -I${COEK_HOME}/include -L${COEK_HOME}/lib/ -lcoek -lipopt -lgfortran -lgurobi_g++5.2 -lgurobi81

OLD: facility_coek.cpp
	g++ -std=c++11 -O3 facility_coek.cpp -o facility_coek -I${COEK_HOME}/include -L${COEK_HOME}/lib/ -lcoek -lipopt -lgfortran -lgurobi_g++5.2 -lgurobi81

run:
	./testgurobi.sh > testgurobi.out 2>&1
	./testpoek.sh > testpoek.out 2>&1
	./testcoek.sh > testcoek.out 2>&1
	./testpyomo.sh > testpyomo.out 2>&1

clean:
	\rm -f facility facility_coek
