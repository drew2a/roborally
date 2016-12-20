package tool
{

    import flash.text.TextField;
    import flash.text.TextFormat;

    /**
     * @author Drew
     */
    public class TextUtil
    {
        public static function createText(text: String, color: uint = 0x000000, size: int = 18, bold: Boolean = false, wordWrap: Boolean = false): TextField
        {
            var textFormat: TextFormat = new TextFormat();
            textFormat.size = size;
            textFormat.bold = bold;

            var textField: TextField = new TextField();
            textField.defaultTextFormat = textFormat;

            textField.text = text;
            textField.wordWrap = wordWrap;
            textField.textColor = color;

            return textField;
        }
    }
}
