from random import seed, randint
import sys

RANDOM_SEED = 0
STAR_COUNT = 8
LAYER_COUNT = 4
MIN = -128
MAX = 127

seed(RANDOM_SEED)

# Randomize lists of stars with distinct x values
layers = []
for i in range(0, LAYER_COUNT):
    stars = {}
    while len(stars) < STAR_COUNT:
        stars[randint(MIN, MAX)] = randint(MIN, MAX)

    layers.append(stars)

for layer in layers:
    sys.stdout.write(
        ",".join("{},{}".format(y, x) for x, y in layer.items()) + "\n"
    )
