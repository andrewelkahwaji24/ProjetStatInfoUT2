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
    print("La Table des Icendies a ete creer avec succees")

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
    print("La Table donnees meteo creer avec succees")

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
    print("La Table donnees geo creer avec succees")

# Création de la table Departements - WAEL TASK
def creer_table_Departements():
    connexion, curs = connecterdb()
    curs.execute("""
    CREATE TABLE IF NOT EXISTS Departements (
        Departement_nom TEXT PRIMARY KEY,
        Code_Insee INTEGER NOT NULL UNIQUE
    )
    """)
    connexion.commit()
    curs.close()
    connexion.close()
    print("La Table Departements creer avec succees")


#Creation de la Table Incendies_Departements HANS and Andrew TASK

def creer_table_incendiesdepartements():
    connexion , curs = connecterdb()
    curs.execute(
        """
        CREATE TABLE IF NOT EXISTS Incendies_Departements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        numero_departement TEXT NOT NULL,
        nom_departement TEXT NOT NULL,
        nombre_incident INTEGER NOT NULL
        )
        """
    )
    connexion.commit()
    curs.close()
    connexion.close()
    print("La Table Incendies Departements a ete creer avec succees")


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
 
#Injection des donees dans la Table Departements WAEL TASK

def injection_table_departements():
    # Liste des départements et leurs codes INSEE
    donnees = [
        ("Ain", 1),
        ("Aisne", 2),
        ("Allier", 3),
        ("Alpes-de-Haute-Provence", 4),
        ("Hautes-Alpes", 5),
        ("Alpes-Maritimes", 6),
        ("Ardèche", 7),
        ("Ardennes", 8),
        ("Ariège", 9),
        ("Aube", 10),
        ("Aude", 11),
        ("Aveyron", 12),
        ("Bouches-du-Rhône", 13),
        ("Calvados", 14),
        ("Cantal", 15),
        ("Charente", 16),
        ("Charente-Maritime", 17),
        ("Cher", 18),
        ("Corrèze", 19),
        ("Côte-d'Or", 21),
        ("Côtes-d'Armor", 22),
        ("Creuse", 23),
        ("Dordogne", 24),
        ("Doubs", 25),
        ("Drôme", 26),
        ("Eure", 27),
        ("Eure-et-Loir", 28),
        ("Finistère", 29),
        ("Gard", 30),
        ("Haute-Garonne", 31),
        ("Gers", 32),
        ("Gironde", 33),
        ("Hérault", 34),
        ("Ille-et-Vilaine", 35),
        ("Indre", 36),
        ("Indre-et-Loire", 37),
        ("Isère", 38),
        ("Jura", 39),
        ("Landes", 40),
        ("Loir-et-Cher", 41),
        ("Loire", 42),
        ("Haute-Loire", 43),
        ("Loire-Atlantique", 44),
        ("Loiret", 45),
        ("Lot", 46),
        ("Lot-et-Garonne", 47),
        ("Lozère", 48),
        ("Maine-et-Loire", 49),
        ("Manche", 50),
        ("Marne", 51),
        ("Haute-Marne", 52),
        ("Mayenne", 53),
        ("Meurthe-et-Moselle", 54),
        ("Meuse", 55),
        ("Morbihan", 56),
        ("Moselle", 57),
        ("Nièvre", 58),
        ("Nord", 59),
        ("Oise", 60),
        ("Orne", 61),
        ("Pas-de-Calais", 62),
        ("Puy-de-Dôme", 63),
        ("Pyrénées-Atlantiques", 64),
        ("Hautes-Pyrénées", 65),
        ("Pyrénées-Orientales", 66),
        ("Bas-Rhin", 67),
        ("Haut-Rhin", 68),
        ("Rhône", 69),
        ("Haute-Saône", 70),
        ("Saône-et-Loire", 71),
        ("Sarthe", 72),
        ("Savoie", 73),
        ("Haute-Savoie", 74),
        ("Paris", 75),
        ("Seine-Maritime", 76),
        ("Seine-et-Marne", 77),
        ("Yvelines", 78),
        ("Deux-Sèvres", 79),
        ("Somme", 80),
        ("Tarn", 81),
        ("Tarn-et-Garonne", 82),
        ("Var", 83),
        ("Vaucluse", 84),
        ("Vendée", 85),
        ("Vienne", 86),
        ("Haute-Vienne", 87),
        ("Vosges", 88),
        ("Yonne", 89),
        ("Territoire de Belfort", 90),
        ("Essonne", 91),
        ("Hauts-de-Seine", 92),
        ("Seine-Saint-Denis", 93),
        ("Val-de-Marne", 94),
        ("Val-d'Oise", 95),
        ("Guadeloupe", 971),
        ("Martinique", 972),
        ("Guyane", 973),
        ("La Réunion", 974),
        ("Mayotte", 976)
    ]

    try:
        # Se connecter à la base de données
        connexion, curs = connecterdb()

        # Exécuter l'insertion des données dans la table
        curs.executemany(
            "INSERT INTO Departements (Departement_nom, Code_Insee) VALUES (?, ?);",
            donnees
        )

        # Valider la transaction
        connexion.commit()

        # Fermer la connexion
        curs.close()
        connexion.close()

        print("Les données des départements ont été insérées avec succès.")

    except Exception:
        # En cas d'erreur, afficher le message et annuler la transaction
        print("Erreur lors de l'insertion des données des départements :")


