import sqlite3, numpy as np, os, random, csv


# creation d'une base de donnée
# creation d'une connexion avec la base de donnees
def connecterdb(database="data.db"):
    connexion = sqlite3.connect(database)
    curs = connexion.cursor()
    return connexion, curs


# Phase de Creation des Tables

# Creation de la Table Incendies
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


# Creation de la Table de Donees Meteo
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


# Creation de la Table Donnees Geo
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


# Creation de la Table Incendies_Departements

def creer_table_incendiesdepartements():
    connexion, curs = connecterdb()
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


# Creation de la Table Incendies 2023

def creer_table_incendies2023():
    connexion, curs = connecterdb()
    curs.execute(
        """
        CREATE TABLE Incendies2023 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            annee INTEGER NOT NULL,
            numero_departement TEXT NOT NULL,
            code_insee TEXT NOT NULL,
            nom_commune TEXT NOT NULL,
            date_premiere_alerte TEXT NOT NULL,
            surface_parcourue REAL NOT NULL,
            surface_foret REAL NOT NULL,
            surface_maquis_garrigues REAL NOT NULL,
            autres_surfaces_naturelles_hors_foret REAL NOT NULL,
            surfaces_agricoles REAL NOT NULL,
            autres_surfaces REAL NOT NULL,
            surface_autres_terres_boisées REAL NOT NULL,
            surfaces_non_boisées_naturelles REAL NOT NULL,
            surfaces_non_boisées_artificialisées REAL NOT NULL,
            surfaces_non_boisées REAL NOT NULL,
            precision_surfaces TEXT NOT NULL,
            type_peuplement TEXT NOT NULL,
            nature TEXT NOT NULL,
            deces_ou_batiments_touchés TEXT NOT NULL,
            nombre_deces INTEGER NOT NULL,
            nombre_batiments_totalement_détruits INTEGER NOT NULL,
            nombre_batiments_partiellement_détruits INTEGER NOT NULL,
            precision_donnee TEXT NOT NULL
        )
        """
    )
    connexion.commit()
    curs.close()
    connexion.close()
    print("La Table Incendies2023 a été créée avec succès.")

#  Creation de la Table Humidites Incendies

def create_table_humidites():
    connexion , curs = connecterdb()
    curs.execute(
        """
        CREATE TABLE humidites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,   
        code_INSEE TEXT NOT NULL,               
        surface_parcourue_m2 REAL NOT NULL,     
        Tens_vap_med REAL NOT NULL              
        )
        """
    )
    connexion.commit()
    curs.close()
    connexion.close()
    print("La Table humidites a été créée avec succès.")

# Creation de la Table Vent
def create_table_vents():
    connexion , curs = connecterdb()
    curs.execute(
        """
        CREATE TABLE vents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,   
        code_INSEE TEXT NOT NULL,               
        surface_parcourue_m2 REAL NOT NULL,     
        Force_vent_med REAL NOT NULL              
        )
        """
    )
    connexion.commit()
    curs.close()
    connexion.close()
    print("La Table Vent a été créée avec succès.")

#Creation de la Table Incendies-Regions

def create_table_incendiesregions():
    connexion, curs = connecterdb()  # Connexion à la base de données
    curs.execute(
        """
        CREATE TABLE incendiesregions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,       
        code_INSEE TEXT NOT NULL,                    
        surface_parcourue_m2 REAL NOT NULL,         
        annee INTEGER NOT NULL,                     
        mois INTEGER NOT NULL,                      
        jour INTEGER NOT NULL,                      
        heure INTEGER NOT NULL,                     
        nature_inc_prim TEXT NOT NULL,              
        nature_inc_sec TEXT,                        
        altitude_med REAL,                         -- Ajout de la colonne altitude_med
        altitude_zone TEXT NOT NULL                 -- Ajout de la colonne altitude_zone
        )
        """
    )
    connexion.commit()  # Sauvegarde de la table créée
    curs.close()  # Fermeture du curseur
    connexion.close()  # Fermeture de la connexion
    print("La table incendiesregions a été créée avec succès.")


# Creation la Table Incendies_temp_heure
def create_table_incendies_temp_heure():
    connexion, curs = connecterdb()  # Connexion à la base de données
    curs.execute(
        """
        CREATE TABLE incendies_temp_heure (
        id INTEGER PRIMARY KEY AUTOINCREMENT,       
        code_INSEE TEXT NOT NULL,                    
        annee INTEGER NOT NULL,                     
        mois INTEGER NOT NULL,                      
        jour INTEGER NOT NULL,                      
        heure INTEGER NOT NULL,                     
        nb_incendies INTEGER NOT NULL,              
        tmax_med REAL NOT NULL
        )
        """
    )
    connexion.commit()  # Sauvegarde de la table créée
    curs.close()  # Fermeture du curseur
    connexion.close()  # Fermeture de la connexion
    print("La table incendies_temp_heure a été créée avec succès.")

# Creation de la Table Impact Pression Vapeur

