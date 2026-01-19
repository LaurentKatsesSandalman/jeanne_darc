// import postgres from "postgres";
// import type { Sql } from "postgres";
// import dotenv from "dotenv";

// dotenv.config();

// // Lecture des variables d'environnement
// const PG_DB = process.env.PG_DB;
// const PG_USER = process.env.PG_USER;
// const PG_PASSWORD = process.env.PG_PASSWORD;
// const PG_HOST = process.env.PG_HOST;
// const PG_PORT = process.env.PG_PORT;

// // Vérification que rien n'est manquant
// if (!PG_DB || !PG_USER || !PG_PASSWORD || !PG_HOST || !PG_PORT) {
//     throw new Error(
//         "Une ou plusieurs variables d’environnement PostgreSQL sont manquantes"
//     );
// }

// // Variable pour stocker la connexion (lazy loading)
// let sqlInstance: Sql | null = null;

// export function getSQL(): Sql {
//     // Ne pas créer de connexion pendant le build
//     if (process.env.NEXT_PHASE === 'phase-production-build') {
//         throw new Error('Database connection not available during build phase');
//     }

//     // Créer la connexion seulement si elle n'existe pas encore
//     if (!sqlInstance) {
//         sqlInstance = postgres({
//     host: PG_HOST,
//     port: Number(PG_PORT),
//     username: PG_USER,
//     password: PG_PASSWORD,
//     database: PG_DB,
//     ssl:
//         process.env.NODE_ENV === "production"
//             ? true // ou { rejectUnauthorized: false }, pour la prod, si SSL activé et autosigné
//             : false, // local : SSL désactivé
// 	connection: {
//         client_encoding: 'UTF8'
//     },
// 	max: 10, // Nombre maximum de connexions (ajustez selon vos besoins)
//     idle_timeout: 20, // Fermer les connexions inactives après 20 secondes
//     connect_timeout: 10,
// });

// console.log('✅ Connexion PostgreSQL établie');
//     }

//     return sqlInstance;
// }

// export const sql = getSQL()

// export default getSQL;

//----------------------------------------------

// 

//--------------------

// import postgres from "postgres";
// import type { Sql } from "postgres";
// import dotenv from "dotenv";

// dotenv.config();

// const PG_DB = process.env.PG_DB;
// const PG_USER = process.env.PG_USER;
// const PG_PASSWORD = process.env.PG_PASSWORD;
// const PG_HOST = process.env.PG_HOST;
// const PG_PORT = process.env.PG_PORT;

// if (!PG_DB || !PG_USER || !PG_PASSWORD || !PG_HOST || !PG_PORT) {
//     throw new Error(
//         "Une ou plusieurs variables d'environnement PostgreSQL sont manquantes"
//     );
// }

// let sqlInstance: Sql | null = null;

// // Détection de la phase de build
// const isBuildTime = process.env.NEXT_PHASE === 'phase-production-build' || 
//                     process.env.NODE_ENV === 'production' && !process.env.VERCEL;

// function getSQL(): Sql {
//     // Pendant le build, on crée un proxy qui throw des erreurs explicites
//     if (isBuildTime) {
//         console.log('⚠️ Build time détecté - pas de connexion DB');
//         return new Proxy({} as Sql, {
//             get() {
//                 throw new Error('Database access not available during build time');
//             }
//         });
//     }

//     if (!sqlInstance) {
//         console.log('✅ Création connexion PostgreSQL (runtime)');
//         sqlInstance = postgres({
//             host: PG_HOST,
//             port: Number(PG_PORT),
//             username: PG_USER,
//             password: PG_PASSWORD,
//             database: PG_DB,
//             ssl: process.env.NODE_ENV === "production" ? true : false,
//             connection: {
//                 client_encoding: 'UTF8'
//             },
//             max: 10,
//             idle_timeout: 20,
//             connect_timeout: 10,
//         });
//     }
//     return sqlInstance;
// }

// export const sql = getSQL();
// export default sql;

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
        console.log('✅ Création connexion PostgreSQL');
        sqlInstance = postgres({
            host: PG_HOST,
            port: Number(PG_PORT),
            username: PG_USER,
            password: PG_PASSWORD,
            database: PG_DB,
            ssl: process.env.NODE_ENV === "production" ? true : false,
            connection: {
                client_encoding: 'UTF8'
            },
            max: 10,
            idle_timeout: 20,
            connect_timeout: 10,
        });
    }
    return sqlInstance;
}

export const sql = getSQL();
export default sql;