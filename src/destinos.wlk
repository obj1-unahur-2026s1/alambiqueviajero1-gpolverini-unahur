import src.recuerdos.*
import src.presidentes.*

object paris {
    method recuerdo() = llaveroTorreEiffel
    method noExistenRestricciones(unVehiculo) = unVehiculo.tieneSuficienteCombustible()
}

object buenosaires {
    var property presidente = milei
    method recuerdo() {
        mate.tieneYerba(presidente.conYerba())
        return mate
    }
    method noExistenRestricciones(unVehiculo) = unVehiculo.esRapido()
}

object bagdad {
    var property recuerdo = bidonDePetroleo
    method noExistenRestricciones(unVehiculo) = true
}

object lasvegas {
    var property conmemora = paris
    method recuerdo() = conmemora.recuerdo()
    method noExistenRestricciones(unVehiculo) = conmemora.noExistenRestricciones(unVehiculo)
}

object japon {
    method recuerdo() = bonsai
    method noExistenRestricciones(unVehiculo) = true
}
