import os
import time
from random import random, randint

in_path = "in.txt"
out_path = "out.txt"


def main():
    programs_names = [filename for filename in os.listdir() if filename[-3:] == "exe"]
    programs_time = {key: [] for key in programs_names}

    for _ in range(10000):
        random_value = random() * (1 if randint(0, 1) else -1) + (randint(-1000, 1000) if randint(1, 10) == 1 else 0)
        with open(in_path, 'w') as f:
            f.write(str(random_value))

        answers = set()
        for program_name in programs_names:
            start_t = time.time()
            os.system(f"./{program_name} < {in_path} > {out_path}")
            end_t = time.time()
            programs_time[program_name].append(end_t - start_t)
            with open(out_path, 'r') as f:
                answers.add(f.read())
        if len(answers) > 1:
            print("Ответы некоторых программ не совпадают")
            return 
    print("Ошибок не найдено\nСреднее время выполнения:")
    out_length = len(max(programs_names)) + 2 + 12
    for program_name in programs_names:
        print(f"{program_name}: " + f"{(sum(programs_time[program_name]) / len(programs_time[program_name])):.10f}".rjust(out_length - len(program_name) + 2))


main()

