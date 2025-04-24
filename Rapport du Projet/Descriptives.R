# Librairies nécessaires
library(tidyverse)
library(ggplot2)
library(dplyr)
library(ggpubr)
library(corrplot)

# Importation des données
df <- read.csv("../Data/donnees_incendies.csv")
df %>% count(nature_inc_prim) %>% mutate(freq = n / sum(n) * 100)


ggplot(df, aes(x = nature_inc_prim)) + 
  geom_bar() +
  ggtitle("Répartition des types d'incendies (primaires)")

df %>% count(nature_inc_sec) %>% mutate(freq = n / sum(n) * 100)
ggplot(df, aes(x = nature_inc_sec)) + 
  geom_bar() +
  ggtitle("Répartition des types d'incendies (secondaires)")


# mois
ggplot(df, aes(x = factor(mois))) + 
  geom_bar() +
  ggtitle("Répartition des incendies par mois")

df_summary_mois <- df %>%
  filter(!is.na(mois)) %>%
  count(mois) %>%
  mutate(freq = n / sum(n) * 100)

ggplot(df_summary_mois, aes(x = "", y = n, fill = factor(mois))) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) + 
  geom_text(aes(label = paste0(round(freq, 1), "%")), 
            position = position_stack(vjust = 0.5), size = 4) +
  scale_fill_brewer(palette = "Pastel1") +
  labs(
    title = "Répartition des incendies par mois",
    fill = "Mois"
  ) +
  theme_void() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14)
  )

df_summary_mois <- df %>%
  filter(!is.na(mois)) %>%
  count(mois) %>%
  mutate(freq = n / sum(n) * 100)

# Convertir la colonne "mois" en facteur ordonné
df_summary_mois$mois <- factor(df_summary_mois$mois, 
                               levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                          "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

ggplot(df_summary_mois, aes(x = mois, y = n, fill = mois)) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +
  scale_fill_brewer(palette = "Set3") +
  labs(
    title = "Répartition des incendies par mois",
    x = "Mois",
    y = "Nombre d'incendies"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14)
  )

library(tidyverse)
library(ggplot2)
library(dplyr)
library(ggpubr)
library(corrplot)
# Charger les librairies nécessaires
library(tidyverse)

# Charger les données
df <- read.csv("../Data/donnees_incendies.csv")

# Variables quantitatives
vars_quanti <- c("surface_parcourue_m2", "annee", "mois", "jour", "heure")

# Statistiques descriptives globales
summary(df[vars_quanti])

# Histogrammes & Boxplots
for (var in vars_quanti) {
  
  # Vérifier si la variable est continue (numérique)
  if (is.numeric(df[[var]])) {
    # Histogramme pour variables continues
    print(
      ggplot(df, aes_string(x = var)) + 
        geom_histogram(bins = 30, fill = "skyblue", color = "black") + 
        ggtitle(paste("Histogramme de", var))
    )
  } else {
    # Diagramme en barres pour variables discrètes (facteurs)
    print(
      ggplot(df, aes_string(x = var)) + 
        geom_bar(fill = "skyblue", color = "black") + 
        ggtitle(paste("Répartition des", var))
    )
  }
  
  # Boxplot
  print(
    ggplot(df, aes_string(y = var)) + 
      geom_boxplot(fill = "orange") + 
      ggtitle(paste("Boxplot de", var))
  )
}


colnames(df)

# Tableau croisé
table(df$nature_inc_prim, df$nature_inc_sec)

# Test du Chi²
chisq.test(table(df$nature_inc_prim, df$nature_inc_sec))





library(ggplot2)
library(dplyr)

df %>%
  filter(!is.na(nature_inc_sec)) %>%
  ggplot(aes(x = nature_inc_prim, fill = nature_inc_sec)) + 
  geom_bar(position = "dodge") +
  scale_fill_brewer(palette = "Set3") +  # Palette plus colorée
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(
    title = "Répartition des types d'incendies (primaire vs secondaire)",
    x = "Nature primaire",
    fill = "Nature secondaire"
  )

# Importer les deux CSV
df_incendies <- read.csv("../Data/donnees_incendies.csv")
df_meteo <- read.csv("../Data/donnees_meteo.csv")

# Matrice de corrélation
cor_matrix <- cor(df[vars_quanti], use = "complete.obs")
corrplot(cor_matrix, method = "color", type = "upper", addCoef.col = "black")

# Scatterplot + régression
ggplot(df, aes(x = Insolation_med, y = Tmax_med)) + 
  geom_point() + 
  geom_smooth(method = "lm", col = "red") + 
  ggtitle("Tmax_med vs Insolation_med")

# Corrélation de Pearson
cor.test(df$Insolation_med, df$Tmax_med, method = "pearson")




# Boxplot Altitude selon nature_inc_prim
ggplot(df, aes(x = nature_inc_prim, y = Altitude)) + 
  geom_boxplot() + 
  ggtitle("Altitude selon le type d'incendie primaire")

