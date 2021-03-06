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
    if entry['folderId'] == folder_id
        print(entry['folderId'])
        print('found a relevant entry!')
        count += 1
    else:
        print("'{id1} != '{id2}'".format(id1=entry['folderId'], id2=folder_id))

print(count)

# print(json.dumps(items, indent=4))
