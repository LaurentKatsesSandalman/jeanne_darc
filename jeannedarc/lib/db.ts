import postgres from "postgres";
import type { Sql } from "postgres";
import dotenv from "dotenv";

dotenv.config();

const PG_DB = process.env.PG_DB;
const PG_USER = process.env.PG_USER;
const PG_PASSWORD = process.env.PG_PASSWORD;
const PG_HOST = process.env.PG_HOST;
const PG_PORT = process.env.PG_PORT;

if (!PG_DB || !PG_USER || !PG_PASSWORD || !PG_HOST || !PG_PORT) {
    throw new Error(
        "Une ou plusieurs variables d'environnement PostgreSQL sont manquantes"
    );
}

let sqlInstance: Sql | null = null;

function getSQL(): Sql {
    if (!sqlInstance) {
        
        sqlInstance = postgres({
            host: PG_HOST,
            port: Number(PG_PORT),
            username: PG_USER,
            password: PG_PASSWORD,
            database: PG_DB,
            ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false,
            connection: {
                client_encoding: 'UTF8'
            },
            max: 10,
            idle_timeout: 20,
            connect_timeout: 60,
        });
    }
    return sqlInstance;
}

export const sql = getSQL();
export default sql;