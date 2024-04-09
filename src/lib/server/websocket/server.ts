import type { Node } from '$lib/server/client/node';
import type { ClientType } from '$lib/types';
import type { IncomingMessage } from 'http';
import type { Duplex } from 'stream';
import { parse } from 'url';
import { Server, WebSocket as WebSocketBase, WebSocketServer } from 'ws';

export const GlobalThisWSS = Symbol.for('sveltekit.wss');

export declare class ExtendedWebSocket extends WebSocketBase {
	socketId: string;
	type: ClientType;
	item: Node;
}

// You can define server-wide functions or class instances here
// export interface ExtendedServer extends Server<ExtendedWebSocket> {};

export interface ExtendedWebSocketServer extends Server<typeof ExtendedWebSocket> {
	nodes: Map<number, Node>;
}

export type ExtendedGlobal = typeof globalThis & {
	[GlobalThisWSS]: ExtendedWebSocketServer;
};

export const onHttpServerUpgrade = (req: IncomingMessage, sock: Duplex, head: Buffer) => {
	const pathname = req.url ? parse(req.url).pathname : null;
	if (pathname !== '/websocket') return;

	const wss = (globalThis as ExtendedGlobal)[GlobalThisWSS];

	wss.handleUpgrade(req, sock, head, (ws) => {
		console.log('[handleUpgrade] creating new connecttion');
		wss.emit('connection', ws, req);
	});
};

export const createWSSGlobalInstance = () => {
	const wss = new WebSocketServer({ noServer: true }) as ExtendedWebSocketServer;
	wss.nodes = new Map();

	(globalThis as ExtendedGlobal)[GlobalThisWSS] = wss;

	wss.on('connection', (ws) => {
		ws.socketId = Math.random().toString(36).substring(7);
		console.log(`[wss:global] client connected (${ws.socketId})`);

		let closed = false;

		setTimeout(() => {
			if (closed) return;
			if (!ws.type) {
				ws.close(1008, 'Connection timeout, check kit server running');
			}
		}, 1000);

		ws.on('close', () => {
			closed = true;
			console.log(`[wss:global] client disconnected (${ws.socketId})`);
		});
	});

	return wss;
};