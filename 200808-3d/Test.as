package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.KeyboardEvent;
	
	public class Test extends MovieClip
	{
		var r:Weather;
		var s:Weather;
		var b:Boolean = true;
		
		public function Test()
		{
			var tx:TextField = new TextField;
			tx.text = "按左键更改天气 ->";
			tx.border = true;
			tx.height = 30;
			
			addChild(tx);
			r = new Rain();
			addChild(r);
			s = new Snow();
			addChild(s);
			s.visible = false;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDownKey);
		}
		
		private function onEnterFrame(event:Event):void
		{
			r.Show(mouseX, mouseY);
			s.Show(mouseX, mouseY);
		}
		
		private function onDownKey(event:KeyboardEvent):void
		{
			if(event.keyCode == 39)
			{
				b = !b;

				if(b)
				{
					s.visible = false;
					r.visible = true;
				}
				else
				{
					s.visible = true;
					r.visible = false;
				}
			}
		}
	}
}