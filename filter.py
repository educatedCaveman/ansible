#!/usr/bin/python
import json
import sys

# count number of arguments:
if len(sys.argv) != 3:
    print('incorrect number of arguments.  takes 2 arguments.')
    sys.exit(1)

# retirieve argument
folder_id = sys.argv[1]
print(folder_id)

items = json.loads(sys.argv[2])
print(items)
