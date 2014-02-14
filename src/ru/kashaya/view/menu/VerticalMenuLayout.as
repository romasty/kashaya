package ru.kashaya.view.menu {
	import flash.display.DisplayObject;

	import ru.plod.gui.layout.ILayout;

	public class VerticalMenuLayout implements ILayout{

		private var _gap : int;

		public function VerticalMenuLayout(gap:int)
		{
			_gap = gap;
		}

		public function arrange(items:Vector.<DisplayObject>):void
		{
            var i : int;

            for each(var b : DisplayObject in items) {

                b.y = i * _gap - .5 * b.height;
                i++;
            }

        }
    }
}