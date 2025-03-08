import geopandas as gpd
import pandas as pd
import matplotlib.pyplot as plt

# Charger les données des incendies
df = pd.read_csv("Data/donnees_geo.csv")

# Charger la carte des départements français en GeoJSON
chemin_fichier_geojson = "Data/contour-des-departements.geojson"  # Remplace par ton bon chemin
gdf_departements = gpd.read_file(chemin_fichier_geojson)

# Créer une figure avec une taille d'image plus grande sans agrandir les axes
fig, ax = plt.subplots(figsize=(15, 15))  # Taille de l'image en 15x15 pouces

# Tracer les départements de la France
gdf_departements.plot(ax=ax, color="lightgray", edgecolor="black")

# Ajouter les points des incendies avec une taille agrandie
ax.scatter(df["longitude"], df["latitude"], color="red", s=50, label="Incendies")  # Augmenter la taille des points avec s=50

# Ajuster la vue (limites de la carte) pour qu'elle prenne toute la France
ax.set_xlim([ -5.5, 10 ])  # Limites de la longitude (à ajuster selon la carte)
ax.set_ylim([41.5, 51.5])   # Limites de la latitude (à ajuster selon la carte)

# Ajouter un titre et une légende
plt.title("Carte des Incendies par Département", fontsize=20)
plt.legend()

# Supprimer les axes pour que la carte soit plus nette
ax.set_axis_off()

# Sauvegarder la carte sans axes, pour une image propre et claire
plt.savefig("carte_incendies_departements_geojson_grande_avec_points_agrandis.png", dpi=600, bbox_inches='tight')

# Afficher la carte
plt.show()



