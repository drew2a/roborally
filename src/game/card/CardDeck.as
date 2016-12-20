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
    public class CardDeck
    {
        private var _cards: Array = [];

        public function init(): void
        {
            _cards = [];
            createRange(UTurnCard.NAME, 1, 7);
            createRange(LeftCard.NAME, 8, 28);
            createRange(RightCard.NAME, 29, 49);
            createRange(BackCard.NAME, 50, 56);
            createForwardRange(57, 78, 1);
            createForwardRange(79, 93, 2);
            createForwardRange(94, 100, 3);
        }

        public function mix(): void
        {
            _cards.sort(function (a: *, b: *): Number
            {
                if (Math.random() < 0.5) {
                    return -1;
                }

                return 1;
            });
        }

        private function createRange(name: String, low: int, hi: int): void
        {
            for (var i: int = low; i <= hi; i++) {
                var card: Card = CardFactory.create(name);
                card.priority = i;
                _cards.push(card)
            }
        }

        private function createForwardRange(low: int, hi: int, steps: int): void
        {
            for (var i: int = low; i <= hi; i++) {
                var card: ForwardCard = CardFactory.create(ForwardCard.NAME) as ForwardCard;
                if (card == null) {
                    return;
                }

                card.priority = i;
                card.steps = steps;

                _cards.push(card)
            }
        }

        public function get cards(): Array
        {
            return _cards;
        }
    }
}
