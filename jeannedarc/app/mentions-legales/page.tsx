// Page : app/mentions-legales/page.tsx
// URL conseillée :  https://refonte.jeannedarc33.fr/mentions-legales
// WARNING: penser à changer https://refonte.jeannedarc33.fr/mentions-legales pour https://jeannedarc33.fr/mentions-legales


export const dynamic = 'force-dynamic';
export const revalidate = 0;

export default function MentionsLegalesPage() {
    return (<main id="main-content">
        <div className="w-[min(90%,1290px)] mx-auto px-4 py-12">
            <h1 className="text-4xl font-bold mb-8">Mentions légales</h1>

            {/* Section 1 - Présentation du site */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">1. Présentation du site</h2>
                <p className="mb-4">
                    En vertu de l&#39;article 6 de la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l&#39;économie numérique, 
                    il est précisé aux utilisateurs du site{' '}
                    <a href="https://refonte.jeannedarc33.fr" className="text-blue-600 hover:underline">
                         https://refonte.jeannedarc33.fr
                    </a>{' '}
                    l&#39;identité des différents intervenants dans le cadre de sa réalisation et de son suivi :
                </p>
                <div className="bg-gray-50 p-6 rounded-lg space-y-2">
                    <p><strong>Propriétaire :</strong> École Privée Jeanne d&#39;Arc – 45 Rue Francis de Pressensé, 33110 Le Bouscat</p>
                    <p><strong>Téléphone :</strong> 05 56 08 52 16</p>
                    <p><strong>Responsable de publication :</strong> Mme Albane MOTAIS DE NARBONNE, Directrice</p>
                    <p><strong>Développement :</strong> Laurent DURUP sous la supervision d&#39;Emmanuel DEVAUX</p>
                    <p><strong>Hébergeur :</strong> Netlify, Inc. – 44 Montgomery Street, Suite 300, San Francisco, CA 94104, États-Unis</p>
                </div>
            </section>

            {/* Section 2 - Conditions générales d'utilisation */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">2. Conditions générales d&#39;utilisation</h2>
                <p className="mb-4">
                    L&#39;utilisation du site{' '}
                    <a href="https://refonte.jeannedarc33.fr" className="text-blue-600 hover:underline">
                         https://refonte.jeannedarc33.fr
                    </a>{' '}
                    implique l&#39;acceptation pleine et entière des conditions générales d&#39;utilisation décrites ci-après. 
                    Ces conditions d&#39;utilisation sont susceptibles d&#39;être modifiées ou complétées à tout moment.
                </p>
                <p className="mb-4">
                    Le site est normalement accessible à tout moment aux utilisateurs. Une interruption pour raison de maintenance technique peut toutefois survenir.
                </p>
                <p>
                    Le site est mis à jour régulièrement. De la même façon, les mentions légales peuvent être modifiées 
                    à tout moment : elles s&#39;imposent néanmoins à l&#39;utilisateur qui est invité à s&#39;y référer le plus 
                    souvent possible afin d&#39;en prendre connaissance.
                </p>
            </section>

            {/* Section 3 - Description des services */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">3. Description des services fournis</h2>
                <p className="mb-4">
                    Le site{' '}
                    <a href="https://refonte.jeannedarc33.fr" className="text-blue-600 hover:underline">
                         https://refonte.jeannedarc33.fr
                    </a>{' '}
                    a pour objet de fournir une information concernant l&#39;ensemble des activités de l&#39;école.
                </p>
                <p className="mb-4">
                    L&#39;École Privée Jeanne d&#39;Arc s&#39;efforce de fournir sur le site des informations aussi précises que possible. 
                    Toutefois, elle ne pourra être tenue responsable des omissions, des inexactitudes et des carences dans la 
                    mise à jour, qu&#39;elles soient de son fait ou du fait des tiers partenaires qui lui fournissent ces informations.
                </p>
                <p>
                    Toutes les informations indiquées sur le site sont données à titre indicatif, et sont susceptibles d&#39;évoluer. 
                    Par ailleurs, les renseignements figurant sur le site ne sont pas exhaustifs.
                </p>
            </section>

            {/* Section 4 - Limitations techniques */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">4. Limitations techniques</h2>
                <p>
                    Le site utilise les technologies web modernes (HTML, CSS, JavaScript, React, Next.js). 
                    L&#39;utilisateur du site s&#39;engage à accéder au site en utilisant un matériel récent et un navigateur 
                    de dernière génération mis à jour.
                </p>
            </section>

            {/* Section 5 - Propriété intellectuelle */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">5. Propriété intellectuelle et crédits</h2>
                <p className="mb-4">
                    L&#39;École Privée Jeanne d&#39;Arc est propriétaire des droits de propriété intellectuelle ou détient les droits 
                    d&#39;usage sur tous les éléments accessibles sur le site, notamment les textes, images, graphismes, logos, et contenus.
                </p>
                <p className="mb-4">
                    Toute reproduction, représentation, modification, publication, adaptation de tout ou partie des éléments du site, 
                    quel que soit le moyen ou le procédé utilisé, est interdite, sauf autorisation écrite préalable de 
                    l&#39;École Privée Jeanne d&#39;Arc.
                </p>
                <p className="mb-4">
                    Toute exploitation non autorisée du site ou de l&#39;un quelconque des éléments qu&#39;il contient sera considérée 
                    comme constitutive d&#39;une contrefaçon et poursuivie conformément aux dispositions des articles L.335-2 et 
                    suivants du Code de Propriété Intellectuelle.
                </p>

                <h3 className="text-xl font-semibold mt-6 mb-3">Crédits des icônes</h3>
                <p className="mb-2">Ce site utilise des icônes provenant des bibliothèques suivantes :</p>
                <ul className="list-disc list-inside space-y-1 ml-4">
                    <li><strong>Lucide Icons</strong> - Licence ISC - © Lucide Contributors 2025 (dérivé de Feather © Cole Bemis 2013-2023)</li>
                    <li><strong>Font Awesome</strong> - Licence CC Attribution - © FortAwesome</li>
                    <li><strong>Pixelarticons</strong> - Licence MIT - © halfmage</li>
                    <li><strong>Scarlab Icons</strong> - Licence MIT - © Scarlab</li>
                    <li><strong>MingCute</strong> - Licence Apache - © Richard9394</li>
                    <li><strong>Eva Icons</strong> - Licence Apache - © Akveo</li>
                    <li><strong>Boxicons</strong> - Licence CC Attribution - © atisawd</li>
                    <li><strong>Solar Icons</strong> - Licence CC Attribution - © Solar Icons</li>
                    <li><strong>Icons by Thewolfkit</strong> - Licence CC Attribution - © thewolfkit</li>
                    <li><strong>Icooon Mono</strong> - Domaine Public</li>
                </ul>
            </section>

            {/* Section 6 - Limitations de responsabilité */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">6. Limitations de responsabilité</h2>
                <p className="mb-4">
                    L&#39;École Privée Jeanne d&#39;Arc ne pourra être tenue responsable des dommages directs et indirects causés au 
                    matériel de l&#39;utilisateur, lors de l&#39;accès au site, et résultant soit de l&#39;utilisation d&#39;un matériel ne 
                    répondant pas aux spécifications techniques requises, soit de l&#39;apparition d&#39;un bug ou d&#39;une incompatibilité.
                </p>
                <p>
                    L&#39;École Privée Jeanne d&#39;Arc ne pourra également être tenue responsable des dommages indirects consécutifs 
                    à l&#39;utilisation du site.
                </p>
            </section>

            {/* Section 7 - Gestion des données personnelles (RGPD) */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">7. Gestion des données personnelles</h2>
                <p className="mb-4">
                    En France, les données personnelles sont protégées par le Règlement Général sur la Protection des Données 
                    (RGPD - Règlement UE 2016/679), la loi n° 78-17 du 6 janvier 1978 modifiée, dite Loi Informatique et Libertés, 
                    et l&#39;article L. 226-13 du Code pénal.
                </p>

                <h3 className="text-xl font-semibold mt-6 mb-3">Collecte des données</h3>
                <p className="mb-4">
                    Les formulaires de contact présents sur le site peuvent collecter des informations personnelles telles que 
                    nom, prénom, adresse email, numéro de téléphone ou tout autre information fournie volontairement par l&#39;utilisateur.
                </p>
                <p className="mb-4">
                    Ces données sont collectées uniquement pour permettre à l&#39;école de répondre aux demandes des utilisateurs. 
                    Les informations sont transmises par email aux personnes habilitées de l&#39;établissement et ne sont pas publiées 
                    sur le site ni stockées dans une base de données publique.
                </p>

                <h3 className="text-xl font-semibold mt-6 mb-3">Authentification</h3>
                <p className="mb-4">
                    Le site utilise le service d&#39;authentification Clerk pour la gestion du back-office administratif. 
                    Seules les personnes autorisées (personnel de l&#39;école) peuvent se connecter à l&#39;interface d&#39;administration.
                </p>

                <h3 className="text-xl font-semibold mt-6 mb-3">Vos droits</h3>
                <p className="mb-4">
                    Conformément au RGPD et à la loi Informatique et Libertés, tout utilisateur dispose d&#39;un droit d&#39;accès, 
                    de rectification, de suppression et d&#39;opposition aux données personnelles le concernant.
                </p>
                <p className="mb-4">
                    Pour exercer ces droits, vous pouvez effectuer votre demande par courrier postal à l&#39;adresse suivante :
                </p>
                <p className="ml-4 mb-4">
                    École Privée Jeanne d&#39;Arc<br />
                    45 Rue Francis de Pressensé<br />
                    33110 Le Bouscat
                </p>
                <p className="mb-4">Ou par téléphone au : 05 56 08 52 16</p>
                <p>
                    Aucune information personnelle de l&#39;utilisateur du site n&#39;est publiée à l&#39;insu de l&#39;utilisateur, 
                    échangée, transférée, cédée ou vendue sur un support quelconque à des tiers.
                </p>
            </section>

            {/* Section 8 - Cookies et traceurs */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">8. Cookies et traceurs</h2>
                <p className="mb-4">
                    La navigation sur le site est susceptible de provoquer l&#39;installation de cookies sur l&#39;ordinateur de l&#39;utilisateur.
                </p>

                <h3 className="text-xl font-semibold mt-6 mb-3">Cookies d&#39;authentification</h3>
                <p className="mb-4">
                    Le site utilise le service Clerk pour l&#39;authentification des administrateurs. Ce service peut déposer des 
                    cookies nécessaires au fonctionnement de la connexion sécurisée au back-office.
                </p>

                <h3 className="text-xl font-semibold mt-6 mb-3">Contenus tiers</h3>
                <p className="mb-4">
                    Le site intègre une carte Google Maps qui peut déposer des cookies conformément à la politique de 
                    confidentialité de Google. Pour plus d&#39;informations, consultez{' '}
                    <a 
                        href="https://policies.google.com/privacy" 
                        target="_blank" 
                        rel="noopener noreferrer"
                        className="text-blue-600 hover:underline"
                    >
                        la politique de confidentialité de Google
                    </a>.
                </p>

                <h3 className="text-xl font-semibold mt-6 mb-3">Gestion des cookies</h3>
                <p className="mb-4">
                    L&#39;utilisateur peut configurer son navigateur pour refuser les cookies. Cependant, le refus d&#39;installation 
                    de certains cookies peut entraîner l&#39;impossibilité d&#39;accéder à certains services, notamment l&#39;interface 
                    d&#39;administration.
                </p>
                <p>
                    Pour gérer les cookies, vous pouvez consulter les paramètres de confidentialité de votre navigateur 
                    (Chrome, Firefox, Safari, Edge, etc.).
                </p>
            </section>

            {/* Section 9 - Liens hypertextes */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">9. Liens hypertextes</h2>
                <p>
                    Le site peut contenir des liens hypertextes vers d&#39;autres sites. L&#39;École Privée Jeanne d&#39;Arc n&#39;a pas la 
                    possibilité de vérifier le contenu des sites ainsi visités, et n&#39;assumera en conséquence aucune responsabilité 
                    de ce fait.
                </p>
            </section>

            {/* Section 10 - Accessibilité */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">10. Accessibilité numérique</h2>
                <p className="mb-4">
                    L&#39;École Privée Jeanne d&#39;Arc s&#39;engage à rendre son site internet accessible conformément à l&#39;article 47 de 
                    la loi n° 2005-102 du 11 février 2005.
                </p>
                <p>
                    Le site est en cours d&#39;optimisation pour être conforme aux normes d&#39;accessibilité (RGAA - Référentiel 
                    Général d&#39;Amélioration de l&#39;Accessibilité). Si vous rencontrez des difficultés d&#39;accès à certains contenus, 
                    n&#39;hésitez pas à nous contacter.
                </p>
            </section>

            {/* Section 11 - Droit applicable */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">11. Droit applicable et attribution de juridiction</h2>
                <p>
                    Tout litige en relation avec l&#39;utilisation du site{' '}
                    <a href="https://refonte.jeannedarc33.fr" className="text-blue-600 hover:underline">
                         https://refonte.jeannedarc33.fr
                    </a>{' '}
                    est soumis au droit français. Il est fait attribution exclusive de juridiction aux tribunaux compétents 
                    de Bordeaux.
                </p>
            </section>

            {/* Section 12 - Principales lois */}
            <section className="mb-8">
                <h2 className="text-2xl font-semibold mb-4">12. Principales lois concernées</h2>
                <ul className="list-disc list-inside space-y-2 ml-4">
                    <li>Règlement (UE) 2016/679 du Parlement européen et du Conseil du 27 avril 2016 (RGPD)</li>
                    <li>Loi n° 78-17 du 6 janvier 1978 relative à l&#39;informatique, aux fichiers et aux libertés (modifiée)</li>
                    <li>Loi n° 2004-575 du 21 juin 2004 pour la confiance dans l&#39;économie numérique</li>
                    <li>Loi n° 2005-102 du 11 février 2005 pour l&#39;égalité des droits et des chances</li>
                </ul>
            </section>

            {/* Date de mise à jour */}
            <div className="mt-12 pt-6 border-t border-gray-300 text-sm text-gray-600">
                <p>Dernière mise à jour : Janvier 2026</p>
            </div>
        </div>
    </main>);
}
