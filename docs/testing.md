# Guía de Testing

## Estrategia de Testing

El proyecto utiliza el framework de testing de Wollok para garantizar la correctitud del código. Los tests están organizados por módulo y cubren el 100% del código con 93 tests que verifican casos normales, casos límite y escenarios de integración.

## Estructura de Tests

```
tests/
├── personajes.wtest   # Tests de Luke (21 tests)
├── destinos.wtest     # Tests de destinos (35 tests)
├── vehiculos.wtest    # Tests de vehículos (28 tests)
├── recuerdos.wtest    # Tests de recuerdos (4 tests)
├── presidentes.wtest  # Tests de presidentes (2 tests)
└── modos.wtest        # Tests de modos del Super Convertible (3 tests)
```

## Ejecutar Tests

### Todos los tests
```bash
# Desde VS Code: Abre la paleta de comandos
# Ctrl+Shift+P (Windows/Linux) o Cmd+Shift+P (Mac)
# Busca: "Wollok: Run All Tests"
# Resultado esperado: 93 tests en verde ✓

# O desde la terminal con Wollok CLI (si está instalado):
wollok test
```

### Test individual
```bash
# Desde VS Code: 
# - Abre el archivo .wtest
# - Click en el ícono "Run Test" que aparece sobre cada test
# - O click derecho en el archivo → "Run Wollok File"

# Desde la terminal:
wollok test tests/personajes.wtest
```

### Tests por archivo
```bash
# Tests de Luke (21 tests)
wollok test tests/personajes.wtest

# Tests de destinos (35 tests)
wollok test tests/destinos.wtest

# Tests de vehículos (28 tests)
wollok test tests/vehiculos.wtest
```

## Cobertura de Tests (100%)

### Personajes (21 tests)
- ✅ Conteo de lugares visitados (4 tests)
- ✅ Gestión de recuerdos (4 tests)
- ✅ Cambio de vehículo (2 tests)
- ✅ Restricciones de viaje (2 tests)
- ✅ Escenarios de integración complejos (8 tests)

### Destinos (35 tests)
- ✅ París: recuerdo y restricciones (4 tests)
- ✅ Buenos Aires: recuerdo según presidente, restricciones (6 tests)
- ✅ Bagdad: recuerdo configurable, sin restricciones (5 tests)
- ✅ Las Vegas: homenaje a París, Buenos Aires, Bagdad, Japón (11 tests)
- ✅ Japón: recuerdo y restricciones (2 tests)
- ✅ Cambios de presidente (2 tests)
- ✅ Cambios de conmemoración (3 tests)
- ✅ Todos los recuerdos de Bagdad (2 tests)

### Vehículos (28 tests)
- ✅ Alambique Veloz: consumo, combustible, velocidad (8 tests)
- ✅ Super Chatarra Especial: consumo basado en armamento (6 tests)
- ✅ Antigualla Blindada: velocidad según gangsters (7 tests)
- ✅ Super Convertible: velocidad según modo (7 tests)

### Recuerdos (4 tests)
- ✅ Propiedad `tieneYerba` del mate
- ✅ Cambios de estado

### Presidentes (2 tests)
- ✅ Política de yerba de Milei
- ✅ Política de yerba de Fernández

### Modos (3 tests)
- ✅ Velocidad de cada modo del Super Convertible

## Formato de Tests (BDD)

El proyecto sigue el formato **Given-When-Then** para los nombres de tests:

```wollok
describe "Objeto | Descripción del comportamiento" {
    test "Given: [contexto inicial] | When: [acción] | Then: [resultado esperado]" {
        // Arrange (preparación)
        // Act (acción)
        // Assert (verificación)
    }
}
```

### Ejemplo Real:
```wollok
describe "Luke | Verificar viajes y conteo de lugares visitados" {
    test "Given: Luke viaja a París con alambique veloz | When: consultamos cuantosLugaresVisito() | Then: debería retornar 1" {
        luke.viajar(paris)
        assert.equals(1, luke.cuantosLugaresVisito())
    }
}
```

