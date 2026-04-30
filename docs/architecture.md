# Arquitectura del Sistema

## Visión General

El proyecto "El Alambique Viajero" es un sistema orientado a objetos que modela los viajes de Luke por diferentes destinos del mundo, utilizando distintos vehículos y trayendo recuerdos típicos de cada lugar. El sistema está diseñado siguiendo principios de programación orientada a objetos y el paradigma de Wollok, con foco en polimorfismo y encapsulamiento.

## Diagrama de Componentes

```
┌────────────────────────────────────────────────┐
│                   PERSONAJES                   │
│  ┌──────────────────────────────────────────┐  │
│  │              Luke                        │  │
│  │  - vehiculo: alambiqueVeloz              │  │
│  │  - ultimoRecuerdo: null                  │  │
│  │  - cantLugaresVisitados: 0               │  │
│  └──────────────────────────────────────────┘  │
└────────────────────────────────────────────────┘
         │                           │
         │ usa                       │ visita
         ▼                           ▼
┌─────────────────────┐    ┌──────────────────────┐
│     VEHÍCULOS       │    │      DESTINOS        │
│  - Alambique Veloz  │    │  - París             │
│  - Super Chatarra   │    │  - Buenos Aires      │
│  - Antigualla       │    │  - Bagdad            │
│  - Super Convertible│    │  - Las Vegas         │
└─────────────────────┘    │  - Japón             │
                           └──────────────────────┘
                                     │
                                     │ retorna
                                     ▼
                           ┌──────────────────────┐
                           │     RECUERDOS        │
                           │  - Llavero           │
                           │  - Mate              │
                           │  - Bidón             │
                           │  - Bonsai            │
                           └──────────────────────┘
```

## Módulos del Sistema

### 1. Personajes (`src/personajes.wlk`)

**Responsabilidad:** Modelar a Luke y gestionar sus viajes.

#### Luke
**Propiedades:**
- `vehiculo = alambiqueVeloz` - Vehículo actual
- `ultimoRecuerdo = null` - Último recuerdo traído
- `cantLugaresVisitados = 0` - Contador de lugares visitados

**Métodos:**
- `cambiarDeVehiculo(unVehiculo)` - Cambia el vehículo de Luke
- `cuantosLugaresVisito()` - Retorna cantidad de lugares visitados
- `ultimoRecuerdo()` - Retorna el último recuerdo traído
- `viajar(unDestino)` - Viaja a un destino si no hay restricciones

**Comportamiento:**
- Solo viaja si el destino no tiene restricciones para el vehículo actual
- Cada viaje reemplaza el recuerdo anterior
- El vehículo sufre las consecuencias del viaje (método `conducir()`)

### 2. Destinos (`src/destinos.wlk`)

**Responsabilidad:** Modelar destinos turísticos con sus recuerdos y restricciones.

#### París
- **Recuerdo:** Llavero de la Torre Eiffel
- **Restricción:** El vehículo debe tener suficiente combustible

#### Buenos Aires
- **Recuerdo:** Mate (con o sin yerba según el presidente)
- **Restricción:** El vehículo debe ser rápido
- **Presidentes:** Milei (con yerba), Fernández (sin yerba)

#### Bagdad
- **Recuerdo:** Configurable (bidón de petróleo, arma, jardines colgantes)
- **Restricción:** Ninguna

#### Las Vegas
- **Recuerdo:** Homenajea a otro destino (retorna su recuerdo)
- **Restricción:** La misma del destino homenajeado

#### Japón
- **Recuerdo:** Bonsai
- **Restricción:** Ninguna

### 3. Vehículos (`src/vehiculos.wlk`)

**Responsabilidad:** Modelar vehículos con diferentes características.

#### Alambique Veloz
- **Combustible:** 200 (variable)
- **Factor de consumo:** 30 por viaje
- **Es rápido:** No
- **Comportamiento:** Consume combustible al viajar

#### Super Chatarra Especial
- **Combustible:** 200 (variable)
- **Armamento:** 4 cañones (constante)
- **Consumo:** 10 × cantidad de armamento = 40 por viaje
- **Es rápido:** No
- **Creatividad:** El combustible se deduce del armamento

#### La Antigualla Blindada
- **Gangsters:** 7 (variable)
- **Es rápido:** Sí, si tiene menos de 4 gangsters
- **Creatividad:** La velocidad depende de la cantidad de gangsters

#### El Super Convertible
- **Modo:** Estándar, Bola de Bowling, o Alfombra Voladora
- **Es rápido:** Depende del modo (solo Alfombra Voladora es veloz)
- **Creatividad:** Puede cambiar de modo y su comportamiento varía

### 4. Recuerdos (`src/recuerdos.wlk`)

**Responsabilidad:** Modelar objetos de recuerdo.

- `llaveroTorreEiffel` - Recuerdo de París
- `mate` - Recuerdo de Buenos Aires (con propiedad `tieneYerba`)
- `bidonDePetroleo` - Recuerdo de Bagdad
- `armaDeDestruccionMasiva` - Recuerdo alternativo de Bagdad
- `replicaJardinesColgantesBabilonia` - Recuerdo alternativo de Bagdad
- `bonsai` - Recuerdo de Japón

### 5. Modos (`src/modos.wlk`)

**Responsabilidad:** Modelar modos del Super Convertible (patrón Strategy).

