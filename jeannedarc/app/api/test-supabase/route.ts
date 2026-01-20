import { NextResponse } from 'next/server';
import { sql } from '@/lib/db';

export const dynamic = 'force-dynamic';

export async function GET() {
  try {
    console.log('Testing Supabase connection...');
    console.log('Host:', process.env.PG_HOST);
    console.log('Port:', process.env.PG_PORT);
    console.log('User:', process.env.PG_USER);
    console.log('DB:', process.env.PG_DB);
    
    const result = await sql`SELECT NOW() as current_time, version() as pg_version`;
    
    return NextResponse.json({ 
      success: true,
      message: 'Connection successful!',
      data: result[0]
    });
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  } catch (error: any) {
    console.error('Connection error:', error);
    return NextResponse.json({ 
      success: false,
      error: error.message,
      code: error.code,
      stack: error.stack
    }, { status: 500 });
  }
}