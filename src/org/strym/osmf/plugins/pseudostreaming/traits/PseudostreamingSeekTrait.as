package org.strym.osmf.plugins.pseudostreaming.traits {
import org.strym.osmf.plugins.pseudostreaming.*;
import org.osmf.media.MediaResourceBase;
import org.osmf.media.URLResource;
import org.osmf.traits.LoaderBase;
import org.osmf.traits.SeekTrait;
import org.osmf.traits.TimeTrait;

public class PseudostreamingSeekTrait extends SeekTrait {
    protected var loader:PseudostreamingNetLoader;
    protected var resource:URLResource;
    
    public function PseudostreamingSeekTrait(timeTrait:TimeTrait, loader:LoaderBase, resource:MediaResourceBase) {
        super(timeTrait);

        this.loader = loader as PseudostreamingNetLoader;
        this.resource = resource as URLResource;
    }

    override public function canSeekTo(time:Number):Boolean {
        return true;
    }

    override protected function seekingChangeStart(newSeeking:Boolean, time:Number):void {
        if (newSeeking) {
            if (time > (timeTrait.duration * Number(loader.netStream.bytesLoaded / loader.netStream.bytesTotal)) || time <  pseudostreamingTimeTrait.currentTime) {
                var query:String = resource.getMetadataValue("pseudostreaming_query") as String;
                if (query && query != "") {
                    var url:String = resource.url + query.replace("{time}", time.toString());

                    loader.netStream.play(url);
                }

                pseudostreamingTimeTrait.positionOffset = time;
            }
            else
                loader.netStream.seek(time - pseudostreamingTimeTrait.positionOffset);

        }
    }
    
    override protected function seekingChangeEnd(time:Number):void {
        super.seekingChangeEnd(time);

        if (seeking)
            setSeeking(false, time);
    }

    protected function get pseudostreamingTimeTrait():PseudostreamingTimeTrait {
        return timeTrait as PseudostreamingTimeTrait;
    }
}
}
