donnees <- read.csv("../Data/donnees_incendies.csv")
head(donnees)

# Supprimer les espaces entre les axes et les barres

hist(
  donnees$annee,
  main = "Distribution des incendies par année",
  xlab = "Année",
  ylab = "Nombre d'incendies",
  col = "#69b3a2",  # Couleur plus moderne
  border = "white",  # Contour blanc pour un meilleur rendu
  breaks = 15,  # Augmenter le nombre de bins si nécessaire
  las = 1,  # Orientation des labels des axes
  cex.main = 1.5,  # Taille du titre
  cex.lab = 1.2,  # Taille des labels des axes
  cex.axis = 1  # Taille des nombres des axes
)


hist(donnees$mois,
     main="Distribution des incendies par mois",
     xlab="Mois",
     col="lightgreen",
     border="black",
     breaks=12)  # 12 mois dans l'année

annee_freq <- table(donnees$annee)

# Créer un graphique en ligne
plot(annee_freq, 
     type="o",  # "o" pour un graphique avec des points et des lignes
     col="blue", 
     main="Évolution des incendies au fil des années", 
     xlab="Année", 
     ylab="Nombre d'incendies")

# Créer un tableau de données empilées (par exemple, par mois et par nature d'incendie)
mois_nature_freq <- table(donnees$mois, donnees$nature_inc_prim)

barplot(mois_nature_freq, 
        beside=FALSE,  # Empiler les barres
        col=rainbow(ncol(mois_nature_freq)), 
        main="Répartition des incendies par mois et nature", 
        xlab="Mois", 
        ylab="Nombre d'incendies", 
        legend = rownames(mois_nature_freq))

mois_freq <- table(donnees$mois)

# Créer un diagramme circulaire
pie(mois_freq, 
    main="Proportions des incendies par mois", 
    col=rainbow(length(mois_freq)))

# Créer un graphique de densité pour la colonne "surface_parcourue_m2"
plot(density(donnees$surface_parcourue_m2), 
     main="Densité de la surface parcourue par les incendies", 
     xlab="Surface parcourue (m²)", 
     col="blue")


## Évolution des incendies au fil des années
library(ggplot2)

ggplot(donnees, aes(x = annee)) +
  geom_histogram(binwidth = 1, fill = "#0073C2FF", color = "white", alpha = 0.8) +  # Bleu pro, bordures blanches
  geom_vline(aes(xintercept = mean(annee)), color = "red", linetype = "dashed", size = 1) +  # Ligne moyenne
  labs(
    title = "Évolution des incendies au fil des années",
    subtitle = "Analyse de la fréquence des incendies par année",
    x = "Année",
    y = "Nombre d'incendies",
    caption = "Source : Base de données incendies"
  ) +
  theme_minimal(base_size = 14) +  # Style épuré
  theme(
    plot.title = element_text(face = "bold", size = 16, color = "#333333"),
    plot.subtitle = element_text(size = 12, color = "#555555"),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(size = 12),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank()
  )

library(ggplot2)

# Convertir la table en dataframe pour ggplot
library(ggplot2)

# Convertir la table en dataframe pour ggplot
donnees_freq <- as.data.frame(annee_freq)
colnames(donnees_freq) <- c("Annee", "Nombre_incendies")

# Trier les données par année (pour s'assurer que la ligne est tracée dans l'ordre chronologique)
donnees_freq <- donnees_freq[order(donnees_freq$Annee), ]

# Créer le graphique avec une ligne qui relie les points
ggplot(donnees_freq, aes(x = Annee, y = Nombre_incendies)) +
  geom_line(color = "blue", size = 1) +  # Ligne bleue
  geom_point(color = "red", size = 2) +   # Points rouges
  labs(
    title = "Évolution des incendies par année",
    x = "Année",
    y = "Nombre d'incendies"
  ) +
  theme_minimal()


##### Impact de l'humidité sur les incendies
# Étape 1 : Charger les bibliothèques nécessaires
library(ggplot2)

# Étape 2 : Importer les données
data <- read.csv("../Exports/export_Humidites.csv")

# Étape 3 : Inspecter les données (vérifiez les premières lignes et les colonnes)
head(data)

# Étape 4 : Assurez-vous que les colonnes sont correctes et ne contiennent pas de valeurs manquantes
summary(data)

# Étape 5 : Créer un histogramme pour Tens_vap_med
ggplot(data, aes(x = Tens_vap_med)) +
  geom_histogram(binwidth = 0.5, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogramme de Tens_vap_med",
       x = "Tens_vap_med (Humidité de l'air)",
       y = "Fréquence") +
  theme_minimal()

