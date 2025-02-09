import sqlite3 , numpy as np , os , random, csv
from scipy import stats
import statsmodels.api as sm
from datetime import datetime


#creation d'une base de donnée
#creation d'une connexion avec la base de donnees
def connecterdb(database="data.db"):
    connexion=sqlite3.connect(database)
    curs=connexion.cursor()
    return connexion, curs

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

#C'est une fonction generale pour pouvoir editer des trucs , creer des tables , inserer ou modifier des donees
def operations_non_observatrices():
    creer_table_incendies()

#La fonction main est utilise pour pouvoir lance un ensemble de fonctions
#C'est un programme generale neccessaire pour l'execution et on peut l'executer autant de fois qu'on veut
def main():
    connecterdb()
    
#Creation table de hans donnees_meteo
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

#Creation table de hans donnees_geo
def creer_table_donnees_geo():
    connexion, curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS donnees_geo(
            code_INSEE TEXT PRIMARY KEY,
            latitude REAL,
            longitude REAL,
            altitude_med REAL
        )
        '''
    )
    connexion.commit()
    curs.close()
    connexion.close()
    
#Creation table hans incendies
def creer_table_incendies():
    connexion, curs = connecterdb()
    curs.execute(
        '''
        CREATE TABLE IF NOT EXISTS incendies(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            commune TEXT NOT NULL,
            code_INSEE INTEGER NOT NULL,
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
    connexion.commit()
    curs.close()
    connexion.close()

main()