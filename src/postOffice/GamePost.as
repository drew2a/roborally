package postOffice
{

    import flash.events.Event;
    import flash.events.EventDispatcher;

    /**
     * @author Drew
     */
    public class GamePost extends EventDispatcher
    {
        private var _trace: Boolean = false;

        override public function dispatchEvent(event: Event): Boolean
        {
            if (_trace) {
                trace(event);
            }

            return super.dispatchEvent(event);
        }
    }
}
