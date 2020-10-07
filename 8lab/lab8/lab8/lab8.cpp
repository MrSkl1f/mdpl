#include "lab8.h"


int main()
{
    int choice = 0;
    while (choice != 5)
    {
        menu(choice);
        if (choice != 5)
            menuManager(choice);
    }
    return 0;
}

void menu(int &choice)
{
    cout << "Menu: \n" <<
        "1. Addition of numbers.\n" <<
        "2. Substraction of numbers.\n" <<
        "3. Multiplication of numbers.\n" <<
        "4. Division of numbers.\n" <<
        "5. Exit\n" <<
        "Your choice: ";
    cin >> choice;
}

void menuManager(int choice)
{
    if (choice < 1 || choice > 4)
    {
        cout << "Wrong choice!\n";
        return;
    }
    float firstNum, secondNum;
    inputNumbers(firstNum, secondNum);
    float res = 0;
    switch (choice)
    {
    case 1:
        res = additionOfNumbers(firstNum, secondNum);
        break;
    case 2:
        res = substractionOfNumbers(firstNum, secondNum);
        break;
    case 3:
        res = multiplicationOfNumbers(firstNum, secondNum);
        break;
    case 4:
        res = divisionOfNumbers(firstNum, secondNum);
        break;
    }
    cout << "Your result is: " << res << endl;
}

void inputNumbers(float& firstNumber, float& secondNumber)
{
    cout << "Input first number: ";
    cin >> firstNumber;
    cout << "Input second number: ";
    cin >> secondNumber;
}

/*
FLD - загрузить вещественное число из источника в стек. номер вершины в SR увеличивается
SR - регистр состояний, содержит слово состояния FPU. Сигнализирует об ошибках, переполнениях
FADD - сложение. Один из операндов - вершина стека
FSUB - деление
FMUL - умножение
FDIV - деление
FSTP - скопировать число с вершины стека в приемник

В С3 (13-11)TOP С2 С1 С0 ES (ошибка работы со стеком) SF (исключания) РЕ UE ОЕ ZE DE IE ???
*/

float additionOfNumbers(float firstNumber, float secondNumber)
{
    float res = 0;
    __asm {
        fld firstNumber
        fadd secondNumber
        fstp res
    }
    return res;
}

float substractionOfNumbers(float firstNumber, float secondNumber)
{
    float res = 0;
    __asm {
        fld firstNumber
        fsub secondNumber
        fstp res
    }
    return res;
}

float multiplicationOfNumbers(float firstNumber, float secondNumber)
{
    float res = 0;
    __asm {
        fld firstNumber
        fmul secondNumber
        fstp res
    }
    return res;
}

float divisionOfNumbers(float firstNumber, float secondNumber)
{
    float res = 0;
    __asm {
        fld firstNumber
        fdiv secondNumber
        fstp res
    }
    return res;
}