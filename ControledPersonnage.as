package {
	import flash.events.*;
	public class ControledPersonnage extends Personnage{
		
		private function keyBoardHandler(e){
			switch(e.keyCode){
				case 37: // gauche
					impulse({x:-1,y:0});
					updateAnimation('west');
				break;
				case 38: // haut
					impulse({x:0,y:-1});
					updateAnimation('south');
				break;
				case 39: // droite
					impulse({x:1,y:0});
					updateAnimation('east');
				break;
				case 40: // bas
					impulse({x:0,y:1});
					updateAnimation('north');
				break;
			}
		}
		
		public function ControledPersonnage() {
			super();
			Main.main.stage.addEventListener( KeyboardEvent.KEY_DOWN,keyBoardHandler );
		}
		override public function remove(){
			super.remove();
			Main.main.stage.removeEventListener( KeyboardEvent.KEY_DOWN,keyBoardHandler );
		}
		
	} 
}