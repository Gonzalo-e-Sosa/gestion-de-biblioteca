#include<string>
using namespace std;

class Autor
{
private:
    string nombre;
public:
    Autor(string nombre);

    inline string getNombre() const {return this->nombre;};

    void setNombre(string nombre); 
    
    //~Autor();
};