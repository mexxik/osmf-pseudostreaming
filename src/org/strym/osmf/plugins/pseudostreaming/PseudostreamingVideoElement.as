package org.strym.osmf.plugins.pseudostreaming {
import org.osmf.elements.VideoElement;
import org.osmf.media.MediaResourceBase;
import org.osmf.net.NetLoader;
import org.osmf.traits.MediaTraitBase;
import org.osmf.traits.MediaTraitType;
import org.osmf.traits.TimeTrait;
import org.strym.osmf.plugins.pseudostreaming.traits.PseudostreamingSeekTrait;
import org.strym.osmf.plugins.pseudostreaming.traits.PseudostreamingTimeTrait;

public class PseudostreamingVideoElement extends VideoElement {
    public function PseudostreamingVideoElement(resource:MediaResourceBase = null, loader:NetLoader = null) {
        super(resource, loader);

        smoothing = false;
    }

    override protected function addTrait(type:String, instance:MediaTraitBase):void {
        var trait:MediaTraitBase = instance;

        if (type == MediaTraitType.TIME) {
            trait = new PseudostreamingTimeTrait((loader as PseudostreamingNetLoader).netStream, resource);
        }
        else if (type == MediaTraitType.SEEK) {
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
