#!/usr/bin/env python

import json
import yaml

print json.dumps(yaml.load(open('inventory.yml', 'r')), sort_keys=True, indent=4, separators=(',', ': '))

