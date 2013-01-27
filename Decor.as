package{

import flash.display.MovieClip;

public class Decor extends MovieClip{
	
	/* 
	 * collection of trigger and re-action
	 * the action is triggered when the personnage Bob enter the zone
	 * the structure is {zone: a movieClip attach to the scene, action( bob ) the action to perform }
	 */
	public var collisions;
	
	public var visuel;
	
	public function Decor( collisionLayers , visuel  ){
	
		collisions=collisionLayers; 
		
		var i=collisions.length
		while(i--)
			this.addChild( collisionLayers[i].zone );
			
		this.addChild( visuel );
	}
	public function detectCollision( motif ){
		//if on of the action retun false, return false so the personnage can cancel the move
		var i=collisions.length
		var accepteMove=true;
		while(i--){
			if( collisions[i].zone.hitTestPoint(motif.x,motif.y,true ) ){
				if( collisions[i].event=="move" )
					accepteMove=collisions[i].action( motif );
				
				if(!collisions[i].inner && collisions[i].event=="enter")
					accepteMove=collisions[i].action( motif );
				collisions[i].inner=true;
			}else{
				if(collisions[i].inner && collisions[i].event=="exit")
					accepteMove=collisions[i].action( motif );
				collisions[i].inner=false;
			}
		}
		return accepteMove;
	}
	public function update( bob ){
		// lets say the personnage stay at the center
		var w=Main.main.w,
			h=Main.main.h;
		
		var x = w/2;
		var y = h/2;
		
		var dx = x-(bob.x);
		var dy = y-(bob.y);
		
		bob.x+=dx;
		bob.y+=dy;
		
		this.x+=dx;
		this.y+=dy;
	}
	public function remove(){
		var i=collisions.length
		while(i--)
			this.removeChild( collisions[i].zone );
		if( visuel )
			this.removeChild( visuel );
	}
	
}

}