## Buenas Prácticas de Testing

### 1. Un Solo Assert por Test
Cada test debe tener exactamente un assert (o `assert.that` con condiciones relacionadas):

✓ **Bueno:**
```wollok
test "Given: Luke viaja a París | When: consultamos ultimoRecuerdo() | Then: debería retornar llaveroTorreEiffel" {
    luke.viajar(paris)
    assert.equals(llaveroTorreEiffel, luke.ultimoRecuerdo())
}
```

✗ **Malo:**
```wollok
test "Luke viaja a París" {
    luke.viajar(paris)
    assert.equals(1, luke.cuantosLugaresVisito())  // ❌ Primer assert
    assert.equals(llaveroTorreEiffel, luke.ultimoRecuerdo())  // ❌ Segundo assert
}
```

### 2. Nombres Descriptivos
Los nombres deben describir claramente el escenario:

✓ **Bueno:**
```wollok
test "Given: Alambique veloz con 200 de combustible | When: conduce a París | Then: debería quedar con 170 de combustible" {
    alambiqueVeloz.combustible(200)
    alambiqueVeloz.conducir(paris)
    assert.equals(170, alambiqueVeloz.combustible())
}
```

✗ **Malo:**
```wollok
test "test1" {
    assert.equals(170, alambiqueVeloz.combustible())
}
```

### 3. Arrange-Act-Assert (AAA)
Organiza tus tests en tres secciones:

```wollok
test "Given: Super convertible en modo alfombra voladora | When: consultamos esRapido() | Then: debería retornar true" {
    // Arrange (preparar)
    elSuperConvertible.convertir(modoAlfombraVoladora)
    
    // Act (actuar) - a veces implícito en el assert
    
    // Assert (verificar)
    assert.that(elSuperConvertible.esRapido())
}
```

### 4. Tests Independientes
Cada test debe ser independiente:

```wollok
test "Given: Alambique veloz con 30 de combustible | When: consultamos tieneSuficienteCombustible() | Then: debería retornar true" {
    alambiqueVeloz.combustible(30)  // Establece el estado necesario
    assert.that(alambiqueVeloz.tieneSuficienteCombustible())
}
```

### 5. Casos Límite
Siempre prueba casos límite:

```wollok
test "Given: Alambique veloz con 29 de combustible | When: consultamos tieneSuficienteCombustible() | Then: debería retornar false" {
    alambiqueVeloz.combustible(29)
    assert.that(!alambiqueVeloz.tieneSuficienteCombustible())
}

test "Given: Antigualla blindada con 3 gangsters | When: consultamos esRapido() | Then: debería retornar true" {
    laAntiguallaBlindada.cantGangster(3)
    assert.that(laAntiguallaBlindada.esRapido())
}

test "Given: Antigualla blindada con 4 gangsters | When: consultamos esRapido() | Then: debería retornar false" {
    laAntiguallaBlindada.cantGangster(4)
    assert.that(!laAntiguallaBlindada.esRapido())
}
```

## Debugging de Tests

### Test Falla Inesperadamente

1. **Lee el mensaje de error:**
   ```
   Expected: llaveroTorreEiffel
   But was: mate
   ```

2. **Verifica el estado:**
   ```wollok
   test "debug: verificar viaje a París" {
       console.println("Vehículo: " + luke.vehiculo)
       console.println("Combustible: " + alambiqueVeloz.combustible())
       luke.viajar(paris)
       console.println("Lugares visitados: " + luke.cuantosLugaresVisito())
       console.println("Último recuerdo: " + luke.ultimoRecuerdo())
       assert.equals(llaveroTorreEiffel, luke.ultimoRecuerdo())
   }
   ```

3. **Simplifica el test:**
   - Reduce el test al mínimo necesario
   - Verifica una cosa a la vez

