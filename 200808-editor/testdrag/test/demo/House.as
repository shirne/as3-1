package test.demo
{
	import flash.display.Sprite;
	
	//class		:	房间
	
	public class House extends Sprite
	{
		//房间地形数据
		private var itemArray:Array;
		//房间地图数据
		private var dituData:Array;
		
		//构造函数
		public function House()
		{
			var xp:int=0;
			var yp:int=0;
			
			//初始化地图数据和地形数据
			dituData = new Array(30);
			for(var i:uint = 0; i < 30; i ++)
			{
				yp = 0;
				dituData[i] = new Array(30);
				for(var j:uint = 0; j < 30; j ++)
				{
					dituData[i][j] =  0;
					
					Tile1(xp, yp);
					yp+=10;
				}
				xp+=10;
				
			}
			
			itemArray = new Array(30);
			for(i = 0; i < 30; i ++)
			{
				itemArray[i] = new Array(30);
				for(j = 0; j < 30; j ++)
				{
					//标志此块没有物品
					itemArray[i][j] = [0, 0, 0, 0, "kong"];
				}
			}
			
			//绘制房间边框
			//drawRect();
		}
		
		private function Tile1(p_x : int, p_y : int,p_color : uint = 0x0000ff)
		{
			with (graphics)
			{
				lineStyle(1, 0x0000ff);
				beginFill(0x000000);
				drawRect(p_x, p_y,10, 10);
				endFill();
			}
		}
		
		
		
		//加入物品,若成功则加入,且返回true,否则不加入,且返回false
		public function tryAddItem(item:Item):Boolean
		{
			//判断所加物品当前位置是否处于房间内部
			if(item.x < x || item.x + item.width > x+width || item.y < y || item.y + item.height> height + y)
				return false;
				
			//若处于房间内部,则准换为相对房间坐标
			item.x = item.x - x;
			item.y = item.y - y;
			
			var xInTiles:uint = item.x / 10;					//物体左上角对应地形地图上的横坐标
			var yInTiles:uint = item.y / 10;					//物体左上角对应地形地图上的纵坐标
			var hTile:uint = item.height / 10;					//物品纵向占用格子数
			var wTile:uint = item.width / 10;					//物品横向占用格子数


			var tempZhangaiArray:Array = TileData.getZhangaiArray(item.getType());	//获取障碍点数组
			var numberX:uint = tempZhangaiArray[0].length;		//此物品的障碍点横跨几列
			var numberY:uint = tempZhangaiArray.length;			//此物品的障碍点纵跨几行
			
			var startX:uint = xInTiles;							//物品障碍属性第一个点在地形中对应位置
			var startY:uint = yInTiles + hTile - numberY;
			
			for(var j = 0; j < numberY; j ++)
			{
				for(var i = 0; i < numberX; i ++)
				{
					//在dituData中判断与待加入模型的障碍外观重合的部分是否有重合障碍

					if(dituData[startY+j][startX+i] != 0 && tempZhangaiArray[j][i] == 1)
						return false;
				}
			}
			
			//更新地图数据
			itemArray[xInTiles][yInTiles] = [item.x, item.y, item.width, item.height, item.getType()];
			
			for(j = 0; j < numberY; j ++)
			{
				for(i = 0; i < numberX; i ++)
				{
					//待加入模型为1的地方,则设置对应ditu数据里的格子为它
					if(tempZhangaiArray[j][i] == 1)
					{
						dituData[startY+j][startX+i] = item;
					}
				}
			}
			
			var tempZ:int = -1;
			for(var z:uint = 0; z < numberX; z ++)
			{
				for(var zz:uint = yInTiles+hTile; zz < 30; zz ++)
				{
					if(dituData[zz][xInTiles+z] != 0)	
					{
						tempZ = getChildIndex(dituData[zz][xInTiles+z]);
						break;
					}	else
					{
						continue;
						
					}
				}
			}
			if(tempZ < 0)	{
				addChild(item)
			}	else if(tempZ == 0)
				{
					addChildAt(item, 0);
				}
				else
			{
				addChildAt(item, tempZ - 1);
			}
			
			trace(dituData);
			
			return true; 
		}
		
		//绘制房间边框
		private function drawRect1():void
		{
			graphics.beginFill(0x2412CB);
			graphics.drawRect(0, 0, 300, 300);
			graphics.endFill();
		}
		
		//返回地形数据
		public function getDituArray():Array		
		{
			return dituData;
		}
		
		//消去房间物品
		public function plushHouse():void			
		{
			//清除物品
			for(;  this.numChildren>0; )
			{
				removeChildAt(0);
			}
			
			//清除地形数据
			for(var i:uint = 0; i < 30; i ++)
			{
				for(var j:uint = 0; j < 30; j ++)
				{
					dituData[i][j] = 0;
				}
			}
		}
		
		//根据地图数据重绘房间,且产生新地形数据
		public function showHouse(lr:LoadRes):void
		{
			for(var i:uint = 0; i < 30; i ++)
			{
				for(var j:uint = 0; j < 30; j ++)
				{
					if(itemArray[i][j][4] != "kong")
					{
						
						var item:Item = new Item(lr.getClass(itemArray[i][j][4]) as Class, itemArray[i][j][4]);
						item.x = itemArray[i][j][0];
						item.y = itemArray[i][j][1];
						item.width = itemArray[i][j][2];
						item.height = itemArray[i][j][3];
						var xInTiles:uint = item.x / 10;					//对应地形地图上的横坐标
						var yInTiles:uint = item.y / 10;					//对应地形地图上的纵坐标
						
						//更新地形数据
						for(var q:uint = 0; q < 4; q ++)
						{
							for(var p:uint = 0; p < 4; p ++)
							{
								dituData[yInTiles+q][xInTiles+p] = item;
							}
						}
						addChild(item);
					}//end if
				}	//end second for
			}	//end first for
		}	//end function 
	}	//end class
	
}