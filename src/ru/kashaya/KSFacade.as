package ru.kashaya {
    import ru.kashaya.view.MainScene;
    import ru.kashaya.view.PreloaderScene;

    public class KSFacade {

        public static var instance : KSFacade = new KSFacade();


        public function KSFacade() {
        }

        public var prelscene : PreloaderScene;
        public var scene : MainScene;

    }
}