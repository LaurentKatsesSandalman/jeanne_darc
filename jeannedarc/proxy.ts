import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server'
import { NextResponse } from 'next/server'

// Définit les routes protégées (si besoin futur)
const isProtectedRoute = createRouteMatcher([
  '/gestion-pages',
])

export default clerkMiddleware(async (auth, req) => {
 const { userId } = await auth()
  
  if (!userId && isProtectedRoute(req)) {
  return NextResponse.redirect(new URL('/', req.url))
  }

})

export const config = {
  matcher: [
    // Skip Next.js internals and all static files, unless found in search params
    '/((?!_next|[^?]*\\.(?:html?|css|js(?!on)|jpe?g|webp|png|gif|svg|ttf|woff2?|ico|csv|docx?|xlsx?|zip|webmanifest)).*)',
    // Always run for API routes
    '/(api|trpc)(.*)',
  ],
}