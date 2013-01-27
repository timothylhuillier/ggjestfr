package {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	public class Personnage extends MovieClip{
	
		public var last_direction;
		public var state:String;
		public var startFollower:Boolean = false;
		
		public var direction=0; 		//vecteur directeur
		public var velocity=0;
		public var contraction = 0;
		public var friction=0.7;
		public var acceleration=5;
		public var velocityCap=15;
		
		public function Personnage() {
			direction={x:0,y:0};
			updateAnimation();
			Main.main.stage.addEventListener( Event.ENTER_FRAME , move );
		}
		
		
		public function updateAnimation(){
			var lbl;
			if( Math.abs( direction.x ) > Math.abs( direction.y ) )
				if( direction.x < -direction.x )
					lbl = 'walk_west';
				else
					lbl = 'walk_east';
			else
				if( direction.y > -direction.y )
					lbl = 'walk_south';
				else
					lbl = 'walk_north';
			if( velocity < 1 )
				lbl += '_idle';
<<<<<<< HEAD
			this.gotoAndPlay(lbl);
=======
			if( this.currentLabel != lbl )
				this.gotoAndPlay(lbl);
>>>>>>> 966cff296d47bc4a5b475bb666e97d052a2272bf
		}
		public function impulse(dir){
		
			this.direction.x= this.direction.x*velocity + dir.x*acceleration;
			this.direction.y= this.direction.y*velocity + dir.y*acceleration;
			
			var l = Math.sqrt( direction.x*direction.x + direction.y*direction.y);
			
			this.direction.x=this.direction.x/l;
			this.direction.y=this.direction.y/l;
			
			this.velocity=Math.min( l , velocityCap );
		}
		
		public function speedUp()
		{
			if (contraction/3 >=3)
				setTimeout( Main.main.nextTableau , 2000 );
			this.velocity += 5;
			contraction++;
			trace(contraction);
		}
		
		public function move(e){
			
			this.velocity*=friction;
			
			this.x+=this.direction.x*this.velocity;
			this.y+=this.direction.y*this.velocity;
			
			if( Main.main.decor && !Main.main.decor.detectCollision( this ) ){
				this.x-=this.direction.x*this.velocity;
				this.y-=this.direction.y*this.velocity;
			}
			Main.main.decor.update( this );
			updateAnimation();
		}
		public function remove(){
			
			Main.main.stage.removeEventListener( Event.ENTER_FRAME , move );
		}
	} 
}