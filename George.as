package {

	public class George extends ControledPersonnage{
		public var bitches=[];
		public function George() {
			super();
			velocityCap=5;
		}
		override public function move(e){
			super.move(null);
			if( Main.main.decor )
				Main.main.decor.update(this);
		}
		override public function remove(){
			super.remove();
		}
	} 
}