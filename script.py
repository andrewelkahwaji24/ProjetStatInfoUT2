import sqlite3 , numpy as np , os , random, csv

#creation d'une base de donnée

def connecterdb(database="data.db"):
    connexion=sqlite3.connect(database)
    curs=connexion.cursor()
    return connexion, curs

connecterdb()