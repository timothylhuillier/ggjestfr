package {
	import flash.display.MovieClip;
	import flash.events.*;
	public class JimLeClapeur extends ControledPersonnage{
	
		public var succesfullClap=0;
		public var bitches=[];
		public var girl=null;
		public function JimLeClapeur() {
			Main.main.stage.addEventListener( KeyboardEvent.KEY_UP , clap );
			
		}
		public var stamp=0;
		public var goodOnes=[false,false,false,false,false,false,false];
		public function queue(b){
			for( var i=0;i<goodOnes.length-1;i++)
				goodOnes[i]=goodOnes[i-1];
			goodOnes[goodOnes.length-1]=b;
		}
		public function resetQueue(){
			goodOnes=[false,false,false,false,false,false,false];
		}
		public function validQueue(){
			var c=0;
			for( var i=0;i<goodOnes.length;i++)
				if( goodOnes[i] )
					c++;
			return c>4;
		}
		public function clap(e){
			
			if( e.keyCode != 32)		//space bar
				return;
			
			var pos=Main.main.soundMgr.sounds[0].canal.position
			
			var T=60/150*1000;
			
			if( Math.abs( 0.5-(pos%T)/T ) > 0.35  ){ // pulsation accepté
				if( new Date().getTime() - stamp < T*1.2 ){
					stamp=new Date().getTime();
					queue(true);
				}else{
					stamp=new Date().getTime();
					queue(false);
				}
				oneSuccessFullClap();
			}else{
				queue(false);
			}
			
			if( !this.girl )
				resetQueue();
				
			if( validQueue() )
				threeSuccessFullClap();
			
		}
		
		override public function move(e){
			super.move(e);
		}
		
		public function oneSuccessFullClap(){
			var b=new burstHalo();
			this.addChild(b);
			
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
		}
	} 
}