# Étape 6 : Si vous voulez voir l'impact de la surface parcourue par l'incendie
ggplot(data, aes(x = Tens_vap_med, y = surface_parcourue_m2)) +
  geom_point(color = "blue") +
  labs(title = "Impact de l'humidité sur la surface parcourue par les incendies",
       x = "Tens_vap_med (Humidité de l'air)",
       y = "Surface parcourue par les incendies (m2)") +
  theme_minimal()


# Étape 1 : Charger les bibliothèques nécessaires
library(ggplot2)

# Étape 2 : Importer les données
data <- read.csv("../Exports/export_Humidites.csv")

# Étape 3 : Vérification rapide des données (pour s'assurer que tout est correct)
head(data)
summary(data)

# Étape 4 : Créer un histogramme avec un design amélioré pour Tens_vap_med
ggplot(data, aes(x = Tens_vap_med)) +
  geom_histogram(binwidth = 0.5, fill = "#1f77b4", color = "white", alpha = 0.7) +
  labs(title = "Distribution de l'humidité de l'air (Tens_vap_med)", 
       x = "Humidité de l'air (Tens_vap_med)", 
       y = "Fréquence") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    panel.grid.major = element_line(color = "gray", size = 0.5),
    panel.grid.minor = element_line(color = "gray", size = 0.25)
  )

# Étape 5 : Créer un diagramme de dispersion avec un design amélioré
ggplot(data, aes(x = Tens_vap_med, y = surface_parcourue_m2)) +
  geom_point(aes(color = surface_parcourue_m2), size = 2, alpha = 0.7) + 
  scale_color_gradient(low = "blue", high = "red") + 
  labs(
    title = "Relation entre l'humidité de l'air et la surface parcourue par les incendies", 
    x = "Humidité de l'air (Tens_vap_med)", 
    y = "Surface parcourue par les incendies (m²)",
    caption = "Source: Données sur les incendies et l'humidité"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    panel.grid.major = element_line(color = "gray", size = 0.5),
    panel.grid.minor = element_line(color = "gray", size = 0.25)
  )

# Histogramme de Tens_vap_med (humidité de l'air)
ggplot(data, aes(x = Tens_vap_med)) +
  geom_histogram(binwidth = 0.5, fill = "#1f77b4", color = "white", alpha = 0.7) +
  labs(title = "Distribution de l'humidité de l'air (Tens_vap_med)", 
       x = "Humidité de l'air (Tens_vap_med)", 
       y = "Fréquence") +
  theme_minimal()

# Histogramme de Tens_vap_med (humidité de l'air)
ggplot(data, aes(x = Tens_vap_med)) +
  geom_histogram(binwidth = 0.5, fill = "#1f77b4", color = "white", alpha = 0.7) +
  labs(title = "Distribution de l'humidité de l'air (Tens_vap_med)", 
       x = "Humidité de l'air (Tens_vap_med)", 
       y = "Fréquence") +
  theme_minimal()
# Diagramme de dispersion entre Tens_vap_med et surface_parcourue_m2
ggplot(data, aes(x = Tens_vap_med, y = surface_parcourue_m2)) +
  geom_point(aes(color = surface_parcourue_m2), size = 2, alpha = 0.7) + 
  scale_color_gradient(low = "blue", high = "red") + 
  labs(title = "Relation entre l'humidité de l'air et la surface parcourue par les incendies", 
       x = "Humidité de l'air (Tens_vap_med)", 
       y = "Surface parcourue par les incendies (m²)") +
  theme_minimal()

# Calcul de la corrélation entre Tens_vap_med et surface_parcourue_m2
correlation <- cor(data$Tens_vap_med, data$surface_parcourue_m2, use = "complete.obs")
print(paste("Corrélation entre Tens_vap_med et surface_parcourue_m2: ", correlation))
# Étape 1 : Charger les bibliothèques nécessaires
library(ggplot2)

# Étape 2 : Importer les données
data <- read.csv("../Exports/export_Humidites.csv")

# Étape 3 : Vérification rapide des données (pour s'assurer que tout est correct)
head(data)
summary(data)
# Histogramme de Tens_vap_med (humidité de l'air)
ggplot(data, aes(x = Tens_vap_med)) +
  geom_histogram(binwidth = 0.5, fill = "#1f77b4", color = "white", alpha = 0.7) +
  labs(title = "Distribution de l'humidité de l'air (Tens_vap_med)", 
       x = "Humidité de l'air (Tens_vap_med)", 
       y = "Fréquence") +
  theme_minimal()




# Charger les bibliothèques nécessaires
library(ggplot2)

# Charger le jeu de données (remplacez par le chemin de votre fichier CSV)
data <- read.csv("../Exports/export_Humidites.csv")

# Histogramme empilé (groupé par code_INSEE)
ggplot(data, aes(x = surface_parcourue_m2, fill = factor(code_INSEE))) +
  geom_histogram(position = "stack", binwidth = 500, color = "black", alpha = 0.7) +
  labs(title = "Surface Parcourue par le Feu par Zone Géographique (Code INSEE)", 
       x = "Surface Parcourue (m²)", 
       y = "Fréquence") +
  scale_fill_brewer(palette = "Set3") +  # Palette de couleurs agréables
  theme_light() +  # Thème clair
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Incliner les labels de l'axe X




