# Mazagan Screenverse

## Description

Mazagan Screenverse est un systeme de réservation de billets de cinéma développé dans le cadre d’un projet pour le module developement eb.  
Cette application web combine **Laravel** pour le backend et **React.js** pour le frontend, avec **Axios** pour les requêtes HTTP et une base de données **MySQL**.

L’objectif est de permettre aux utilisateurs de consulter les films, sélectionner des séances, réserver des places, et gérer leurs réservations de manière simple et efficace.

---

## Fonctionnalités principales

- Consultation des films disponibles et des séances programmées  
- Réservation des places  
- Gestion des utilisateurs (inscription, connexion)  
- Interface utilisateur dynamique et réactive avec React.js  
- Communication backend-frontend via Axios. 
- Stockage des données dans une base MySQL.

---

## Technologies utilisées

- **Backend** : Laravel (PHP)  
- **Frontend** : React.js  
- **Communication API** : Axios  
- **Base de données** : MySQL  
- **Gestion des versions** : Git & GitHub

---

## Installation et utilisation

### Prérequis

- PHP >= 8.x  
- Composer  
- Node.js & npm  
- MySQL  
- Serveur Apache ou Nginx


### Cloner le projet

1. Cloner :  
   ```bash
   git clone https://github.com/Souhailtounfi/cinema.git

### Frontend (Raect Js)

1. Se déplacer dans le dossier frontend :  
   ```bash
   cd frontend
   ```
2. Installer les dependances npm:  
   ```bash
   npm install
   ```
5. Démarrer le serveur React :  
   ```bash
   npm run dev
   ```

### Backend (Laravel)

1. Se déplacer dans le dossier backend :  
   ```bash
   cd last_backend
   ```
2. Installer les dépendances PHP :  
   ```bash
   composer install
   ```
3. Configurer le fichier `.env` (base de données, clé d’application...)  
4. Lancer les migrations :  
   ```bash
   php artisan migrate
   ```
5. Démarrer le serveur Laravel :  
   ```bash
   php artisan serve
   ```
