package action
{

    import game.card.Card;

    import map.GameMap;

    /**
     * @author Drew
     */
    public class Action
    {
        private var _card: Card;

        public function Action(card: Card)
        {
            _card = card;
        }

        public function start(gameMap: GameMap): void
        {

        }

        public function get card(): Card
        {
            return _card;
        }

    }
}