# Tmax selon nature_sec_inc
ggplot(df, aes(x = nature_sec_inc, y = Tmax_med)) + 
  geom_boxplot() + 
  ggtitle("Tmax selon nature secondaire")

# Test ANOVA
anova_test <- aov(Tmax_med ~ nature_sec_inc, data = df)
summary(anova_test)




install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("sf")  # si pas déjà fait






```{r carte-europe-incendies, fig.width=10, fig.height=7, echo=FALSE, message=FALSE, warning=FALSE}
library(readr)
library(dplyr)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Charger les données
df <- read_csv("../Data/annual-number-of-fires.csv")
df_filtre <- df %>% filter(Year >= 2012 & Year <= 2025)
resume_total <- df_filtre %>%
  group_by(Entity) %>%
  summarise(total = sum(`Annual number of fires`, na.rm = TRUE)) %>%
  arrange(desc(total))

# Liste des pays européens
pays_europe <- c(
  "Albania", "Andorra", "Armenia", "Austria", "Azerbaijan", "Belarus", "Belgium", "Bosnia and Herzegovina",
  "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Georgia",
  "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Kazakhstan", "Kosovo", "Latvia", "Liechtenstein",
  "Lithuania", "Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "North Macedonia",
  "Norway", "Poland", "Portugal", "Romania", "Russia", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain",
  "Sweden", "Switzerland", "Turkey", "Ukraine", "United Kingdom", "Vatican"
)

df_europe <- resume_total %>% filter(Entity %in% pays_europe)

# Récupérer la carte des pays
europe_map <- ne_countries(scale = "medium", returnclass = "sf")

# Joindre les données d’incendies
europe_map <- europe_map %>%
  left_join(df_europe, by = c("name" = "Entity"))

# Tracer la carte
ggplot(data = europe_map) +
  geom_sf(aes(fill = total)) +
  scale_fill_gradientn(colors = rev(heat.colors(10)), na.value = "gray90") +
  labs(
    title = "Nombre d'incendies de forêt en Europe (2012–2025)",
    fill = "Nombre d'incendies"
  ) +
  theme_minimal()






```{r carte-europe-incendies, fig.width=10, fig.height=7, echo=FALSE, message=FALSE, warning=FALSE}
library(readr)
library(dplyr)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Charger les données
df <- read_csv("../Data/annual-number-of-fires.csv")
df_filtre <- df %>% filter(Year >= 2012 & Year <= 2025)
resume_total <- df_filtre %>%
  group_by(Entity) %>%
  summarise(total = sum(`Annual number of fires`, na.rm = TRUE)) %>%
  arrange(desc(total))

# Liste des pays européens
pays_europe <- c(
  "Albania", "Andorra", "Armenia", "Austria", "Azerbaijan", "Belarus", "Belgium", "Bosnia and Herzegovina",
  "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Georgia",
  "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Kazakhstan", "Kosovo", "Latvia", "Liechtenstein",
  "Lithuania", "Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "North Macedonia",
  "Norway", "Poland", "Portugal", "Romania", "Russia", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain",
  "Sweden", "Switzerland", "Turkey", "Ukraine", "United Kingdom", "Vatican"
)

df_europe <- resume_total %>% filter(Entity %in% pays_europe)

# Charger la carte et joindre les données
europe_map <- ne_countries(scale = "medium", returnclass = "sf")
europe_map <- europe_map %>%
  left_join(df_europe, by = c("name" = "Entity"))

# Afficher la carte avec zoom sur l'Europe
ggplot(data = europe_map) +
  geom_sf(aes(fill = total)) +
  scale_fill_gradientn(colors = rev(heat.colors(10)), na.value = "gray90") +
  labs(
    title = "Nombre d'incendies de forêt en Europe (2012–2025)",
    fill = "Nombre d'incendies"
  ) +
  coord_sf(xlim = c(-25, 60), ylim = c(34, 72), expand = FALSE) +  # Zoom sur l’Europe
  theme_minimal()





