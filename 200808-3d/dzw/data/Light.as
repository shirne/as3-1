package dzw.data
{
	
	/**
	 *	简单光照类
	 */
	public class Light
	{
		private var lx:Number;
		private var ly:Number;
		private var lz:Number;
		private var brightness:Number;
		
		public function Light(lx:Number = 100, ly:Number = 200, lz:Number = 300, brightness:Number = 0.5)
		{
			this.lx = lx;
			this.ly = ly;
			this.lz = lz;
			this.brightness = brightness;
		}
		
		public function get X():Number
		{
			return lx;
		}
		
		public function get Y():Number
		{
			return ly;
		}
		public function get Z():Number
		{
			return lz;
		}
		
		public function set Brightness(b:Number):void
		{
			this.brightness = Math.max(b, 0);
			this.brightness = Math.min(this.brightness, 1);
		}
		
		public function get Brightness():Number
		{
			return this.brightness;
		}
	}
}