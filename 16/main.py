class Complex(complex):
    __lt__=lambda s,o: (s.imag,s.real) < (o.imag,o.real)
    __add__=lambda s,o: Complex(complex(s)+o)

import heapq

grid = open("16/16.txt").read().splitlines()
grid = {Complex(x,y):c for y,r in enumerate(grid) for x,c in enumerate(r)}
start = next(z for z in grid if grid[z]=='S')
end = next(z for z in grid if grid[z]=='E')

queue = [(0, start, 1, [start])]
seen = {}
best = set()
low = float("inf")

while queue:
    score, loc, face, path = heapq.heappop(queue)
    if score>low: break
    if loc == end:
        if low>score: best.clear()
        low = score
        best |= set(path)
    seen[loc,face] = score

    for d in map(Complex,(-1,1,-1j,1j)):
        if grid.get(loc+d,'#')=='#': continue
        cost = 1001 if d!=face else 1
        if seen.get((loc+d,d),float("inf")) > score+cost:
            heapq.heappush(queue, (score+cost, loc+d, d, path+[loc+d]))

print(f"part 1: {low} part2: {len(best)}")