import src.vehiculos.*

object luke {
    var vehiculo = alambiqueVeloz
    var ultimoRecuerdo = null
    var cantLugaresVisitados = 0

    method cambiarDeVehiculo(unVehiculo) { vehiculo = unVehiculo }
    method cuantosLugaresVisito() = cantLugaresVisitados
    method ultimoRecuerdo() = ultimoRecuerdo
    method viajar(unDestino) {
        if (unDestino.noExistenRestricciones(vehiculo)) {
            vehiculo.conducir(unDestino)
            ultimoRecuerdo = unDestino.recuerdo()
            cantLugaresVisitados += 1
        }
    }
}