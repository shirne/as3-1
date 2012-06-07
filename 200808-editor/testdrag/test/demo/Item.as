package test.demo
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	//class		:	物品类(显示在物品栏)
		
	public class Item extends Sprite
	{
		public static var ITEM_DOWM:String = "item_down";
		private var m_Class:Class;				//标志物品类别
		private var m_typeString:String;				//此物品类别字符串表达
		
		//构造函数(物品所属Class, Class的字符串表示)
		public function Item(className:Class, typeString:String)	//带参构造函数[物品类]
		{
			m_typeString = typeString;
			m_Class = className;
			addChild(new m_Class());
			//注册物品被按下的事件(鼠标按下)处理函数
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		}
		
		//返回物品类别的字符串表达
		public function getType():String
		{
			return m_typeString;
		}
		
		//当一个物品被按下后发送事件
		private function onDown(event:MouseEvent):void
		{
			dispatchEvent(new Event(Item.ITEM_DOWM));
		}
	}
}