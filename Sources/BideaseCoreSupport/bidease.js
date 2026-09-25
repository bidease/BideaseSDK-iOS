(() => {
    let bidease = window.bidease = {};
    bidease.subscribers = new Set();

    // The bridge carries strings. Objects go through JSON so the value survives into CREATIVE_LOGGED
    // as its content, capped because those bytes are creative-controlled — native repeats the cap as
    // MAX_JS_TEMPLATE_HALF (String.kt), since a creative can post the body and skip this helper.
    // The throw JSON.stringify raises on a cycle or a BigInt is contained, not passed to the creative.
    // BEGIN shared payload helper — kept identical on both platforms by the lint job.
    const MAX_PAYLOAD = 8192;
    // Never cut inside a surrogate pair — mirrors asJsTemplateHalf in the SDK's String.kt.
    const capped = (s) => {
        if (s.length <= MAX_PAYLOAD) return s;
        const code = s.charCodeAt(MAX_PAYLOAD - 1);
        return s.slice(0, code >= 0xD800 && code <= 0xDBFF ? MAX_PAYLOAD - 1 : MAX_PAYLOAD);
    };
    const asBridgeString = (value) => {
        if (typeof value === 'string') return capped(value);
        if (value === null || value === undefined) return '';
        try {
            const s = typeof value === 'object' ? JSON.stringify(value) : String(value);
            return s === undefined ? '' : capped(s);
        } catch (e) {
            return '';
        }
    };
    // END shared payload helper

    bidease.sendCommand = (action, payload) => {
        // The body crosses an UNTYPED boundary and native reads these two as strings. A number or
        // object payload survives into a String field and segfaulted there — so it is normalized
        // here; the action is passed through for `handleBideaseMessage` to reject and report.
        const message = {
            action: action,
            payload: asBridgeString(payload)
        };
        
        window.webkit.messageHandlers.bidease.postMessage(message);
    };

    bidease.receiveCommand = (action, payload) => {
        bidease.subscribers.forEach(subscriber => subscriber(action, payload));
    };
    
    bidease.subscribe = (subscriber) => {
        bidease.subscribers.add(subscriber);
    };

    bidease.unsubscribe = (subscriber) => {
        bidease.subscribers.delete(subscriber);
    };
	
	bidease.close = () => {
		const message = {
			nativeAction: 'close',
		};
		
		window.webkit.messageHandlers.bidease.postMessage(message);
	};

	bidease.setNativeCloseVisible = (visible) => {
		const message = {
			nativeAction: 'setNativeCloseVisible',
			visible: `${visible}`,
		};
		
		window.webkit.messageHandlers.bidease.postMessage(message);
	};
	
	bidease.switchScene = (scene) => {
		const message = {
			nativeAction: 'switchScene',
			scene: `${scene}`,
		};
		
		window.webkit.messageHandlers.bidease.postMessage(message);
	};
})();
