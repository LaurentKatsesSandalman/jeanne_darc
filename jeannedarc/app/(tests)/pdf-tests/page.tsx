export default function PdfTests() {
/*Gérer un “chargement / erreur” avec <iframe>

Tu peux utiliser les événements DOM natifs :

onLoad → déclenché quand le <iframe> a fini de charger.

onError → déclenché si le <iframe> ne peut pas charger le contenu.

Exemple :
import { useState } from "react";

export default function PdfViewer({ src }) {
  const [loaded, setLoaded] = useState(false);
  const [error, setError] = useState(false);

  return (
    <div>
      {!loaded && !error && <p>Chargement du PDF...</p>}
      {error && <p>Le load du PDF a foiré</p>}

      <iframe
        src={src}
        width="800"
        height="500"
        onLoad={() => setLoaded(true)}
        onError={() => setError(true)}
        style={{ display: loaded ? "block" : "none" }}
      />
    </div>
  );
}
*/

  return (
    <>
      
       <h2>Method 1: Using Object Tag</h2> 
	   <object  
            // data="public/Fiche_Stage_RD_Fullstack.pdf" ne marche pas avec du local
            data="https://www.conseil-constitutionnel.fr/sites/default/files/2021-09/constitution.pdf"
			width="800"
            height="500">
    </object>
		<h2>Method 2: Using an iframe</h2>
		{/* this is the recommended method with NextJS */}
      <iframe  
            // src="public/Fiche_Stage_RD_Fullstack.pdf"
			src="https://www.conseil-constitutionnel.fr/sites/default/files/2021-09/constitution.pdf"
            width="800"
            height="500">
    </iframe>
	<h2>Method 2: Using an iframe with local</h2>
      <iframe  
            src="/Fiche_Stage_RD_Fullstack.pdf"
			//src="https://www.conseil-constitutionnel.fr/sites/default/files/2021-09/constitution.pdf"
            width="800"
            height="500">
    </iframe>
	<h2>Method 3: Using embed tag</h2>
	<embed  
            // src="public/Fiche_Stage_RD_Fullstack.pdf"
			src="https://www.conseil-constitutionnel.fr/sites/default/files/2021-09/constitution.pdf"
            width="800"
            height="500">
    </embed>
    </>
  );
}