-- Création de la table Region (table indépendante)
CREATE TABLE Region (
    N_Region INT AUTO_INCREMENT PRIMARY KEY,
    Nom_Region VARCHAR(50) NOT NULL
);

-- Création de la table Agent_Local (dépend de Region)
CREATE TABLE Agent_Local (
    N_Agent INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Telephone VARCHAR(15) UNIQUE NOT NULL,
    N_Region INT NOT NULL,
    FOREIGN KEY (N_Region) REFERENCES Region(N_Region)
);

-- Création de la table Client
CREATE TABLE Client (
    N_Client INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Telephone VARCHAR(15) UNIQUE NOT NULL
);

-- Création de la table Transaction (dépend de Client et d'Agent_Local)
CREATE TABLE Transaction_Transfert (
    N_Transaction INT AUTO_INCREMENT PRIMARY KEY,
    N_Client_Emetteur INT NOT NULL,
    N_Client_Recepteur INT NOT NULL,
    N_Agent INT NOT NULL,
    Montant DECIMAL(10,2) NOT NULL,
    Date_Transaction DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (N_Client_Emetteur) REFERENCES Client(N_Client),
    FOREIGN KEY (N_Client_Recepteur) REFERENCES Client(N_Client),
    FOREIGN KEY (N_Agent) REFERENCES Agent_Local(N_Agent)
);
-- 1. Insertion des régions
INSERT INTO Region (Nom_Region) VALUES 
('Dakar'), 
('Thies'), 
('Saint-Louis');

-- 2. Insertion des agents (liés aux régions)
INSERT INTO Agent_Local (Nom, Prenom, Telephone, N_Region) VALUES 
('Diop', 'Amadou', '771234567', 1),  -- Agent à Dakar
('Fall', 'Fatou', '769876543', 2),   -- Agent à Thies
('Ndiaye', 'Ousmane', '701112233', 3); -- Agent à Saint-Louis

-- 3. Insertion des clients
INSERT INTO Client (Nom, Prenom, Telephone) VALUES 
('Sow', 'Moussa', '772223344'),
('Ba', 'Aminata', '763334455'),
('Diallo', 'Ibrahima', '704445566'),
('Gueye', 'Khady', '785556677');

-- 4. Insertion des transactions
-- Moussa (1) envoie 50000 à Aminata (2) via l'agent Amadou (1) à Dakar
INSERT INTO Transaction_Transfert (N_Client_Emetteur, N_Client_Recepteur, N_Agent, Montant) 
VALUES (1, 2, 1, 50000.00);

-- Aminata (2) envoie 25000 à Khady (4) via l'agent Fatou (2) à Thies
INSERT INTO Transaction_Transfert (N_Client_Emetteur, N_Client_Recepteur, N_Agent, Montant) 
VALUES (2, 4, 2, 25000.00);

-- Ibrahima (3) envoie 100000 à Moussa (1) via l'agent Ousmane (3) à Saint-Louis
INSERT INTO Transaction_Transfert (N_Client_Emetteur, N_Client_Recepteur, N_Agent, Montant) 
VALUES (3, 1, 3, 100000.00);
-- Requête 1 : Volume total transféré par région
-- Utilise une jointure, GROUP BY et la fonction d'agrégation SUM()
SELECT r.Nom_Region, SUM(t.Montant) AS Volume_Total
FROM Transaction_Transfert t
JOIN Agent_Local a ON t.N_Agent = a.N_Agent
JOIN Region r ON a.N_Region = r.N_Region
GROUP BY r.Nom_Region;

-- Requête 2 : Liste détaillée des transactions avec les noms (Jointures multiples)
SELECT 
    t.N_Transaction,
    e.Prenom AS Prenom_Emetteur, e.Nom AS Nom_Emetteur,
    r.Prenom AS Prenom_Recepteur, r.Nom AS Nom_Recepteur,
    t.Montant,
    t.Date_Transaction
FROM Transaction_Transfert t
JOIN Client e ON t.N_Client_Emetteur = e.N_Client
JOIN Client r ON t.N_Client_Recepteur = r.N_Client;

-- Requête 3 : Clients ayant envoyé de l'argent MAIS n'en ayant jamais reçu (Opérateur ensembliste)
SELECT N_Client_Emetteur AS N_Client FROM Transaction_Transfert
EXCEPT
SELECT N_Client_Recepteur FROM Transaction_Transfert;