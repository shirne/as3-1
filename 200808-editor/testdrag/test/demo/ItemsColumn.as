package test.demo
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	//class		:	物品栏
	
	public class ItemsColumn extends Sprite
	{
		public static var SELECT_ITEM:String = "select_item";
		
		//记录当前物品栏所操作的物品
		private var m_nowDragItem:Item;	
		//物品栏中物品个数
		private var m_itemNumber:uint;	
		//保存当前所选择物品的绝对X,Y坐标
		private var m_X:uint;			
		private var m_Y:uint;
		
		public function ItemsColumn()
		{
			m_itemNumber = 0;
			drawHouseRect();					//绘制边框
		}

		public function addItem(item:Item):void
		{
			//所添加到物品进行缩放显示
			item.scaleX = 0.5;
			item.scaleY = 0.5
			item.y = 43*m_itemNumber++;
			addChild(item);
			//侦听物品被按下的事件
			item.addEventListener(Item.ITEM_DOWM, handleDowmItem);
		}
		
		//处理物品被按下时的事件
		public function handleDowmItem(event:Event):void
		{
			//储存当前操作的物品
			m_nowDragItem = event.target as Item;
			
			//转换为绝对坐标
			m_X = x + m_nowDragItem.x;
			m_Y = y + m_nowDragItem.y;
			
			//发送物品栏中选择物品事件
			dispatchEvent(new Event(ItemsColumn.SELECT_ITEM));
			
		}
		
		//获取物品栏中当前选择的那个物品的类型的字符串表达
		public function getNowSelect():String
		{
			return m_nowDragItem.getType();
		}
		
		//获取物品栏中当前选择的那个物品的X绝对坐标
		public function getNowSelectPointX():uint
		{
			return m_X;
		}
		//获取物品栏中当前选择的那个物品的Y绝对坐标
		public function getNowSelectPointY():uint
		{
			return m_Y;
		}
		
		//绘制房间边框
		private function drawHouseRect():void
		{
			graphics.beginFill(0xFFCC00);
			graphics.drawRect(0, 0, 50, 150);
			graphics.endFill();
		}
	}
}