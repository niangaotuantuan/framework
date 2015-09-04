import sys
#filter vocabulary for word sim evaluation
#Need another evaluation dictionary
d = {}
for line in open(sys.argv[1], 'r'):
  d[line.strip()] = 0

for line in sys.stdin:
  if line.strip().split()[0] in d: print line.strip()
