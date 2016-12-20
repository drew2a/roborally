package ui
{

    import flash.display.MovieClip;
    import flash.events.Event;

    /**
     * @author Drew
     */
    public class StageObject extends MovieClip
    {
        public function StageObject()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        protected function init(): void
        {


        }

        private function onAddedToStage(event: Event): void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            init();
        }
    }
}
