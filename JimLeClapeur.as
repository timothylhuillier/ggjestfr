package {
	import flash.display.MovieClip;
	import flash.events.*;
	public class JimLeClapeur extends ControledPersonnage{
	
		public var succesfullClap=0;
		public var bitches=[];
		public var girl=null;
		public function JimLeClapeur() {
			Main.main.stage.addEventListener( KeyboardEvent.KEY_UP , clap );
			Main.main.stage.addEventListener( Event.ENTER_FRAME , enterF );
		}
		public var stamp=0;
		public var goodOnes=[false,false,false,false,false,false,false];
		public function queue(b){
			for( var i=1;i<goodOnes.length;i++)
				goodOnes[i-1]=goodOnes[i];
			goodOnes[goodOnes.length-1]=b;
		}
		var alo=new hint();
		public function enterF(e){
			
			var pos=Main.main.soundMgr.sounds[0].canal.position;
			var T=800;
			if( alo.parent )
				alo.parent.removeChild(alo);
			
			if( (pos%T)/T  < 0.15 || 0.85 < (pos%T)/T )
				if( this.girl )
					this.girl.addChild( alo );
					
		}
		public function resetQueue(){
			goodOnes=[false,false,false,false,false,false,false];
		}
		public function validQueue(){
			var c=0;
			for( var i=0;i<goodOnes.length;i++)
				if( goodOnes[i] )
					c++;
			return c;
		}
		public function clap(e){
			
			if( e.keyCode != 32)		//space bar
				return;
			
			var pos=Main.main.soundMgr.sounds[0].canal.position
			
			var T=800;
			trace( (pos%T)/T );
			if( new Date().getTime() - stamp < T*5 && ( (pos%T)/T  < 0.25 || 0.75 < (pos%T)/T )  ){ // pulsation accepté
				stamp=new Date().getTime();
				queue(true);
				oneSuccessFullClap();
			}else{
				stamp=new Date().getTime();
				queue(false);
			}
			
			if( !this.girl )
				resetQueue();
				
			
			var queuValid=validQueue();
			Main.main.soundMgr.fade( "main" , 0.5+0.5*queuValid/4 );
			if( queuValid > 4 )
				threeSuccessFullClap();
			
		}
		
		override public function move(e){
			super.move(e);
		}
		
		public function oneSuccessFullClap(){
			
			if( this.girl )
				this.girl.addChild( new burstHalo() );
				
			var i=bitches.length;
			while(i--)
				bitches[i].addChild( new burstHalo() );
		}
		public function threeSuccessFullClap(){
			bitches.push( this.girl );
			this.girl.follow=true;
			this.girl.Jim=this;
			this.girl=null;
		}
		override public function remove(){
			Main.main.stage.removeEventListener( KeyboardEvent.KEY_UP , clap );
			Main.main.stage.removeEventListener( Event.ENTER_FRAME , enterF );
		}
	} 
}