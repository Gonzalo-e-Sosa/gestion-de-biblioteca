#include<string>
using namespace std;

class Categoria
{
private:
    string nombre;
    string desc;
public:
    Categoria(string nombre, string desc);

    inline string getNombre() const {return this->nombre;};
    inline string getDesc() const {return this->desc;};

    void setNombre(string nombre);
    void setDesc(string desc);

    //~Categoria();
};