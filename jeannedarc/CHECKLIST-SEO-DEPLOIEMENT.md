# ✅ Checklist Déploiement & Tests SEO - École Jeanne d'Arc

## 📅 À faire APRÈS mise en production

---

## 1️⃣ Vérifications Techniques Immédiates

### Fichiers SEO essentiels
- [ ] Vérifier **robots.txt** : https://refonte.jeannedarc33.fr/robots.txt
  - Doit afficher les règles d'indexation
  - Doit bloquer `/gestion-pages`, `/login`, `/plus`, `/recherche`
  
- [ ] Vérifier **sitemap.xml** : https://refonte.jeannedarc33.fr/sitemap.xml
  - Doit lister toutes les pages publiques
  - Doit inclure `/mentions-legales`
  - Format XML valide

### Redirections
- [ ] Tester redirection Netlify → domaine custom
  - Aller sur `https://jeannedarc33.netlify.app`
  - Doit rediriger vers `https://refonte.jeannedarc33.fr`
  
- [ ] Tester suppression trailing slash
  - Visiter `https://refonte.jeannedarc33.fr/actualites/` (avec slash)
  - Doit rediriger vers `https://refonte.jeannedarc33.fr/actualites` (sans slash)

### Canonical URLs
- [ ] Vérifier homepage
  - Ouvrir https://refonte.jeannedarc33.fr
  - Inspecter le code source (Ctrl+U ou Cmd+U)
  - Chercher `<link rel="canonical"` 
  - Doit pointer vers `https://refonte.jeannedarc33.fr/`

- [ ] Vérifier page dynamique (ex: actualites)
  - Ouvrir https://refonte.jeannedarc33.fr/actualites
  - Inspecter le code source
  - Canonical doit pointer vers `https://refonte.jeannedarc33.fr/actualites`

### Images
- [ ] Vérifier que les images chargent correctement
  - Tester plusieurs pages
  - Config `remotePatterns` intacte dans next.config.js
  - Vérifier que le logo du header s'affiche
  - Vérifier images de contenu

### Meta descriptions
- [ ] Vérifier meta description homepage
  - Inspecter le code source
  - Chercher `<meta name="description"`
  - Doit afficher la nouvelle description optimisée

---

## 2️⃣ Tests Données Structurées (JSON-LD)

- [ ] **Rich Results Test** - Google
  - Aller sur : https://search.google.com/test/rich-results
  - Entrer l'URL : `https://refonte.jeannedarc33.fr`
  - Vérifier que Google détecte les données structurées "School"
  - S'assurer qu'il n'y a pas d'erreurs
  - Vérifier les informations détectées :
    - Nom de l'école
    - Adresse
    - Téléphone
    - Horaires

- [ ] Vérifier le logo carré
  - S'assurer que `/images/logo-square.png` est accessible
  - URL complète : https://refonte.jeannedarc33.fr/images/logo-square.png

---

## 3️⃣ Google Search Console (PRIORITAIRE)

### Configuration initiale
- [ ] Créer un compte Google Search Console : https://search.google.com/search-console
- [ ] Ajouter la propriété `https://refonte.jeannedarc33.fr`
- [ ] Vérifier la propriété (méthode DNS recommandée via OVH)
- [ ] Soumettre le sitemap
  - Dans Search Console → Sitemaps
  - Ajouter : `https://refonte.jeannedarc33.fr/sitemap.xml`

### Après quelques jours
- [ ] Vérifier l'indexation des pages
- [ ] Consulter les erreurs d'exploration éventuelles
- [ ] Vérifier les Core Web Vitals
- [ ] Analyser les requêtes de recherche

---

## 4️⃣ Bing Webmaster Tools (Optionnel mais recommandé)

- [ ] Créer un compte : https://www.bing.com/webmasters
- [ ] Ajouter le site `https://refonte.jeannedarc33.fr`
- [ ] Soumettre le sitemap
- [ ] Vérifier l'indexation

---

## 5️⃣ Google Business Profile (Fiche Google Maps)

