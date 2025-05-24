# 🎬 Système de Réservation de Billets de Cinéma ( Mazagan Screenverse>

Ce projet est une application web complète de réservation de billets de cinéma, développée avec Laravel v12 pour le backend et React.js pour le frontend.

## 📌 Fonctionnalités

- Authentification des utilisateurs (inscription / connexion)
- Liste des films disponibles avec leurs détails
- Sélection d'une séance (date et heure)
- Réservation d'une place
- Génération automatique d'un **PDF avec code QR** pour le billet
- Interface utilisateur moderne et réactive

## 🛠️ Technologies Utilisées

### Backend :
- Laravel 12
- API RESTful
- Base de données MySQL 
- Génération de PDF avec `jspdf` 
- Génération de Qr code avec `jspdf` 

### Frontend :
- React.js
- React Router
- Tailwind CSS
- Axios pour la communication avec l'API

## 🚀 Installation

### Prérequis
- PHP >= 8.1
- Composer
- Node.js et npm
- MySQL ou autre base de données

### Étapes pour le Backend (Laravel)
cd last_backend
composer install
php artisan migrate
php artisan serve

### Étapes pour le Frontend (React)
cd frontend
npm install
npm run dev


