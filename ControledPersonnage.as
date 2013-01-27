package {
	import flash.events.*;
	public class ControledPersonnage extends Personnage{
		private var keyDown={
			up:false,
			bot:false,
			left:false,
			right:false}
		private function upHandler(e)
		{
			switch(e.keyCode){
				case 37: // gauche
					keyDown.left=false;
				break;
				case 38: // haut
					keyDown.up=false;
				break;
				case 39: // droite
					keyDown.right=false;
				break;
				case 40: // bas
					keyDown.bot=false;
				break;
			}
		}
		
		private function downHandler(e){
			switch(e.keyCode){
				case 37: // gauche
					keyDown.left=true;
				break;
				case 38: // haut
					keyDown.up=true;
				break;
				case 39: // droite
					keyDown.right=true;
				break;
				case 40: // bas
					keyDown.bot=true;
				break;
			}
		}
		
		private function continuous(e){
			if( keyDown.left ) impulse({x:-1,y:0});
			if( keyDown.right ) impulse({x:1,y:0});
			if( keyDown.up  ) impulse({x:0,y:-1});
			if( keyDown.bot  ) impulse({x:0,y:1});
		}
		
		public function ControledPersonnage() {
			super();
			Main.main.stage.addEventListener( KeyboardEvent.KEY_DOWN,downHandler );
			Main.main.stage.addEventListener( KeyboardEvent.KEY_UP,upHandler );
			Main.main.stage.addEventListener( Event.ENTER_FRAME,continuous );
		}
		override public function remove(){
			super.remove();
			Main.main.stage.removeEventListener( KeyboardEvent.KEY_DOWN,downHandler );
			Main.main.stage.removeEventListener( KeyboardEvent.KEY_UP,upHandler );
			Main.main.stage.removeEventListener( Event.ENTER_FRAME,continuous );
		}
		
	} 
}