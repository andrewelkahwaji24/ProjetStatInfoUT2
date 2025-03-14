import folium
import pandas as pd

# Charger les données des incendies
df = pd.read_csv("Data/donnees_geo.csv")

# Créer une carte centrée sur la France
m = folium.Map(location=[46.603354, 1.888334], zoom_start=6)

# Ajouter des marqueurs pour chaque incendie
for _, row in df.iterrows():
    folium.Marker(
        location=[row["latitude"], row["longitude"]],
        popup=f"Code INSEE: {row['code_INSEE']}<br>Altitude: {row['altitude_med']} m",
        icon=folium.Icon(color="red", icon="fire", prefix="fa")  # Icône feu 🔥
    ).add_to(m)

# Sauvegarder la carte
m.save("carte_incendies.html")
