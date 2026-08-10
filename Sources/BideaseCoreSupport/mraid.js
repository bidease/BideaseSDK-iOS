// GENERATED FILE — DO NOT EDIT.
function sendMessageToLogHandler(message) {
    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.log) {
        window.webkit.messageHandlers.log.postMessage(message);
    }
}

// NOTE: we deliberately do NOT override the creative's console.log. Wrapping it puts our code
// into the creative's call path (a throwing wrapper once black-screened Voodoo playables);
// creative logs are inspectable via Safari Web Inspector instead.

var __mraidBridge = {
    send: function(command, args) {
        var parts = [];
        for (var i = 0; i < args.length; i++) {
            parts.push(encodeURIComponent(args[i]));
        }
        document.location.href = "mraid:" + command + "/" + parts.join("/");
    },
    query: function(key) {
        return window.mraid[key];
    },
    log: function(message) {
        sendMessageToLogHandler(message);
    }
};

(function() {
    var mraid = window.mraid = {};
    var debug = function(messageBuilder) {};

    mraid.eventListeners = {};
    mraid.state = "loading";
    mraid.viewable = false;
    mraid.resizePropertiesInitialized = false;
    mraid.volumePercentage = null;

    mraid.orientationProperties = {
        allowOrientationChange: true,
        forceOrientation: "none"
    };

    mraid.expandProperties = {
        width: 0,
        height: 0,
        useCustomClose: false
    };

    mraid.lastExposure = {
        /* default 0: an ad not yet shown (e.g. preloaded in background) must report not-exposed so video does not autoplay */
        exposedPercentage: 0.0,
        visibleRectangle: {
            x: 0.0,
            y: 0.0,
            width: 0.0,
            height: 0.0
        },
        occlusionRectangles: null
    };

    /* customClosePosition is deprecated in MRAID 3.0; the host always renders the close indicator top-right */
    mraid.resizeProperties = {
        width: 0,
        height: 0,
        customClosePosition: "top-right",
        offsetX: 0,
        offsetY: 0,
        allowOffscreen: true
    };

    mraid.placementType = "inline";
    mraid.currentPosition = { x: 0, y: 0, width: 0, height: 0 };
    mraid.maxSize = { width: 0, height: 0 };
    mraid.defaultPosition = { x: 0, y: 0, width: 0, height: 0 };
    mraid.screenSize = { width: 0, height: 0 };
    mraid.currentAppOrientation = { orientation: "portrait", locked: false };

    mraid.allSupports = {
        sms: true,
        tel: true,
        calendar: false,
        storePicture: false,
        inlineVideo: true,
        location: false
    };

    // ---- event coalescing during expand/resize/close transitions (MRAID 3.0 §4: perform all
    // changes, then fire chained events so the ad only needs to watch a single event) ----
    var eventsQueue = [];
    var addEventToQueue = function(eventInfo) {
        // keep only the newest event of each type, except errors
        if (eventInfo["event"] !== "error") {
            var eventIndex = eventsQueue.findIndex(item => item["event"] === eventInfo["event"]);
            if (eventIndex != -1) {
                eventsQueue.splice(eventIndex, 1);
            }
        }
        eventsQueue.push(eventInfo);
    };

    var transitionLevel = 0;
    var isTransitionToExpand = false;
    var finishTransition = function() {
        isTransitionToExpand = false;
        while ((eventsQueue.length > 0) && (transitionLevel == 1)) {
            var eventInfo = eventsQueue.shift();
            mraid.fireEvent(eventInfo['event'], eventInfo['args']);
        }
        transitionLevel--;
    };

    // ---- native call queue: one outstanding native call at a time ----
    var nativeCallQueue = [];
    var nativeCallInProcess = false;

    var callContainer = function(command) {
        var args = Array.prototype.slice.call(arguments);
        args.shift();
        if (nativeCallInProcess) {
            nativeCallQueue.push({ command: command, args: args });
        } else {
            nativeCallInProcess = true;
            __mraidBridge.send(command, args);
        }
    };

    mraid.nativeCallComplete = function() {
        if (nativeCallQueue.length === 0) {
            nativeCallInProcess = false;
        } else {
            var next = nativeCallQueue.shift();
            __mraidBridge.send(next.command, next.args);
        }
    };

    mraid.open = function(url) {
        callContainer('open', url);
    };

    mraid.resize = function() {
        if (mraid.resizePropertiesInitialized) {
            transitionLevel++;
            callContainer('resize');
        } else {
            mraid.onError("Resize properties are not yet initialized. Set resize properties using mraid.setResizeProperties(properties) method.", "resize");
        }
    };

    mraid.expand = function(url) {
        if (url) {
            transitionLevel++;
            callContainer('expand', url);
        } else {
            if (!isTransitionToExpand && mraid.getState() !== "expanded") {
                transitionLevel++;
                isTransitionToExpand = true;
            }
            callContainer('expand');
        }
    };

    mraid.close = function() {
        transitionLevel++;
        callContainer('close');
    };

    mraid.getPlacementType = function() {
        return __mraidBridge.query('placementType');
    };

    mraid.getState = function() {
        return mraid.state;
    };

    mraid.getVersion = function() {
        return '3.0';
    };

    mraid.isViewable = function() {
        return mraid.viewable;
    };

    mraid.getScreenSize = function() {
        return __mraidBridge.query('screenSize');
    };

    mraid.getDefaultPosition = function() {
        return __mraidBridge.query('defaultPosition');
    };

    mraid.getCurrentPosition = function() {
        return __mraidBridge.query('currentPosition');
    };

    mraid.getMaxSize = function() {
        return __mraidBridge.query('maxSize');
    };

    mraid.setMaxSize = function(width, height) {
        mraid.maxSize.width = width;
        mraid.maxSize.height = height;
    };

    mraid.setScreenSize = function(width, height) {
        mraid.screenSize.width = width;
        mraid.screenSize.height = height;
    };

    mraid.setCurrentPosition = function(x, y, width, height) {
        mraid.currentPosition.x = x;
        mraid.currentPosition.y = y;
        mraid.currentPosition.width = width;
        mraid.currentPosition.height = height;
    };

    mraid.setDefaultPosition = function(x, y, width, height) {
        mraid.defaultPosition.x = x;
        mraid.defaultPosition.y = y;
        mraid.defaultPosition.width = width;
        mraid.defaultPosition.height = height;
    };

    mraid.setCurrentAppOrientation = function(orientation, locked) {
        mraid.currentAppOrientation.orientation = orientation;
        mraid.currentAppOrientation.locked = locked;
    };

    mraid.getCurrentAppOrientation = function() {
        return __mraidBridge.query('currentAppOrientation');
    };

    mraid.supports = function(feature) {
        return mraid.allSupports[feature];
    };

    mraid.playVideo = function(url) {
        callContainer('playVideo', url);
    };

    mraid.addEventListener = function(event, listener) {
        var handlers = mraid.eventListeners[event];
        if (handlers == null) {
            handlers = mraid.eventListeners[event] = [];
        }
        for (var handler = 0; handler < handlers.length; handler++) {
            if (listener == handlers[handler]) {
                return;
            }
        }
        handlers.push(listener);

        if (event === "exposureChange") {
            /* MRAID 3.0 §7.5: on registration the host sends the initial exposure state asynchronously. */
            setTimeout(mraid.fireEvent, 0, "exposureChange");
        }
        if (event === "audioVolumeChange") {
            /* MRAID 3.0 §7.6: on registration the host sends the initial audio volume asynchronously. */
            setTimeout(mraid.fireEvent, 0, "audioVolumeChange", mraid.volumePercentage);
        }
    };

    mraid.removeEventListener = function(event, listener) {
        var handlers = mraid.eventListeners[event];
        if (handlers != null) {
            for (var handler = 0; handler < handlers.length; handler++) {
                if (handlers[handler] == listener) {
                    handlers.splice(handler, 1);
                    break;
                }
            }
        }
    };

    mraid.setOrientationProperties = function(properties) {
        if (!properties) {
            return;
        }
        var aoc = properties.allowOrientationChange;
        if (aoc === true || aoc === false) {
            mraid.orientationProperties.allowOrientationChange = aoc;
        }
        var fo = properties.forceOrientation;
        if (fo == 'landscape' || fo == 'portrait' || fo == 'none') {
            mraid.orientationProperties.forceOrientation = fo;
        }
        callContainer('onOrientationPropertiesChanged', JSON.stringify(mraid.getOrientationProperties()));
    };

    mraid.getOrientationProperties = function() {
        return mraid.orientationProperties;
    };

    mraid.getResizeProperties = function() {
        return mraid.resizeProperties;
    };

    mraid.getExpandProperties = function() {
        mraid.expandProperties.isModal = true;
        return mraid.expandProperties;
    };

    mraid.setResizeProperties = function(properties) {
        mraid.resizePropertiesInitialized = false;

        if (!properties) {
            mraid.onError("properties is null", "setResizeProperties");
            return;
        }

        //Allow Offscreen
        if (typeof(properties.allowOffscreen) !== "boolean") {
            mraid.onError("allowOffscreen param of [" + properties.allowOffscreen + "] is unusable.", "setResizeProperties");
            return;
        }

        var allowOffscreen = properties.allowOffscreen;

        //Get max size
        var maxSize = mraid.getMaxSize();
        if (!maxSize || !maxSize.width || !maxSize.height) {
            mraid.onError("Unable to use maxSize of [" + JSON.stringify(maxSize) + "]", "setResizeProperties");
            return;
        }

        //Width
        if (properties.width == null || typeof properties.width === 'undefined' || isNaN(properties.width)) {
            mraid.onError("width param of [" + properties.width + "] is unusable.", "setResizeProperties");
            return;
        }
        if (properties.width < 50 || (properties.width > maxSize.width && !allowOffscreen)) {
            mraid.onError("width param of [" + properties.width + "] outside of acceptable range of 50 to " + maxSize.width, "setResizeProperties");
            return;
        }

        //Height
        if (properties.height == null || typeof properties.height === 'undefined' || isNaN(properties.height)) {
            mraid.onError("height param of [" + properties.height + "] is unusable.", "setResizeProperties");
            return;
        }
        if (properties.height < 50 || (properties.height > maxSize.height && !allowOffscreen)) {
            mraid.onError("height param of [" + properties.height + "] outside of acceptable range of 50 to " + maxSize.height, "setResizeProperties");
            return;
        }

        //Offset
        if (properties.offsetX == null || typeof properties.offsetX === 'undefined' || isNaN(properties.offsetX)) {
            mraid.onError("offsetX param of [" + properties.offsetX + "] is unusable.", "setResizeProperties");
            return;
        }
        if (properties.offsetY == null || typeof properties.offsetY === 'undefined' || isNaN(properties.offsetY)) {
            mraid.onError("offsetY param of [" + properties.offsetY + "] is unusable.", "setResizeProperties");
            return;
        }

        mraid.resizeProperties.width = properties.width;
        mraid.resizeProperties.height = properties.height;
        mraid.resizeProperties.customClosePosition = properties.customClosePosition;
        mraid.resizeProperties.offsetX = properties.offsetX;
        mraid.resizeProperties.offsetY = properties.offsetY;
        mraid.resizeProperties.allowOffscreen = properties.allowOffscreen;

        mraid.resizePropertiesInitialized = true;
    };

    mraid.setExpandProperties = function(properties) {
        if (properties && properties.width != null && typeof properties.width !== 'undefined' && !isNaN(properties.width)) {
            mraid.expandProperties.width = properties.width;
        }
        if (properties && properties.height != null && typeof properties.height !== 'undefined' && !isNaN(properties.height)) {
            mraid.expandProperties.height = properties.height;
        }
    };

    mraid.getLocation = function() {
        // geo is unsupported: MRAID 3.0 communicates the "-1" sentinel for location not available.
        mraid.onError("-1", "getLocation");
        return "-1";
    };

    /* useCustomClose is deprecated in MRAID 3.0 and unsupported: the SDK always renders its own close button. No-op. */
    mraid.useCustomClose = function(useCustomClose) {
    };

    mraid.fireEvent = function(event, args) {
        var handlers = mraid.eventListeners[event];
        if (handlers == null) {
            return;
        }
        for (var handler = 0; handler < handlers.length; handler++) {
            if (event == 'ready') {
                handlers[handler]();
            } else if (event == 'error') {
                handlers[handler](args[0], args[1]);
            } else if (event == 'stateChange') {
                handlers[handler](args);
            } else if (event == 'viewableChange') {
                handlers[handler](args);
            } else if (event == 'sizeChange') {
                handlers[handler](args[0], args[1]);
            } else if (event == 'exposureChange') {
                handlers[handler](mraid.lastExposure.exposedPercentage, mraid.lastExposure.visibleRectangle, mraid.lastExposure.occlusionRectangles);
            } else if (event == 'audioVolumeChange') {
                handlers[handler](args);
            }
        }
    };

    mraid.createCalendarEvent = function(parameters) {
        callContainer('createCalendarEvent', JSON.stringify(parameters));
    };

    mraid.storePicture = function(url) {
        callContainer('storePicture', url);
    };

    mraid.unload = function() {
        callContainer('unload');
    };

    mraid.onError = function(message, action) {
        if (transitionLevel > 0) {
            addEventToQueue({ "event": "error", "args": [message, action] });
            if (action === "expand" || action === "resize" || action == "close") {
                finishTransition();
            }
        } else {
            mraid.fireEvent("error", [message, action]);
        }
    };

    mraid.onReady = function() {
        mraid.onStateChange("default");
        mraid.fireEvent("ready");
    };

    mraid.onReadyExpanded = function() {
        mraid.onStateChange("expanded");
        mraid.fireEvent("ready");
    };

    mraid.onSizeChange = function(width, height) {
        if (transitionLevel > 0) {
            addEventToQueue({ "event": "sizeChange", "args": [width, height] });
        } else {
            mraid.fireEvent("sizeChange", [width, height]);
        }
    };

    mraid.onStateChange = function(state) {
        mraid.state = state;
        if (transitionLevel > 0) {
            addEventToQueue({ "event": "stateChange", "args": mraid.getState() });
            finishTransition();
        } else {
            mraid.fireEvent("stateChange", mraid.getState());
        }
    };

    /* DEPRECATED as of MRAID 3.0 — use exposureChange */
    mraid.onViewableChange = function(isViewable) {
        mraid.viewable = isViewable;
        if (transitionLevel > 0) {
            addEventToQueue({ "event": "viewableChange", "args": mraid.isViewable() });
        } else {
            mraid.fireEvent("viewableChange", mraid.isViewable());
        }
    };

    mraid.onExposureChange = function(viewExposureString) {
        var viewExposure = JSON.parse(viewExposureString);
        mraid.lastExposure = viewExposure;
        if (transitionLevel > 0) {
            addEventToQueue({ "event": "exposureChange" });
        } else {
            mraid.fireEvent("exposureChange");
        }
    };

    mraid.onAudioVolumeChange = function(newVolumePercentage) {
        mraid.volumePercentage = newVolumePercentage;
        if (transitionLevel > 0) {
            addEventToQueue({ "event": "audioVolumeChange", "args": newVolumePercentage });
        } else {
            mraid.fireEvent("audioVolumeChange", newVolumePercentage);
        }
    };
}());
