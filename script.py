import sqlite3 , numpy as np , os , random, csv

#creation d'une base de donnée

def connecterdb(database="data.db"):
    connexion=sqlite3.connect(database)
    curs=connexion.cursor()
    return connexion, curs

connecterdb()

def creer_table_incendies():
    connexion , curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE  incendies(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            commune TEXT NOT NULL,
            code_INSEE TEXT NOT NULL,
            surface_parcourue_m2 INTEGER NOT NULL,
            annee INTEGER NOT NULL,
            mois TEXT NOT NULL,
            jour INTEGER NOT NULL,
            heure INTEGER NOT NULL,
            nature_inc_prim TEXT NOT NULL,
            nature_inc_sec TEXT
            )
        '''
    )

creer_table_incendies()