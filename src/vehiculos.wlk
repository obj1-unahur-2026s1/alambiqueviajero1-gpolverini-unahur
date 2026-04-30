import src.modos.*

object alambiqueVeloz {
    const factorConsumoDeCombustible = 30
    var property combustible = 200

    method tieneSuficienteCombustible() = combustible >= factorConsumoDeCombustible
    method esRapido() = false
    method conducir(unDestino) { combustible = 0.max(combustible - factorConsumoDeCombustible) }
}

object superChatarraEspecial {
    var property combustible = 200
    const cantArmamento = 4

    method esRapido() = false
    method tieneSuficienteCombustible() = combustible > 0
    method conducir(unDestino) { combustible = 0.max(combustible - 10 * cantArmamento) }
}

object laAntiguallaBlindada {
    var property cantGangster = 7

    method esRapido() = cantGangster < 4
    method tieneSuficienteCombustible() = true
    method conducir(unDestino) {}
}

object elSuperConvertible {
    var modo = modoEstandar

    method convertir(unModo) { modo = unModo }
    method esRapido() = modo.esVeloz()
    method tieneSuficienteCombustible() = true
    method conducir(unDestino) {}
}
