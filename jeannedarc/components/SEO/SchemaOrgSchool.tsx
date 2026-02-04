export function SchemaOrgSchool() {
    const schoolData = {
        "@context": "https://schema.org",
        "@type": "School",
        name: "École Jeanne d'Arc",
        alternateName: "JDA Le Bouscat",
        description:
            "École maternelle et primaire de l'enseignement catholique sous tutelle diocésaine sous contrat avec l'État",
        url: "https://refonte.jeannedarc33.fr",
        logo: "https://refonte.jeannedarc33.fr/images/logo-square.png",
        image: "https://refonte.jeannedarc33.fr/images/logo-square.png",
        address: {
            "@type": "PostalAddress",
            streetAddress: "45 Rue Francis de Pressensé",
            addressLocality: "Le Bouscat",
            postalCode: "33110",
            addressCountry: "FR",
        },
        geo: {
            "@type": "GeoCoordinates",
            latitude: "44.8686",
            longitude: "-0.5978",
        },
        telephone: "+33556085216",
        openingHoursSpecification: [
            {
                "@type": "OpeningHoursSpecification",
                dayOfWeek: ["Monday", "Tuesday", "Thursday", "Friday"],
                opens: "08:45",
                closes: "12:00",
                description: "Horaires de classe (matin)",
            },
            {
                "@type": "OpeningHoursSpecification",
                dayOfWeek: ["Monday", "Tuesday", "Thursday", "Friday"],
                opens: "13:30",
                closes: "16:30",
                description: "Horaires de classe (après-midi)",
            },
            {
                "@type": "OpeningHoursSpecification",
                dayOfWeek: ["Monday", "Tuesday", "Thursday", "Friday"],
                opens: "07:45",
                closes: "08:45",
                description: "Garderie du matin",
            },
            {
                "@type": "OpeningHoursSpecification",
                dayOfWeek: ["Monday", "Tuesday", "Thursday", "Friday"],
                opens: "16:30",
                closes: "18:15",
                description: "Garderie du soir",
            },
        ],
        availableLanguage: {
            "@type": "Language",
            name: "French",
            alternateName: "fr",
        },
    };

    return (
        <script
            type="application/ld+json"
            dangerouslySetInnerHTML={{ __html: JSON.stringify(schoolData) }}
        />
    );
}
