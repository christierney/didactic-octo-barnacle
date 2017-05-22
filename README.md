# usage

    ./parse.sh [file.chlsj]

Produces ‘[file.csv]` and ‘[file-analysis.csv]`.

May need to make `parse.sh` and `jq-osx-amd64` executable. `jq` binary from https://stedolan.github.io/jq/download/.

You can also run the python script on an individual file to see the percentage of time it hits each cache layer. You need to pass in the entire [file.csv] path

    python [file.csv] true 
