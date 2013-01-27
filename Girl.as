
package{

	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
public class Girl extends Personnage{

	public var follow=false;
	public var Jim;
	public var attachement=100+Math.random()*80;
	public var lbl;
	public function Girl(){
		super();
		var a=Math.random()*Math.PI;
		this.direction={x:Math.cos(a),y:Math.sin(a)};
	}
	override public function move(e){
			
		if(follow){
			var ab={x:this.x-Jim.x+Main.main.decor.x,y:this.y-Jim.y+Main.main.decor.y};
			var l=Math.sqrt(ab.x*ab.x+ab.y*ab.y);
			
			if( l > attachement ){
				this.x-=ab.x/l*(l - attachement);
				this.y-=ab.y/l*(l - attachement);
			}
			
			for( var i=0; i<Jim.bitches.length ; i ++ )
				if( Jim.bitches[i] != this ){
					ab={x:this.x-Jim.bitches[i].x,y:this.y-Jim.bitches[i].y};
					l=Math.sqrt(ab.x*ab.x+ab.y*ab.y);
					
					if( l < 100 ){
						this.x += ab.x/l*3;
						this.y += ab.y/l*3;
					}
				}
		}
			
		//got a wallhack
	}
}
	
	
	
	
	
	
}