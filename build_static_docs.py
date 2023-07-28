#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import json
import re
import os

PATH_DBT_PROJECT = ""
IGNORED_PROJECTS = ['metrics', 'dbt_utils']

search_str = 'o=[i("manifest","manifest.json"+t),i("catalog","catalog.json"+t)]'

with open(os.path.join(PATH_DBT_PROJECT, 'target', 'index.html'), 'r') as f:
    content_index = f.read()
    
with open(os.path.join(PATH_DBT_PROJECT, 'target', 'manifest.json'), 'r') as f:
    json_manifest = json.loads(f.read())

for element_type in ['nodes', 'sources', 'macros', 'parent_map', 'child_map']:
    for key in list(json_manifest.get(element_type, {}).keys()):  
        for ignore_project in IGNORED_PROJECTS:
            if re.match(fr'^.*\.{ignore_project}\.', key):
                del json_manifest[element_type][key]
    
with open(os.path.join(PATH_DBT_PROJECT, 'target', 'catalog.json'), 'r') as f:
    json_catalog = json.loads(f.read())

# create single docs file in public folder
with open(os.path.join(PATH_DBT_PROJECT, 'docs', 'index.html'), 'w') as f:
    new_str = "o=[{label: 'manifest', data: "+json.dumps(json_manifest)+"},{label: 'catalog', data: "+json.dumps(json_catalog)+"}]"
    new_content = content_index.replace(search_str, new_str)
    f.write(new_content)
