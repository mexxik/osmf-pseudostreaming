package org.strym.osmf.plugins.pseudostreaming {
import org.osmf.elements.LightweightVideoElement;
import org.osmf.media.MediaResourceBase;
import org.osmf.net.NetLoader;
import org.osmf.traits.MediaTraitBase;
import org.osmf.traits.MediaTraitType;
import org.osmf.traits.TimeTrait;

public class PseudostreamingVideoElement extends LightweightVideoElement {
    public function PseudostreamingVideoElement(resource:MediaResourceBase = null, loader:NetLoader = null) {
        super(resource, loader);

        smoothing = false;
    }

    override protected function addTrait(type:String, instance:MediaTraitBase):void {
        var trait:MediaTraitBase = instance;

        if (type == MediaTraitType.SEEK) {
            var timeTrait:TimeTrait = null;

            if (hasTrait(MediaTraitType.TIME)) {
                timeTrait = getTrait(MediaTraitType.TIME) as TimeTrait;
            }

            if (timeTrait) {
                trait = new PseudostreamingSeekTrait(timeTrait, loader, resource);
            }
        }

        super.addTrait(type, trait);
    }
}
}
