# Guía para Desarrolladores

## Introducción

Esta guía está diseñada para ayudar a desarrolladores que quieran contribuir o extender el proyecto "El Alambique Viajero". Aquí encontrarás información sobre el flujo de trabajo, convenciones de código y mejores prácticas.

## Configuración del Entorno de Desarrollo

### Requisitos
- Visual Studio Code con extensión de Wollok
- Wollok 4.2.3+
- Git

### Configuración Inicial
```bash
# Clonar el repositorio
git clone <url-del-repositorio>
cd alambique-viajero

# Abrir en VS Code
code .
```

Ver [setup.md](setup.md) para instrucciones detalladas.

## Flujo de Trabajo

### 1. Antes de Empezar

1. **Actualiza tu rama local:**
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Crea una nueva rama:**
   ```bash
   git checkout -b feature/nombre-descriptivo
   # o
   git checkout -b fix/nombre-del-bug
   ```

### 2. Durante el Desarrollo

1. **Escribe tests primero (TDD):**
   ```wollok
   describe "Luke | Nueva funcionalidad" {
       test "Given: contexto | When: acción | Then: resultado esperado" {
           // Test que falla
           assert.equals(valorEsperado, luke.nuevoMetodo())
       }
   }
   ```

2. **Implementa la funcionalidad:**
   ```wollok
   object luke {
       method nuevoMetodo() {
           // Implementación mínima para pasar el test
       }
   }
   ```

3. **Ejecuta los tests frecuentemente:**
   - Después de cada cambio significativo
   - Antes de hacer commit

4. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde
   - Elimina duplicación
   - Mejora nombres de variables/métodos

### 3. Antes de Hacer Commit

1. **Ejecuta TODOS los tests:**
   - Desde VS Code: Ctrl+Shift+P → "Wollok: Run All Tests"
   - Verifica que todos pasen (93 tests en verde)

2. **Verifica que no haya errores de compilación:**
   - Revisa el panel "Problems" en VS Code (Ctrl+Shift+M)

3. **Revisa tus cambios:**
   ```bash
   git status
   git diff
   ```

### 4. Hacer Commit

```bash
# Agrega los archivos modificados
git add src/archivo.wlk tests/archivo.wtest

# Commit con mensaje descriptivo
git commit -m "Agrega nuevo destino Roma

- Implementa objeto Roma con su método recuerdo
- Agrega restricciones para que Luke pueda visitarlo
- Agrega tests para verificar el comportamiento
- Fixes #123"
```

### 5. Push y Pull Request

```bash
# Push a tu rama
git push origin feature/nombre-descriptivo

# Crea un Pull Request en GitHub/GitLab
# Describe los cambios y referencia issues relacionados
```

## Convenciones de Código

### Nomenclatura

#### Objetos
```wollok
// Objetos singleton: camelCase
object luke { }
object paris { }
object alambiqueVeloz { }
object mate { }
```

#### Métodos
```wollok
// Métodos: camelCase
method viajar(unDestino) { }
method cambiarDeVehiculo(unVehiculo) { }
method noExistenRestricciones(unVehiculo) { }
method tieneSuficienteCombustible() { }
```

#### Variables
```wollok
// Variables: camelCase
var vehiculo = alambiqueVeloz
var ultimoRecuerdo = null
var cantLugaresVisitados = 0
const factorConsumoDeCombustible = 30
```

### Estilo de Código

#### Indentación
- Usa **4 espacios** (no tabs)
- VS Code con la extensión de Wollok lo configura automáticamente

#### Llaves
```wollok
// ✓ Bueno: llave de apertura en la misma línea
method viajar(unDestino) {
    // código
}

// ✗ Malo: llave de apertura en nueva línea
method viajar(unDestino)
{
    // código
}
```

#### Espacios
```wollok
// ✓ Bueno: espacios alrededor de operadores
combustible = 0.max(combustible - factorConsumoDeCombustible)

// ✗ Malo: sin espacios
combustible=0.max(combustible-factorConsumoDeCombustible)

// ✓ Bueno: espacio después de comas
method consumir(cantidad, sustancia)

// ✗ Malo: sin espacios
method consumir(cantidad,sustancia)
```

#### Líneas en Blanco
```wollok
object luke {
    // Una línea en blanco entre métodos
    method viajar(unDestino) {
        // código
    }
    
    method cambiarDeVehiculo(unVehiculo) {
        // código
    }
}
```

### Comentarios

#### Cuándo Comentar
```wollok
// ✓ Bueno: comentar lógica compleja o no obvia
// Es rápido si tiene menos de 4 gangsters (menos peso)
method esRapido() = cantGangster < 4

// ✗ Malo: comentar lo obvio
method viajar(unDestino) {
    cantLugaresVisitados += 1  // incrementa contador
}
```

#### Comentarios TODO
```wollok
// TODO: Implementar validación de combustible negativo
// FIXME: Este método no maneja el caso de destino null
// HACK: Solución temporal hasta refactorizar
```

