import postgres from "postgres";
import dotenv from "dotenv";

dotenv.config();

// Lecture des variables d'environnement
const PG_DB = process.env.PG_DB;
const PG_USER = process.env.PG_USER;
const PG_PASSWORD = process.env.PG_PASSWORD;
const PG_HOST = process.env.PG_HOST;
const PG_PORT = process.env.PG_PORT;

// Vérification que rien n'est manquant
if (!PG_DB || !PG_USER || !PG_PASSWORD || !PG_HOST || !PG_PORT) {
    throw new Error(
        "Une ou plusieurs variables d’environnement PostgreSQL sont manquantes"
    );
}

export const sql = postgres({
    host: PG_HOST,
    port: Number(PG_PORT),
    username: PG_USER,
    password: PG_PASSWORD,
    database: PG_DB,
    ssl:
        process.env.NODE_ENV === "production"
            ? true // ou { rejectUnauthorized: false }, pour la prod, si SSL activé et autosigné
            : false, // local : SSL désactivé
	connection: {
        client_encoding: 'UTF8'
    },
	max: 10, // Nombre maximum de connexions (ajustez selon vos besoins)
    idle_timeout: 20, // Fermer les connexions inactives après 20 secondes
    connect_timeout: 10,
});

export default sql;
