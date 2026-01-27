CREATE DATABASE IF NOT EXISTS PixelBayDB;
USE PixelBayDB;

DROP TABLE IF EXISTS Contient;
DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
   Id_user INT AUTO_INCREMENT PRIMARY KEY,
   email VARCHAR(100) UNIQUE NOT NULL,
   name VARCHAR(50) NOT NULL,
   password VARCHAR(255) NOT NULL,
   role VARCHAR(50) NOT NULL
);

CREATE TABLE orders(
   Id_order INT,
   order_date DATETIME NOT NULL,
   status VARCHAR(50) NOT NULL,
   Id_user INT NOT NULL,
   PRIMARY KEY(Id_order),
   FOREIGN KEY(Id_user) REFERENCES users(Id_user)
);

CREATE TABLE category(
   Id_Catégorie INT,
   name VARCHAR(50) NOT NULL,
   PRIMARY KEY(Id_Catégorie)
);

CREATE TABLE produit(
   Id_Produit INT,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   in_stock BOOLEAN NOT NULL,
   Id_Catégorie INT NOT NULL,
   PRIMARY KEY(Id_Produit),
   FOREIGN KEY(Id_Catégorie) REFERENCES category(Id_Catégorie)
);

CREATE TABLE Contient(
   Id_order INT,
   Id_Produit INT,
   PRIMARY KEY(Id_order, Id_Produit),
   FOREIGN KEY(Id_order) REFERENCES orders(Id_order),
   FOREIGN KEY(Id_Produit) REFERENCES produit(Id_Produit)
);
