package ru.kashaya.model {
    import ru.kashaya.exception.UnsupportedData;

    public class ContentDataModelFactory {

        public static const TEXT : String = "text";
        public static const GALLERY : String = "gallery";
        public static const GROUP : String = "group";
        public static const LINK : String = "link";
        public static const PICTURE : String = "pic";




        public static function createDataModel(type : String, parent : IContentDataModel) : IContentDataModel
        {
            var model : IContentDataModel;

            switch(type) {
                case TEXT : model = new TextDataModel(parent); break;
                case GALLERY : model = new GalleryModel(parent); break;
                case GROUP : model = new DataGroupModel(parent); break;
                case LINK : model = new ExternalLink(parent); break;
                case PICTURE : model = new PictureDataModel(parent); break;
                default : throw new UnsupportedData(type);
            }

            return model;
        }
    }
}