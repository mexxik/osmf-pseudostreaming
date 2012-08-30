package org.strym.osmf.plugins.pseudostreaming {
import org.osmf.media.MediaResourceBase;
import org.osmf.media.URLResource;
import org.osmf.traits.LoaderBase;
import org.osmf.traits.SeekTrait;
import org.osmf.traits.TimeTrait;

public class PseudostreamingSeekTrait extends SeekTrait {

    protected var _loader:PseudostreamingNetLoader;
    protected var _resource:URLResource;
    
    private var _offset:Number = 0;

    public function PseudostreamingSeekTrait(timeTrait:TimeTrait, loader:LoaderBase, resource:MediaResourceBase) {
        super(timeTrait);

        _loader = loader as PseudostreamingNetLoader;
        _resource = resource as URLResource;
    }

    override public function canSeekTo(time:Number):Boolean {
        return true;
    }

    override protected function seekingChangeStart(newSeeking:Boolean, time:Number):void {
        if (newSeeking) {
            if (time > (_loader.netStream.time + _loader.netStream.bufferLength + _offset) || time <  _loader.netStream.time) {
                _loader.netStream.play(_resource.url + "&ec_prebuf=5&ec_rate=350&" + "ec_seek=" + time);
            }
            else
                _loader.netStream.seek(time);

            _offset = time;
        }
    }
    
    override protected function seekingChangeEnd(time:Number):void {
        super.seekingChangeEnd(time);

        if (seeking)
            setSeeking(false, time);
    }
}
}
