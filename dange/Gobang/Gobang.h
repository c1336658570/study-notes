# pragma once

# include <stdio.h>
# include <string.h>

# define ROW 30
# define COL 30

# define PLAYER1 1
# define PLAYER2 2

# define NEXT        0
# define PLAYER1_WIN 1
# define PLAYER2_WIN 2
# define DRAW        3

enum Dir
{
    LEFT,
    RIGHT,
    UP,
    DOWN,
    LEFT_UP,
    LEFT_DOWN,
    RIGHT_UP,
    RIGHT_DOWN
};

void Menu();
void Game();
int result(int board[][COL], int row, int col);
void PlayerMove(int board[][COL], int row, int col, 
        int player);
void ShowBoard(int board[][COL], int row, int cal);
