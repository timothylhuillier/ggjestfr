
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
	
public class Main extends MovieClip{

	
	public static var main;
	public var decor;
	
	public var w=500;
	public var h=400;
	
	public var stock={};
	
	public var tableauCursor=0;
	
	public var tableaux = [
		{
			lbl:"crazy stuff with uterus",
			prepare:function(){
			
				var bob=new Bob();
				bob.x=w/2;
				bob.y=h/2;
				
				var collisions=[
				{ 	zone : new MovieClip(),			// zone as a sprite
					event : "move",					// the event, "move" , "enter" or "exit"
					inner : false,					// always initialise at false
					action : function( bob ){
						return false;				// return false -> the movement wil be canceled
					}
				},
				{ 	zone : new tableau1_walls(),
					event : "enter",
					inner : false,
					action : function( bob ){
						return true;
						trace("on");
						nextTableau();
						return true;	// return true -> the movement will not be canceled
					}
				}];
				
				var i=collisions.length;
				while(i--)
					addChild( collisions[i].zone );
				
				var decor=new Decor( collisions , new MovieClip() );
				
				addChild( bob );
				addChild( decor );
				
				stock.decor=decor;
				stock.bob=bob;
				
				Main.main.decor=decor;
				
			},
			finish:function(){
				stock.bob.parent.removeChild( stock.bob );
				stock.decor.parent.removeChild( stock.decor );
				stock.bob=null;
				stock.decor=null;
				
			}
			
		},
		
		{
			lbl:"walking on the wood",
			prepare:function(){
			
				var bob=new Bob();
				bob.x=w/2;
				bob.y=h/2;
				
				var sm = new SoundManager();
				
				var collisions=[
				{ 	zone : new MovieClip(),			// zone as a sprite
					event : "move",					// the event, "move" , "enter" or "exit"
					inner : false,					// always initialise at false
					action : function( bob ){
						return false;				// return false -> the movement wil be canceled
					}
				},
				{ 	zone : new tableau1_walls(),
					event : "enter",
					inner : false,
					action : function( bob ){
						trace("on");
						sm.fade("two" , 1);
						return true;	// return true -> the movement will not be canceled
					}
				},
				{ 	zone : new tableau1_walls(),
					event : "exit",
					inner : false,
					action : function( bob ){
						trace("on");
						sm.fade("two" ,0);
						return true;	// return true -> the movement will not be canceled
					}
				}
				];
				
				var decor=new Decor( collisions , new MovieClip()  );
				
				addChild( bob );
				addChild( decor );
				
				stock.decor=decor;
				stock.bob=bob;
				
				Main.main.decor=decor;
				Main.main.soundMgr=sm;
			},
			finish:function(){
				stock.bob.parent.removeChild( stock.bob );
				stock.decor.parent.removeChild( stock.decor );
				stock.bob=null;
				stock.decor=null;
				
			}
		}
	
	]
	
	public function nextTableau(){
		var i = tableauCursor++;
		if( i>0)
			tableaux[i-1].finish();
		if( i<tableaux.length )
			tableaux[i].prepare();
	}
	
	public function Main(){
		
		main=this;
		
		nextTableau();
		
		//this.addEventListener( "enterFrame" , this.open );
	}
	
}
	
	
	
	
	
	
}