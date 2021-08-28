#!/bin/sh

echo "Starting Compiler Explorer container..."
docker start ubuntu-compiler-explorer || docker run --name=compiler-explorer -p 10240:10240 -d ubuntu-compiler-explorer # -v /additional/libs:/shared 
echo "Compiler Explorer will be available at http://localhost:10240"
