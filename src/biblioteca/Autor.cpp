#include "../../include/biblioteca/Autor.h"

Autor::Autor(string nombre){
    setNombre(nombre);
}

void Autor::setNombre(string nombre){
    if(nombre.empty() || nombre.length() == 0)
        return;
        // throw error
    
    this->nombre = nombre;
}