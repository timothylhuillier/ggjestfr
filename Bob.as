package {

	public class Bob extends ControledPersonnage{
		public var b=0;
		public function Bob() {
			super();
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