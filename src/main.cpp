#include "../include/biblioteca/Usuario.h"
#include<iostream>
using namespace std;

int main(){
    Usuario gonza("99999999", "gonza123", "gonzalo@outlook.com", "12345");

    cout << gonza.getDni() << "\n"; 
    cout << gonza.getNombre() << "\n"; 
    cout << gonza.getCorreo() << "\n";

    cout << "hello world!" << "\n";
}