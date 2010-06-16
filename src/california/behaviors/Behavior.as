package california.behaviors {
    import org.flixel.FlxG;
    
    public class Behavior {
        // Find the appropriate Behavior subclass and instantiate it
        // properly.
        public var conditional:Boolean = false;
        public var flagName:String;
        public var flagValue:Boolean;
        
        public static function getBehaviorFromXML(behaviorNode:XML):Behavior {
            var behavior:Behavior = null;
            
            switch (behaviorNode.@type.toString()) {
                case "dialog":
                behavior = new DialogBehavior(behaviorNode.toString());
                break;
                
                case "transitionToRoom":
                behavior = new TransitionToRoomBehavior(behaviorNode.@targetRoom.toString());
                break;
                
                case "replaceSprite":
                behavior = new ReplaceSpriteBehavior(behaviorNode.@oldSprite, behaviorNode.@newSprite, behaviorNode.@x, behaviorNode.@y);
                break;
                
                case "removeSprite":
                behavior = new RemoveSpriteBehavior(behaviorNode.@targetSprite);
                break;
                
                case "addSprite":
                behavior = new AddSpriteBehavior(behaviorNode.@spriteName, behaviorNode.@x, behaviorNode.@y, behaviorNode.@width, behaviorNode.@height);
                break;
                
                case "addVerb":
                behavior = new AddVerbBehavior(behaviorNode.@newVerb);
                break;

                case "flash":
                behavior = new FlashBehavior();
                break;
                
                case "soundEffect":
                behavior = new SoundEffectBehavior(behaviorNode.@soundName);
                break;
                
                case "removeVerb":
                behavior = new RemoveVerbBehavior(behaviorNode.@targetVerb);
                break;
                
                case "replaceVerb":
                behavior = new ReplaceVerbBehavior(behaviorNode.@oldVerb, behaviorNode.@newVerb);
                break;

                case "catchFireflies":
                behavior = new CatchFirefliesBehavior();
                break;

                case "setFlag":
                behavior = new SetFlagBehavior(behaviorNode.@flagName, behaviorNode.@value);
                break;
            }

            //FlxG.log('parent node name ' + behaviorNode.parent().name());
            if(behaviorNode.parent().name() == 'conditionalBehaviors') {
                behavior.conditional = true;
                behavior.flagName = behaviorNode.parent().@flagName;
                behavior.flagValue = behaviorNode.parent().@value == "1" ? true : false;
            }

            
            return behavior;
        }

        public function run():void {
            // all subclasses should override this
        }
    }
}