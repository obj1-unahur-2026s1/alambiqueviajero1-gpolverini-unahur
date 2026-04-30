# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [1.0.0] - 2026-04-30

### Agregado

#### Personajes
- Implementación del objeto `luke` con gestión de viajes
- Atributos: `vehiculo`, `ultimoRecuerdo`, `cantLugaresVisitados`
- Método `viajar(unDestino)`: permite que Luke viaje si no hay restricciones
- Método `cambiarDeVehiculo(unVehiculo)`: cambia el vehículo de Luke
- Método `cuantosLugaresVisito()`: retorna cantidad de lugares visitados
- Método `ultimoRecuerdo()`: retorna el último recuerdo traído

#### Destinos
- **París**: recuerdo llavero Torre Eiffel, restricción de combustible
- **Buenos Aires**: recuerdo mate (con/sin yerba según presidente), restricción de velocidad
  - Presidentes: Milei (con yerba), Fernández (sin yerba)
- **Bagdad**: recuerdo configurable, sin restricciones
- **Las Vegas**: homenajea otros destinos, hereda recuerdo y restricciones
- **Japón**: recuerdo bonsai, sin restricciones (nuevo destino turístico)

#### Vehículos
- **Alambique Veloz**: 
  - Combustible inicial: 200
  - Consumo: 30 por viaje
  - No es rápido
- **Super Chatarra Especial**:
  - Combustible inicial: 200
  - Armamento: 4 cañones
  - Consumo: 10 × armamento = 40 por viaje
  - No es rápido
  - Creatividad: combustible basado en armamento
- **La Antigualla Blindada**:
  - Gangsters: 7 (variable)
  - Es rápido si tiene menos de 4 gangsters
  - Creatividad: velocidad depende de gangsters
- **El Super Convertible**:
  - Modos: Estándar, Bola de Bowling, Alfombra Voladora
  - Es rápido solo en modo Alfombra Voladora
  - Creatividad: comportamiento varía según modo (patrón Strategy)

#### Recuerdos
- `llaveroTorreEiffel` - Recuerdo de París
- `mate` - Recuerdo de Buenos Aires (con propiedad `tieneYerba`)
- `bidonDePetroleo` - Recuerdo de Bagdad
- `armaDeDestruccionMasiva` - Recuerdo alternativo de Bagdad
- `replicaJardinesColgantesBabilonia` - Recuerdo alternativo de Bagdad
- `bonsai` - Recuerdo de Japón

#### Tests (Cobertura 100%)
- **personajes.wtest** (21 tests):
  - Conteo de lugares visitados
  - Gestión de recuerdos
  - Cambio de vehículo
  - Restricciones de viaje
  - Escenarios de integración complejos
- **destinos.wtest** (35 tests):
  - Recuerdos típicos de cada destino
  - Restricciones de viaje
  - Cambios de presidente en Buenos Aires
  - Homenajes de Las Vegas
  - Cambios de conmemoración
- **vehiculos.wtest** (28 tests):
  - Consumo de combustible
  - Verificación de velocidad
  - Cambios de estado (gangsters, modos)
  - Múltiples viajes
- **recuerdos.wtest** (4 tests):
  - Propiedad `tieneYerba` del mate
  - Cambios de estado
- **presidentes.wtest** (2 tests):
  - Política de yerba de cada presidente
- **modos.wtest** (3 tests):
  - Velocidad de cada modo del Super Convertible

#### Documentación
- README.md con especificación completa del ejercicio
- docs/index.md - Índice de documentación
- docs/architecture.md - Arquitectura del sistema
- docs/development.md - Guía para desarrolladores
- docs/setup.md - Guía de instalación
- docs/testing.md - Guía de testing
- CONTRIBUTING.md - Guía de contribución
- CODE_OF_CONDUCT.md - Código de conducta
- CHANGELOG.md - Este archivo
- LICENSE (ISC)

### Configuración
- Proyecto configurado para Wollok
- Estructura de carpetas src/ (6 archivos) y tests/ (6 archivos)
- Configuración de .gitignore para archivos de log
- Imports correctos entre módulos
- Separación de responsabilidades: personajes, destinos, vehículos, recuerdos, modos, presidentes

### Polimorfismo
- **Vehículos**: todos responden a `esRapido()`, `tieneSuficienteCombustible()`, `conducir(unDestino)`
- **Destinos**: todos responden a `recuerdo()` y `noExistenRestricciones(unVehiculo)`
- Permite que Luke use cualquier vehículo y visite cualquier destino sin modificar su lógica
- Patrón Strategy implementado en Super Convertible con modos intercambiables

### Patrones de Diseño
- Singleton Pattern para todos los objetos
- Polymorphism para vehículos y destinos
- Strategy Pattern para modos del Super Convertible
- Delegation en Las Vegas (delega a destino homenajeado)

[1.0.0]: https://github.com/obj1-unahur-2026s1/alambiqueviajero1-gpolverini-unahur/releases/tag/v1.0.0