## Mejores Prácticas

### 1. Principio de Responsabilidad Única
Cada objeto debe tener una sola responsabilidad:

```wollok
// ✓ Bueno: cada objeto tiene una responsabilidad clara
object luke {
    // Responsabilidad: gestionar viajes y recuerdos
}

object paris {
    // Responsabilidad: proveer recuerdo y restricciones de París
}

// ✗ Malo: objeto con múltiples responsabilidades
object sistema {
    // Gestiona luke, destinos, vehículos, recuerdos
}
```

### 2. Encapsulamiento
No expongas detalles de implementación:

```wollok
// ✓ Bueno: encapsula el estado interno
object luke {
    var vehiculo = alambiqueVeloz  // privado
    var ultimoRecuerdo = null  // privado
    var cantLugaresVisitados = 0  // privado
    
    method cambiarDeVehiculo(unVehiculo) {
        vehiculo = unVehiculo
    }
}

// ✗ Malo: expone todo con property
object luke {
    var property vehiculo = alambiqueVeloz  // No debería ser público
    var property ultimoRecuerdo = null  // No debería ser público
}
```

### 3. Polimorfismo
Aprovecha el polimorfismo de Wollok:

```wollok
// ✓ Bueno: todos los vehículos responden a la misma interfaz
luke.cambiarDeVehiculo(alambiqueVeloz)
luke.viajar(paris)  // Usa alambiqueVeloz.tieneSuficienteCombustible()

luke.cambiarDeVehiculo(elSuperConvertible)
luke.viajar(buenosaires)  // Usa elSuperConvertible.esRapido()

// ✗ Malo: usar condicionales para tipos
method viajar(unDestino) {
    if (vehiculo == alambiqueVeloz) {
        // lógica específica
    } else if (vehiculo == superChatarraEspecial) {
        // otra lógica
    }
}
```

### 4. Inmutabilidad Cuando Sea Posible
```wollok
// ✓ Bueno: usa const para valores que no cambian
object alambiqueVeloz {
    const factorConsumoDeCombustible = 30
}

// ✗ Malo: usar var innecesariamente
object alambiqueVeloz {
    var factorConsumoDeCombustible = 30  // ¿realmente necesita cambiar?
}
```

### 5. Nombres Descriptivos
```wollok
// ✓ Bueno: nombres que expresan intención
method noExistenRestricciones(unVehiculo) = unVehiculo.tieneSuficienteCombustible()

// ✗ Malo: nombres crípticos
method check(v) = v.ok()
```

## Patrones Comunes

### Pattern: Métodos de Consulta
```wollok
// Métodos que retornan información sin cambiar estado
method cuantosLugaresVisito() = cantLugaresVisitados
method ultimoRecuerdo() = ultimoRecuerdo
method recuerdo() = llaveroTorreEiffel
method esRapido() = cantGangster < 4
```

### Pattern: Métodos de Acción
```wollok
// Métodos que cambian el estado del objeto
method viajar(unDestino) { 
    if (unDestino.noExistenRestricciones(vehiculo)) {
        vehiculo.conducir(unDestino)
        ultimoRecuerdo = unDestino.recuerdo()
        cantLugaresVisitados += 1
    }
}

method cambiarDeVehiculo(unVehiculo) { 
    vehiculo = unVehiculo 
}
```

### Pattern: Delegation
```wollok
// Delegar a componentes
object luke {
    method viajar(unDestino) {
        if (unDestino.noExistenRestricciones(vehiculo)) {
            // Delega al vehículo
            vehiculo.conducir(unDestino)
            // Delega al destino
            ultimoRecuerdo = unDestino.recuerdo()
            cantLugaresVisitados += 1
        }
    }
}

object lasvegas {
    // Delega todo al destino homenajeado
    method recuerdo() = conmemora.recuerdo()
    method noExistenRestricciones(unVehiculo) = conmemora.noExistenRestricciones(unVehiculo)
}
```

### Pattern: Strategy
```wollok
// El Super Convertible usa Strategy con sus modos
object elSuperConvertible {
    var modo = modoEstandar
    
    method convertir(unModo) { modo = unModo }
    method esRapido() = modo.esVeloz()
}

object modoEstandar {
    method esVeloz() = false
}

object modoAlfombraVoladora {
    method esVeloz() = true
}
```

## Flujo del Sistema

El flujo típico del sistema es:

1. **Estado inicial:**
   - Luke tiene alambiqueVeloz como vehículo
   - No ha visitado ningún lugar (0)
   - No tiene recuerdo (null)

2. **Viaje a un destino:**
   - Luke invoca `viajar(unDestino)`
   - Se verifica si no existen restricciones
   - Si puede ir: el vehículo conduce, se trae el recuerdo, incrementa contador
   - Si no puede ir: no pasa nada

3. **Cambio de vehículo:**
   - Luke invoca `cambiarDeVehiculo(unVehiculo)`
   - El nuevo vehículo reemplaza al anterior
   - Los viajes futuros usan el nuevo vehículo

