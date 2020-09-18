import wollok.game.*
import personajesVisuales.*

object juegoTomYJerry {
	const respawnMillis = 2000
	const tom = tomVisual
	const jerry = jerryVisual
	
	method jugar(){
		self.configurar()
		game.start()
	}
	
	method configurar(){
		self.configurarVentana()
		self.configurarTom()
		self.agregarRaton(jerry)
		self.configurarTeclas()
	}
	
	method configurarTom() {
		game.addVisualCharacter(tom)
		game.onCollideDo(tom, { raton => tom.atrapasteA(raton) })
	}

	method configurarTeclas() {
		keyboard.space().onPressDo({ tom.corrida() })
		// TODO: hacer que al apretar S se agregue al raton speedyGonzalez
		// TODO: hacer que cuando apretemos i tom nos diga si le conviene perseguir a jerry
	}
	
	method agregarRaton(raton) {
		spawner.spawnear(raton)
		game.onTick(respawnMillis / raton.velocidad(),
					spawner.respawnEvent(raton),{ spawner.respawnear(raton) })
	}
	
	method quitarRaton(raton){
		spawner.despawnear(raton)
		game.removeTickEvent(spawner.respawnEvent(raton))
	}
	
	// Evento de colisión
	method atrapado(raton, deberiaRevivir){
		self.quitarRaton(raton)

		if(deberiaRevivir)
			self.agregarRaton(raton)
	}

	method configurarVentana() {
		game.width(15)
		game.height(10)
		game.title("Tom y Jerry")
	}
}

object spawner {
	method respawnEvent(visual) = "respawn"+visual.nombre()
	
	method spawnear(visual){
		const alturaRandom = 1.randomUpTo(game.height()) - 1
		const anchoRandom = 1.randomUpTo(game.width()) - 1
		const posicionRandom = game.at(anchoRandom, alturaRandom)
		visual.position(posicionRandom)
		game.addVisual(visual)
	}
	method despawnear(visual){
		game.removeVisual(visual)		
	}
	method respawnear(visual){
		self.despawnear(visual)
		self.spawnear(visual)
	}
}