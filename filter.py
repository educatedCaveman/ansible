#!/usr/bin/python
import json
import sys

# count number of arguments:
if len(sys.argv) != 3:
    print('incorrect number of arguments.  takes 2 arguments.')
    sys.exit(1)

# retirieve argument, but remove quotes from it
raw_in = sys.argv[1]
folder_id = raw_in[1:-1]
print(folder_id)

items = json.loads(sys.argv[2])
ssh_items = {}

count = 0

for entry in items:
    if entry['folderId'] == folder_id:
        print(json.dumps(entry, indent=4))
        count += 1

print(count)

# print(json.dumps(items, indent=4))
