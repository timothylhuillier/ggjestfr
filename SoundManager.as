
package{

	import flash.media.*;
	import flash.events.*;
	import flash.net.URLRequest;
	
public class SoundManager {

	
	public var biblio=[
		{lbl:"one",src:s716},
		{lbl:"two",src:s714},
		{lbl:"three",src:s715}
		];
	public var sounds;
	
	
	
	
	public function SoundManager(){
		
		sounds=[];
		
		var i=biblio.length;
		while(i--){
			var s = new biblio[i].src();
			var canal=s.play(0, int.MAX_VALUE);
			var st=canal.soundTransform;
			st.volume=0;
			canal.soundTransform=st;
			sounds.push({s:s,lbl:biblio[i].lbl,canal:canal});
		}
		
	}
	public function fade( lbl , lvl ){
	
		var i=sounds.length;
		while(i--)
			if( lbl==sounds[i].lbl ){
				var st=sounds[i].canal.soundTransform;
				st.volume=lvl;
				sounds[i].canal.soundTransform=st;
				
				trace( sounds[i].canal.soundTransform.volume );
				/*
				var sens = (lvl-sounds[i].lvl)>0:1:-1;
				
				sounds[i].lvl=0.01;
				if( sounds[i].lvl
				*/
			}
			
	}
	
}
	
	
	
	
	
	
}