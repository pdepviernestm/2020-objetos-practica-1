import wollok.game.*
import jerry.*
import juego.*

// TODO: hacer que tomVisual pueda usar a tom

object tomVisual {
	var property position = game.origin()
	const perseguido = jerryVisual
	const tom = null
	
	method image() = "tom.png"  
	
	method atrapasteA(raton){
		// TODO: hacer que cuando atrape al raton, se lo coma y le mande al raton que fue atrapado
		self.informarEnergia()
	}
	
	// Asumamos que esto calcula bien cuanto tardaria en correr
	method tiempoDeCorrida() = self.distanciaParaCorrida() / 1.max(self.velocidad() - perseguido.velocidad())
	
	method corrida(){
		tom.correr(self.tiempoDeCorrida())
		// TODO: hacer que Tom se mueva hsata la posicion del perseguido tras haber corrido
	}

	method distanciaParaCorrida() {
		if(!game.hasVisual(perseguido))
			self.error("Ya no está " + perseguido.nombre() + " para perseguir :(")
			
		return self.position().distance(perseguido.position()) * 3
	}
	
	
	method informarEnergia(){
		self.informar("Tengo " + tom.energia().toString() + " joules")
	}

	method informarConveniencia(){
		if(tom.convieneCorrerRatonA(jerry, self.distanciaParaCorrida()))
			self.informar("Es un buen momento para correr!")
		else
			self.informar("No conviene correr ahora")
	}

	method informar(texto){
		game.say(self, texto)
	}
	
	// Delegado al tom original	
	method comer(raton){ tom.comer(raton) }
	method velocidad() = tom.velocidad()
	method correr(tiempo){ tom.correr(tiempo) }
}

object jerryVisual {
	var property position  
	method image() = "jerry.png"  
	method nombre() = "Jerry"
	
	method peso() = jerry.peso()
	method velocidad() = jerry.velocidad()
	method atrapado(){
		jerry.acelerar()
		juegoTomYJerry.atrapado(self, self.revive())
	}
	
	method revive() = self.velocidad() < 20
}

// TODO: Agregar a speedyGonzalez, otro raton que tiene velocidad 7, peso 2,
// cuando es atrapado se le avisa al juego (igual que jerry esto),
// nunca deberia revivir, su imagen es "speedy-gonzalez.png" y su nombre es "Speedy"
