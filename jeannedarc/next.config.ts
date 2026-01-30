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

	async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'X-Frame-Options',
            value: 'SAMEORIGIN',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin',
          },
          {
            key: 'Permissions-Policy',
            value: 'camera=(), microphone=(), geolocation=()',
          },
        ],
      },
    ];
  },

	// Redirections
	// async redirects() {
	// 	return [
	// 		// Netlify domain → custom domain
	// 		{
	// 			source: '/:path*',
	// 			has: [
	// 				{
	// 					type: 'host',
	// 					value: 'jeannedarc33.netlify.app',
	// 				},
	// 			],
	// 			destination: 'https://refonte.jeannedarc33.fr/:path*',
	// 			permanent: true, // 301 redirect
	// 		},
	// 	]
	// },
};

export default nextConfig;