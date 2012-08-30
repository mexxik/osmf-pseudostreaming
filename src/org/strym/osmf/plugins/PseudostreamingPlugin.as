package org.strym.osmf.plugins {
import flash.display.Sprite;

import org.osmf.media.PluginInfo;
import org.strym.osmf.plugins.pseudostreaming.PseudostreamingPluginInfo;

public class PseudostreamingPlugin extends Sprite {

    private var _pluginInfo:PseudostreamingPluginInfo;

    public function PseudostreamingPlugin() {
        _pluginInfo = new PseudostreamingPluginInfo();

        super();
    }

    public function get pluginInfo():PluginInfo {
        return _pluginInfo;
    }
}
}