# Charger les bibliothèques nécessaires
library(ggplot2)

# Charger le jeu de données (remplacez par le chemin de votre fichier CSV)
data <- read.csv("../Exports/export_vents.csv")

# Histogramme de la Surface Parcourue par le Feu groupé par Force du Vent
ggplot(data, aes(x = surface_parcourue_m2, fill = factor(Force_vent_med))) +
  geom_histogram(position = "dodge", binwidth = 1000, color = "white", alpha = 0.85) +  # Barres avec un contour blanc et plus d'opacité
  labs(title = "Surface Parcourue par le Feu selon la Force du Vent", 
       x = "Surface Parcourue (m²)", 
       y = "Fréquence") +
  scale_fill_brewer(palette = "Pastel1", name = "Force du Vent") +  # Palette pastel subtile
  theme_light() +  # Thème léger pour un fond plus lumineux
  theme(
    axis.text.x = element_text(size = 12, angle = 45, hjust = 1),  # Meilleure lisibilité des labels de l'axe X
    axis.text.y = element_text(size = 12),  # Taille de police de l'axe Y
    axis.title = element_text(size = 14, face = "bold"),  # Titres des axes en gras
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),  # Titre du graphique en gras et centré
    legend.title = element_text(size = 12, face = "bold"),  # Titre de la légende en gras
    legend.text = element_text(size = 11)  # Texte de la légende en taille normale
  )


library(ggplot2)
library(plotly)

data <- read.csv("../Exports/export_vents.csv")

# Création de l'histogramme avec hist()
hist(data$surface_parcourue_m2, 
     breaks = 30,  # Ajustez le nombre de classes pour une meilleure lisibilité
     col = "violet",  # Couleur des barres
     border = "black",  # Bordure des barres
     main = "Histogramme de la Surface Parcourue par les Incendies dhdhdh", 
     xlab = "Surface Parcourue (m²)", 
     ylab = "Fréquence",
     freq = TRUE)  # Garde l'affichage en fréquence


# Convertir ggplot en graphique interactif
ggplotly(p)

# Charger les bibliothèques nécessaires
# Charger les bibliothèques nécessaires
# Charger les bibliothèques nécessaires
library(ggplot2)
library(dplyr)

# Charger le jeu de données (remplacez par le chemin de votre fichier CSV)
# Charger les bibliothèques nécessaires
library(ggplot2)

# Charger le jeu de données (remplacez par le chemin de votre fichier CSV)
data <- read.csv("../Exports/export_vents.csv")

# Diagramme de dispersion simple
ggplot(data, aes(x = Force_vent_med, y = surface_parcourue_m2)) +
  geom_point(color = "black", size = 2) +  # Points noirs simples
  labs(title = "Surface Parcourue par le Feu en fonction de la Force du Vent", 
       x = "Force du Vent", 
       y = "Surface Parcourue (m²)") +
  theme_minimal() +  # Thème minimal pour une présentation épurée
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),  # Incliner les labels de l'axe X pour une meilleure lisibilité
    axis.text.y = element_text(size = 12),  # Lisibilité des valeurs sur l'axe Y
    axis.title = element_text(size = 14, face = "bold"),  # Titre des axes en gras
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5)  # Titre du graphique en gras et centré
  )


# Charger les bibliothèques nécessaires

# Charger les bibliothèques nécessaires
library(dplyr)

# Charger le jeu de données (remplacez par le chemin de votre fichier CSV)
data <- read.csv("../Exports/export_vents.csv")

# Diviser la Force du Vent en catégories (Faible, Moyenne, Forte)
data$Force_vent_cat <- cut(data$Force_vent_med, 
                           breaks = c(-Inf, 10, 20, Inf), 
                           labels = c("Faible", "Moyenne", "Forte"))

# Calculer les moyennes et les écarts types par catégorie de force du vent
summary_stats <- data %>%
  group_by(Force_vent_cat) %>%
  summarise(
    Moyenne = mean(surface_parcourue_m2, na.rm = TRUE),
    Ecart_type = sd(surface_parcourue_m2, na.rm = TRUE),
    N = n()
  )

print(summary_stats)

# Test t de Student pour comparer les moyennes entre "Faible" et "Forte"
group_faible <- subset(data, Force_vent_cat == "Faible")
group_forte <- subset(data, Force_vent_cat == "Forte")

# Test t pour comparer les moyennes des surfaces parcourues entre les deux groupes
t_test_result <- t.test(group_faible$surface_parcourue_m2, group_forte$surface_parcourue_m2)

# Affichage des résultats du test t
print(t_test_result)
