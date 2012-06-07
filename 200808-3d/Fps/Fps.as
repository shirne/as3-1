package Fps{
	import flash.system.System;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.*;
	import flash.text.TextField;
	public class Fps extends MovieClip {
		private var time:Timer;
		private var temp:int;
		private var temps:int;
		private var fpsvar:int;
		private var t:int=0;
		private var txt:TextField;
		private var txt11:TextField;
		//var shit:MovieClip;
		public function Fps():void {
			txt=new TextField();
			txt.height=60;
			txt.width=120;
			txt.textColor=0x000000;
			addChild(txt);
			txt11=new TextField();
			txt11.y=30;
			txt11.height=60;
			txt11.width=120;
			txt11.textColor=0x000000;
			addChild(txt11);
			time=new Timer(1);
			time.addEventListener(TimerEvent.TIMER, onTick);
			time.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			this.addEventListener("enterFrame",enterFrames);
			time.start();
			temp=getTimer();
			setInterval(timeover,1000);
		}
		private function enterFrames(event):void {
			t++;
		}
		private function timeover():void {
			fpsvar=temps-temp;
			temp=temps;
			txt11.text="FPS: "+fpsvar;
			txt.text="FPS: "+t+"\nRAM: "+System.totalMemory+" byte";
			t=0;
		}
		private function onTick(event:TimerEvent):void {
			temps=event.target.currentCount;
		}
		private function onTimerComplete(event:TimerEvent):void {

		}
	}
}