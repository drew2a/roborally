package ui
{

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.EventDispatcher;

    import map.cell.type.PlayerCell;

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class HealthPanel extends StageObject
    {
        private static const DISTANCE_BETWEEN_LAMP: int = 35;
        private var _post: EventDispatcher;
        private var _healthContainer: Sprite;
        private var _health: int = PlayerCell.MAX_HEALTH;

        public function HealthPanel(post: EventDispatcher)
        {
            _post = post;
        }

        override protected function init(): void
        {
            super.init();
            _post.addEventListener(GameEvent.ON_POWER_UP, onPowerUp);
            _post.addEventListener(GameEvent.ON_DAMAGE, onDamage);
        }

        private function draw(): void
        {
            if (_healthContainer != null) {
                removeChild(_healthContainer);
            }

            _healthContainer = new Sprite();
            var i: int = 0;
            for (; i < _health; i++) {
                createLamp(new EmbedClasses.lifeGreen, i);
            }
            for (; i < PlayerCell.MAX_HEALTH; i++) {
                createLamp(new EmbedClasses.lifeRed, i);
            }

            addChild(_healthContainer);

        }

        private function createLamp(lamp: Bitmap, i: int): void
        {
            lamp.x = i * DISTANCE_BETWEEN_LAMP;
            _healthContainer.addChild(lamp);
        }

        private function onDamage(event: GameEvent): void
        {
            var playerCell: PlayerCell = event.object as PlayerCell;
            if (playerCell == null) {
                return;
            }

            _health = playerCell.health;
            draw();
        }

        private function onPowerUp(event: GameEvent): void
        {
            draw();
        }
    }
}