- `modoEstandar` - No es veloz
- `modoBolaDeBowling` - No es veloz
- `modoAlfombraVoladora` - Es veloz

### 6. Presidentes (`src/presidentes.wlk`)

**Responsabilidad:** Modelar presidentes de Buenos Aires y su política de yerba.

- `milei` - El mate viene con yerba
- `fernandez` - El mate viene sin yerba

## Patrones de Diseño

### 1. Singleton Pattern
Todos los objetos son singletons (una única instancia):
- Personaje: `luke`
- Destinos: `paris`, `buenosaires`, `bagdad`, `lasvegas`, `japon`
- Vehículos: `alambiqueVeloz`, `superChatarraEspecial`, `laAntiguallaBlindada`, `elSuperConvertible`
- Recuerdos: objetos únicos

### 2. Polymorphism

**Vehículos** responden polimórficamente a:
- `esRapido()` - Indica si el vehículo es rápido
- `tieneSuficienteCombustible()` - Indica si tiene combustible suficiente
- `conducir(unDestino)` - Ejecuta las consecuencias del viaje

**Destinos** responden polimórficamente a:
- `recuerdo()` - Retorna el recuerdo típico
- `noExistenRestricciones(unVehiculo)` - Verifica si el vehículo puede ir

**Ventaja:** Luke puede usar cualquier vehículo y visitar cualquier destino sin modificar su lógica.

### 3. Strategy Pattern
El Super Convertible usa el patrón Strategy con sus modos:
- `modoEstandar` - No es veloz
- `modoBolaDeBowling` - No es veloz
- `modoAlfombraVoladora` - Es veloz

### 4. Delegation
- Luke delega la verificación de restricciones al destino
- Luke delega las consecuencias del viaje al vehículo
- Las Vegas delega su recuerdo y restricciones al destino homenajeado

## Decisiones de Diseño

### ¿Por qué cada viaje reemplaza el recuerdo anterior?
**Razón:** El enunciado especifica que "su casa es pequeña, por lo que tira el recuerdo que haya traído de algún viaje anterior".

### ¿Por qué el vehículo sufre consecuencias?
**Razón:** El enunciado dice "El vehículo utilizado para viajar sufre las consecuencias", implementado mediante el método `conducir()`.

### ¿Por qué todos los vehículos implementan los mismos métodos?
**Razón:** Para lograr polimorfismo, todos deben responder a la misma interfaz, permitiendo que Luke los use indistintamente.

### ¿Por qué Las Vegas delega todo?
**Razón:** El enunciado dice que "hace homenaje a otros lugares", lo cual se implementa delegando el recuerdo y las restricciones al destino homenajeado.

## Extensibilidad

El sistema está diseñado para ser fácilmente extensible:

### Agregar nuevos destinos
```wollok
object roma {
    method recuerdo() = coliseo
    method noExistenRestricciones(unVehiculo) = true
}
```

### Agregar nuevos vehículos
```wollok
object bicicletaVoladora {
    method esRapido() = true
    method tieneSuficienteCombustible() = true
    method conducir(unDestino) {
        // Lógica específica
    }
}
```

### Agregar nuevos modos al Super Convertible
```wollok
object modoTurboPropulsado {
    method esVeloz() = true
}
```

## Flujo de Interacción Típico

1. **Estado inicial:**
   ```wollok
   luke.cuantosLugaresVisito()  // 0
   luke.ultimoRecuerdo()  // null
   ```

2. **Viajar a un destino:**
   ```wollok
   luke.viajar(paris)
   // Verifica restricciones: paris.noExistenRestricciones(alambiqueVeloz)
   // Si puede ir: alambiqueVeloz.conducir(paris)
   // Trae recuerdo: luke.ultimoRecuerdo = paris.recuerdo()
   // Incrementa contador: cantLugaresVisitados++
   ```

3. **Cambiar de vehículo:**
   ```wollok
   luke.cambiarDeVehiculo(elSuperConvertible)
   elSuperConvertible.convertir(modoAlfombraVoladora)
   luke.viajar(buenosaires)  // Ahora puede ir porque es rápido
   ```

## Polimorfismo en Acción

### Vehículos
```wollok
// Luke puede usar cualquier vehículo
luke.cambiarDeVehiculo(alambiqueVeloz)
luke.viajar(paris)  // Usa alambiqueVeloz.tieneSuficienteCombustible()

luke.cambiarDeVehiculo(elSuperConvertible)
luke.viajar(buenosaires)  // Usa elSuperConvertible.esRapido()
```

### Destinos
```wollok
// Todos los destinos responden a los mismos mensajes
paris.recuerdo()  // llaveroTorreEiffel
buenosaires.recuerdo()  // mate
japon.recuerdo()  // bonsai
```

## Consideraciones de Testing

El proyecto tiene cobertura del 100% con 93 tests distribuidos en:
- `tests/personajes.wtest` - Tests de Luke (21 tests)
- `tests/destinos.wtest` - Tests de destinos (35 tests)
- `tests/vehiculos.wtest` - Tests de vehículos (28 tests)
- `tests/recuerdos.wtest` - Tests de recuerdos (4 tests)
- `tests/presidentes.wtest` - Tests de presidentes (2 tests)
- `tests/modos.wtest` - Tests de modos (3 tests)

Ver [testing.md](testing.md) para más detalles.
