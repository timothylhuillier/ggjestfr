
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

	
	public static var main;
	public var decor;

	public function Girl(){
		super();
		var a=Math.random()*Math.PI;
		this.direction={x:Math.cos(a),y:Math.sin(a)};
	}
	
}
	
	
	
	
	
	
}