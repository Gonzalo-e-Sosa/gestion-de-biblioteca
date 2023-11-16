cmake_minimum_required(VERSION 3.12)

project(gestion-de-biblioteca)

# Configuración de C++
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Definir las rutas de las carpetas fuente y de encabezado
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)

# Configurar el destino de construcción para los ejecutables
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/bin)

# Configurar el ejecutable principal
add_executable(gestion-de-biblioteca ${SOURCE_DIR}/main.cpp)

# Configurar las rutas de encabezado
target_include_directories(gestion-de-biblioteca PRIVATE ${INCLUDE_DIR})

# Enlazar bibliotecas adicionales si es necesario
# target_link_libraries(NombreEjecutable Libreria1 Libreria2 ...)

# Añadir los subdirectorios correspondientes
add_subdirectory(src)
add_subdirectory(tests)