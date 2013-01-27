﻿
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
	
	public var w=900;
	public var h=800;
	
	public var stock={};
	
	public var tableauCursor=0;
	
	public var soundMgr=0;
	
	public var tableaux = [
		{
			lbl:"crazy stuff with uterus",
			prepare:function(){
			
				var bob=new Bob();
				var sang = new le_rouge();
				
				var collisions=[
				{ 	zone : new collision_tableau1(),// zone as a sprite
					event : "move",					// the event, "move" , "enter" or "exit"
					inner : false,					// always initialise at false
					action : function( bob ){
						return false;				// return false -> the movement wil be canceled
					}
				},
				{ 	zone : new exit_tableau1(),
					event : "enter",
					inner : false,
					action : function( bob ){
						trace("trigger");
						setTimeout( nextTableau , 20000 );
						return true;	// return true -> the movement will not be canceled
					}
				},
				{
					zone : sang,
					event : "enter",
					inner : false,
					action : function (bob) {
						trace("sang");
						if (bob.velocity > 0)
							{
								if (bob.velocity < 0.5)
									bob.velocity = 0;
								else
									bob.velocity -= 0.5;
							}
						return true;
					}
					
				}];
				
				
				var eaux= new les_eaux();
				eaux.y=2500;
				var eaux_removed = false;
				sang.y=2100;
				var descente=function(e){
					if (eaux_removed == false)
						eaux.y+=20;
					else 
						{
							sang.y+=2;
							trace(sang.y);
						}
					if(eaux_removed == false && eaux.y>5000)
					{
						eaux_removed = true;
					}
					if (bob.y < sang.y)
						trace ("BUMP! : " + bob.y);
					if (sang.y > 5000)
					{
						eaux.removeEventListener(Event.ENTER_FRAME,descente);
						eaux.parent.removeChild(eaux);
						sang.parent.removeChild(sang);
					}
				};
				eaux.addEventListener(Event.ENTER_FRAME,descente);
				
				
				
				
				
				var decor=new Decor( collisions , new fond_tableau1() );
				
				var s = new Musique_scene_1_IG();
				var canal=s.play(0, int.MAX_VALUE);
				
				
				
				addChild( decor );
				addChild( bob );
				addChild(eaux);
				addChild(sang);
				
				stock.decor=decor;
				stock.bob=bob;
				stock.canal=canal;
				
				Main.main.decor=decor;
				
			},
			finish:function(){
				
				stock.bob.remove();
				stock.decor.remove();
				stock.bob.parent.removeChild( stock.bob );
				stock.decor.parent.removeChild( stock.decor );
				stock.canal.stop();
				Main.main.decor=null;
				stock.bob=null;
				stock.decor=null;
				stock.canal=null;
			}
			
		},
		{
			lbl:"walking on the wood",
			prepare:function(){
			
				var jim=new JimLeClapeur();
				
				var biblio=[
					{lbl:"coeur",src:Musique_scene_2_coeur},
					{lbl:"gay",src:Musique_scene_2_main_gay_moustache},
					{lbl:"petasse",src:Musique_scene_2_petasse},
					{lbl:"quelconque",src:Musique_scene_2_femme_normale},
					{lbl:"exhibo",src:Musique_scene_2_exhibo}
				];
				
				var sm = new SoundManager( biblio );
				
				sm.fade( "coeur" , 0.7 );
				
				var girls=[
					{g:null,x:4750,y:480,rond:null,lbl:"petasse",src:Girl},
					{g:null,x:2450,y:180,rond:null,lbl:"gay",src:Girl},
					{g:null,x:480,y:980,rond:null,lbl:"coeur",src:Girl},
					{g:null,x:950,y:-180,rond:null,lbl:"exhibo",src:Girl}
				];
					
				
				var collisions=[
				{ 	zone : new collision_tableau2(),			// zone as a sprite
				//{ 	zone : new MovieClip(),			// zone as a sprite
					event : "move",					// the event, "move" , "enter" or "exit"
					inner : false,					// always initialise at false
					action : function( jim ){
						return false;				// return false -> the movement wil be canceled
					}
				}]
	
				var i=girls.length;
				while(i--){
					(function(){
						var g=new girls[i].src();
						var rond=new tableau2_trigger();
						collisions.push(
						{ 	zone : rond,
							event : "enter",
							inner : false,
							action : function( jim ){
								jim.girl=g;
								sm.fade(g.lbl , 0.4);
								return true;	// return true -> the movement will not be canceled
								
							}
						} );
						collisions.push(
						{ 	zone : rond,
							event : "exit",
							inner : false,
							action : function( jim ){
								jim.girl=null;
								sm.fade(g.lbl ,0);
								return true;	// return true -> the movement will not be canceled
								
							}
						} );
						rond.x=girls[i].x;
						rond.y=girls[i].y;
						g.x=girls[i].x;
						g.y=girls[i].y;
						girls[i].g=g;
						girls[i].rond=rond;
						g.lbl=girls[i].lbl;
					})();
				}
				
				
				var decor=new Decor( collisions , new fond_tableau2()  );
				
				var j=girls.length;
				while(j--){
					decor.addChild( girls[j].rond );
					decor.addChild( girls[j].g );
				}
					
				
				addChild( decor );
				addChild( jim );
				
				stock.decor=decor;
				stock.bob=jim;
				stock.girls=girls;
				
				Main.main.decor=decor;
				Main.main.soundMgr=sm;
			},
			finish:function(){
				stock.bitches=stock.bob.bitches;
				var j=stock.girls.length;
				while(j--){
					decor.removeChild( stock.girls[j].rond );
					decor.removeChild( stock.girls[j].g );
				}
				stock.bob.remove();
				stock.decor.remove();
				Main.main.soundMgr.remove();
				stock.bob.parent.removeChild( stock.bob );
				stock.decor.parent.removeChild( stock.decor );
				Main.main.soundMgr=null;
				stock.bob=null;
				stock.decor=null;
				
			}
		}
		/*{
			lbl:"where i go",
			prepare:function(){
			
				var george=new George();
				
				george.bitches=stock.bitches;
				stock.bitches=null;
				
				var stones=[
					{g:null,x:-1000,y:-280,src:stone1,touched:false,rond:null},
					{g:null,x:-450,y:180,src:stone1,touched:false,rond:null},
					{g:null,x:-1480,y:480,src:stone1,touched:false,rond:null}
				];
					
				var cadre=new collision_tableau3();
				var fancy_cadre=new fond_tableau3();
				var collisions=[
				{ 	zone : cadre,			// zone as a sprite
					event : "move",					// the event, "move" , "enter" or "exit"
					inner : false,					// always initialise at false
					action : function( george ){
						return false;				// return false -> the movement wil be canceled
					}
				}]
	
				var i=stones.length;
				while(i--){
					(function(){
						var g=new stones[i].src();
						var j=i;
						var rond=new collision_stone1();
						collisions.push(
						{ 	zone : rond,
							event : "move",
							inner : false,
							action : function( george ){
								if(!stones[j].touched){
									trace( j );
									george.velocityCap-=4.3;
									stones[j].touched=true;
								}
								return false;	// return true -> the movement will not be canceled
								
							}
						} );
						rond.x=stones[i].x;
						rond.y=stones[i].y;
						g.x=stones[i].x;
						g.y=stones[i].y;
						stones[i].g=g;
						stones[i].rond=rond;
					})();
				}
				
				var decor=new Decor( collisions , fancy_cadre  );
				
				addChild( decor );
				
				i=stones.length;
				while(i--){
					decor.addChild(stones[i].g);
					decor.addChild(stones[i].rond);
				}
				
				addChild( george );
				
				stock.decor=decor;
				stock.bob=george;
				
				Main.main.decor=decor;
				
				var tick=0;
				var sin_tick=-1;
				var t=[1,0.8,0.6,0.5,0.41,0.33];
				var cursor=0;
				
				var last_d=1;
				var decrease=function(){
					
					if(sin_tick>=0){
						var s=Math.cos(sin_tick/70*Math.PI*6)*( 1-sin_tick/70 ) / ( 1 + sin_tick/70*3 );
						
						var d=t[cursor+1] + (t[cursor]-t[cursor+1])*s;
						
						cadre.scaleY=cadre.scaleX=fancy_cadre.scaleX=fancy_cadre.scaleY=d;
						
						/*
						var r={ x:george.x , y:george.y };
						var l=Math.sqrt( r.x*r.x + r.y*r.y );
						
						george.x = george.x*( d - last_d );
						george.y = george.y*( d - last_d );
						
						last_d=d;
						sin_tick++;
						if( sin_tick > 70 ){
							sin_tick=-1;
							
							cursor++
							if( cursor+1>t.length)
								removeEventListener(Event.ENTER_FRAME,decrease);
						}
						
						
						
						tick=0;
					}
					if( tick > 160 )
						sin_tick=0;

					tick++
					
					
				};
				
				addEventListener(Event.ENTER_FRAME,decrease);
			},
			finish:function(){
				stock.bob.remove();
				stock.decor.remove();
				Main.main.soundMgr.remove();
				stock.bob.parent.removeChild( stock.bob );
				stock.decor.parent.removeChild( stock.decor );
				Main.main.soundMgr=null;
				stock.bob=null;
				stock.decor=null;
				
			}
		}*/
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
	}
	
}
	
	
	
	
	
	
}