import { json, type RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ locals }) => {
	return json(Array.from(locals.wss.nodes.values()).map((i) => i.serializable));
};