### Test Pasa Pero No Debería

- Verifica que estás usando `assert.equals()` o `assert.that()` correctamente
- Asegúrate de que el test realmente ejecuta la lógica esperada
- Revisa que no haya typos en los nombres de métodos

## Agregar Nuevos Tests

Cuando agregues nueva funcionalidad, sigue estos pasos:

1. **Escribe el test primero (TDD):**
   ```wollok
   test "Given: Nuevo destino Roma | When: Luke viaja | Then: debería traer coliseo" {
       luke.viajar(roma)
       assert.equals(coliseo, luke.ultimoRecuerdo())
   }
   ```

2. **Implementa la funcionalidad mínima:**
   - Haz que el test pase

3. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde

4. **Agrega más tests:**
   - Casos límite
   - Casos de error
   - Diferentes escenarios

## Ejemplos de Tests por Módulo

### Tests de Personajes

```wollok
describe "Luke | Verificar viajes y conteo de lugares visitados" {
    test "Given: Luke no ha viajado | When: consultamos cuantosLugaresVisito() | Then: debería retornar 0" {
        assert.equals(0, luke.cuantosLugaresVisito())
    }

    test "Given: Luke viaja a París con alambique veloz | When: consultamos cuantosLugaresVisito() | Then: debería retornar 1" {
        luke.viajar(paris)
        assert.equals(1, luke.cuantosLugaresVisito())
    }
}

describe "Luke | Verificar recuerdos de viajes" {
    test "Given: Luke viaja a París | When: consultamos ultimoRecuerdo() | Then: debería retornar llaveroTorreEiffel" {
        luke.viajar(paris)
        assert.equals(llaveroTorreEiffel, luke.ultimoRecuerdo())
    }
}
```

### Tests de Destinos

```wollok
describe "París | Verificar recuerdo típico" {
    test "Given: París | When: consultamos recuerdo() | Then: debería retornar llaveroTorreEiffel" {
        assert.equals(llaveroTorreEiffel, paris.recuerdo())
    }
}

describe "Buenos Aires | Verificar recuerdo según presidente" {
    test "Given: Buenos Aires con presidente Milei | When: consultamos recuerdo() y tieneYerba | Then: mate debería tener yerba" {
        buenosaires.presidente(milei)
        buenosaires.recuerdo()
        assert.that(mate.tieneYerba())
    }
}
```

### Tests de Vehículos

```wollok
describe "Alambique Veloz | Verificar consumo de combustible" {
    test "Given: Alambique veloz con 200 de combustible | When: conduce a París | Then: debería quedar con 170 de combustible" {
        alambiqueVeloz.combustible(200)
        alambiqueVeloz.conducir(paris)
        assert.equals(170, alambiqueVeloz.combustible())
    }
}

describe "Super Chatarra Especial | Verificar consumo basado en armamento" {
    test "Given: Super chatarra con 200 de combustible | When: conduce a París | Then: debería quedar con 160 de combustible (consume 40)" {
        superChatarraEspecial.combustible(200)
        superChatarraEspecial.conducir(paris)
        assert.equals(160, superChatarraEspecial.combustible())
    }
}
```

## Casos de Prueba Importantes

### Restricciones de Viaje

```wollok
// París requiere combustible suficiente
luke.cambiarDeVehiculo(alambiqueVeloz)
alambiqueVeloz.combustible(200)
luke.viajar(paris)  // ✓ Puede ir

alambiqueVeloz.combustible(20)
luke.viajar(paris)  // ✗ No puede ir

// Buenos Aires requiere velocidad
luke.cambiarDeVehiculo(alambiqueVeloz)
luke.viajar(buenosaires)  // ✗ No puede ir (no es rápido)

luke.cambiarDeVehiculo(elSuperConvertible)
elSuperConvertible.convertir(modoAlfombraVoladora)
luke.viajar(buenosaires)  // ✓ Puede ir (es rápido)
```

