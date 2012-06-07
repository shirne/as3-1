package dzw.data
{
	public class Line
	{
		private var aspect:DVector;
		private var point:DPoint;
		
		public function Line(aspect:DVector, point:DPoint)
		{
			this.aspect = aspect;
			this.point = point;
		}
		
		public function get Aspect():DVector
		{
			return aspect;
		}
		
		public function get Point():DPoint
		{
			return point;
		}
		
		public function getPara():Number
		{
			return -point.Z/aspect.Z;
		}
		
		public function getCutX():Number
		{
			return getPara()*aspect.X + point.X;
		}
		
		public function getCutY():Number
		{
			return getPara()*aspect.Y + point.Y;
		}
		
	}
}