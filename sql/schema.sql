CREATE DATABASE `bts-sio-it-manager`;

CREATE TABLE Sites_geographiques (
    code_site VARCHAR(50) PRIMARY KEY,
    nom_site VARCHAR(50) NOT NULL,
    ville VARCHAR(50) NOT NULL,
    adresse VARCHAR(50) NOT NULL
);

CREATE TABLE Services (
    code_service VARCHAR(50) PRIMARY KEY,
    nom_service VARCHAR(50) NOT NULL,
    budget_annuel VARCHAR(50)
);

CREATE TABLE Catégorie (
    id_categorie VARCHAR(50) PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL,
    duree_amortissement_ans VARCHAR(50)
);

CREATE TABLE Fournisseur (
    id_fournisseur VARCHAR(50) PRIMARY KEY,
    raison_sociale VARCHAR(50) NOT NULL,
    contact_email VARCHAR(50),
    telephone VARCHAR(50),
    delai_livraison_jours VARCHAR(50)
);

CREATE TABLE LOGICIEL (
    id_logiciel VARCHAR(50) PRIMARY KEY,
    nom_logiciel VARCHAR(50) NOT NULL,
    editeur VARCHAR(50),
    version VARCHAR(50),
    type_licence VARCHAR(50)
);

CREATE TABLE Collaborateur (
    matricule VARCHAR(50) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prénom VARCHAR(50) NOT NULL,
    email_pro VARCHAR(50),
    num_tel VARCHAR(50),
    date_embauche DATE,
    code_service VARCHAR(50),
    code_site VARCHAR(50),
    CONSTRAINT fk_collaborateur_service FOREIGN KEY (code_service) REFERENCES Services(code_service),
    CONSTRAINT fk_collaborateur_site FOREIGN KEY (code_site) REFERENCES Sites_geographiques(code_site)
);

CREATE TABLE MATERIEL (
    num_serie VARCHAR(50) PRIMARY KEY,
    marque VARCHAR(50),
    modele VARCHAR(50),
    date_achat DATE,
    prix_achat VARCHAR(50),
    date_fin_garantie DATE,
    état VARCHAR(50),
    id_fournisseur VARCHAR(50),
    id_categorie VARCHAR(50),
    CONSTRAINT fk_materiel_fournisseur FOREIGN KEY (id_fournisseur) REFERENCES Fournisseur(id_fournisseur),
    CONSTRAINT fk_materiel_categorie FOREIGN KEY (id_categorie) REFERENCES Catégorie(id_categorie)
);

CREATE TABLE TICKET (
    num_ticket VARCHAR(50) PRIMARY KEY,
    date_ouverture DATE NOT NULL,
    description_panne VARCHAR(500),
    niveau_urgence VARCHAR(50),
    statut VARCHAR(50),
    date_cloture DATE,
    num_serie VARCHAR(50),
    matricule VARCHAR(50),
    CONSTRAINT fk_ticket_materiel FOREIGN KEY (num_serie) REFERENCES MATERIEL(num_serie),
    CONSTRAINT fk_ticket_collaborateur FOREIGN KEY (matricule) REFERENCES Collaborateur(matricule)
);

CREATE TABLE attribuer (
    matricule VARCHAR(50),
    num_serie VARCHAR(50),
    date_attribution DATE,
    etat VARCHAR(50),
    date_rendu DATE,
    PRIMARY KEY (matricule, num_serie),
    CONSTRAINT fk_attribuer_collaborateur FOREIGN KEY (matricule) REFERENCES Collaborateur(matricule),
    CONSTRAINT fk_attribuer_materiel FOREIGN KEY (num_serie) REFERENCES MATERIEL(num_serie)
);

CREATE TABLE installer (
    num_serie VARCHAR(50),
    id_logiciel VARCHAR(50),
    date_installation DATE,
    licence VARCHAR(50),
    PRIMARY KEY (num_serie, id_logiciel),
    CONSTRAINT fk_installer_materiel FOREIGN KEY (num_serie) REFERENCES MATERIEL(num_serie),
    CONSTRAINT fk_installer_logiciel FOREIGN KEY (id_logiciel) REFERENCES LOGICIEL(id_logiciel)
);