def creer_table_impact_pression_vapeur():
    connexion, curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS impact_pression_vapeur(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code_INSEE TEXT NOT NULL,
            tens_vap_med REAL NOT NULL,
            surface_parcourue_m2 INTEGER NOT NULL
        )
        '''
    )
    # Confirme la création
    connexion.commit()
    # Fermer le curseur et la connexion
    curs.close()
    connexion.close()
    print("La table impact_pression_vapeur a été créée avec succès")

#Creation de la Table Impact Climat Urbanisation

def creer_table_impact_climat_urbanisation():
    connexion, curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS impact_climat_urbanisation(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code_INSEE TEXT NOT NULL,
            nature_sec_inc TEXT NOT NULL,
            rr_med REAL NOT NULL
        )
        '''
    )
    # Confirme la création
    connexion.commit()
    # Fermer le curseur et la connexion
    curs.close()
    connexion.close()
    print("La table impact_climat_urbanisation a été créée avec succès")

#Creation de la Tables Incendies-Crim

def creer_table_incendies_criminels():
    connexion , curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS incendies_criminels(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code_INSEE TEXT NOT NULL,
            nature_inc_prim TEXT NOT NULL,
            tmax_med REAL NOT NULL 
        )
        '''
    )
    connexion.commit()
    curs.close()
    connexion.close()
    print("La table impact_climat_urbanisation a été créée avec succès")

#Creation de la Table Incendies Meteo

def creer_table_incendies_meteo():
    connexion, curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS incendies_meteo(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code_INSEE TEXT NOT NULL,
            commune TEXT NOT NULL,
            surface_parcourue_m2 INTEGER NOT NULL,
            annee INTEGER NOT NULL,
            mois TEXT NOT NULL,
            jour INTEGER NOT NULL,
            heure INTEGER NOT NULL,
            nature_inc_prim TEXT NOT NULL,
            nature_inc_sec TEXT NOT NULL,
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
    print("La Table incendies_meteo a été créée avec succès.")


# Phase d'injection des donees (insertion des donnees)

# Injection des donees dans la Table Incendies
def injecter_donnees_incendies():
    connexion, curs = connecterdb()
    fichier = "Data/donnees_incendies.csv"
    try:
        with open(fichier, 'r') as csvfile:
            reader = csv.DictReader(csvfile)
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


# Injection des donees dans la Table Geo
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


# Injection dans la table Meteo
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


# Injection des donees dans la Table Departements WAEL TASK

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


# Injection des donees dans la table Incendies_Departements HANS and Andrew TASK
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

#Injections des donnees dans la Table Incendies 2023
def injecter_donnees_incendies_2023():
    connexion, curs = connecterdb()
    fichier = "Data/incendies_2023.csv"  # Remplacez par le chemin réel de votre fichier CSV
    try:
        with open(fichier, 'r', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                curs.execute(
                    '''
                    INSERT INTO Incendies_Departements2023 (
                        annee, numero_departement, code_insee, nom_commune, date_premiere_alerte, surface_parcourue,
                        surface_foret, surface_maquis_garrigues, autres_surfaces_naturelles_hors_foret, surfaces_agricoles,
                        autres_surfaces, surface_autres_terres_boisées, surfaces_non_boisées_naturelles,
                        surfaces_non_boisées_artificialisées, surfaces_non_boisées, precision_surfaces, type_peuplement,
                        nature, deces_ou_batiments_touchés, nombre_deces, nombre_batiments_totalement_détruits,
                        nombre_batiments_partiellement_détruits, precision_donnee
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ''',
                    (
                        int(row['annee']),
                        row['numero_departement'],
                        row['code_insee'],
                        row['nom_commune'],
                        row['date_premiere_alerte'],
                        float(row['surface_parcourue']),
                        float(row['surface_foret']),
                        float(row['surface_maquis_garrigues']),
                        float(row['autres_surfaces_naturelles_hors_foret']),
                        float(row['surfaces_agricoles']),
                        float(row['autres_surfaces']),
                        float(row['surface_autres_terres_boisées']),
                        float(row['surfaces_non_boisées_naturelles']),
                        float(row['surfaces_non_boisées_artificialisées']),
                        float(row['surfaces_non_boisées']),
                        row['precision_surfaces'],
                        row['type_peuplement'],
                        row['nature'],
                        row['deces_ou_batiments_touchés'],
                        int(row['nombre_deces']),
                        int(row['nombre_batiments_totalement_détruits']),
                        int(row['nombre_batiments_partiellement_détruits']),
                        row['precision_donnee']
                    )
                )
        connexion.commit()
        curs.close()
        connexion.close()
        print("Les données des incendies 2023 ont été importées avec succès.")
    except Exception as e:
        print(f"Erreur lors de l'importation des données : {e}")

# Injection des donneees dans la Table Humidites

def injecter_donnees_humidites():
    # Connexion à la base de données
    connexion, curs = connecterdb()

    try:
        # Faire un INNER JOIN entre les tables donnees_incendies et donnees_meteo
        curs.execute(
            """
            INSERT INTO humidites (code_INSEE, surface_parcourue_m2, Tens_vap_med)
            SELECT 
                i.code_INSEE, 
                i.surface_parcourue_m2, 
                m.Tens_vap_med
            FROM 
                incendies i
            INNER JOIN 
                donnees_meteo m 
            ON 
                i.code_INSEE = m.code_INSEE
            """
        )

        # Commit des changements dans la base de données
        connexion.commit()
        print("Les données ont été insérées avec succès.")

    except Exception as e:
        print(f"Une erreur s'est produite : {e}")
        raise ValueError("Erreur lors de l'importation des données.")

    finally:
        # Fermeture de la connexion et du curseur
        curs.close()
        connexion.close()

#Injection des donnees dans la Table Vents
def injecter_donnees_vents():
    # Connexion à la base de données
    connexion, curs = connecterdb()

    try:
        # Faire un INNER JOIN entre les tables donnees_incendies et donnees_meteo
        curs.execute(
            """
            INSERT INTO vents (code_INSEE, surface_parcourue_m2, Force_vent_med)
            SELECT 
                i.code_INSEE, 
                i.surface_parcourue_m2, 
                m.Force_vent_med
            FROM 
                incendies i
            INNER JOIN 
                donnees_meteo m 
            ON 
                i.code_INSEE = m.code_INSEE
            """
        )

        # Commit des changements dans la base de données
        connexion.commit()
        print("Les données ont été insérées avec succès.")

    except Exception as e:
        print(f"Une erreur s'est produite : {e}")
        raise ValueError("Erreur lors de l'importation des données.")

    finally:
        # Fermeture de la connexion et du curseur
        curs.close()
        connexion.close()

#Injection des doneees dans la Table Incendies-Regions
def injecter_donnees_incendiesregions():
    connexion, curs = connecterdb()  # Connexion à la base de données
    try:
        curs.execute(
            """
            INSERT INTO incendiesregions (code_INSEE, surface_parcourue_m2, annee, mois, jour, heure, nature_inc_prim, nature_inc_sec, altitude_med, altitude_zone)
            SELECT 
                i.code_INSEE, 
                i.surface_parcourue_m2, 
                i.annee, 
                i.mois, 
                i.jour, 
                i.heure, 
                i.nature_inc_prim, 
                i.nature_inc_sec, 
                g.altitude_med,      -- Récupère altitude_med de la table donnees_geo
                CASE 
                    WHEN g.altitude_med >= 1000 THEN 'Haute'   -- Classe les zones en fonction de l'altitude
                    ELSE 'Basse'
                END AS altitude_zone
            FROM 
                incendies i
            INNER JOIN 
                donnees_geo g
            ON 
                i.code_INSEE = g.code_INSEE
            """
        )
        connexion.commit()  # Sauvegarde des données
        print("Les données ont été insérées avec succès dans incendiesregions.")

    except Exception as e:
        print(f"Une erreur s'est produite : {e}")
        raise ValueError("Erreur lors de l'insertion des données d'altitude.")

    finally:
        curs.close()  # Fermeture du curseur
        connexion.close()  # Fermeture de la connexion


#Injection des doneees dans la Table Incendies temp heure
def injection_table_incendies_temp_heure():
    connexion, curs = connecterdb()

    curs.execute("""
        INSERT INTO incendies_temp_heure (code_INSEE, annee, mois, jour, heure, nb_incendies, tmax_med)
        SELECT 
            i.code_INSEE,
            i.annee,
            i.mois,
            i.jour,
            i.heure,
            COUNT(*) AS nb_incendies,
            m.Tmax_med
        FROM incendies i
        INNER JOIN donnees_meteo m 
            ON i.code_INSEE = m."Code_INSEE"
        GROUP BY 
            i.code_INSEE, i.annee, i.mois, i.jour, i.heure, m.Tmax_med
    """)

    connexion.commit()
    curs.close()
    connexion.close()
    print("Les données des incendies croisés avec la température ont été insérées avec succès.")


#Injection des donnees dans la table impact pression vapeur

def injection_table_impact_pression_vapeur():
    connexion, curs = connecterdb()

    curs.execute("""
        INSERT INTO impact_pression_vapeur (code_INSEE, tens_vap_med, surface_parcourue_m2)
        SELECT 
            i.code_INSEE,
            m.Tens_vap_med,
            i.surface_parcourue_m2
        FROM incendies i
        INNER JOIN donnees_meteo m 
            ON i.code_INSEE = m."Code_INSEE"
    """)

    connexion.commit()
    curs.close()
    connexion.close()
    print("Les données des incendies croisés avec la pression de vapeur ont été insérées avec succès.")

#Injection des donnees dans la Table Impact Climat Urbanisation
def injection_table_impact_climat_urbanisation():
    # Connexion à la base de données
    connexion, curs = connecterdb()

    # Exécution de la requête SQL pour insérer les données
    curs.execute("""
        INSERT INTO impact_climat_urbanisation (code_INSEE, nature_sec_inc, rr_med)
        SELECT 
            i.code_INSEE,
            i.nature_inc_sec,
            m.rr_med
        FROM incendies i
        INNER JOIN donnees_meteo m 
            ON i.code_INSEE = m."Code_INSEE"
    """)

    # Valider les changements
    connexion.commit()

    # Fermer le curseur et la connexion
    curs.close()
    connexion.close()

    print("Les données des incendies croisés avec les données climatiques ont été insérées avec succès.")

#Injection des donnees dans la Table Incendies_Criminels
def injection_table_inendies_criminels():
    # Connexion à la base de données
    connexion, curs = connecterdb()

    # Exécution de la requête SQL pour insérer les données
    curs.execute("""
        INSERT INTO incendies_criminels (code_INSEE, nature_inc_prim ,tmax_med )
        SELECT 
            i.code_INSEE,
            i.nature_inc_prim,
            m.Tmax_med
        FROM incendies i
        INNER JOIN donnees_meteo m 
            ON i.code_INSEE = m."Code_INSEE"
    """)
    # Valider les changements
    connexion.commit()

    # Fermer le curseur et la connexion
    curs.close()
    connexion.close()

    print("Les données des incendies croisés avec les données climatiques ont été insérées avec succès.")

#Injection des donnes dans la Table Incendies Meteo

def injection_table_incendies_meteo():
    # Connexion à la base de données
    connexion, curs = connecterdb()

    # Exécution de la requête SQL pour insérer les données fusionnées
    curs.execute("""
        INSERT INTO incendies_meteo (
            code_INSEE, commune, surface_parcourue_m2,
            annee, mois, jour, heure,
            nature_inc_prim, nature_inc_sec,
            RR_med, NBJRR1_med, NBJRR5_med, NBJRR10_med,
            Tmin_med, Tmax_med, Tens_vap_med,
            Force_vent_med, Insolation_med, Rayonnement_med
        )
        SELECT
            i.code_INSEE, i.commune, i.surface_parcourue_m2,
            i.annee, i.mois, i.jour, i.heure,
            i.nature_inc_prim, i.nature_inc_sec,
            m.RR_med, m.NBJRR1_med, m.NBJRR5_med, m.NBJRR10_med,
            m.Tmin_med, m.Tmax_med, m.Tens_vap_med,
            m.Force_vent_med, m.Insolation_med, m.Rayonnement_med
        FROM incendies i
        INNER JOIN donnees_meteo m ON i.code_INSEE = m.code_INSEE;
    """)

    # Valider les changements
    connexion.commit()

    # Fermer le curseur et la connexion
    curs.close()
    connexion.close()

    print("Les données des incendies fusionnées avec les données météorologiques ont été insérées avec succès.")

#Phase d'affichage des donnees
# Affichage des donees de la table Incendies
def afficher_donnees_incendies():
    connexion, curs = connecterdb()

    curs.execute("SELECT * FROM incendies")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()


# Affichage des donees de la table Geo
def afficher_donnees_geo():
    connexion, curs = connecterdb()

    curs.execute("SELECT * FROM donnees_geo")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()


# Affichage des donees de la Table Meteo
def afficher_donnees_meteo():
    connexion, curs = connecterdb()

    curs.execute("SELECT * FROM donnees_meteo")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()


# Affiche des doneees dans la Table Departements

def afficher_donees_Departements():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM Departements")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()


# Affiche des donnees dans la Table Incendies-Dep
def afficher_doneees_IncendiesDep():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM Incendies_Departements")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Afficher les donnees dans la Table Incendies2023

def afficher_doneees_incendies2023():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM Incendies2023")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

# Affiche les donnees dans la Table Humidites

def afficher_doneees_humidites():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM humidites")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

# Affiche les donnees dans la Table Vents

def afficher_doneees_vents():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM vents")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Affiche les donnees dans la Table Incendies-regions

def afficher_doneees_incendiesregions():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM incendiesregions")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()


# Affiche les donnees dans la Table Incendies-Temp-Heure

def afficher_doneees_incendies_tem_heure():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM incendies_tem_heure")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Affiche les donnees dans la Table Incendies-criminels
def afficher_doneees_incendies_criminels():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM incendies_criminels")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Affiche les donnees dans la Table Impact Climat Urbanisation
def afficher_doneees_impact_climat_urbanisation():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM impact_climat_urbanisation")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Affiche les donnees dans la Table Impact Pression Vapeur
def afficher_doneees_impact_pression_vapeur():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM impact_pression_vapeur")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Affiche les donnees dans la Table  Incendies_Geo

def afficher_doneees_incendies_geo():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM incendies_geo")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()

#Affiche les donnees dans la Table  Incendies_Meteo

def afficher_doneees_incendies_meteo():
    connexion, curs = connecterdb()
    curs.execute("SELECT * FROM incendies_meteo")
    lignes = curs.fetchall()

    for ligne in lignes:
        print(ligne)

    curs.close()
    connexion.close()


# Phase d'exportation des doneees en CSV Comma Separated Values

# Exportation des donees de la Table Incendies
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


# Exportation des doneees de la Table Meteo
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


# Exportation des donnees de la Table Geo
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


# Exportarion des donnees de la Table Departements
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


# Exportation des donees de la Table Incendies_Departements
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

# Exportation des donnees de la Table Humidites

def export_donnees_humidites(fichier_output="Exports/export_Humidites.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM humidites")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Humidites ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)

# Exportation de la Table Incendies2023

def export_donnees_incendies2023(fichier_output="Exports/export_Incendies2023.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM Incendies2023")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Incendies2023 ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)

#Exportation des donnees de la Table Vents

def export_donnees_vents(fichier_output="Exports/export_vents.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM vents")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Vents ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)

#Exportation de la Table Incendies Regions
def export_donnees_incendiesregions(fichier_output="Exports/export_incendiesregions.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM incendiesregions")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table IncendiesRegions ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)

#Exportation des donnees de la Tables Incendies Temp Heure

def export_donnees_incendies_temp_heure(fichier_output="Exports/export_incendiestempheure.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM incendies_temp_heure")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Incendies_temp_heure ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)

# Exportation des donnees de la table impact pression vapeur
def export_donnees_impact_pression_vapeure(fichier_output="Exports/export_impactvapeure.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM impact_pression_vapeur")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Impact Pression Vapeure ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)

#Exportation des donnees dans la Table Impact_climat_urbansiation

def export_donnees_impact_climat_urbanisation(fichier_output="Exports/export_impactclimaturbanisation.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM impact_climat_urbanisation")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Impact Climat Urbanisation ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)


def export_donnees_incendies_criminels(fichier_output="Exports/export_incendies_criminels.csv"):
    try:
        connexion, curs = connecterdb()
        curs.execute("SELECT * FROM incendies_criminels")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)
            csv_ecriture.writerows(lignes)

        curs.close()
        connexion.close()

        print("Les données de la Table Incendies Criminels ont été exportées avec succès")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)

#Exportation des donnes de la Table Incendies Meteo

import csv

def export_donnees_incendies_meteo(fichier_output="Exports/export_incendies_meteo.csv"):
    try:
        # Connexion à la base de données
        connexion, curs = connecterdb()

        # Exécution de la requête pour récupérer toutes les données de la table incendies_meteo
        curs.execute("SELECT * FROM incendies_meteo")
        lignes = curs.fetchall()
        colonnes = [description[0] for description in curs.description]

        # Écriture des données dans un fichier CSV
        with open(fichier_output, 'w', newline='', encoding='utf-8') as fichier:
            csv_ecriture = csv.writer(fichier)
            csv_ecriture.writerow(colonnes)  # Écrire les noms des colonnes
            csv_ecriture.writerows(lignes)   # Écrire les données

        # Fermer le curseur et la connexion
        curs.close()
        connexion.close()

        print("Les données de la Table incendies_meteo ont été exportées avec succès.")

    except sqlite3.Error as e:
        print("Erreur avec la base de données SQLite :", e)
    except Exception as e:
        print("Erreur lors de l'exportation des données :", e)

#Fonctions Speciales:

def ajouter_colonne_altitude_zone():
    connexion, curs = connecterdb()
    try:
        # Ajouter la colonne altitude_zone à la table incendiesregions
        curs.execute(
            """
            ALTER TABLE incendiesregions
            ADD COLUMN altitude_zone TEXT;
            """
        )
        connexion.commit()
        print("La colonne 'altitude_zone' a été ajoutée avec succès.")

    except Exception as e:
        print(f"Une erreur s'est produite : {e}")
        raise ValueError("Erreur lors de l'ajout de la colonne 'altitude_zone'.")

    finally:
        curs.close()  # Fermeture du curseur
        connexion.close()  # Fermeture de la connexion

def mettre_a_jour_altitude_zone():
    connexion, curs = connecterdb()
    try:
        # Mise à jour de la colonne altitude_zone selon la valeur de altitude_med
        curs.execute(
            """
            UPDATE incendiesregions
            SET altitude_zone = CASE
                WHEN altitude_med >= 1000 THEN 'Haute Altitude'
                ELSE 'Basse Altitude'
            END;
            """
        )
        connexion.commit()
        print("La colonne 'altitude_zone' a été mise à jour avec succès.")

    except Exception as e:
        print(f"Une erreur s'est produite : {e}")
        raise ValueError("Erreur lors de la mise à jour de la colonne 'altitude_zone'.")

    finally:
        curs.close()  # Fermeture du curseur
        connexion.close()  # Fermeture de la connexion

def supprimer_colonne_nb_incendies():
    connexion, curs = connecterdb()
    try:
        # Supprimer la colonne nb_incendies de la table incendies_temp_heure
        curs.execute(
            """
            ALTER TABLE incendies_temp_heure
            DROP COLUMN nb_incendies;
            """
        )
        connexion.commit()
        print("La colonne 'nb_incendies' a été supprimée avec succès.")

    except Exception as e:
        print(f"Une erreur s'est produite : {e}")
        raise ValueError("Erreur lors de la suppression de la colonne 'nb_incendies'.")

    finally:
        curs.close()  # Fermeture du curseur
        connexion.close()  # Fermeture de la connexion


# Menu de notre Programme
def menu():
    while True:
        print("Bienvenue dans le Menu du Programme du Projet Stat Info")
        print("Veuillez choisir une des options suivantes selon votre besoin")
        print("1. Créer les tables")
        print("2. Injecter des données dans les tables")
        print("3. Afficher des donnees d'une table")
        print("4. Exporter des doneees d'une table")
        print("5. Fonctions Speciales")
        print("6. Quiter le Menu")

        choix = input("Entrez le numero de choix que vous voulez choisir: ")

        if choix == "1":
            print('Bienvenue dans le Module de Creation des tables')
            print('1. Creer table incendies')
            print('2. Creer table donnees meteo')
            print('3. Creer table donnees geo')
            print('4. Creer Table Departements')
            print('5. Creer Table Incendies_Departements')
            print('6. Creer la Table Incendies 2023')
            print('7. Creation de la Table Humidites')
            print('8. Creation de la Table Vents')
            print('9. Creation de la Table Incendies-Regions')
            print('10. Creation de la Table Incendies_temp_heure')
            print('11. Creation de la Table Impact Pression Vapeur')
            print('12. Creer Table Impact Climat Urbanisation')

            choix1 = int(input("Entrez le numero de choix pour la table que vous voulez creer : "))

            if choix1 == 1:
                print("Creation de la Table Incendies")
                creer_table_incendies()
                print("La Creation de la Table Incendies a ete creer avec succees ")
            elif choix1 == 2:
                print(" Creation de la Table Meteo")
                creer_table_donnees_meteo()
                print("La Creation de la Table Meteos a ete creer avec succees  ")
            elif choix1 == 3:
                print("Creation de la Table Geo")
                creer_table_donnees_geo()
                print("La Creation de la Table Geos a ete creer avec succees ")
            elif choix1 == 4:
                print("Creation de la Table Departements")
                creer_table_Departements()
                print("La Creation de la Table Departements a ete creer avec succees ")
            elif choix1 == 5:
                print("Creation de la Table Incendies_Departements")
                creer_table_incendiesdepartements()
                print("La Creation de la Table Incendies_Departements a ete creer avec succees ")
            elif choix1 == 6:
                print("Creation de la Table Incendies 2023")
                creer_table_incendies2023()
                print("La Creation de la Table Incendies 2023 a ete creer avec succees ")
            elif choix1 == 7:
                print("Creation de la Table Humidites")
                create_table_humidites()
                print("La Creation de la Table Humidites a ete creer avec succees ")
            elif choix1 == 8:
                print("Creation de la Table Vents")
                create_table_vents()
                print("La Creation de la Table Vents a ete creer avec succees ")
            elif choix1 == 9:
                print("Creation de la Table Incendies-Regions")
                create_table_incendiesregions()
                print("La Creation de la Table Incendies-Regions a ete creer avec succees ")
            elif choix1 == 10:
                print("Creation de la Table Incendies-Temp-Heure")
                create_table_incendies_temp_heure()
                print("La Creation de la Table Incendies-temp-heure a ete creer avec succees ")
            elif choix1 == 11:
                print("Creation de la Table Impact Pression Vapeur")
                creer_table_impact_pression_vapeur()
                print("La Creation de la Table Impact Pression Vapeur a ete creer avec succees ")
            elif choix1 == 12:
                print("Creation de la Table Climat Urbanisation")
                creer_table_impact_climat_urbanisation()
                print("La Creation de la Table Impact Climat Urbanisation a ete creer avec succees ")
            elif choix1 == 13:
                print("Creation de la Table Incendies_Criminels")
                creer_table_incendies_criminels()
                print("La Creation de la Table Incendies_Criminels a ete creer avec succees ")
            elif choix1 ==14:
                print("Creation de la Table Incendies Meteo")
                creer_table_incendies_meteo()
                print("La Creation de la Table Incendies Meteo a ete creer avec succees ")

            else:
                print(" Le numero choisi est invalide ou n'existe pas   ")

        elif choix == "2":
            print("Bienvenue dans le Module de l'injection des tables avec des donnees   ")
            print('1.Injecter des donnees dans la table incendies')
            print('2.Injecter des donnees dans la table meteo')
            print('3.Injecter des donnees dans la table geo')
            print('4.Injection des donees dans la Table Departements')
            print('5.Injection des donees dans la Table Incendies_Departements')
            print('6.Injection des donees dans la Table Incendies 2023')
            print('7. Injection des donees de la Table Humidites')
            print('8; Injection des donnees de la Table Vents')
            print('9. Injections des donees dans la Table Incendies-Regions')
            print('10. Injections des donnees dans la Table Incendies-temp-heure')
            print('11. Injection des donnees dans la Table Impact Pression Vapeur')
            print('12. Injection des donnees dans la Table Impact Climat Urbanisation')

            choix2 = int(input("Veuillez choisir une option: "))

            if choix2 == 1:
                print("   Injection des données dans la table incendies")
                injecter_donnees_incendies()
                print("Injection effectue avec succees dans la Table Incendies   ")
            elif choix2 == 2:
                print("   Injection des données dans la table meteo")
                injecter_donnees_meteo()
                print("Injection effectue avec succees dans la Table Meteos ")
            elif choix2 == 3:
                print("   Injection des données dans la table geo")
                injecter_donnees_geo()
                print("Injection effectue avec succees dans la Table Geo ")
            elif choix2 == 4:
                print("   Injection des donees dans la Table Departements")
                injection_table_departements()
                print("Injection effectue avec succees dans la Table Departements  ")
            elif choix2 == 5:
                print("   Injection des donnes dans la Table Incendies_Departements")
                injection_table_incendies_departements()
                print("Injection effectue avec succees dans la Table Incendies_Departements ")
            elif choix2 == 6:
                print("Injection de la Table Incendies 2023")
                injecter_donnees_incendies_2023()
                print("L'injection de la Table Incendies 2023 a ete creer avec succees")
            elif choix2 == 7:
                print("Injection de la Table Humidites")
                injecter_donnees_humidites()
                print("Injection effectue avec succees dans la Table Humidites")
            elif choix2 == 8:
                print("Injection de la Table Vents")
                injecter_donnees_vents()
                print("Injection effectue avec succees dans la Table Vents")
            elif choix2 == 9:
                print("Injection de la Table IncendiesRegions")
                injecter_donnees_incendiesregions()
                print("Injection effectue avec succees dans la Table IncedniesRegions")
            elif choix2 == 10:
                print("Injection de la Table Incendies-temp-heure")
                injection_table_incendies_temp_heure()
                print("Injection effectue avec succees dans la Table Incendies-temp-heure")
            elif choix2 == 11:
                print("Injection de la Table Impact Pression Vapeure")
                injection_table_impact_pression_vapeur()
                print("Injection effectue avec succees dans la Table Impact Pression Vapeure")
            elif choix2 == 12:
                print("Injection de la Table Impact_climat_organisation")
                injection_table_impact_climat_urbanisation()
            elif choix2 == 13:
                print("Injection de la Table Incendies Criminels")
                injection_table_inendies_criminels()
            elif choix2 == 14:
                print("Injection de la Table Incendies Meteo")
                injection_table_incendies_meteo()
            else:
                print("  Le numero choisi est invalide ou n'existe pas  ")

        elif choix == "3":
            print("Bienvenue dans le module de l'affichage des tables")
            print('1. Afficher les doneees de la table Incendies')
            print('2. Afficher les donnees de la table Meteo')
            print('3. Afficher les donnees de la table Geo')
            print('4. Afficher les donnees de la table Departements')
            print('5. Afficher les donnees de la Table Incendies_Departements qui fait une analyse pour identifier chaque Departement combien est le nombre dincendies de chaque Dep ')
            print('6. Afficher les donnes de la Table Humidites')
            print('7. Afficher les donnes de la Table Incendies2023')
            print('8. Afficher les donnes de la Table Vents')
            print('9. Afficher les donnes de la Table Incendies-regions')
            print('10. Afficher les donnes de la Table Incendies-temp-heure')
            print("11. Afficher les donnes de la Table Impact Climat Urbanisation")
            print("12. Afficher les donnes de la Table Impact Pression Vapeure")
            print("13. Afficher les donnees de la Table Incendies Criminels")
            print("14. Afficher les donnees de la Table Incendies Geo")
            print("15. Afficher les donnees de la Table Incendies Meteo")

            choix3 = int(input("Veuillez choisir une option: "))
            if choix3 == 1:
                print("  Afficher les donnees de la table Incendies")
                afficher_donnees_incendies()
                print("Affichage de la Table Incendies completes avec succees  ")
            elif choix3 == 2:
                print("  Afficher les donnees de la table Meteo")
                afficher_donnees_meteo()
                print("Affichage de la Table Meteo completes avec succees  ")
            elif choix3 == 3:
                print("  Afficher les donnees de la table Geo")
                afficher_donnees_geo()
                print("Affichage de la Table Geo completes avec succees  ")
            elif choix3 == 4:
                print('  Afficher les doneees de la Table Departements')
                afficher_donees_Departements()
                print("Affichage de la Table Departements completes avec succees  ")
            elif choix3 == 5:
                print('  Afficher les donnees de la Table Incidenes_Departements')
                afficher_doneees_IncendiesDep()
                print("Affichage de la Table Incendies_Departements completes avec succees  ")
            elif choix3 == 6:
                print('Afficher les donnes de la Table Humidites')
                afficher_doneees_humidites()
                print('Afficher de la Table Humidites completes avec succes')
            elif choix3 == 7:
                print('Afficher les donnes de la Table Incendies2023')
                afficher_doneees_incendies2023()
                print('Afficher de la Table Incendies2023 completes avec succes')
            elif choix3 == 8:
                print('Afficher les donnes de la Table Vents')
                afficher_doneees_vents()
                print('Afficher de la Table Vents completes avec succes')
            elif choix3 == 9:
                print("Afficher les donne de la Table Incendies-regions")
                afficher_doneees_incendiesregions()
                print('Afficher de la Table Incendiesregions completes avec succes')
            elif choix3 == 10:
                print("Afficher les donne de la Table Incendies-temp-heure")
                afficher_doneees_incendies_tem_heure()
                print('Afficher de la Table Incendies-temp-heure completes avec succes')
            elif choix3 == 11:
                print("Afficher les donne de la Table Impact Climat Urbanisation")
                afficher_doneees_impact_climat_urbanisation()
                print('Afficher de la Table Impact Climat Urbanisation completes avec succes')
            elif choix3 == 12:
                print("Afficher les donne de la Table Impact Pression Vapeur")
                afficher_doneees_impact_pression_vapeur()
                print('Afficher de la Table Impact Pression Vapeur completes avec succes')
            elif choix3 == 13:
                print("Afficher les donne de la Table Incendies Criminels")
                afficher_doneees_incendies_criminels()
                print('Afficher de la Table Incendies Criminels completes avec succes')
            elif choix3 == 14:
                print("Afficher les donne de la Table Incendies-Geo")
                afficher_doneees_incendies_geo()
                print('Afficher de la Table Incendies-Geo completes avec succes')
            elif choix3 == 15:
                print("Afficher les donne de la Table Incendies-Meteo")
                afficher_doneees_incendies_meteo()
                print('Afficher de la Table Incendies-Meteo completes avec succes')
            else:
                print("Le numero choisi est invalide ou n'existe pas")

        elif choix == "4":
            print("Bienvenue dans le module de l'exportation des donees d'une table")
            print("1.Exportation des donnees de la Table Incendies")
            print("2.Exportation des donnees de la Table Meteo")
            print("3.Exportation des donnees de la Table Geo")
            print("4.Exportation des donnees de la Table Departements")
            print("5.Exportation des donnees de la Table Incendies_Departements")
            print("6.Exportation des donnees de la Table Humidites")
            print("7.Exportation des donnees de la Table Incendies2023")
            print("8. Exportation des donnees de la Table Vents")
            print("9. Exportation des donnees de la Table IncendiesRegions")
            print("10. Exportation des donnees de la Table Incendies_temp_heure")
            print("11. Exportation des donnees de la Table Impact Pression Vapeure")
            print("12. Exportation des donnees de la Table Impact Climat Urbanisation")
            print("13. Exportation des donnees de la Table Incendies Criminels")
            print("14. Exportation des donnees de la Table Incendies Meteo")


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
            elif choix4==6:
                print("La procedure de l'exportation des donees pour la Table Humidites a commencee")
                export_donnees_humidites()
            elif choix4 == 7:
                print("La procedure de l'exportation des donnees pour la Table Incendies2023 a commencee")
                export_donnees_incendies2023()
            elif choix4 == 8:
                print("La procedure de l'exportation des donnees pour la Table Vents a commencee")
                export_donnees_vents()
            elif choix4 == 9:
                print("La procedure de l'exportation des donnees pour la Table Incendiesregions a commencee")
                export_donnees_incendiesregions()
            elif choix4 == 10:
                print("La procedure de l'exportation des donnees pour la Table Incendies_temp_heure a commencee")
                export_donnees_incendies_temp_heure()
            elif choix4 == 11:
                print("La procedure de l'exportation des donnees pour la Table ImpactPressionVap a commencee")
                export_donnees_impact_pression_vapeure()
            elif choix4 == 12:
                print("La procedure de l'exportation des donnees pour la Table ImpactClimatUrb a commencee")
                export_donnees_impact_climat_urbanisation()
            elif choix4 == 13:
                print("La procedure de l'exportation des donnees pour la Table Incendies Criminels a commencee")
                export_donnees_incendies_criminels()
            elif choix4 == 14:
                print("La procedure de l'exportation des donnees pour la Table Incendies Meteo a commencee")
                export_donnees_incendies_meteo()

            else:
                print("Le numero choisi est invalide ou n'existe pas")

        elif choix == "5":
            print("Bienvenue dans le Module Fonctions Speciales")
            print("1. Ajouter une colonne altitude zone")
            print("2. Mettre a jour Altitude Zone")
            print("3. Supprimer colonne nb_incendies")
            choix5 = int(input("Veuillez choisir une option"))
            if choix5 == 1:
                print("On va ajouter une colonne altitude zone")
                ajouter_colonne_altitude_zone()
                print("Processus Done")
            elif choix5 == 2:
                print("On va mettre a jout l'altitude zone")
                mettre_a_jour_altitude_zone()
                print("Processus Done")
            elif choix5 == 3:
                print("On va supprimer la colonne nb_incendies")
                supprimer_colonne_nb_incendies()
                print("Processus Done")
            else:
                print("Le numero choisi est invalide ou n'existe pas")
        elif choix == "6":
            confirmation = input("Etes vous sur de vouloir quiiter le menu du Projet Stat Info?")
            if confirmation == "o" or confirmation == "ok" or confirmation == "yes" or confirmation == "Oui" or confirmation == "si" or confirmation == "oui":
                print("Merci d'avoir d'utilise le programme A bientot!")
                break
            else:
                print(" Retour au menu...")
        else:
            print("Le numero choisi est invalide ou n'existe pas  ")


# Appel de la fonction menu
menu()

