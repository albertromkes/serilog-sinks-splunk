#!/bin/bash

# Ensure any exit code exits TravisCI
set -e

dotnet restore
for path in src/*/project.json; do
    dirname="$(dirname "${path}")"
    dotnet build ${dirname}
done 

for path in sample/project.json; do
    dirname="$(dirname "${path}")"
    dotnet build ${dirname}
done 

for path in test/Serilog.Sinks.Splunk.Tests/project.json; do
    dirname="$(dirname "${path}")"
    dotnet build ${dirname} -f netcoreapp1.0 -c Release
    dotnet test ${dirname} -f netcoreapp1.0  -c Release
done