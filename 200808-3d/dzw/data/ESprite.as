package dzw.data
{
	/*
	 *	自定义模型数据的ThreeSprite
	 */
	 
	public class ESprite extends ThreeSprite
	{
		public function ESprite(data:Array)
		{
			model = data;
			l = model.length-1;

			var ll:int = model[l].length;
			
			var temp:Array = model[l];
			
			for(var i = 0; i < ll; i ++)
			{
				addChild(temp[i]);
			}
		}
	}
}