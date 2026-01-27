CREATE DATABASE IF NOT EXISTS PixelBayDB;
USE PixelBayDB;

-- Suppression dans l'ordre pour éviter les erreurs de clés étrangères
DROP TABLE IF EXISTS orders_produit;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS category;








CREATE TABLE users(
   Id_user INT AUTO_INCREMENT PRIMARY KEY,
   email VARCHAR(100) UNIQUE NOT NULL,
   name VARCHAR(50) NOT NULL,
   password VARCHAR(255) NOT NULL,
   role VARCHAR(50) NOT NULL DEFAULT 'client'
);

INSERT INTO users (email, name, password, role) VALUES
('admin@pixelbay.com', 'Admin_Boss', 'hash_secure_123', 'admin'),
('lucas.gamer@gmail.com', 'Lucas', 'pass_lucas_99', 'client'),
('emma.v@outlook.fr', 'Emma', 'emma_pixel_2024', 'client'),
('jean.test@yahoo.fr', 'Jean_Test', 'test_password_456', 'client'),
('sophie.pro@gmail.com', 'Sophie', 'sophie_secret_789', 'client');

-- SELECT * FROM users;





CREATE TABLE orders(
   Id_order INT AUTO_INCREMENT PRIMARY KEY, 
   order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   status VARCHAR(50) NOT NULL,
   Id_user INT NOT NULL,
   FOREIGN KEY(Id_user) REFERENCES users(Id_user) ON DELETE CASCADE 
);

INSERT INTO orders (status, Id_user) VALUES
('En attente', 2),
('expédiée', 3),
('livrée', 4),
('annulée', 5),
('livrée', 2);

-- SELECT * FROM orders;





CREATE TABLE category(
   Id_Categorie INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL
);
INSERT INTO category (name) VALUES
('RPG'),
('Aventure'),
('FPS'),
('Sport');

-- SELECT * FROM category;






CREATE TABLE produit(
   Id_Produit INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   in_stock BOOLEAN NOT NULL,
   Id_Categorie INT NOT NULL,
   FOREIGN KEY(Id_Categorie) REFERENCES category(Id_Categorie) ON DELETE CASCADE
);
INSERT INTO produit (name, price, in_stock, Id_Categorie) VALUES
('The Witcher 3', 39.99, TRUE, 1),
('Assassin\'s Creed Valhalla', 49.99, TRUE, 2),
('Call of Duty : Modern Warfare', 59.99, TRUE, 3),
('FIFA 22', 29.99, TRUE, 4),
('Elden Ring', 59.99, TRUE, 1),
('Uncharted 4', 19.99, TRUE, 2),
('Battlefield 2042', 14.99, FALSE, 3),
('NBA 2K23', 29.99, TRUE, 4);

-- SELECT * FROM produit;



CREATE TABLE orders_produit (
   Id_order INT,
   Id_Produit INT,
   PRIMARY KEY(Id_order, Id_Produit),
   FOREIGN KEY(Id_order) REFERENCES orders(Id_order) ON DELETE CASCADE,
   FOREIGN KEY(Id_Produit) REFERENCES produit(Id_Produit) ON DELETE CASCADE
);

INSERT INTO orders_produit (Id_order, Id_Produit) VALUES
(2, 3),
(2, 2), (2, 6), (2,5),
(3, 3), (3, 7), (3, 1), (3, 5), 
(4, 4), (5,2),
(5, 8), (5, 4);


SELECT p.name, p.price, c.name FROM produit p JOIN category c ON p.Id_categorie = c.Id_categorie WHERE c.name = 'RPG' AND p.in_stock = TRUE;