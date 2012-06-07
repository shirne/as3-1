package {

	import Com;
	import Node;

	public class Validate {

		private static  var add1:String = "+";
		private static  var add2:String = "+";
		private static  var add3:String = "+";
		private static  var dec1:String = "-";
		private static  var dec2:String = "-";
		private static  var dec3:String = "-";
		private static  var div1:String = "/";
		private static  var div2:String = "/";
		private static  var div3:String = "/";
		private static  var mul1:String = "*";
		private static  var mul2:String = "*";
		private static  var mul3:String = "*";
		private static  var count:int = 0;

		private static  var operArray:Array;

		public static function getGameResult(num:Array):Array {

			if (count++ == 0) {
				init();
			}
			
			var zhongji:Array = Node.getResult(num);

			for (var h:int = 0; h < operArray.length; h ++) {
				for (var ya:int = 0; ya < zhongji.length; ya ++) {
					var rr:int = getResult(zhongji[ya], operArray[h]);
					if (rr == 24) {
						return [zhongji[ya][0], operArray[h][0], zhongji[ya][1], operArray[h][1], zhongji[ya][2], operArray[h][2], zhongji[ya][3]]
					}
					rr = getResult(zhongji[ya], [operArray[h][0], operArray[h][2], operArray[h][1]]);
					if (rr == 24) {
						return [zhongji[ya][0], operArray[h][0], zhongji[ya][1], operArray[h][2], zhongji[ya][2], operArray[h][1], zhongji[ya][3]]
					}
					rr = getResult(zhongji[ya], [operArray[h][1], operArray[h][2], operArray[h][0]]);
					if (rr == 24) {
						return [zhongji[ya][0], operArray[h][1], zhongji[ya][1], operArray[h][2], zhongji[ya][2], operArray[h][0], zhongji[ya][3]]
					}
					rr = getResult(zhongji[ya], [operArray[h][1], operArray[h][0], operArray[h][2]]);
					if (rr == 24) {
						return [zhongji[ya][0], operArray[h][1], zhongji[ya][1], operArray[h][0], zhongji[ya][2], operArray[h][2], zhongji[ya][3]]
					}
					rr = getResult(zhongji[ya], [operArray[h][2], operArray[h][0], operArray[h][1]]);
					if (rr == 24) {
						return [zhongji[ya][0], operArray[h][2], zhongji[ya][1], operArray[h][0], zhongji[ya][2], operArray[h][1], zhongji[ya][3]]
					}
					rr = getResult(zhongji[ya], [operArray[h][2], operArray[h][1], operArray[h][0]]);
					if (rr == 24) {
						return [zhongji[ya][0], operArray[h][2], zhongji[ya][1], operArray[h][1], zhongji[ya][2], operArray[h][0], zhongji[ya][3]]
					}
				}
			}
			return new Array;
		}
		
		private static function init():void {

			operArray = Com.getResult([add1, add2, add3, dec1, dec2, dec3, div1, div2, div3, mul1, mul2, mul3], 3);

			for (var i:int = 0; i  < operArray.length; i++) {
				var temp:Array = operArray[i];
				for (var j:int = i + 1; j < operArray.length; ) {
					if (temp.toString() ==  operArray[j].toString()) {
						operArray.splice(j, 1);
					} else {
						j++;
					}
				}
			}
		}
		
		public  static function getResult(n:Array, p:Array):int {
			var total:int = n[0];

			for (var r:int = 0; r < n.length-1; r++) {
				total = suan(total, n[r+1], p[r]);
			}
			return total;
		}

		private static function suan(na:int, nb:int, p:String):Number {
			switch (p) {
				case add1 :
					return na + nb;
				case dec1 :
					return na - nb;
				case div1 :
					if (na % nb != 0) {
						return 1000;
					}
					return na / nb;
				case mul1 :
					return na * nb;
			}
			return 0;
		}

	}
}