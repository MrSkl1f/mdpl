#include <iostream>

int main(void)
{	
	std::cout << "centimeters: ";
    double h;
    std::cin >> h;
    std::cout << "chest circumference: ";
	double t; 
    std::cin >> t;
    std::cout << "weight: ";
	double m;
	std::cin >> m;

    double normalWeight = h * t / 240;
    if (normalWeight == m)
    	std::cout << "everything is ok\n";
   	else if (normalWeight > m)
   		std::cout << "You're overweight\n";
   	else
   		std::cout << "You are too thin\n";
    double massIndex = m / ((h / 100)  * (h / 100));
	std::cout << normalWeight << "\n" << massIndex;
	return 0;
}
