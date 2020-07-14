#!/usr/bin/env bash

docker exec client ls /volume/dir1/
docker exec server touch /volume/dir1/file1.txt
docker exec client ls /volume/dir1/

docker exec server ls /volume/dir2/
docker exec client touch /volume/dir2/file2.txt
docker exec server ls /volume/dir2/
