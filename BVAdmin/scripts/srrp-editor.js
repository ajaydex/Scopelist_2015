/* Copyright (c) by Structured Solutions. All rights reserved. */
function setHelp(control, header, body) {
    if ((typeof(showtips) == "undefined" || showtips) && typeof(tip) != "undefined") {
        tip.setHeader(header);
        tip.setBody(body);
        tip.sizeUnderlay();
        tip.cfg.setProperty("visible", true);
        var y = tip.cfg.getProperty("y");
        var scrolly = document.documentElement.scrollTop || document.body.scrollTop;
        var viewPortHeight = YAHOO.util.Dom.getClientHeight();
        if (y < scrolly || y > (scrolly + viewPortHeight - 25)) {
            var pos = [ tip.cfg.getProperty("x"), scrolly + 25 ];
            var anim = new YAHOO.util.Motion(tip.element, { points: { to: pos } } , 0.5, YAHOO.util.Easing.easeOutStrong);
            anim.onComplete.subscribe(function() { tip.syncPosition(); tip.cfg.refireEvent("iframe"); });
            anim.animate();
        }
        return true;
    } else {
        return false;
    }
}
function showHelp() {
    showtips = true;
}
function hideHelp() {
    showtips = false;
}        
function init() {
    if (typeof(initialized) == "undefined" || !initialized) {
        tip = new YAHOO.widget.Panel("tip1", 
            { 
                context:["subhead", "tr", "tr"],
                draggable:true,
                effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25},
                visible:false
            }
        );
        
        if (tip.render()) {
            var x = tip.cfg.getProperty("x");
            var y = tip.cfg.getProperty("y");
            tip.cfg.setProperty("x", x-5);
            tip.cfg.setProperty("y", y+40);
            tip.hideEvent.subscribe(hideHelp);
        }

        results = new YAHOO.widget.Panel("testresults", 
            {
                context:["subhead", "tr", "tr"],
                draggable:true,
                effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25},
                visible:false
            }
        );
        
        if (results.render()) {
            var x = results.cfg.getProperty("x");
            var y = results.cfg.getProperty("y");
            results.cfg.setProperty("x", x-15);
            results.cfg.setProperty("y", y+100);
        }

        importcostdialog = new YAHOO.widget.Panel("importcost", 
            { 
                draggable:true,
                fixedcenter:true,
                modal:true,
                visible:false
            } 
        );
        
        if (importcostdialog.render()) {
            importcostdialog.hideEvent.subscribe(hideImportCostDialogValidation);
        }

        importpackagingdialog = new YAHOO.widget.Panel("importpackaging", 
            { 
                draggable:true,
                fixedcenter:true,
                modal:true,
                visible:false
            } 
        );
        
        if (importpackagingdialog.render()) {
            importpackagingdialog.hideEvent.subscribe(hideImportPackagingDialogValidation);
        }
        
        showtips = false;
        initialized = true;
    }
}
function showImportCostDialog() {
    init();
    importcostdialog.sizeUnderlay();
    importcostdialog.show();
}
function showImportPackagingDialog() {
    init();
    importpackagingdialog.sizeUnderlay();
    importpackagingdialog.show();
}
YAHOO.util.Event.addListener(window, "load", init);