- [ ] Vérifier/Créer la fiche établissement
  - Rechercher "École Jeanne d'Arc Le Bouscat" sur Google
  - Revendiquer la fiche si pas déjà fait
  - Mettre à jour les informations :
    - Site web : `https://refonte.jeannedarc33.fr` (ou domaine principal après bascule)
    - Horaires
    - Photos
    - Description

---

## 6️⃣ Performance & Core Web Vitals

### Lighthouse Audit
- [ ] Ouvrir Chrome DevTools (F12)
- [ ] Onglet "Lighthouse"
- [ ] Cocher : Performance, Accessibility, Best Practices, SEO
- [ ] Mode : Desktop & Mobile
- [ ] Lancer l'audit
- [ ] Vérifier les scores (objectif : >90 partout)

### PageSpeed Insights
- [ ] Aller sur : https://pagespeed.web.dev/
- [ ] Tester : `https://refonte.jeannedarc33.fr`
- [ ] Vérifier Mobile & Desktop
- [ ] Noter les Core Web Vitals :
  - LCP (Largest Contentful Paint) : < 2.5s
  - FID (First Input Delay) : < 100ms
  - CLS (Cumulative Layout Shift) : < 0.1

---

## 7️⃣ Tests Manuels SEO

### Meta tags
- [ ] Tester le partage sur Facebook
  - Aller sur : https://developers.facebook.com/tools/debug/
  - Entrer l'URL du site
  - Vérifier l'aperçu (titre, description, image)

- [ ] Vérifier Open Graph image
  - S'assurer que `/images/og-image.jpg` existe et est accessible
  - Dimensions : 1200x630px

### Recherche Google
- [ ] Après quelques jours/semaines, chercher :
  - "école jeanne d'arc le bouscat"
  - "école catholique le bouscat"
  - "école primaire le bouscat"
- [ ] Vérifier que le site apparaît dans les résultats
- [ ] Vérifier que la description affichée est correcte

---

## 8️⃣ Mots-clés (Après validation directrice)

- [ ] Obtenir la liste des mots-clés validés par la directrice
- [ ] Utiliser la page `/recherche` du site pour vérifier leur présence
- [ ] Identifier les pages où ajouter naturellement les mots-clés manquants
- [ ] Intégrer les mots-clés dans :
  - Textes existants (naturellement)
  - Meta descriptions
  - Alt texts d'images (si pertinent)
- [ ] Éviter le keyword stuffing (densité max 1-3%)

---

## 9️⃣ Monitoring Netlify

- [ ] Vérifier l'usage quotidien des Serverless Functions
  - Se connecter à Netlify
  - Onglet "Functions" ou "Usage"
  - Noter les chiffres
  - S'assurer de rester dans les limites du plan gratuit

---

## 🔟 Validation finale

- [ ] Tester la navigation sur mobile
- [ ] Tester la navigation sur desktop
- [ ] Vérifier que toutes les pages se chargent correctement
- [ ] Tester le formulaire de contact (si existant)
- [ ] Vérifier l'authentification Clerk (login admin)
- [ ] Tester les modifications de contenu en admin
- [ ] Vérifier que les modifications apparaissent après revalidation (~30 sec)

---

## 📊 Suivi continu (hebdomadaire/mensuel)

- [ ] Consulter Google Search Console (erreurs, positions)
- [ ] Vérifier les Core Web Vitals
- [ ] Analyser les requêtes de recherche
- [ ] Ajuster les contenus selon les performances
- [ ] Monitorer l'usage Netlify

---

## 🚨 En cas de problème

### Sitemap ne se génère pas
→ Vérifier les logs Netlify lors du build
→ Vérifier la connexion à Supabase (variables d'environnement)

### Pages non indexées
→ Vérifier robots.txt
→ Soumettre manuellement les URLs dans Search Console

### Erreurs données structurées
→ Utiliser le Rich Results Test pour identifier l'erreur
→ Vérifier le JSON-LD dans le code source

### Mauvaises performances
→ Vérifier les images (taille, format)
→ Vérifier le cache Netlify
→ Analyser le rapport Lighthouse détaillé

---

**Date de dernière mise à jour** : 28 janvier 2026
**Projet** : Refonte École Jeanne d'Arc - Next.js
**URL staging** : https://refonte.jeannedarc33.fr
**URL production future** : https://jeannedarc33.fr
