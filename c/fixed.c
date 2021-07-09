#include <stdio.h>

void fixed_addition(void)
{
    /**
     * Let's imagine that all the integers we are using have an imaginary "scale factor" associated
     * 
     * 
     * Scale factor -> N = 10 
     * 5     + 6     = 11
     * equals
     * N*0.5 + N*0.6 = N*1.1
     * 
     * 
     * If we want this ->   0.5 +   0.6 =   1.1
     *    we  do  this ->     5 +     6 =    11
     *  what we get is -> N*0.5 + N*0.6 = N*1.1
     * 
     * 
     * N*X + N*Y = N*(X+Y) 
     * 
     * They can overflow !!!
     * A = 128
     * B = 128
     * C = 256 = 0 !!!
     * 
     **/
    #define SCALE_FACTOR 10.0F
    unsigned char A = 5; //this is really 0.5
    unsigned char B = 6; //this is really 0.6
    unsigned char C;
    C = A + B; //C is now 11 with integer math but is really 1.1 when we take into account the scale factor
    printf("%d + %d = %d\n", A, B, C);
    printf("%f + %f = %f\n", A / SCALE_FACTOR, B / SCALE_FACTOR, C / SCALE_FACTOR);
}

void fixed_multiplication(void)
{
    /**
     * 
     * N*X * N*Y = N²*(X*Y)
     * The scale factor is scaled in the result !!!
     * 
     * We have to divide by N to get N*(X*Y)
     * or
     * we can keep it for more resolution
     * 
     * Be careful
     * 8bits x 8bits = 16bits !!! for the result
     * 
     **/ 
    #define SCALE_FACTOR 10.0F
    unsigned char A = 5; //this is really 0.5
    unsigned char B = 6; //this is really 0.6
    unsigned char C;
    unsigned short C_temp;      //intermediate term needs to have more bits
    C_temp = A * B;             //C is now 30 with integer math but is scaled from the true number by SCALE_FACTOR squared !!!
    C = C_temp / SCALE_FACTOR;  //C is now 3 what is the real 0.3 scaled by SCALE_FACTOR
    printf("%d * %d = %d(%d)\n", A, B, C, C_temp);
    printf("%f * %f = %f\n", A / SCALE_FACTOR, B / SCALE_FACTOR, C / SCALE_FACTOR);
}

int main(void)
{
    fixed_addition();
    fixed_multiplication();
    return 1;
}