class Criatura{
  var poderOfensivo
  var rolActual 
  var poderMagico

  method poderMagico()
  method perderPoderMagico(valor){poderMagico = poderMagico - valor}
  method astucia()
  method rol(){return rolActual}
  method poderOfensivo(criatura){poderOfensivo =  criatura.poderMagico()* 10 + rolActual.darExtra(criatura)}
  method esFormidable(criatura){return criatura.esAstuta() or criatura.esExtraordinario(self)}
  method asignarRol(nuevoRol){rolActual = nuevoRol}
}
class Hada inherits Criatura{
 var kilometros = 2
  method kmPuedeVolar(){return kilometros}
  method aumentarKilometros(masKilometros){kilometros = (kilometros + masKilometros).min(25)}
  method astuta(){return self.astucia()>50}
  method esExtraordinario(){rolActual.esExtraordinario(self) and self.adicional()}
  method adicional(){return self.kmPuedeVolar()>10}
}
class Duende inherits Criatura{
  const esAstuta = false
override method poderOfensivo(criatura){
  poderOfensivo =  criatura.poderMagico()* 10 + rolActual.darExtra(self) + (poderOfensivo*0.1)}
  method astuta(){return esAstuta}
}
class Domador {
  var mascotas = []

  method mascotasConCuernos(){return mascotas.count({m=>m.tieneCuerno()})}
  method agregarMascota(unaMascota){mascotas.add(unaMascota)}
  method entrenarMascota(mascota){}
  method darExtra(criatura){return 150 * self.mascotasConCuernos()}
  method esExtraordinario(criatura){criatura.poderMagico()>= 15 and mascotas.all({m=>m.edad()>=10})}
  method cambiarDeRol(criatura){ return 
    if(self.mascotasConCuernos() > 0)criatura.asignarRol(new Hechicero())}
}
class Hechicero {
  method darExtra(criatura){return 0}
  method esExtraordinario(){ return true}
  method cambiarDeRol(criatura){ criatura.asignarRol(new Guardian())}
}
class Guardian {
  method darExtra(criatura){return 100}
  method esExtraordinario(criatura){criatura.poderMagico()> 50}
  method asignarRol(criatura){criatura.cambiarDeRol(new Domador()) }
}
class Mascota{
  var edad = 1
  var tieneCuernos = true
  method edad(){return edad}
  method crecer(uno){edad = edad + uno}
  method tieneCuerno(){return tieneCuernos}
}
class Colonia{
  const criaturas 
  var areaActual 
  method habitantes(){return criaturas}
  method poderOfensivo(){return criaturas.sum({c=>c.poderOfensivo()})}
  method atacar(colonia){}
  method conquistar(area){
    if(self.poderOfensivo() > area.poderDefensivo())
    area.serConquistado(self)
    areaActual = area}
  method perderConquista(area){
    self.poderOfensivo() < area.poderDefensivo()
    criaturas.forEach({c=>c.perderPoderMagico(c.poderMagico() * 0.15)})}
}
object parque{
  var colonias = []
  var areas = []
  method agregarColonia(colonia){colonias.add(Colonia)}
  method agregarArea(area){areas.add(area)}
}
 class LosClaros{
  var colonia
  method poderDefensivo(){return colonia.poderOfensivo() + 100}
  method serConquistado(otraColonia){colonia = otraColonia}
}
class LosCastillos{
  var  colonia
  method poderDefensivo(){return 200 * colonia.habitantes().count({h=>h.esFormidable()})}
  method serConquistado(otraColonia){colonia = otraColonia}
}