#Injection des donees dans la table Incendies_Departements HANS and Andrew TASK
def injection_table_incendies_departements():
    connexion, curs = connecterdb()

    curs.execute("""
        INSERT INTO Incendies_Departements (numero_departement, nom_departement, nombre_incident)
        SELECT 
            SUBSTR(i.code_INSEE, 1, 2) AS numero_departement,
            d.Departement_nom,
            COUNT(*) AS nombre_incident
        FROM incendies i
        INNER JOIN Departements d ON SUBSTR(i.code_INSEE, 1, 2) = CAST(d.Code_Insee AS TEXT)
        GROUP BY numero_departement
    """)

    connexion.commit()
    curs.close()
    connexion.close()
    print("Les données des incendies par département ont été insérées avec succès.")


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

#Affiche des doneees dans la Table Departements

def afficher_donees_Departements():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM Departements")
    lignes=curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

def afficher_doneees_IncendiesDep():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM Incendies_Departements")
    lignes=curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()


#Phase d'exportation des doneees en CSV Comma Separated Values

#Exportation des donees de la Table Incendies
def export_doneees_incendies(fichier_output="Exports/export_incendies.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM incendies")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Incendies ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite")
    except Exception as e:
        print("Erreur lors de l'exportation des données")

#Exportation des doneees de la Table Meteo
def export_doneees_meteo(fichier_output="Exports/export_meteo.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM donnees_meteo")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Meteo ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite")
    except Exception as e:
        print("Erreur lors de l'exportation des données")

#Exportation des donnees de la Table Geo
def export_doneees_geo(fichier_output="Exports/export_geo.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM donnees_geo")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Geo ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite")
    except Exception as e:
        print("Erreur lors de l'exportation des données")

#Exportarion des donnees de la Table Departements
def export_doneees_departements(fichier_output="Exports/export_departements.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM Departements")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Departements ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite")
    except Exception as e:
        print("Erreur lors de l'exportation des données")

#Exportation des donees de la Table Incendies_Departements
def export_doneees_incendies_dep(fichier_output="Exports/export_Incendies_Departements.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM Incendies_Departements")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Incedies Departements ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite")
    except Exception as e:
        print("Erreur lors de l'exportation des données")
