package game.card.type
{

    import action.type.ForwardAction;

    import flash.text.TextField;

    import game.card.Card;

    import tool.TextUtil;

    /**
     * @author Drew
     */
    public class ForwardCard extends Card
    {
        public static const NAME: String = "forward";
        private var _steps: int = 1;

        public function ForwardCard(name: String)
        {
            super(name, new ForwardAction(this));
        }

        override protected function init(): void
        {
            super.init();

            addChild(new EmbedClasses.cell);
            addChild(new EmbedClasses.arrow);

            var textField: TextField = TextUtil.createText(_steps.toString(), 0xff3300, 30, true);
            textField.x = 0;
            textField.y = -5;
            addChild(textField);
        }


        public function get steps(): int
        {
            return _steps;
        }

        public function set steps(value: int): void
        {
            _steps = value;
        }
    }
}
