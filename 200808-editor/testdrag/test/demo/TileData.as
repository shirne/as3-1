package test.demo
{
	import flash.geom.Point;
	//class		:	作为测试用
	public class TileData
	{
		static public var dataArray:Array = ["test.demo.Dao", "test.demo.Jian", "test.demo.Qiang"];
		static public var zhangaiArray:Object = {bingqi:[[0,0,0,0], [0,0,0,0], [1,1,1,1], [1,1,1,1]],
													dao:[[1,1,1,1], [0,0,0,0], [1,1,1,1], [1,1,1,1]],
													jian:[[0,0,0,0], [0,0,0,0], [0,0,0,0], [1,1,1,1]],
													qiang:[[0,0,0,0], [1,1,1,1], [0,0,0,0], [1,1,1,1]],
												npc:[[1,1],[1,1]]};
		public static function getZhangaiArray(str:String):Array
		{
			switch(str)
			{
				case "test.demo.Dao":
					return zhangaiArray["dao"];
					break;
				case "test.demo.Jian":
					return zhangaiArray["jian"];
					break;
				case "test.demo.Qiang":
					return zhangaiArray["qiang"];
					break;
					
				default:
					return zhangaiArray["bingqi"];
			}
		}
	}
}