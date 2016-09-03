import sys
N=int(sys.argv[1])
f=open(sys.argv[2])
for i in range(N):
    line=f.next().strip()
    print line
f.close()