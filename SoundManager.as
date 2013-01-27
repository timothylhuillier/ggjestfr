
package{

	import flash.media.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.utils.*;
	
public class SoundManager {

	public var sounds;
	
	public function SoundManager( biblio ){
		
		sounds=[];
		
		var i=biblio.length;
		while(i--){
			var s = new biblio[i].src();
			var canal=s.play(0, int.MAX_VALUE);
			var st=canal.soundTransform;
			if( biblio[i].lbl!="main")
				st.volume=0;
			else
				st.volume=0.5;
			canal.soundTransform=st;
			sounds.push({s:s,lbl:biblio[i].lbl,canal:canal});
		}
		
	}
	public function fade( lbl , lvl ){
		if(lvl>1)
			lvl=1;
		var i=sounds.length;
		while(i--)
			if( lbl==sounds[i].lbl ){
				
				var st=sounds[i].canal.soundTransform;
				/*
				var d=lvl-st.volume;
				var sens=d>0?1:-1;
				
				var nv=st.volume+sens*Math.min(Math.abs(d),0.06);
				
				st.volume=nv;
				sounds[i].canal.soundTransform=st;
				
				if( nv != lvl )
					setTimeout( function(){ if( fade ) fade( lbl , lvl ); } , 200);
				*/
				st.volume=lvl;
				sounds[i].canal.soundTransform=st;
				
			}
			
	}
	public function remove(){
			var i=sounds.length;
			while(i--){
				sounds[i].canal.stop();
				sounds[i]=null;
			}
			sounds=null;
	}
	
}
	
	
	
	
	
	
}