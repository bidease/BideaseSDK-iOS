(() => {
    let bidease = window.bidease = {};
    bidease.subscribers = new Set();

    bidease.sendCommand = (action, payload) => {
        const message = {
            action: action,
            payload: payload
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
