#include <iostream>
#include <string.h>

#define countOfSymbols 30

extern "C" {
    void strcopy(char* insertionPointer, char* pointerFrom, int len);
}


int main()
{
    char testString[] = "test test ";
    int len = 0;

    __asm {
        mov ecx, 10000
        mov al, 0  // символ окончания строки
        lea edi, [testString] // вычисляет эффективный адрес источника, помещает в edi
        repne scasb // повторный просмотр строки из байтов
        mov ebx, 10000
        sub ebx, ecx
        dec ebx 
        mov len, ebx
    };
    std::cout << len << "\n";
    
    char newString[countOfSymbols] = "qwerty";

    strcopy(newString, testString, len);
    std::cout << "New string: " << newString << std::endl;
    
    strcopy(testString + 5, testString, 5);
    std::cout << "New string: " << testString << std::endl;

    return 0;
}
