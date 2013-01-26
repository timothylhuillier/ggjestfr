package {
	import flash.display.MovieClip;
	import flash.events.*;
	public class JimLeClapeur extends ControledPersonnage{
	
		public var state:String;
		public var succefullClap=0;
		public function JimLeClapeur() {
			Main.main.stage.addEventListener( KeyboardEvent.KEY_UP , clap );
			var netClient:Object = new Object();
			netClient.onMetaData = function(meta:Object){
				  duree=meta.duration;
				  trace(duree);
				  curseur.addEventListener(Event.ENTER_FRAME, curseurAction);
			};
			ns.client=netClient;

			function curseurAction(evt:Event):void {
				  curseur.x=barreLect.x+ns.time*barreLect.width/duree;
			}
		}
		public var stamp=0;
		public function clap(e){
			if( e.keyCode != 34)		//space bar
				return;
			
			
			var pos=Main.main.soundMgr.sounds[0].canal.position
			
			var T=60/150*1000;
			
			if( Math.abs( 0.5-(pos%T)/T ) > 0.1  ){ // pulsation accepté
				if( new Date().getTime() - stamp < T*1.3 ){
					stamp=new Date().getTime();
					succefullClap++;
				}else{
					stamp=new Date().getTime();
					succefullClap=1;
				}
				oneSuccessFullClap();
			}else{
				succesfullClap=0;
			}
			
			if( succesfullClap > 2 )
				threeSuccessFullClap();
			
		}
		public function oneSuccessFullClap(){
			//TODO animate
		
		}
		public function threeSuccessFullClap(){
			//TODO animate
		
		}
		public function remove(){
			Main.main.stage.removeEventListener( KeyboardEvent.KEY_UP , clap );
		}
	} 
}