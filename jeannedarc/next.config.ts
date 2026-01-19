import type { NextConfig } from "next";

const nextConfig: NextConfig = {
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
};

export default nextConfig;
