package
{
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class InputBoard extends MovieClip
	{
		public static var V:String = "V";
		public static var S:String = "S";
		public static var N:String = "N";
		private var fuben:Array = new Array;
		private var n:Array = new Array;
		private var biaodashi:Array  = new Array;
		
		public function InputBoard()
		{
			one.addEventListener(MouseEvent.CLICK, onClickSyomble);
			two.addEventListener(MouseEvent.CLICK, onClickSyomble);
			three.addEventListener(MouseEvent.CLICK, onClickSyomble);
			four.addEventListener(MouseEvent.CLICK, onClickSyomble);
			five.addEventListener(MouseEvent.CLICK, onClickSyomble);
			six.addEventListener(MouseEvent.CLICK, onClickSyomble);
			seven.addEventListener(MouseEvent.CLICK, onClickSyomble);
			eight.addEventListener(MouseEvent.CLICK, onClickSyomble);
			nine.addEventListener(MouseEvent.CLICK, onClickSyomble);
			ten.addEventListener(MouseEvent.CLICK, onClickSyomble);
			eleven.addEventListener(MouseEvent.CLICK, onClickSyomble);
			twelve.addEventListener(MouseEvent.CLICK, onClickSyomble);
			thirteen.addEventListener(MouseEvent.CLICK, onClickSyomble);
			jia.addEventListener(MouseEvent.CLICK, onClickSyomble);
			jian.addEventListener(MouseEvent.CLICK, onClickSyomble);
			sheng.addEventListener(MouseEvent.CLICK, onClickSyomble);
			chu.addEventListener(MouseEvent.CLICK, onClickSyomble);
			view.addEventListener(MouseEvent.CLICK, onClickSyomble);
			clean.addEventListener(MouseEvent.CLICK, onClickSyomble);
			sub.addEventListener(MouseEvent.CLICK, onClickSyomble);
			next.addEventListener(MouseEvent.CLICK, onClickSyomble);
			
		}
		
		private function onClickSyomble(event:MouseEvent):void
		{
			switch(event.target.label)
			{
				case "View Result":
					dispatchEvent(new Event(InputBoard.V))
					break;
				case "Sub":
					if(biaodashi.length == 7 || biaodashi.length == 0)
						dispatchEvent(new Event(InputBoard.S))
					break;
				case "Next":
					dispatchEvent(new Event(InputBoard.N))
					break;
					
				case "Clean Up":
					trace("d")
					cleanUp();
					break;
				
				case "+":
					if(biaodashi.length == 7)	return ;
					if(biaodashi[biaodashi.length-1] as int)
					{
						biaodashi.push("+");
					}
					break;
				case "-":
					if(biaodashi.length == 7)	return ;
					if(biaodashi[biaodashi.length-1] as int)
					{
						biaodashi.push("-");
					}
					break;
				case "*":
					if(biaodashi.length == 7)	return ;
					if(biaodashi[biaodashi.length-1] as int)
					{
						biaodashi.push("*");
					}
					break;
				case "/":
					if(biaodashi.length == 7)	return ;
					if(biaodashi[biaodashi.length-1] as int)
						biaodashi.push("/");
					break;
				default:
					if(biaodashi.length == 7)	return ;
					if(biaodashi[biaodashi.length-1] as int)
						return ;

					for(i = 0; i < n.length; i ++)
					{
						if(n[i] == int(event.target.label))
						{
							biaodashi.push(int(event.target.label));
							n.splice(i, 1);
							break;
						}
							
					}
					
			}
			
			statement.text = "";
			
			for(var i:int = 0; i < biaodashi.length; i ++)
			{
				statement.appendText(biaodashi[i].toString());
			}
		}
		
		private function cleanUp():void
		{
			n = fuben.concat();
			biaodashi = new Array;
			statement.text = "";
		}
		
		public function set Hou(n:Array):void
		{
			biaodashi = new Array;
			statement.text = "";
			houxuan.text = "";
			for(var i:int = 0; i < n.length; i ++)
			{
				houxuan.appendText(n[i].toString() + "   ");
			}
			this.fuben = n.concat();
			this.n = n;
		}
		
		public function get Statement():Array
		{
			return biaodashi;
		}
	}
}