#Menu de notre Programme
def menu():
    while True:
        print("🔹Bienvenue dans le Menu du Programme du Projet Stat Info🔹")
        print("Veuillez choisir une des options suivantes selon votre besoin")
        print("1. 📌 Créer les tables")
        print("2. 📥 Injecter des données dans les tables")
        print("3. 📊 Afficher des donnees d'une table")
        print("4. 📦Exporter des doneees d'une table")
        print("5. ❌ Quiter le Menu")

        choix = input("Entrez le numero de choix que vous voulez choisir: ")

        if choix == "1":
            print('🔹 Bienvenue dans le Module de Creation des tables🔹')
            print('1. 📌 Creer table incendies')
            print('2. 📌 Creer table donnees meteo')
            print('3. 📌 Creer table donnees geo')
            print('4. 📌 Creer Table Departements')
            print('5. 📌 Creer Table Incendies_Departements')

            choix1 = int(input("Entrez le numero de choix pour la table que vous voulez creer : "))

            if choix1 == 1:
                print("📌 Creation de la Table Incendies")
                creer_table_incendies()
                print("La Creation de la Table Incendies a ete creer avec succees ✅")
            elif choix1 == 2:
                print("📌 Creation de la Table Meteo")
                creer_table_donnees_meteo()
                print("La Creation de la Table Meteos a ete creer avec succees ✅")
            elif choix1 == 3:
                print("📌 Creation de la Table Geo")
                creer_table_donnees_geo()
                print("La Creation de la Table Geos a ete creer avec succees ✅")
            elif choix1 == 4:
                print("📌 Creation de la Table Departements")
                creer_table_Departements()
                print("La Creation de la Table Departements a ete creer avec succees ✅")
            elif choix1 == 5:
                print("📌 Creation de la Table Incendies_Departements")
                creer_table_incendiesdepartements()
                print("La Creation de la Table Incendies_Departements a ete creer avec succees ✅")
            else:
                print("⚠️ Le numero choisi est invalide ou n'existe pas ⚠️")

        elif choix == "2":
            print("🔹Bienvenue dans le Module de l'injection des tables avec des donnees🔹")
            print('1. 📥 Injecter des donnees dans la table incendies')
            print('2. 📥 Injecter des donnees dans la table meteo')
            print('3. 📥 Injecter des donnees dans la table geo')
            print('4. 📥 Injection des donees dans la Table Departements')
            print('5. 📥 Injection des donees dans la Table Incendies_Departements')

            choix2 = int(input("Veuillez choisir une option: "))

            if choix2 == 1:
                print("📥 Injection des données dans la table incendies")
                injecter_donnees_incendies()
                print("Injection effectue avec succees dans la Table Incendies ✅")
            elif choix2 == 2:
                print("📥 Injection des données dans la table meteo")
                injecter_donnees_meteo()
                print("Injection effectue avec succees dans la Table Meteos ✅")
            elif choix2 == 3:
                print("📥 Injection des données dans la table geo")
                injecter_donnees_geo()
                print("Injection effectue avec succees dans la Table Geo ✅")
            elif choix2 == 4:
                print("📥 Injection des donees dans la Table Departements")
                injection_table_departements()
                print("Injection effectue avec succees dans la Table Departements ✅")
            elif choix2==5:
                print("📥 Injection des donnes dans la Table Incendies_Departements")
                injection_table_incendies_departements()
                print("Injection effectue avec succees dans la Table Incendies_Departements ✅")
            else:
                print("⚠️Le numero choisi est invalide ou n'existe pas⚠️")

        elif choix=="3":
            print("Bienvenue dans le module de l'affichage des tables")
            print('1. 📊 Afficher les doneees de la table Incendies')
            print('2. 📊 Afficher les donnees de la table Meteo')
            print('3. 📊 Afficher les donnees de la table Geo')
            print('4. 📊 Afficher les donnees de la table Departements')
            print('5. 📊 Afficher les donnees de la Table Incendies_Departements qui fait une analyse pour identifier chaque Departement combien est le nombre dincendies de chaque Dep ')
            choix3 = int(input("Veuillez choisir une option: "))
            if choix3 == 1:
                print("📊 Afficher les donnees de la table Incendies")
                afficher_donnees_incendies()
                print("Affichage de la Table Incendies completes avec succees ✅")
            elif choix3 == 2:
                print("📊 Afficher les donnees de la table Meteo")
                afficher_donnees_meteo()
                print("Affichage de la Table Meteo completes avec succees ✅")
            elif choix3 == 3:
                print("📊 Afficher les donnees de la table Geo")
                afficher_donnees_geo()
                print("Affichage de la Table Geo completes avec succees ✅")
            elif choix3== 4:
                print('📊 Afficher les doneees de la Table Departements')
                afficher_donees_Departements()
                print("Affichage de la Table Departements completes avec succees ✅")
            elif choix3==5:
                print('📊 Afficher les donnees de la Table Incidenes_Departements')
                afficher_doneees_IncendiesDep()
                print("Affichage de la Table Incendies_Departements completes avec succees ✅")
            else:
                print("⚠️Le numero choisi est invalide ou n'existe pas⚠️")
        elif choix == "4":
            print("Bienvenue dans le module de l'exportation des donees d'une table")
            print("1. 📦 Exporter les donees de la Table Incendies")
            print("2. 📦 Exporter les donees de la Table Meteo")
            print("3. 📦 Exporter les donees de la Table Geo")
            print("4. 📦 Exporter les donees de la Table Departements")
            print("5. 📦 Exporter les donees de la Table Incendies_Departements")
            choix4 = int(input("Veuillez choisir une option"))
            if choix4 == 1:
                print("La procedure de l'exportation des donees pour la Table Incendies a commencee")
                export_doneees_incendies()
            elif choix4 == 2:
                print("La procedure de l'exportation des donees pour la Table Meteo a commencee")
                export_doneees_meteo()
            elif choix4 == 3:
                print("La procedure de l'exportation des donees pour la Table Geo a commencee")
                export_doneees_geo()
            elif choix4 == 4:
                print("La procedure de l'exportation des donees pour la Table Departements a commencee")
                export_doneees_departements()
            elif choix4 == 5:
                print("La procedure de l'exportation des donees pour la Table Incendies_Departements a commencee")
                export_doneees_incendies_dep()
            else:
                print("⚠️Le numero choisi est invalide ou n'existe pas⚠️")

        elif choix=="5":
            confirmation = input("❓Etes vous sur de vouloir quiiter le menu du Projet Stat Info?")
            if confirmation == "o" or confirmation == "ok" or confirmation == "yes" or confirmation == "Oui" or confirmation == "si" or confirmation == "oui":
                print("👋 Merci d'avoir d'utilise le programme A bientot!")
                break
            else:
                print("✅ Retour au menu...")
        else:
            print("⚠️Le numero choisi est invalide ou n'existe pas⚠️")


# Appel de la fonction menu
menu()
