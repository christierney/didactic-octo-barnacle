import csv
import os
import sys

# Open csv file
input_filename = sys.argv[1]
input_dir = os.getcwd()
input_csv_filename = "{dir}/{name}".format(dir=input_dir, name=input_filename)
print "Opening " + input_csv_filename
input_csv = open(input_csv_filename)
reader = csv.reader(input_csv, delimiter=",")
rows = []

hit_order = ["Origin", "X-Cache-CF", "X-Cache-Remote", "X-Cache"]
header = ["Responses"] + hit_order + ["Latency", "Duration"]
hit_percentages = [0, 0, 0, 0]

for row in reader:
    if "time" in row[0]:
        continue

    latency = float(row[1])
    duration = float(row[2])

    hit_cf = row[5] == "true"
    hit_xr = row[6] == "true"
    hit_xc = row[7] == "true"
    hit_or = not (hit_cf or hit_xr or hit_xc)
    
    info = []
    hits = [hit_or, hit_cf, hit_xr, hit_xc]

    for i in range(0, len(hits)):
        hit = hits[i]
        if hit:
            info.append(str(i+1))
            hit_percentages[i] += 1
        else:
            info.append("0")
            
    info += [str(latency), str(duration)]
    rows.append(info)

output_filename = os.path.splitext(input_csv_filename)[0] + "-analysis.csv"
output_csv = open(output_filename, "w")
output_csv.write(",".join(header)+"\n")

for i in range(0, len(rows)):
    row = 'r{num}, {vals}\n'.format(num=str(i), vals=",".join(rows[i]))
    output_csv.write(row)

output_csv.close()

print "\nPercentage of requests that hit each endpoint\n---------------------------------------------"
for i in range(0, len(hit_percentages)):
    percentage = "{0:.2f}".format(hit_percentages[i]/(len(rows)*1.0)*100.0)
    print hit_order[i] +": " + percentage + "%"
print "\n"


    
