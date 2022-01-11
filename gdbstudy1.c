/*************************************************************************
	> File Name: gdbstudy.c
	> Author: 
	> Mail: 
	> Created Time: 2022年01月11日 星期二 21时36分21秒
 ************************************************************************/

#include<stdio.h>

void hello()
{
    printf("hello echo~");
}

int main(void)
{
    int arr[4] = {1, 2, 3, 4};
    int i;
    for (i = 0; i < 4; ++i)
    {
        printf("%d\n", arr[i]);
    }
    hello();
    printf("\n");
    return 0;
}
