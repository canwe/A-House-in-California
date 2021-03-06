package california.sprites {
    import org.flixel.*;
    import california.Main;
    
    public class Player extends GameSprite {
        private var moveSpeed:uint;
        private var walkTarget:Number;
        private var minTargetDistance:uint;
        private var walkTargetCallback:Function;
        
        public function Player(name:String, X:Number, Y:Number):void {
            super(name,X,Y,false);

            var PlayerImage:Class = Main.library.getAsset(name);

            this.loadGraphic(PlayerImage, true, true, 12, 12);

            addAnimation("walk", [0,1,2,3], 12);
            addAnimation("stopped", [9]);
            
            moveSpeed = 64;
            minTargetDistance = 2; // At this point the character will stop accelerating towards its target.
            drag.x = 700;

            width = 3;
            offset.x = 6;
            
            walkTarget = -1;
        }

        override public function update():void {
            if(walkTarget >= 0) {
                if(Math.abs(walkTarget - x) > minTargetDistance) {
                    if(walkTarget < x) {
                        play("walk");
                        
                        facing = LEFT;
                        x -= moveSpeed * FlxG.elapsed;
                    } else {
                        play("walk");
                        
                        facing = RIGHT;
                        x += moveSpeed * FlxG.elapsed;
                    }
                } else {
                    // Clear the walk target, run the callback, and clear the callback
                    walkTarget = -1;
                    
                    if(walkTargetCallback != null) {
                        walkTargetCallback();
                        walkTargetCallback = null;
                    }
                    
                    play("stopped");
                }
            }
            
            super.update();
        }

        public function setWalkTarget(X:Number, callback:Function = null):void {
            walkTarget = X;
            walkTargetCallback = callback;
        }
    }
}