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
ssh_items = {}

count = 0

for entry in items:
    print(type(entry))
    print('found a relevant entry!')
    count += 1

print(count)

# print(json.dumps(items, indent=4))
