#!/bin/bash

# 定义变量
OUTDIR=/opt  #不能加空格

# 使用变量
echo "output to : ${OUTDIR}"  #输出
ls ${OUTDIR}  #相当于执行了ls /opt
ls $OUTDIR  #{}定界符