```{r carte-europe-noms, fig.width=11, fig.height=8, echo=FALSE, message=FALSE, warning=FALSE}
library(readr)
library(dplyr)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Charger les données
df <- read_csv("../Data/annual-number-of-fires.csv")
df_filtre <- df %>% filter(Year >= 2012 & Year <= 2025)
resume_total <- df_filtre %>%
  group_by(Entity) %>%
  summarise(total = sum(`Annual number of fires`, na.rm = TRUE)) %>%
  arrange(desc(total))

# Liste des pays européens
pays_europe <- c(
  "Albania", "Andorra", "Armenia", "Austria", "Azerbaijan", "Belarus", "Belgium", "Bosnia and Herzegovina",
  "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Georgia",
  "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Kazakhstan", "Kosovo", "Latvia", "Liechtenstein",
  "Lithuania", "Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "North Macedonia",
  "Norway", "Poland", "Portugal", "Romania", "Russia", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain",
  "Sweden", "Switzerland", "Turkey", "Ukraine", "United Kingdom", "Vatican"
)

df_europe <- resume_total %>% filter(Entity %in% pays_europe)

# Charger les frontières et fusionner
europe_map <- ne_countries(scale = "medium", returnclass = "sf")
europe_map <- europe_map %>%
  left_join(df_europe, by = c("name" = "Entity"))

# Calculer les positions des labels (centroïdes)
europe_centroids <- st_centroid(europe_map)

# Affichage
ggplot(data = europe_map) +
  geom_sf(aes(fill = total)) +
  geom_text(data = europe_centroids, aes(x = st_coordinates(geometry)[,1],
                                         y = st_coordinates(geometry)[,2],
                                         label = name),
            size = 2.5, color = "black", check_overlap = TRUE) +
  scale_fill_gradientn(colors = rev(heat.colors(10)), na.value = "gray90") +
  labs(
    title = "Nombre d'incendies de forêt en Europe (2012–2025)",
    fill = "Nombre d'incendies"
  ) +
  coord_sf(xlim = c(-25, 60), ylim = c(34, 72), expand = FALSE) +
  theme_minimal()






library(survival)
library(ggplot2)

# Vérifier et trier les données par commune et année
data_survie <- data_clean %>%
  arrange(code_INSEE, annee) %>%  # Trier les données par code_INSEE et année
  group_by(code_INSEE) %>%
  mutate(
    # Calculer la différence entre l'année courante et l'année précédente
    time = c(NA, diff(annee)),
    event = incendie  # Garder 1 si incendie, 0 sinon
  ) %>%
  filter(event == 1)  # Garder uniquement les années où un incendie a eu lieu

# Créer un objet de survie
surv_obj <- Surv(time = data_survie$time, event = data_survie$event)

# Ajuster un modèle de survie
surv_fit <- survfit(surv_obj ~ 1)

# Extraire les résultats du modèle survfit
surv_data <- data.frame(
  time = surv_fit$time,
  surv = surv_fit$surv,
  n.risk = surv_fit$n.risk
)

# Visualisation avec ggplot2
ggplot(surv_data, aes(x = time, y = surv)) +
  geom_step(aes(color = "blue"), size = 1.5) +  # Courbe de survie colorée en bleu
  labs(
    title = "Courbe de survie des incendies",
    x = "Temps (années)",
    y = "Probabilité de survie"
  ) +
  scale_color_manual(values = c("blue")) +  # Personnalisation de la couleur
  theme_minimal() +  # Thème minimaliste
  theme(
    plot.title = element_text(hjust = 0.5),  # Centrer le titre
    axis.title = element_text(size = 12),  # Taille des titres des axes
    axis.text = element_text(size = 10),  # Taille des étiquettes des axes
    legend.position = "none"  # Cacher la légende
  )






library(survival)
library(ggplot2)
library(dplyr)

# Vérifier et trier les données par commune et année
data_survie <- data_clean %>%
  arrange(code_INSEE, annee) %>%  # Trier les données par code_INSEE et année
  group_by(code_INSEE) %>%
  mutate(
    # Calculer la différence entre l'année courante et l'année précédente
    time = c(NA, diff(annee)),
    event = incendie  # Garder 1 si incendie, 0 sinon
  ) %>%
  filter(event == 1)  # Garder uniquement les années où un incendie a eu lieu

# Créer un objet de survie
surv_obj <- Surv(time = data_survie$time, event = data_survie$event)

# Ajuster un modèle de survie
surv_fit <- survfit(surv_obj ~ 1)

# Extraire les résultats du modèle survfit
surv_data <- data.frame(
  time = surv_fit$time,
  surv = surv_fit$surv,
  n.risk = surv_fit$n.risk
)

# Visualisation améliorée avec ggplot2
ggplot(surv_data, aes(x = time, y = surv)) +
  geom_step(aes(color = "blue"), size = 1.5) +  # Courbe de survie colorée en bleu
  labs(
    title = "Courbe de survie des incendies dans les communes",
    subtitle = "Suivi des incendies par commune et par année",
    x = "Temps depuis le dernier incendie (années)",
    y = "Probabilité de survie des communes",
    caption = "Source: Données des incendies"
  ) +
  scale_color_manual(values = c("blue")) +  # Personnalisation de la couleur
  theme_minimal() +  # Thème minimaliste
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),  # Centrer et styliser le titre
    plot.subtitle = element_text(hjust = 0.5, size = 12),  # Centrer et styliser le sous-titre
    axis.title = element_text(size = 14),  # Taille des titres des axes
    axis.text = element_text(size = 12),  # Taille des étiquettes des axes
    axis.text.x = element_text(angle = 45, hjust = 1),  # Rotation des étiquettes de l'axe x pour plus de lisibilité
    plot.caption = element_text(hjust = 1, size = 10, color = "grey"),  # Texte en bas à droite
    legend.position = "none",  # Cacher la légende
    panel.grid.major = element_line(color = "lightgrey", size = 0.5),  # Lignes de grille principales
    panel.grid.minor = element_line(color = "lightgrey", size = 0.25),  # Lignes de grille secondaires
    panel.background = element_rect(fill = "white")  # Fond blanc pour une meilleure lisibilité
  )

