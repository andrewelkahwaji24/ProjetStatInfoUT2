import sqlite3 , numpy as np , os , random, csv


#creation d'une base de donnée
#creation d'une connexion avec la base de donnees
def connecterdb(database="data.db"):
    connexion=sqlite3.connect(database)
    curs=connexion.cursor()
    return connexion, curs

#Creation des Tables
#Creation de la Table Incendies
def creer_table_incendies():
    connexion, curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS incendies(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            commune TEXT NOT NULL,
            code_INSEE TEXT NOT NULL,
            surface_parcourue_m2 INTEGER NOT NULL,
            annee INTEGER NOT NULL,
            mois TEXT NOT NULL,
            jour INTEGER NOT NULL,
            heure INTEGER NOT NULL,
            nature_inc_prim TEXT NOT NULL,
            nature_inc_sec TEXT NOT NULL
        )
        '''
    )
    # Confirme la création
    connexion.commit()
    # Fermer le curseur et la connexion
    curs.close()
    connexion.close()

#Creation de la Table de Donees Meteo
def creer_table_donnees_meteo():
    connexion, curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS donnees_meteo(
            code_INSEE TEXT PRIMARY KEY,
            RR_med REAL NOT NULL,
            NBJRR1_med REAL NOT NULL,
            NBJRR5_med REAL NOT NULL,
            NBJRR10_med REAL NOT NULL,
            Tmin_med REAL NOT NULL,
            Tmax_med REAL NOT NULL,
            Tens_vap_med REAL NOT NULL,
            Force_vent_med REAL NOT NULL,
            Insolation_med REAL NOT NULL,
            Rayonnement_med REAL NOT NULL
        )
        '''
    )
    connexion.commit()
    curs.close()
    connexion.close()