4. **Recuerdos:**
   - Cada viaje exitoso reemplaza el recuerdo anterior
   - Solo se conserva el último recuerdo

## Testing

### Test-Driven Development (TDD)

1. **Red:** Escribe un test que falle
2. **Green:** Implementa lo mínimo para que pase
3. **Refactor:** Mejora el código

```wollok
// 1. RED: Test que falla
describe "Luke | Nueva funcionalidad" {
    test "Given: contexto | When: acción | Then: resultado" {
        assert.equals(valorEsperado, luke.nuevoMetodo())
    }
}

// 2. GREEN: Implementación mínima
object luke {
    method nuevoMetodo() = valorEsperado
}

// 3. REFACTOR: (si es necesario)
```

Ver [testing.md](testing.md) para más detalles.

## Debugging

### Técnicas de Debugging

#### 1. Console.println()
```wollok
method viajar(unDestino) {
    console.println("Destino: " + unDestino)
    console.println("Vehículo: " + vehiculo)
    console.println("Puede ir: " + unDestino.noExistenRestricciones(vehiculo))
    if (unDestino.noExistenRestricciones(vehiculo)) {
        vehiculo.conducir(unDestino)
        ultimoRecuerdo = unDestino.recuerdo()
        cantLugaresVisitados += 1
    }
}
```

#### 2. Breakpoints
- Click en el margen izquierdo del editor en VS Code
- Ejecuta en modo Debug (F5)
- Inspecciona variables en el panel de Debug

#### 3. Tests Específicos
```wollok
test "debug: verificar viaje a París" {
    console.println("Combustible inicial: " + alambiqueVeloz.combustible())
    luke.viajar(paris)
    console.println("Combustible final: " + alambiqueVeloz.combustible())
    console.println("Lugares visitados: " + luke.cuantosLugaresVisito())
    assert.equals(1, luke.cuantosLugaresVisito())
}
```

## Errores Comunes

### 1. Olvidar implementar todos los métodos polimórficos
```wollok
// ✗ Malo: falta método conducir()
object nuevoVehiculo {
    method esRapido() = true
    method tieneSuficienteCombustible() = true
    // Falta: method conducir(unDestino) { }
}

// ✓ Bueno: implementa todos los métodos
object nuevoVehiculo {
    method esRapido() = true
    method tieneSuficienteCombustible() = true
    method conducir(unDestino) { }
}
```

### 2. No Inicializar Variables
```wollok
// ✗ Malo
object luke {
    var vehiculo  // Error: no inicializada
}

// ✓ Bueno
object luke {
    var vehiculo = alambiqueVeloz
}
```

### 3. Confundir Restricciones
```wollok
// ✗ Malo: método mal nombrado
method existenRestricciones(unVehiculo) = unVehiculo.esRapido()

// ✓ Bueno: nombre claro
method noExistenRestricciones(unVehiculo) = unVehiculo.esRapido()
```

### 4. Olvidar que cada viaje reemplaza el recuerdo
```wollok
// ✗ Malo: asumir que los recuerdos se acumulan
luke.viajar(paris)
luke.viajar(japon)
// Ahora solo tiene bonsai, no llavero + bonsai

// ✓ Bueno: entender el reemplazo
luke.viajar(paris)  // Tiene llavero
luke.viajar(japon)  // Ahora tiene bonsai (reemplazó al llavero)
```

## Preguntas Frecuentes

### ¿Cómo agrego un nuevo destino?

1. Crea un nuevo objeto en `src/destinos.wlk`
2. Implementa `recuerdo()` y `noExistenRestricciones(unVehiculo)`
3. Agrega tests en `tests/destinos.wtest`
4. Úsalo en `luke.viajar(nuevoDestino)`

Ejemplo:
```wollok
object roma {
    method recuerdo() = coliseo
    method noExistenRestricciones(unVehiculo) = true
}
```

### ¿Cómo agrego un nuevo vehículo?

1. Crea un nuevo objeto en `src/vehiculos.wlk`
2. Implementa `esRapido()`, `tieneSuficienteCombustible()`, `conducir(unDestino)`
3. Agrega tests en `tests/vehiculos.wtest`

### ¿Cómo agrego un nuevo recuerdo?

1. Crea un nuevo objeto en `src/recuerdos.wlk`
2. Úsalo en el método `recuerdo()` de algún destino

### ¿Puedo modificar el README.md?

No, el README.md contiene la especificación del ejercicio y no debe modificarse.

### ¿Dónde reporto bugs?

Crea un issue en el repositorio con:
- Descripción del bug
- Pasos para reproducir
- Comportamiento esperado vs actual
- Versión de Wollok

## Contacto

Si tienes preguntas o necesitas ayuda:
- Crea un issue con la etiqueta "question"
- Revisa la [Guía de Contribución](../CONTRIBUTING.md)
- Consulta el [Código de Conducta](../CODE_OF_CONDUCT.md)
