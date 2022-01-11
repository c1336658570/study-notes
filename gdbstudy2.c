/*************************************************************************
	> File Name: gdbstudy2.c
	> Author: 
	> Mail: 
	> Created Time: 2022年01月11日 星期二 22时41分16秒
    >调试正在运行的程序
************************************************************************/

//test test1 两个函数
//i i++
//main函数调用 test test1

#include<stdio.h>

void test()
{
    
}

void test1()
{
    int i = 0;
    i++;
}

int main(void)
{
    for (; ;)
    {
        test();
        test1();
    }
    

    return 0;
}
