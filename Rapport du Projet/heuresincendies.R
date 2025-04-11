library(plotly)

# Lire les données
df <- read_csv("C:/Users/media/OneDrive/Escriptori/annual-number-of-fires.csv")

# Filtrer les données entre 2012 et 2025
df_filtered <- df[df$Year >= 2012 & df$Year <= 2025, ]

# Somme des incendies par pays
resumen_total <- aggregate(`Annual number of fires` ~ Entity, data = df_filtered, sum, na.rm = TRUE)

# Trier par le nombre total d'incendies
resumen_total <- resumen_total[order(-resumen_total$`Annual number of fires`), ]

# Liste des pays européens
paises_europa <- c(
  "Albania", "Andorra", "Armenia", "Austria", "Azerbaijan", "Belarus", "Belgium", "Bosnia and Herzegovina",
  "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Georgia",
  "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Kazakhstan", "Kosovo", "Latvia", "Liechtenstein",
  "Lithuania", "Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "North Macedonia",
  "Norway", "Poland", "Portugal", "Romania", "Russia", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain",
  "Sweden", "Switzerland", "Turkey", "Ukraine", "United Kingdom", "Vatican"
)

# Filtrer les pays européens
df_europa <- resumen_total[resumen_total$Entity %in% paises_europa, ]

# Calculer les valeurs min et max des incendies
max_incendios <- max(df_europa$`Annual number of fires`, na.rm = TRUE)
min_incendios <- min(df_europa$`Annual number of fires`, na.rm = TRUE)

# Valeurs de zmax et zmin
zmax <- max(60000, max_incendios)  # Rouge pour les valeurs élevées
zmin <- min_incendios  # Garder la valeur minimale

# Créer la carte choroplétique avec plotly
fig <- plot_ly(
  data = df_europa,
  type = 'choropleth',
  locations = ~Entity,
  locationmode = 'country names',
  z = ~`Annual number of fires`,
  colorscale = 'YlOrRd',  # Echelle 'YlOrRd'
  reversescale = TRUE,  # Inverser les couleurs pour que les valeurs élevées soient rouges
  colorbar = list(title = "Nombre d'incendies"),
  zmin = zmin,
  zmax = zmax,
  text = ~paste(Entity, "<br>Total incendies:", `Annual number of fires`),
  hoverinfo = "text"
)

# Layout et titre
fig <- fig %>% layout(
  title = "Nombre des incendies de forêt en Europe (2012-2025)",
  geo = list(
    showframe = FALSE,
    showcoastlines = TRUE,
    projection = list(type = 'mercator'),  # Projection de type mercator
    center = list(lat = 50, lon = 10),  # Centrer la carte sur l'Europe
    scaleanchor = "x",  # Assurer que la carte est proportionnelle
    projection_scale = 4,  # Zoom sur la carte
    lonaxis = list(range = c(-30, 60)),  # Limiter la longitude
    lataxis = list(range = c(35, 72))  # Limiter la latitude
  )
)

# Montrer la carte
fig
