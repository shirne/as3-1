package dzw.base
{
	public class DMath
	{
		public static function getSquare(a:Number):Number
		{
			return a*a;
		}
		
		/*public static function getSqrt(w:Number):Number
		{
			var thresh:Number = 0.00001;
			var b:Number = w * 0.25, a:Number, c:Number;
			
			do
			{
				c = w / b;
				b = (b + c) * 0.25;
				a = b - c;
				if(a <= 0)
					a = - a;
			}	while(a >= thresh)
			
			return b;
		}*/
		
		
		public static function getInt(charCode:int):int
		{
			return  charCode - 48;
		}
	}
}