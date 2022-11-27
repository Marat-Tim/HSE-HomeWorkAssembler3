#include "stdio.h"
#include "math.h"

double calculate(double x) {
    double prev, now, pow_x;
    prev = 0;
    now = 1;
    pow_x = x;
    while (fabs(now - prev) > 0.0005) {
        prev = now;
        now += pow_x;
        pow_x *= x;
    }
    return now;
}

int main(int argc, char **argv) {
    FILE *in, *out;
    if (argc == 3) {
        in = fopen(argv[1], "r");
        out = fopen(argv[2], "w");
        if (in == NULL || out == NULL) {
            printf("Error when working with files\n");
            return 1;
        }
    } else {
        printf("Since no input and output files are specified, stdin and stdout will be used\n");
        in = stdin;
        out = stdout;
    }
    double x;
    fscanf(in, "%lf", &x);
    if (x >= 1 || x <= -1) {
        printf("Input value must be in range (-1, 1)\n");
        return 1;
    }
    fprintf(out, "%lf\n", calculate(x));
    fclose(in);
    fclose(out);
    return 0;
}
