package {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Personnage extends MovieClip{
	
		public var state:String;
		
		public var direction=0; 		//vecteur directeur
		public var velocity=0;
		public var friction=0.8;
		public var acceleration=3;
		public var velocityCap=10;
		
		public function Personnage() {
			updateAnimation('east');
			direction={x:0,y:0};
			Main.main.stage.addEventListener( Event.ENTER_FRAME , move );
		}
		
		public function updateAnimation($direction){
			var lbl;

			switch($direction){
				case 'west': // gauche
					lbl = 'walk_west';
				break;
				case 'south': // haut
					lbl = 'walk_north';
				break;
				case 'east': // droite
					lbl = 'walk_east';
				break;
				case 'north': // bas
					lbl = 'walk_south';
				break;
			}
			this.gotoAndStop(lbl);
			
		}
		public function impulse(dir){
			this.direction.x= this.direction.x*velocity + dir.x*acceleration;
			this.direction.y= this.direction.y*velocity + dir.y*acceleration;
			
			var l = Math.sqrt( direction.x*direction.x + direction.y*direction.y);
			
			this.direction.x=this.direction.x/l;
			this.direction.y=this.direction.y/l;
			
			this.velocity=Math.min( l , velocityCap );
		}
		public function move(e){
			
			
			
			this.velocity*=friction;
			
			var rx=this.x;
			var ry=this.y;
			
			this.x+=this.direction.x*this.velocity;
			this.y+=this.direction.y*this.velocity;
			
			if( Main.main.decor && !Main.main.decor.detectCollision( this ) ){
				this.x=rx;
				this.y=ry;
			}
			
			// updateAnimation();
		}
		public function remove(){
			
			Main.main.stage.removeEventListener( Event.ENTER_FRAME , move );
		}
	} 
}