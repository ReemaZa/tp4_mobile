# TP 4 Flutter – Consommation des services


## Objectifs du TP

L’objectif de ce TP est de mettre en œuvre l’interrogation de services Web REST
dans une application Flutter en utilisant plusieurs méthodes :
- `http`
- `Dio`
- `Retrofit.dart`

---

##  Description

### 1 Récupération d’une citation aléatoire (HTTP)

- Utilisation de l’API : https://zenquotes.io/api/random
- Appel réseau effectué avec le package `http`
- Transformation du JSON en objet Dart (`Quote`)
- Affichage de la citation du jour dans l’application

---

### 2️ Affichage de plusieurs citations

- Utilisation de l’API : https://zenquotes.io/api/quotes
- Chargement initial de 5 citations
- Bouton Load more permettant de charger 5 citations supplémentaires
- Lorsque toutes les citations sont affichées, un message indique qu’il n’y a plus de données

---

### 3️ Navigation avec Intro Screen

- Écran d’introduction (`IntroScreen`)
- Bouton permettant d’accéder à la citation du jour

---

## Implémentation avec Dio

- Remplacement du package `http` par `Dio`
- Avantages :
- Gestion avancée des erreurs
- Configuration des timeouts
- Meilleure lisibilité du code
- Client HTTP plus professionnel

---

## Implémentation avec Retrofit

- Utilisation de `Retrofit.dart` avec `Dio`
- Définition des endpoints via annotations (`@GET`)
- Génération automatique du code réseau
- Séparation claire entre :
- Définition de l’API
- Logique métier
- Interface utilisateur

---

##  Comparaison des approches

| Méthode     | Avantages |
|------------|----------|
| http       | Simple, rapide à mettre en place |
| Dio        | Plus puissant, gestion avancée |
| Retrofit   | Moins de code, meilleure structure, automatisation |

---

##  Captures d’écran

Des captures d’écran de sont disponibles dans le dépôt.


---



