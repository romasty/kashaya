package ru.kashaya.view.menu {
	import flash.display.DisplayObject;

	import ru.kashaya.view.components.layout.ILayout;

	import ru.kashaya.view.controls.KSMenuButton;

	public class HorizontalMenuLayout implements ILayout{

		public function updateLayout(items:Vector.<DisplayObject>):void
		{
            var prevB : DisplayObject;

            for each(var b : DisplayObject in items) {

                b.x = prevB ? prevB.x + prevB.width + 40 : 0;
                prevB = b;
            }
        }

    }
}