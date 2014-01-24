package ru.kashaya.exception {
    import ru.kashaya.model.IContentDataModel;

    public class UnsupportedData extends Error {
        public function UnsupportedData(type : String, container : * = null) {

            var mess : String = "Unsupported data type: " + type;
            if(container) mess += " in " + container;
            super(mess);

        }
    }
}