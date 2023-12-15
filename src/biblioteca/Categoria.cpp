#include "../../include/biblioteca/Categoria.h"

Categoria::Categoria(string nombre, string desc){
    setNombre(nombre);
    setDesc(desc);
}

void Categoria::setNombre(string nombre){
    if(nombre.empty() || nombre.length() == 0)
        // throw error
    this->nombre = nombre;
}

void Categoria::setDesc(string desc){
    if(nombre.empty() || nombre.length() == 0)
        // throw error
    this->nombre = nombre;    
}
