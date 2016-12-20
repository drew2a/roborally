package tool
{

    import flash.display.DisplayObject;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    /**
     * @author Drew
     */
    public class DisplayUtil
    {
        public static function addStroke(displayObject: DisplayObject, blur: Number = 5, color: uint = 0xFF006633, quality: int = BitmapFilterQuality.HIGH,
            strength: Number = 100): void
        {
            if (displayObject == null) {
                return;
            }

            var glow: GlowFilter = new GlowFilter();
            glow.blurX = glow.blurY = blur;
            glow.color = color;
            glow.quality = quality;
            glow.strength = strength;

            var array: Array = [];
            array.push(glow);
            displayObject.filters = array;
        }

        public static function removeStroke(displayObject: DisplayObject): void
        {
            if (displayObject == null) {
                return;
            }

            displayObject.filters = [];
        }

        public static  function rotateAroundCenter(object: DisplayObject, angleDegrees: Number): void
        {
            if (object.rotation == angleDegrees) {
                return;
            }

            var matrix: Matrix = object.transform.matrix;
            var rect: Rectangle = object.getBounds(object.parent);

            matrix.translate(-(rect.left + (rect.width / 2)), -(rect.top + (rect.height / 2)));
            matrix.rotate((angleDegrees / 180) * Math.PI);
            matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
            object.transform.matrix = matrix;

            object.rotation = Math.round(object.rotation);
        }
    }
}
