#!/usr/bin/python
import json
import sys
from tabulate import tabulate

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

host_map = []

for entry in items:
    if entry['folderId'] == folder_id:
        # print(json.dumps(entry, indent=4))
        hostname = entry['name']
        password = entry['login']['password']
        host_map.append([hostname, password])
        count += 1

print(tabulate(host_map))

print(count)

# print(json.dumps(items, indent=4))
