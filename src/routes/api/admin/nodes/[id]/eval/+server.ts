import { json, text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ request, locals }) => {
	const code = await request.text();
	if (!locals.node) {
		return text('Node not found', { status: 404 });
	}

	const res = await locals.node.eval(code);
	return json(res);
};
