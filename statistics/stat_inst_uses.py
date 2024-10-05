from collections import defaultdict
from pathlib import Path
from tabulate import tabulate

if __name__ == "__main__":
    count = defaultdict(int)
    all_count = 0

    with open(Path("trace.txt"), "r") as f:
        for line in f.readlines():
            # inst, user = line.split("<-")
            count[line] += 1
            all_count += 1

    data = sorted([[k, v] for k, v in count.items()], key=lambda arr: arr[1], reverse=True)

    data_to_print = list(map(lambda arr: [arr[0], f"{arr[1] / all_count:2.1%}"], data))
    print(tabulate(data_to_print, headers=['"Instruction <- User"', "Percentage"]))