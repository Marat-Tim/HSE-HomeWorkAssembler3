# HSE_HomeWorkAssembler3
🏫 Домашнее задание №3 по курсу "Архитектуры вычислительных систем", БПИ216 Багаев Марат, Вариант 11

# Задание на 4 балла
1. Написал код на C - [code.c](code.c)
2. С помощью команды ```gcc code.c -S -o code.s -masm=intel``` получил код на ассемблере - [code.s](code.s)
3. Добавил в код на ассемблере комментарии, поясняющие эквивалентное представление переменных в программе на C - [code.s](code.s)
4. С помощью команды ```gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions code.c -S -o code_nice.s``` убрал из ассемблерного кода лишние макросы - [code_nice.s](code_nice.s)
5. Скомпилировал программу из ассемблера в исполняемый файл с помощью команды ```gcc code_nice.s -o code_nice.exe``` - [code_nice.exe](code_nice.exe) 
6. Написал на питоне тестирующий скрипт - [script.py](script.py). Тестирование ошибок не выявило

# Задание на 5 баллов
1. Функции с передачей данных через парамерты я уже использовал
2. Локальные переменные я тоже использовал
3. Добавил в [code.s](code.s) комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата
4. Комментарии о связи между парамертами функции и регистрами уже были([code.s](code.s))

# Задание на 6 баллов
1. Я заменил следующие переменные со стека на регистры:
- В функции calculate заменил аргумент double x = -40[rbp] на xmm2
- В функции calculate заменил double prev = -24[rbp] на xmm3
- В функции calculate заменил double now = -16[rbp] на xmm4
- В функции calculate заменил double pow_x = -8[rbp] на xmm5

Надеюсь этого хватит

Новый код - [code_without_vars.s](code_without_vars.s)

2. Я надеюсь, что пункта 1 хватит для пояснения эквивалентного использование регистров вместо переменных исходной программы на C
3. Я скомпилировал все программы, которые у меня были и составил таблицу со скоростями их выполнения и памятью, которую они занимают

| Программа                 | Время в секундах   | Память exe-шников в байтах | Память объектных файлов в байтах |
|:--------------------------:|:------------------:|:------------------:|:----------------------------------:|
| [code_without_vars.exe](code_without_vars.s)  | 0.0014849127       | 16304     |     3040        |
| [code_s.exe](code.s)             | 0.0016389749       | 16304               |      3056      |
| [code_c.exe](code.c)             | 0.0014942788       | 16304              |      3056      |
| [code_nice.exe](code_nice.s)          | 0.0015096718       | 16248              |   2656         |

Ура, наконец-то, замена переменных со стека на регистры сделало программу самой быстрой из всех(в прошлых дз code_without_vars.exe работал дольше всех).  

# Задание на 7 баллов
1. Возможность выбрать файлы для ввода и вывода у меня уже была(1-ый аргумент командной строки - файл для ввода, 2-ой - для вывода)

2. Проверка на корректнось числа аргументов и сообщения об ошибах тоже были раньше

3. Создал папку "multi-module project". Разделил исходную программу на 2 части. Код main функции в файле [main.s](multi-module_project/main.s) и код функции calculate в файле [calculate.s](multi-module_project/calculate.s). С помощью команды ```gcc -c *.s``` превратил их в объектные файлы и далее командой ```gcc *.o -o "multi-module code.exe"``` получил исполняемый файл. Результат в папке [multi-module_project](multi-module_project/)
