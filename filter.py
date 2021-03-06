#!/usr/bin/python
import json
import sys

# count number of arguments:
if len(sys.argv) != 3:
    print('incorrect number of arguments.  takes a single argument')
    sys.exit(1)

# retirieve argument
folder_id = sys.argv[1]

print(f'the folder ID to filter on is {folder_id}'
)