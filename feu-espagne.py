import geopandas as gpd
import pandas as pd
import matplotlib.pyplot as plt

# Charger les données des incendies
df = pd.read_csv("incendios.csv" , delimiter = ';')

# Charger la carte des régions ou provinces espagnoles en GeoJSON
chemin_fichier_geojson = "spain.geojson"  # Remplace par le chemin du fichier GeoJSON des régions espagnoles
gdf_regions = gpd.read_file(chemin_fichier_geojson)

# Créer une figure avec une taille d'image plus grande sans agrandir les axes
fig, ax = plt.subplots(figsize=(15, 15))  # Taille de l'image en 15x15 pouces

# Tracer les régions de l'Espagne
gdf_regions.plot(ax=ax, color="lightgray", edgecolor="black")

# Ajouter les points des incendies avec une taille agrandie
ax.scatter(df["longitud"], df["latitud"], color="red", s=50, label="Incendies")

# Ajuster la vue (limites de la carte) pour qu'elle prenne toute l'Espagne
ax.set_xlim([ -9.5, 4 ])  # Limites de la longitude pour l'Espagne
ax.set_ylim([36, 43.8])    # Limites de la latitude pour l'Espagne

# Ajouter un titre et une légende
plt.title("Carte des Incendies en Espagne par Région", fontsize=20)
plt.legend()

# Supprimer les axes pour que la carte soit plus nette
ax.set_axis_off()

# Sauvegarder la carte sans axes, pour une image propre et claire
plt.savefig("carte_incendies_espagne_grande_avec_points_agrandis.png", dpi=600, bbox_inches='tight')

# Afficher la carte
plt.show()
