#
# This python scripts creates a text of HTML summary of the performance results in a
# directory.
#
# TODO: add command-line parser that can accept an option to specify the format.
#

import os.path
import sys
import glob
import pandas
import tabulate
import csv

problems = set()
sizes = set()
data = {}
for fname in glob.glob(os.path.join(".", sys.argv[1],"*.csv")):
    with open(fname) as csvfile:
        reader = csv.reader(csvfile)
        first=True
        
        for row in reader:
            if first:
                first=False
                problems.add(row[1])
                problem=row[1]
            else:
                size = int(row[0])
                sizes.add(size)
                if (row[2] == "ok"):
                    data[problem, size] = round(float(row[1]),2)
                else:
                    data[problem, size] = row[2]

results = {}
results['Modeling'] = []
for size in sorted(sizes):
    results[str(size)] = []
for problem in sorted(problems):
    results['Modeling'].append(problem)
    for size in sizes:
        results[str(size)].append( data.get((problem,size), "missing") )

print("-"*70)
print("Data Summary: "+sys.argv[1])
print("-"*70)

print("")
print("Runtime Performance (seconds)")
df = pandas.DataFrame(results)
print(tabulate.tabulate(df, headers='keys', tablefmt='psql', showindex="never"))

if "gurobi" in problems:
    for size in sizes:
        if not ("gurobi",size) in data:
            print("Cannot normalize with Gurobi:  missing data")
            sys.exit(0)
        try:
            gval = float(data["gurobi",size])
        except ValueError:
            print("Cannot normalize with Gurobi:  non-numeric value")
            sys.exit(0)

        size_str = str(size)
        i=0
        for problem in sorted(problems):
            try:
                pval = float(results[size_str][i])
            except ValueError:
                # We just skip data that isn't numeric
                continue
            results[size_str][i] = round(pval/gval,2)
            i = i+1

    print("")
    print("Normalized Performance (relative to Gurobi)")
    df = pandas.DataFrame(results)
    print(tabulate.tabulate(df, headers='keys', tablefmt='psql', showindex="never"))

            
    


    
        