### Reemplazo de Recuerdos

```wollok
// Cada viaje reemplaza el recuerdo anterior
luke.viajar(paris)
luke.ultimoRecuerdo()  // llaveroTorreEiffel

luke.viajar(japon)
luke.ultimoRecuerdo()  // bonsai (reemplazó al llavero)
```

### Polimorfismo de Vehículos

```wollok
// Todos los vehículos pueden ser usados por Luke
luke.cambiarDeVehiculo(alambiqueVeloz)
luke.viajar(paris)

luke.cambiarDeVehiculo(superChatarraEspecial)
luke.viajar(paris)

luke.cambiarDeVehiculo(laAntiguallaBlindada)
luke.viajar(bagdad)

luke.cambiarDeVehiculo(elSuperConvertible)
luke.viajar(japon)
```

### Las Vegas Homenajea

```wollok
// Las Vegas hereda recuerdo y restricciones del destino homenajeado
lasvegas.conmemora(paris)
lasvegas.recuerdo()  // llaveroTorreEiffel
// Requiere combustible suficiente

lasvegas.conmemora(buenosaires)
lasvegas.recuerdo()  // mate
// Requiere ser rápido

lasvegas.conmemora(japon)
lasvegas.recuerdo()  // bonsai
// Sin restricciones
```

## Verificación de Polimorfismo

Los tests verifican que el polimorfismo funciona correctamente:

```wollok
// Todos los vehículos responden a la misma interfaz
alambiqueVeloz.esRapido()
alambiqueVeloz.tieneSuficienteCombustible()
alambiqueVeloz.conducir(paris)

superChatarraEspecial.esRapido()
superChatarraEspecial.tieneSuficienteCombustible()
superChatarraEspecial.conducir(paris)

// Todos los destinos responden a la misma interfaz
paris.recuerdo()
paris.noExistenRestricciones(vehiculo)

buenosaires.recuerdo()
buenosaires.noExistenRestricciones(vehiculo)
```

## Escenarios de Integración

Los tests de integración verifican flujos completos:

```wollok
test "Given: Luke viaja a París, luego a Bagdad, luego a Japón | When: consultamos cuantosLugaresVisito() | Then: debería retornar 3" {
    luke.viajar(paris)
    luke.viajar(bagdad)
    luke.viajar(japon)
    assert.equals(3, luke.cuantosLugaresVisito())
}

test "Given: Luke viaja a París con alambique, cambia a super convertible y viaja a Buenos Aires | When: consultamos cuantosLugaresVisito() | Then: debería retornar 2" {
    luke.cambiarDeVehiculo(alambiqueVeloz)
    luke.viajar(paris)
    luke.cambiarDeVehiculo(elSuperConvertible)
    elSuperConvertible.convertir(modoAlfombraVoladora)
    luke.viajar(buenosaires)
    assert.equals(2, luke.cuantosLugaresVisito())
}
```

## Valores de Referencia

### Consumo de Combustible

**Alambique Veloz:**
- Consumo: 30 por viaje
- Inicial: 200 → Después de 1 viaje: 170

**Super Chatarra Especial:**
- Consumo: 10 × 4 armamento = 40 por viaje
- Inicial: 200 → Después de 1 viaje: 160

### Velocidad según Gangsters

**Antigualla Blindada:**
- 0-3 gangsters: es rápido
- 4+ gangsters: no es rápido

### Modos del Super Convertible

- Modo Estándar: no es veloz
- Modo Bola de Bowling: no es veloz
- Modo Alfombra Voladora: es veloz

## Recursos Adicionales

- [Documentación oficial de Wollok Testing](https://www.wollok.org/documentacion/testing/)
- [Guía de TDD](https://www.wollok.org/documentacion/tdd/)
- Ver [architecture.md](architecture.md) para entender la estructura del código
- Ver [setup.md](setup.md) para instrucciones de instalación
- Ver [development.md](development.md) para guía de desarrollo
