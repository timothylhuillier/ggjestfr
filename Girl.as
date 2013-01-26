
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
	public var attachement=100;

	public function Girl(){
		super();
		var a=Math.random()*Math.PI;
		this.direction={x:Math.cos(a),y:Math.sin(a)};
	}
	override public function move(e){
			
		if(follow){
			var ab={x:this.x-Jim.x,y:this.y-Jim.y};
			var l=Math.sqrt(ab.x*ab.x+ab.y*ab.y);
			
			if( l > attachement ){
				this.x-=ab.x/l*(l - attachement);
				this.y-=ab.y/l*(l - attachement);
			}
			trace("hello");
		}
			
		//got a wallhack
	}
}
	
	
	
	
	
	
}