#Creation de la Table Donnees Geo
def creer_table_donnees_geo():
    connexion, curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS donnees_geo(
            code_INSEE TEXT PRIMARY KEY,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            altitude_med REAL NOT NULL 
        )
        '''
    )
    connexion.commit()
    curs.close()
    connexion.close()

#Phase d'injection des donees
#Injection des donees dans la Table Incendies
def injecter_donnees_incendies():
    connexion, curs = connecterdb()
    fichier="Data/donnees_incendies.csv"
    try:
        with open(fichier, 'r') as csvfile:
            reader=csv.DictReader(csvfile)
            for row in reader:
                curs.execute(
                    '''
                    INSERT INTO incendies (
                        commune, code_INSEE, surface_parcourue_m2, 
                        annee, mois, jour, heure, 
                        nature_inc_prim, nature_inc_sec
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ''',
                    (
                        row['commune'],
                        row['code_INSEE'],
                        int(row['surface_parcourue_m2']),
                        int(row['annee']),
                        row['mois'],
                        int(row['jour']),
                        int(row['heure']),
                        row['nature_inc_prim'],
                        row['nature_inc_sec']
                    )
                )
        connexion.commit()
        curs.close()
        connexion.close()
        print("Les donnees ont etes importes avec succees")
    except:
        raise ValueError("Erreur lors de l'importation des données.")

#Injection des donees dans la Table Geo
def injecter_donnees_geo():
    connexion, curs = connecterdb()
    fichier = "Data/donnees_geo.csv"
    try:
        with open(fichier, 'r') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                curs.execute(
                    '''
                    INSERT INTO donnees_geo (
                        code_INSEE, latitude, longitude, altitude_med
                    ) VALUES (?, ?, ?, ?)
                    ''',
                    (
                        row['code_INSEE'],
                        float(row['latitude']),
                        float(row['longitude']),
                        float(row['altitude_med'])
                    )
                )
        connexion.commit()
        curs.close()
        connexion.close()
        print("Les données géographiques ont été importées avec succès.")
    except:
        raise ValueError("Erreur lors de l'importation des données.")


#Injection dans la table Meteo
def injecter_donnees_meteo():
    connexion, curs = connecterdb()
    fichier = "Data/donnees_meteo.csv"

    try:
        with open(fichier, 'r') as csvfile:
            reader = csv.DictReader(csvfile)

            for row in reader:
                # Conversion des valeurs : remplacer 'NA' par 0.0, sinon convertir en float
                def convertir(valeur):
                    return 0.0 if valeur == 'NA' else float(valeur)

                curs.execute(
                    '''
                    INSERT INTO donnees_meteo (
                        code_INSEE, RR_med, NBJRR1_med, NBJRR5_med, NBJRR10_med,
                        Tmin_med, Tmax_med, Tens_vap_med, Force_vent_med,
                        Insolation_med, Rayonnement_med
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ''',
                    (
                        row['Code.INSEE'],
                        convertir(row['RR_med']),
                        convertir(row['NBJRR1_med']),
                        convertir(row['NBJRR5_med']),
                        convertir(row['NBJRR10_med']),
                        convertir(row['Tmin_med']),
                        convertir(row['Tmax_med']),
                        convertir(row['Tens_vap_med']),
                        convertir(row['Force_vent_med']),
                        convertir(row['Insolation_med']),
                        convertir(row['Rayonnement_med'])
                    )
                )

        connexion.commit()
        curs.close()
        connexion.close()
        print("Les données météo ont été importées avec succès.")

    except Exception as e:
        raise ValueError("Erreur lors de l'importation des données.")

#Affichage des donees de la table Incendies
def afficher_donnees_incendies():
    connexion, curs = connecterdb()

    curs.execute("SELECT * FROM incendies")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Affichage des donees de la table Geo
def afficher_donnees_geo():
    connexion, curs = connecterdb()

    curs.execute("SELECT * FROM donnees_geo")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Affichage des donees de la Table Meteo
def afficher_donnees_meteo():
    connexion, curs = connecterdb()

    curs.execute("SELECT * FROM donnees_meteo")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Menu de notre Programme
def menu():
    print("Bienvenue dans le Menu du Programme du Projet Stat Info")
    print("Veuillez choisir une des options suivantes selon votre besoin")
    print("1. Créer les tables")
    print("2. Injecter des données dans les tables")
    print("3. Afficher des donnees d'une table")

    choix = input("Entrez le numero de choix que vous voulez choisir: ")

    if choix == "1":
        print('Bienvenue dans le Module de Creation des tables')
        print('1. Creer table incendies')
        print('2. Creer table donnees meteo')
        print('3. Creer table donnees geo')

        choix1 = int(input("Entrez le numero de choix pour la table que vous voulez creer : "))

        if choix1 == 1:
            creer_table_incendies()
        elif choix1 == 2:
            creer_table_donnees_meteo()
        elif choix1 == 3:
            creer_table_donnees_geo()
        else:
            print("Le numero choisi est invalide ou n'existe pas")

    elif choix == "2":
        print("Bienvenue dans le Module de l'injection des tables avec des donnees")
        print('1. Injecter des donnees dans la table incendies')
        print('2. Injecter des donnees dans la table meteo')
        print('3. Injecter des donnees dans la table geo')

        choix2 = int(input("Veuillez choisir une option: "))

        if choix2 == 1:
            print("Injection des données dans la table incendies")
            injecter_donnees_incendies()
        elif choix2 == 2:
            print("Injection des données dans la table meteo")
            injecter_donnees_meteo()
        elif choix2 == 3:
            print("Injection des données dans la table geo")
            injecter_donnees_geo()
        else:
            print("Le numero choisi est invalide ou n'existe pas")

    elif choix=="3":
        print("Bienvenue dans le module de l'affichage des tables")
        print('1. Afficher les doneees de la table Incendies')
        print('2. Afficher les donnees de la table Meteo')
        print('3. Afficher les donnees de la table Geo')
        choix3 = int(input("Veuillez choisir une option: "))
        if choix3 == 1:
            print("Afficher les donnees de la table Incendies")
            afficher_donnees_incendies()
        elif choix3 == 2:
            print("Afficher les donnees de la table Meteo")
            afficher_donnees_meteo()
        elif choix3 == 3:
            print("Afficher les donnees de la table Geo")
            afficher_donnees_geo()
        else:
            print("Le numero choisi est invalide ou n'existe pas")
    else:
        print("Le numero choisi est invalide ou n'existe pas")


# Appel de la fonction menu
menu()
