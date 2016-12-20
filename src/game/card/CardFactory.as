package game.card
{

    import game.card.type.BackCard;
    import game.card.type.ForwardCard;
    import game.card.type.LeftCard;
    import game.card.type.RightCard;
    import game.card.type.UTurnCard;

    /**
     * @author Drew
     */
    public class CardFactory
    {
        private static var _cells: Object = {};
        {
            _cells[ForwardCard.NAME] = ForwardCard;
            _cells[BackCard.NAME] = BackCard;
            _cells[LeftCard.NAME] = LeftCard;
            _cells[RightCard.NAME] = RightCard;
            _cells[UTurnCard.NAME] = UTurnCard;
        }

        public static function create(name: String): Card
        {
            return new _cells[name](name);
        }
    }
}
