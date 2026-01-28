import type { NextConfig } from "next";

const nextConfig: NextConfig = {
	// Supprime les trailing slash
	trailingSlash: false,

	images: {
		unoptimized: true,	
		remotePatterns: [
			{
				protocol: "https",
				hostname: "www.jeannedarc33.fr",
				pathname: "/**",
			},
			{
				protocol: "http",
				hostname: "www.image-heberg.fr",
				pathname: "/**",
			}
		],
	},

	// Redirections
	async redirects() {
		return [
			// Netlify domain → custom domain
			{
				source: '/:path*',
				has: [
					{
						type: 'host',
						value: 'jeannedarc33.netlify.app',
					},
				],
				destination: 'https://refonte.jeannedarc33.fr/:path*',
				permanent: true, // 301 redirect
			},
		]
	},
};

export default nextConfig;