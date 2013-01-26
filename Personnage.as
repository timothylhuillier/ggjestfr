package {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Personnage extends MovieClip{
	
		public var follower:Vector.<pnj>; // followers
		public var last_direction;
		public var state:String;
		public var startFollower:Boolean = false;
		
		public var direction=0; 		//vecteur directeur
		public var velocity=0;
		public var friction=0.9;
		public var acceleration=3;
		public var velocityCap=13;
		
		public function Personnage(var pos_x:int, var pos_y:int) {
			v = new Vector.<pnj>();
			updateAnimation('east', true);
			direction={x:pos_x,y:pos_y};
			Main.main.stage.addEventListener( Event.ENTER_FRAME , move );
		}
		
		public function addFollower(var follow:pnj)
		{
			this.follower.push(follow);
			startFollower = true;
			
		}
		
		public function updateAnimation(direction, idle){
			var lbl;
			if (direction == 'west') // gauche
				lbl = 'walk_west';
			else if (direction == 'south')
				lbl = 'walk_south';
			else if (direction == 'east')
				lbl = 'walk_east';
			else if (direction == 'north')
				lbl = 'walk_north';
			if (idle == true)
				lbl += '_idle';
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
			Main.main.decor.update( this );
			//updateAnimation();
		}
		public function remove(){
			
			Main.main.stage.removeEventListener( Event.ENTER_FRAME , move );
		}
	} 
}