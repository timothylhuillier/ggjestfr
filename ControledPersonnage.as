package {
	import flash.events.*;
	public class ControledPersonnage extends Personnage{
		
		private function idleHandler(e)
		{
			switch(e.keyCode){
				case 37: // gauche
					updateAnimation('west', true);
				break;
				case 38: // haut
					updateAnimation('north', true);
				break;
				case 39: // droite
					updateAnimation('east', true);
				break;
				case 40: // bas
					updateAnimation('south', true);
				break;
			}
		}
		
		private function keyBoardHandler(e){
			switch(e.keyCode){
				case 37: // gauche
					impulse({x:-1,y:0});
					updateAnimation('west', false);
				break;
				case 38: // haut
					impulse({x:0,y:-1});
					updateAnimation('north', false);
				break;
				case 39: // droite
					impulse({x:1,y:0});
					updateAnimation('east', false);
				break;
				case 40: // bas
					impulse({x:0,y:1});
					updateAnimation('south', false);
				break;
			}
		}
		
		public function ControledPersonnage() {
			super();
			Main.main.stage.addEventListener( KeyboardEvent.KEY_DOWN,keyBoardHandler );
			Main.main.stage.addEventListener( KeyboardEvent.KEY_UP,idleHandler );
		}
		override public function remove(){
			super.remove();
			Main.main.stage.removeEventListener( KeyboardEvent.KEY_DOWN,keyBoardHandler );
			Main.main.stage.removeEventListener( KeyboardEvent.KEY_UP,idleHandler );
		}
		
	} 
}