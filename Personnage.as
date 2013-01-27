﻿package {
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
			
			if( this.currentLabel != lbl )
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
		
		public function speedUp()
		{
			if (Main.main.tableaux[Main.main.tableauCursor].lbl == "crazy stuff with uterus")
				{
					if (contraction/2 >=3)
						{
							setTimeout( Main.main.nextTableau , 2000 );
							Main.main.level++;
							return;
						}
					this.velocity += 5;
					contraction++;
				}
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