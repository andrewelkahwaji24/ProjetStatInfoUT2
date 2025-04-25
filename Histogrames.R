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


# Charger les bibliothèques nécessaires
library(dplyr)
library(ggplot2)

# Charger le jeu de données (remplacez par le chemin de votre fichier CSV)
data <- read.csv("../Exports/export_vents.csv")

# Calcul des statistiques de la Force du Vent par code INSEE
stats_vent_par_zone <- data %>%
  group_by(code_INSEE) %>%
  summarise(
    Moyenne_vent = mean(Force_vent_med, na.rm = TRUE),
    Ecart_type_vent = sd(Force_vent_med, na.rm = TRUE),
    Vent_min = min(Force_vent_med, na.rm = TRUE),
    Vent_max = max(Force_vent_med, na.rm = TRUE),
    N = n()
  )

# Affichage des résultats
print(stats_vent_par_zone)

# Visualisation de la Force du Vent par zone géographique (Code INSEE)
ggplot(stats_vent_par_zone, aes(x = reorder(code_INSEE, Moyenne_vent), y = Moyenne_vent)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Force du Vent par Zone Géographique (Code INSEE)", 
       x = "Code INSEE", 
       y = "Moyenne de la Force du Vent") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +  # Incliner les labels de l'axe X pour lisibilité
  theme_minimal()


library(ggplot2)
library(dplyr)

# Charger les données
data <- read.csv("../Exports/export_vents.csv")
library(dplyr)

# Sélectionner un sous-ensemble des données (par exemple, 100 premières lignes)
data_sample <- data[1:100, ]

# Regrouper et créer le graphique avec les données réduites
data_summary <- data_sample %>%
  group_by(code_INSEE) %>%
  summarise(Force_vent_moyenne = mean(Force_vent_med, na.rm = TRUE))

ggplot(data_summary, aes(x = factor(code_INSEE), y = Force_vent_moyenne)) + 
  geom_bar(stat = "identity", fill = "blue") + 
  labs(title = "Force du vent par zone géographique",
       x = "Code INSEE",
       y = "Force du vent moyenne (m/s)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))






# Charger les données
data <- read.csv("../Exports/export_vents.csv")
# Calcul de la corrélation entre Force du Vent et Surface Parcourue
cor(data$Force_vent_med, data$surface_parcourue_m2, use = "complete.obs")


library(ggplot2)
library(dplyr)

# Trier les données par surface parcourue et garder les 10 premières zones
top_10_zones <- data_summary %>%
  arrange(desc(Surface_parcourue_total)) %>%
  head(10)

# Créer le graphique avec ces 10 zones
ggplot(top_10_zones, aes(x = factor(code_INSEE), y = Surface_parcourue_total)) + 
  geom_bar(stat = "identity", fill = "red") + 
  labs(title = "Top 10 des zones avec la plus grande surface parcourue par le feu",
       x = "Code INSEE",
       y = "Surface parcourue (m²)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotation des labels pour plus de lisibilité


data <- read.csv("../Exports/export_vents.csv")
# Vérifier les valeurs manquantes
sum(is.na(data$Tens_vap_med))  # Nombre de NA dans Tens_vap_med
sum(is.na(data$surface_parcourue_m2))  # Nombre de NA dans surface_parcourue_m2
# Vérifier la longueur des deux variables
length(data$Tens_vap_med)
length(data$surface_parcourue_m2)
data <- read.csv("../Exports/export_vents.csv")

# Tracer un graphique de dispersion pour visualiser la relation
plot(data$Force_vent_med, data$surface_parcourue_m2,
     main = "Relation entre Tens_vap_med et surface_parcourue_m2",
     xlab = "Force_vent_med", ylab = "Surface parcourue (m²)",
     pch = 19, col = "blue")

# Ajouter une ligne de régression (si besoin)
abline(lm(surface_parcourue_m2 ~ Force_vent_med, data = data), col = "red")

correlation <- cor(data$Force_vent_med, data$surface_parcourue_m2, use = "complete.obs")
print(paste("Corrélation entre Tens_vap_med et surface_parcourue_m2: ", correlation))

# Désactiver la notation scientifique
options(scipen = 999)

# Tracer le graphique de dispersion avec les données nettoyées
plot(data$Force_vent_med, data$surface_parcourue_m2,
     main = "Relation entre Force_vent_med et surface_parcourue_m2",
     xlab = "Force du vent (m/s)", ylab = "Surface parcourue (m²)",
     pch = 19, col = "blue")

# Ajouter une ligne de régression
abline(lm(surface_parcourue_m2 ~ Force_vent_med, data = data), col = "red")


# Tracer le graphique de dispersion pour Force_vent_med et surface_parcourue_m2
plot(data$Force_vent_med, data$surface_parcourue_m2,
     main = "Relation entre Force_vent_med et surface_parcourue_m2",
     xlab = "Force du vent médiane (m/s)", ylab = "Surface parcourue (m²)",
     pch = 19, col = "blue")

# Ajouter une ligne de régression
abline(lm(surface_parcourue_m2 ~ Force_vent_med, data = data), col = "red")







library(ggplot2)

# Charger les données
data <- read.csv("../Exports/export_vents.csv")

# Créer un graphique avec régression polynomial
ggplot(data, aes(x = Force_vent_med, y = surface_parcourue_m2)) +
  geom_point(color = "black", size = 2) + 
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "blue", se = FALSE) + 
  labs(title = "Régression Polynomial", 
       x = "Force du Vent", 
       y = "Surface Parcourue (m²)") +
  theme_minimal()



# Histogramme avec courbe de densité pour la Force du Vent
data <- read.csv("../Exports/export_vents.csv")
ggplot(data, aes(x = Force_vent_med)) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "red", color = "black", alpha = 0.7) +
  geom_density(color = "blue", size = 1) + 
  labs(title = "Distribution de la Force du Vent avec Courbe de Densité", x = "Force du Vent", y = "Densité") +
  theme_minimal()


# Créer une variable catégorielle pour la force du vent
data$vent_categorie <- cut(data$Force_vent_med, breaks = c(0, 3, 5, 10), labels = c("Faible", "Modéré", "Fort"))

# Graphique pour comparer la surface parcourue par le feu selon la catégorie de vent
ggplot(data, aes(x = vent_categorie, y = surface_parcourue_m2)) +
  geom_boxplot(fill = "lightblue", color = "black") + 
  labs(title = "Surface Parcourue par le Feu en fonction de la Force du Vent", x = "Catégorie de Vent", y = "Surface Parcourue (m²)") +
  theme_minimal()
str(data)


library(ggplot2)
data <- read.csv("../Exports/export_Humidites.csv")
ggplot(data, aes(x = Tens_vap_med, y = surface_parcourue_m2)) +
  geom_point(color = "blue", alpha = 0.6) +  # Ajoute les points
  geom_smooth(method = "lm", color = "red", se = FALSE) +  # Ajoute la droite de régression
  labs(title = "Corrélation entre Force du Vent et Surface Parcourue",
       x = "Force du Vent (moyenne)",
       y = "Surface Parcourue (m²)") +
  theme_minimal()


library(ggplot2)
data <- read.csv("../Exports/export_Humidites.csv")
ggplot(data, aes(x = Tens_vap_med, y = surface_parcourue_m2)) +
  geom_point(alpha = 0.6, color = "blue") +  # Points du nuage
  geom_smooth(method = "lm", color = "red", se = FALSE) +  # Régression linéaire
  labs(title = "Corrélation entre Force_vent_med et surface_parcourue_m2",
       x = "Force du vent (médiane)",
       y = "Surface parcourue (m²)") +
  theme_minimal()

correlation <- cor(incendiesregions$surface_parcourue_m2, incendiesregions$altitude_med, use = "complete.obs")
print(paste("Corrélation de Pearson entre la surface des incendies et l'altitude : ", round(correlation, 2)))


# Créer un graphique boxplot pour comparer les surfaces des incendies selon la zone d'altitude
library(ggplot2)
incendiesregions <- read.csv("../Exports/export_incendiesregions.csv")
# Comparer la surface des incendies entre les zones haute et basse altitude
ggplot(incendiesregions, aes(x = altitude_zone, y = surface_parcourue_m2)) +
  geom_boxplot(fill = c("lightblue", "lightgreen")) +
  labs(title = "Surface des incendies par zone d'altitude", 
       x = "Zone d'altitude", 
       y = "Surface parcourue (m²)") +
  theme_minimal()


# Créer un graphique de comptage pour comparer le nombre d'incendies selon la zone d'altitude
ggplot(incendiesregions, aes(x = altitude_zone)) +
  geom_bar(fill = c("lightblue", "lightgreen")) +
  labs(title = "Nombre d'incendies par zone d'altitude", 
       x = "Zone d'altitude", 
       y = "Nombre d'incendies") +
  theme_minimal()


# Visualisation de la corrélation avec un graphique de type scatter plot (nuage de points)
ggplot(incendiesregions, aes(x = altitude_med, y = surface_parcourue_m2)) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "Corrélation entre l'altitude et la surface des incendies",
       x = "Altitude (m)", y = "Surface parcourue des incendies (m²)") +
  theme_minimal() +
  geom_smooth(method = "lm", se = FALSE, color = "red")


# Visualisation du modèle de régression polynomiale
ggplot(incendiesregions, aes(x = altitude_med, y = surface_parcourue_m2)) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "Régression Polynomiale entre Altitude et Surface des Incendies",
       x = "Altitude (m)", y = "Surface parcourue des incendies (m²)") +
  theme_minimal() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE, color = "red")


# Histogramme de la surface des incendies par zone d'altitude
ggplot(incendiesregions, aes(x = surface_parcourue_m2, fill = altitude_zone)) +
  geom_histogram(binwidth = 5000, position = "dodge", alpha = 0.7) +
  labs(title = "Distribution de la surface des incendies par zone d'altitude",
       x = "Surface des incendies (m²)", y = "Fréquence") +
  theme_minimal()

# Boxplot pour comparer la surface des incendies entre haute et basse altitude
ggplot(incendiesregions, aes(x = altitude_zone, y = surface_parcourue_m2)) +
  geom_boxplot(fill = c("lightblue", "lightgreen")) +
  labs(title = "Surface des incendies par zone d'altitude", 
       x = "Zone d'altitude", 
       y = "Surface parcourue (m²)") +
  theme_minimal()

# Graphique de ligne pour la variation de la surface des incendies au fil des années
ggplot(incendiesregions, aes(x = annee, y = surface_parcourue_m2, color = altitude_zone)) +
  geom_line() +
  labs(title = "Variation de la surface des incendies au fil des années",
       x = "Année", y = "Surface parcourue des incendies (m²)") +
  theme_minimal()

# Diagramme en barres empilées pour la nature des incendies par zone d'altitude
ggplot(incendiesregions, aes(x = altitude_zone, fill = nature_inc_prim)) +
  geom_bar(position = "stack") +
  labs(title = "Répartition des types d'incendies par zone d'altitude",
       x = "Zone d'altitude", y = "Nombre d'incendies") +
  theme_minimal()


incendiesregions <- read.csv("../Exports/export_incendiesregions.csv")
# Visualisation de la corrélation avec un graphique de type scatter plot (nuage de points)
ggplot(incendiesregions, aes(x = altitude_med, y = surface_parcourue_m2)) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "Corrélation entre l'altitude et la surface des incendies",
       x = "Altitude (m)", y = "Surface parcourue des incendies (m²)") +
  theme_minimal() +
  geom_smooth(method = "lm", se = FALSE, color = "red")

correlation <- cor(incendiesregions$surface_parcourue_m2, incendiesregions$altitude_med, use = "complete.obs")
print(paste("Corrélation de Pearson entre la surface des incendies et l'altitude : ", round(correlation, 2)))



# Visualisation du modèle de régression polynomiale
ggplot(incendiesregions, aes(x = altitude_med, y = surface_parcourue_m2)) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "Régression Polynomiale entre Altitude et Surface des Incendies",
       x = "Altitude (m)", y = "Surface parcourue des incendies (m²)") +
  theme_minimal() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = TRUE, color = "red")



# Histogramme de la surface des incendies par zone d'altitude
ggplot(incendiesregions, aes(x = surface_parcourue_m2, fill = altitude_zone)) +
  geom_histogram(binwidth = 5000, position = "dodge", alpha = 0.7) +
  labs(title = "Distribution de la surface des incendies par zone d'altitude",
       x = "Surface des incendies (m²)", y = "Fréquence") +
  theme_minimal()


incendiesregions <- read.csv("../Exports/export_incendiesregions.csv")
ggplot(incendiesregions, aes(x = altitude_zone, y = surface_parcourue_m2)) +
  geom_boxplot(fill = c("lightblue", "lightgreen")) +
  labs(title = "Surface des incendies par zone d'altitude", 
       x = "Zone d'altitude", 
       y = "Surface parcourue (m²)") +
  theme_minimal()

# Graphique de ligne pour la variation de la surface des incendies au fil des années
ggplot(incendiesregions, aes(x = annee, y = surface_parcourue_m2, color = altitude_zone)) +
  geom_line() +
  labs(title = "Variation de la surface des incendies au fil des années",
       x = "Année", y = "Surface parcourue des incendies (m²)") +
  theme_minimal()

# Diagramme en barres empilées pour la nature des incendies par zone d'altitude
ggplot(incendiesregions, aes(x = altitude_zone, fill = nature_inc_prim)) +
  geom_bar(position = "stack") +
  labs(title = "Repartition des types d'incendies par zone d'altitude",
       x = "Zone d'altitude", y = "Nombre d'incendies") +
  theme_minimal()

ggplot(incendiesregions, aes(x = annee, fill = nature_inc_prim)) +
  geom_bar(position = "fill") +  
  labs(title = "Repartition des types d'incendies par annee",  # Sans accents
       x = "Annee",
       y = "Proportion",
       fill = "Type d'incendie") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")

install.packages("dplyr")  # Exécuter une seule fois si le package n'est pas installé
library(dplyr)  # Charger le package

incendies_summarized <- incendiesregions %>%
  group_by(annee, nature_inc_prim) %>%
  summarise(nombre = n(), .groups = 'drop') %>%
  group_by(annee) %>%
  mutate(proportion = nombre / sum(nombre))  # Calcul des proportions

# Création du graphique en courbes
ggplot(incendies_summarized, aes(x = annee, y = proportion, color = nature_inc_prim, group = nature_inc_prim)) +
  geom_line(linewidth = 1.2) +  # Utilisation de linewidth au lieu de size
  geom_point(size = 3) +   # Ajouter des points pour mieux voir les données
  labs(title = "Évolution des types d'incendies par année",
       x = "Année",
       y = "Proportion",
       color = "Type d'incendie") +
  scale_color_brewer(palette = "Set2") +  # Palette de couleurs pour différencier les catégories
  theme_minimal() +
  theme(legend.position = "bottom")  # Déplacer la légende en bas


# Graphique de ligne pour la variation de la surface des incendies au fil des années
ggplot(incendiesregions, aes(x = annee, y = surface_parcourue_m2, color = altitude_zone)) +
  geom_line() +
  labs(title = "Variation de la surface des incendies au fil des années",
       x = "Année", y = "Surface parcourue des incendies (m²)") +
  theme_minimal()

ggplot(incendiesregions, aes(x = altitude_zone, fill = nature_inc_prim)) +
  geom_bar(position = "fill") +
  labs(title = "Repartition des types d'incendies par zone d'altitude",
       x = "Zone d'altitude", y = "Nombre d'incendies") +
  theme_minimal()


# Créer la matrice des fréquences observées (sans les totaux)
observed <- matrix(c(200, 400, 500, 50,  # Zone Basse
                     30, 100, 50, 10),   # Zone Haute
                   nrow = 4, byrow = FALSE)
rownames(observed) <- c("Accidentelle", "Involontaire", "Malveillance", "Naturelle")
colnames(observed) <- c("Basse", "Haute")

# Afficher les fréquences observées
print("Fréquences observées :")
print(observed)

# Calculer les totaux des lignes et des colonnes
row_totals <- rowSums(observed)
col_totals <- colSums(observed)
grand_total <- sum(observed)

# Calculer les fréquences attendues
expected <- matrix(0, nrow = 4, ncol = 2)
for (i in 1:4) {
  for (j in 1:2) {
    expected[i, j] <- (row_totals[i] * col_totals[j]) / grand_total
  }
}
rownames(expected) <- rownames(observed)
colnames(expected) <- colnames(observed)

# Afficher les fréquences attendues
print("Fréquences attendues :")
print(round(expected, 2))

# Calculer le Chi²
chi2_contrib <- matrix(0, nrow = 4, ncol = 2)
for (i in 1:4) {
  for (j in 1:2) {
    chi2_contrib[i, j] <- (observed[i, j] - expected[i, j])^2 / expected[i, j]
  }
}
chi2_stat <- sum(chi2_contrib)

# Afficher les contributions au Chi²
print("Contributions au Chi² :")
print(round(chi2_contrib, 4))

# Afficher la statistique Chi²
print("Statistique Chi² :")
print(chi2_stat)

# Degré de liberté
df <- (nrow(observed) - 1) * (ncol(observed) - 1)
print("Degré de liberté :")
print(df)

# Valeur critique (pour alpha = 0.05)
critical_value <- qchisq(0.95, df)
print("Valeur critique (alpha = 0.05) :")
print(critical_value)


incendiesregions <- read.csv("../Exports/export_incendiesregions.csv")
ggplot(incendiesregions, aes(x = annee, y = surface_parcourue_m2, color = altitude_zone)) +
  geom_line() +
  labs(title = "Variation de la surface des incendies au fil des annees",
       x = "Annee", y = "Surface parcourue des incendies") +
  theme_minimal()


incendiesregions <- read.csv("../Exports/export_incendiesregions.csv")

# Diagramme en barres empilées pour la nature des incendies par zone d'altitude
ggplot(incendiesregions, aes(x = altitude_zone, fill = nature_inc_prim)) +
  geom_bar(position = "stack") +
  labs(title = "Repartition des types d'incendies par zone d'altitude",
       x = "Zone d'altitude", y = "Nombre d'incendies") +
  theme_minimal()



incendiesregions <- read.csv("../Exports/export_incendiesregions.csv")

ggplot(incendiesregions, aes(x = annee, fill = nature_inc_prim)) +
  geom_bar(position = "fill") +  # Position "fill" pour montrer les proportions
  labs(title = "Repartition des types d'incendies par annee",
       x = "Annee",
       y = "Proportion",
       fill = "Type d'incendie") +
  theme_minimal() +  # Thème minimal pour rendre le graphique plus clair
  scale_fill_brewer(palette = "Set2")  # Palette de couleurs pour différencier les types d'incendies

incendies <- read.csv("../Exports/export_incendies.csv")

# Convert 'heure' column to integer (extract hour from time)
incendies$heure <- as.character(incendies$heure)
incendies$heure <- as.integer(sub(":.*", "", incendies$heure))

# Plot histogram
hist(
  incendies$heure, 
  main = "Nombre d'incendies par heure", 
  xlab = "Heure", 
  ylab = "Nombre d'incendies", 
  col = "red", 
  border = "black", 
  breaks = seq(0, 23, 1), 
  xaxt = "n",  # Hide default x-axis
  cex.axis = 0.8
)
axis(1, at = seq(0, 23, 1), labels = seq(0, 23, 1), cex.axis = 0.8)



library(ggplot2)
library(dplyr)

# Charger les données
agg_data <- read.csv("../Exports/export_incendiestempheure.csv")

# Calculer le nombre d'incendies par jour (regroupement par an, mois, jour)
agg_data_daily <- agg_data %>%
  group_by(annee, mois, jour) %>%
  summarise(nb_incendies = n(),   # Nombre d'incendies par jour
            tmax_med = mean(tmax_med, na.rm = TRUE))   # Température maximale moyenne par jour

# Créer un graphique en nuage de points avec ggplot2
ggplot(agg_data_daily, aes(x = tmax_med, y = nb_incendies)) +
  geom_point(color = "#1f77b4", size = 3, alpha = 0.7) +  # Points de données (couleur et opacité ajustées)
  geom_smooth(method = "lm", color = "red", se = FALSE, linetype = "dashed", size = 1.2) +  # Ligne de régression (ajout de type de ligne et taille)
  labs(
    title = "Relation entre la température maximale quotidienne et le nombre d'incendies",
    subtitle = "Analyse de la température maximale (°C) et des incendies par jour",
    x = "Température Maximale Quotidienne (°C)",
    y = "Nombre d'Incendies",
    caption = "Source: Données d'incendies et température"
  ) +
  theme_minimal(base_size = 14) +  # Thème minimal avec taille de base augmentée pour meilleure lisibilité
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),  # Centrer et formater le titre
    plot.subtitle = element_text(hjust = 0.5, size = 12),               # Centrer et formater le sous-titre
    axis.title = element_text(size = 14),                                # Taille des titres des axes
    axis.text = element_text(size = 12),                                 # Taille des labels des axes
    plot.caption = element_text(size = 10, hjust = 1)                    # Taille et alignement de la légende
  )



library(ggplot2)
library(dplyr)

# Charger les données
agg_data <- read.csv("../Exports/export_incendiestempheure.csv")

# Créer des classes de température (par ex. tous les 2°C)
agg_data_bins <- agg_data %>%
  mutate(
    tmax_bin = cut(tmax_med, breaks = seq(0, max(tmax_med, na.rm = TRUE) + 2, by = 2), right = FALSE)
  ) %>%
  group_by(tmax_bin) %>%
  summarise(nb_incendies = n())

# Visualiser : Histogramme des incendies par classe de température
ggplot(agg_data_bins, aes(x = tmax_bin, y = nb_incendies)) +
  geom_col(fill = "#FF5733", alpha = 0.8) +
  geom_vline(xintercept = which(agg_data_bins$nb_incendies == max(agg_data_bins$nb_incendies)), 
             linetype = "dashed", color = "blue", size = 1) +
  labs(
    title = "Seuils de température critique pour l'émergence des incendies",
    x = "Température maximale quotidienne (par classes de 2°C)",
    y = "Nombre total d'incendies",
    caption = "Source: Données incendies et température"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )


library(ggplot2)
library(dplyr)

# Charger les données
agg_data <- read.csv("../Exports/export_incendiestempheure.csv")

# Aggrégation par mois et heure
agg_data_periode <- agg_data %>%
  group_by(mois, heure) %>%
  summarise(nb_incendies = n())

# Mois en facteur pour l'affichage correct
agg_data_periode$mois <- factor(agg_data_periode$mois, levels = 1:12, labels = month.name)
agg_data_periode <- droplevels(agg_data_periode)

ggplot(agg_data_periode, aes(x = heure, y = mois, fill = nb_incendies)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "red") +
  scale_y_discrete(drop = TRUE) +   # 🔴 ici on évite les NA sur l’axe Y
  labs(
    title = "Périodes à risque élevé d'incendie",
    x = "Heure de la journée",
    y = "Mois",
    fill = "Nombre d'incendies"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

agg_data_periode <- agg_data %>%
  filter(!is.na(mois), mois >= 1 & mois <= 12, !is.na(heure)) %>%  # Suppression des NA
  group_by(mois, heure) %>%
  summarise(nb_incendies = n(), .groups = "drop") %>%
  mutate(
    mois = factor(mois, levels = 1:12, labels = month.name)
  )


print("Check levels de mois")
print(levels(agg_data_periode$mois))

print("Check table mois")
print(table(agg_data_periode$mois, useNA = "ifany"))

print("Check head")
print(head(agg_data_periode))

agg_data_periode <- agg_data %>%
  filter(!is.na(mois) & mois >= 1 & mois <= 12, !is.na(heure)) %>%  # Supprime NA juste après le chargement
  group_by(mois, heure) %>%
  summarise(nb_incendies = n(), .groups = "drop") %>%
  mutate(
    mois = factor(mois, levels = 1:12, labels = month.name)
  )


agg_data_periode <- agg_data %>%
  filter(mois >= 1 & mois <= 12, !is.na(heure)) %>%
  group_by(mois, heure) %>%
  summarise(nb_incendies = n(), .groups = "drop") %>%
  mutate(
    mois = factor(mois, levels = 1:12, labels = month.name)
  )



# Charger les bibliothèques nécessaires
library(dplyr)
library(ggplot2)

# Charger les données
agg_data <- read.csv("../Exports/export_incendiestempheure.csv")

# Convertir la colonne 'mois' en facteur avec un ordre correct (Jan -> Dec)
agg_data$mois <- factor(agg_data$mois, levels = month.name)

# Vérifier la conversion
print(table(agg_data$mois))  # Vérifie la répartition des mois

# Aggrégation par mois et heure
agg_data_periode <- agg_data %>%
  filter(!is.na(mois) & mois %in% month.name, !is.na(heure)) %>%  # Supprimer les NA et s'assurer que les mois sont valides
  group_by(mois, heure) %>%
  summarise(nb_incendies = n(), .groups = "drop") %>%
  mutate(
    mois = factor(mois, levels = month.name)  # Assure que les mois sont ordonnés de janvier à décembre
  )

# Créer le graphique (Heatmap) : Nombre d'incendies en fonction de l'heure et du mois
ggplot(agg_data_periode, aes(x = heure, y = mois, fill = nb_incendies)) +
  geom_tile(color = "white") +  # Bordures blanches pour bien séparer les cases
  scale_fill_gradient(low = "white", high = "red") +  # Dégradé du blanc au rouge
  labs(
    title = "Périodes à risque élevé d'incendie",
    x = "Heure de la journée",
    y = "Mois",
    fill = "Nombre d'incendies"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Vérifier les valeurs uniques dans la colonne 'mois'
unique(agg_data$mois)

# Si les mois sont numériques (1 à 12), les convertir en noms de mois
agg_data$mois <- factor(agg_data$mois, levels = 1:12, labels = month.name)

# Vérifier que la conversion a bien fonctionné
table(agg_data$mois)




incendies <- read.csv("../Data/donnees_incendies.csv")
incendies$mois <- factor(incendies$mois, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

nb_incendies_par_mois <- table(incendies$mois)

barplot(nb_incendies_par_mois, 
        col = "orange", 
        border = "black", 
        main = "Nombre d'incendies par mois", 
        xlab = "Mois", 
        ylab = "Nombre d'incendies",
        las = 2)  


incendies$saison <- NA 

incendies$saison[incendies$mois %in% c("Dec", "Jan", "Feb")] <- "Hiver"
incendies$saison[incendies$mois %in% c("Mar", "Apr", "May")] <- "Printemps"
incendies$saison[incendies$mois %in% c("Jun", "Jul", "Aug")] <- "Été"
incendies$saison[incendies$mois %in% c("Sep", "Oct", "Nov")] <- "Automne"

nb_incendies_par_saison <- table(incendies$saison)

couleurs_saisons <- c("Hiver" = "blue", "Printemps" = "green", "Été" = "orange", "Automne" = "brown")

barplot(nb_incendies_par_saison, 
        col = couleurs_saisons[names(nb_incendies_par_saison)],  
        border = "black", 
        main = "Nombre d'incendies par saison", 
        xlab = "Saison", 
        ylab = "Nombre d'incendies")



incendies <- read.csv("../Data/donnees_incendies.csv")

incendies$jour <- as.Date(incendies$jour, format="%Y-%m-%d")

head(incendies$jour)

Sys.setlocale("LC_TIME", "fr_FR.UTF-8")  
incendies$jour_semaine <- weekdays(incendies$jour, abbreviate = FALSE)


incendies$jour_semaine <- factor(incendies$jour_semaine, 
                                 levels = c("lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"))

semaine_incendies <- sum(incendies$jour_semaine %in% c("lundi", "mardi", "mercredi", "jeudi", "vendredi"))
weekend_incendies <- sum(incendies$jour_semaine %in% c("samedi", "dimanche"))

total_incendies <- c(semaine = semaine_incendies, weekend = weekend_incendies)

par(mar = c(2, 2, 2, 2))  
pie(total_incendies, 
    col = c("lightblue", "orange"), 
    main = "Repartition des incendies entre semaine et week-end",
    labels = c("Semaine (Lun-Ven)", "Week-end (Sam-Dim)"),
    cex = 1) 



data <- read.csv("../Exports/export_impactvapeure.csv")

library(ggplot2)

# Créer un graphique de dispersion entre la pression de vapeur et la surface parcourue par le feu
ggplot(data, aes(x = tens_vap_med, y = surface_parcourue_m2)) +
  geom_point(color = "blue") +  # Points bleus
  geom_smooth(method = "lm", color = "red") +  # Ajouter une droite de régression linéaire
  labs(title = "Impact de la pression de vapeur sur la vitesse de propagation des incendies",
       x = "Pression de vapeur (hPa)",
       y = "Surface parcourue par le feu (m²)") +
  theme_minimal()


model <- lm(surface_parcourue_m2 ~ tens_vap_med, data = data)
on



# Calcul de la corrélation de Pearson
correlation <- cor(data$tens_vap_med, data$surface_parcourue_m2, method = "pearson")

# Afficher le résultat
correlation



# Charger la bibliothèque ggplot2 pour la visualisation
library(ggplot2)

# Créer un graphique de dispersion entre la pression de vapeur et la surface parcourue par le feu
ggplot(data, aes(x = tens_vap_med, y = surface_parcourue_m2)) +
  geom_point(color = "blue") +  # Afficher les points en bleu
  geom_smooth(method = "lm", color = "red", linetype = "dashed") +  # Droite de régression linéaire
  labs(title = "Relation entre la pression de vapeur et la surface parcourue par le feu",
       x = "Pression de vapeur (hPa)",
       y = "Surface parcourue par le feu (m²)") +
  theme_minimal()










# Charger les librairies nécessaires
library(dplyr)

# Supposons que votre dataframe s'appelle df
df <- read.csv("../Exports/export_impactclimaturbanisation.csv")  # Charger vos données

# Modèle de régression linéaire
mod <- lm(rr_med ~ nature_sec_inc, data = df)

# Résumé du modèle
summary(mod)

# Visualiser les résultats du modèle avec ggplot
ggplot(df, aes(x = nature_sec_inc, y = rr_med)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, col = "red") +
  labs(title = "Régression de RR_med sur nature_sec_inc", x = "Nature de l'incident", y = "RR_med")



# Calculer la moyenne de 'RR_med' par 'code_INSEE'
avg_rrmed_by_insee <- aggregate(rr_med ~ code_INSEE, data = df, FUN = mean)

# Visualiser les résultats
ggplot(avg_rrmed_by_insee, aes(x = reorder(code_INSEE, rr_med), y = rr_med)) +
  geom_bar(stat = "identity") +
  labs(title = "Moyenne de RR_med par code INSEE", x = "Code INSEE", y = "Moyenne de RR_med") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Modèle de régression pour évaluer l'impact de 'code_INSEE' et 'nature_sec_inc' sur 'RR_med'
mod_multi <- lm(rr_med ~ nature_sec_inc + code_INSEE, data = df)

# Résumé du modèle
summary(mod_multi)










# Chargement des librairies
library(ggplot2)
library(dplyr)
library(sf)
library(readr)

# Importation des données
data <- read_csv("../Exports/export_impactclimaturbanisation.csv")

# Suppression des NA sur les colonnes pertinentes
data_clean <- data %>%
  filter(!is.na(rr_med), !is.na(nature_sec_inc))

# 1. Boxplot rr_med par nature_sec_inc (sans NA)
ggplot(data_clean, aes(x = nature_sec_inc, y = rr_med, fill = nature_sec_inc)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Distribution de rr_med par type d'incident secondaire",
       x = "Type d'incident secondaire",
       y = "Risque relatif médian (rr_med)") +
  theme(legend.position = "none")

# 2. Histogramme de rr_med (sans NA)
ggplot(data_clean, aes(x = rr_med)) +
  geom_histogram(binwidth = 0.5, fill = "#2c7fb8", color = "white") +
  theme_minimal() +
  labs(title = "Histogramme de rr_med",
       x = "Risque relatif médian",
       y = "Nombre d'occurrences")

# 3. Barplot du nombre d'incidents par nature_sec_inc (sans NA)
data_clean %>%
  count(nature_sec_inc) %>%
  ggplot(aes(x = reorder(nature_sec_inc, n), y = n, fill = nature_sec_inc)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Nombre d'incidents par type",
       x = "Type d'incident secondaire",
       y = "Nombre d'incidents") +
  theme(legend.position = "none")

  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Nombre d'incidents par type",
       x = "Type d'incident secondaire",
       y = "Nombre d'incidents") +
  theme(legend.position = "none")

# 4. Heatmap géographique (optionnel si code_INSEE = géolocalisation)
# Pour ça, il te faut un fond de carte des communes INSEE (fichier shapefile ou via {mapsf}, {cartography} etc.)
# Exemple simple si tu as une base géographique

# Si tu veux je peux aussi t’ajouter un choropleth map (carte colorée) par INSEE et rr_med si tu m’en dis plus sur tes codes_INSEE.


  data_clean %>%
    count(nature_sec_inc) %>%
    ggplot(aes(x = reorder(nature_sec_inc, n), y = n, fill = nature_sec_inc)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    theme_minimal() +
    labs(title = "Nombre d'incidents par type",
         x = "Type d'incident secondaire",
         y = "Nombre d'incidents") +
    theme(legend.position = "none")
  
  

  
incendies <- read.csv("../Data/donnees_incendies.csv")
  
incendies$annee <- as.numeric(incendies$annee)
  
  
incendies_criminels <- subset(incendies, nature_inc_prim == "Malveillance")
  
incendies_par_annee <- table(incendies_criminels$annee)
  
incendies_par_annee_df <- data.frame(annee = as.numeric(names(incendies_par_annee)), 
                                       nombre_incendies = as.vector(incendies_par_annee))
  
  
incendies_total_par_annee <- table(incendies$annee)
  
incendies_total_par_annee_df <- data.frame(annee = as.numeric(names(incendies_total_par_annee)),
                                             nombre_incendies_total = as.vector(incendies_total_par_annee))
  
  par(mar=c(5, 4, 4, 5) + 0.1)
  
  plot(incendies_par_annee_df$annee, incendies_par_annee_df$nombre_incendies, 
       type="o", col="red", 
       xlab="Année", ylab="Nombre d'incendies criminels", 
       main="Relation entre les incendies criminels et le total d'incendies",
       ylim=c(0, max(incendies_par_annee_df$nombre_incendies) * 1.2))  # Aumenta el límite del eje y izquierdo
  
  lines(incendies_total_par_annee_df$annee, incendies_total_par_annee_df$nombre_incendies_total, 
        type="o", col="blue", pch=16)
  
  axis(4, at=seq(0, max(incendies_total_par_annee_df$nombre_incendies_total), by=500), 
       labels=seq(0, max(incendies_total_par_annee_df$nombre_incendies_total), by=500))
  
  legend("topright", legend=c("Malveillance", "Total des incendies"), 
         col=c("red", "blue"), lty=1, pch=5, xpd=TRUE, inset=c(0.05, 1.1))
  
  
  
  
  
  
  
  library(ggplot2)
  
  donnees_combinees<- read.csv("../Exports/export_incendies_criminels.csv")
  library(ggplot2)
  
  ggplot(donnees_combinees, aes(x = tmax_med, fill = nature_inc_prim)) +
    geom_histogram(position = "dodge", bins = 30, alpha = 0.7) +  # Slight transparency for better visibility
    scale_fill_manual(values = c("#FF6347", "#4682B4", "#32CD32", "#FFD700")) +  # Custom colors for the fill
    labs(
      title = "Distribution de la Température Maximale en Fonction de la Nature des Incendies",
      x = "Température Maximale (°C)",  # More specific axis label
      y = "Fréquence",  # More specific y-axis label
      fill = "Nature des Incendies"  # Label for the fill legend
    ) +
    theme_minimal() +  # Cleaner background
    theme(
      plot.title = element_text(size = 12, face = "bold", color = "darkblue", hjust = 0.5),  # Title styling
      axis.title.x = element_text(size = 14, face = "bold", color = "black"),  # X-axis title styling
      axis.title.y = element_text(size = 14, face = "bold", color = "black"),  # Y-axis title styling
      axis.text = element_text(size = 12, color = "black"),  # Axis text styling
      legend.title = element_text(size = 12, face = "bold"),  # Legend title styling
      legend.text = element_text(size = 9)  # Legend text styling
    ) +
    theme(axis.line = element_line(size = 0.8, color = "black"))  # Adds border to the plot
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  data <- read.csv("../Exports/export_meteo.csv", header = TRUE, sep = ",")
  variables <- c("Tmin_med", "Tmax_med", "RR_med", "NBJRR1_med", "NBJRR5_med", 
                 "NBJRR10_med", "Tens_vap_med", "Force_vent_med", 
                 "Insolation_med", "Rayonnement_med")
  data_subset <- data[, variables]
  corr <- cor(data_subset, use = "complete.obs")
  plot(data$Tmin_med, data$Rayonnement_med, 
       main = "Tmin_med vs Rayonnement_med",
       xlab = "Tmin_med (°C)", ylab = "Rayonnement_med",
       pch = 16, col = "red")
  abline(lm(Rayonnement_med ~ Tmin_med, data = data), col = "black", lwd = 2)  
  plot(data$Tmax_med, data$Insolation_med, 
       main = "Tmax_med vs Insolation_med",
       xlab = "Tmax_med (°C)", ylab = "Insolation_med",
       pch = 16, col = "blue")
  abline(lm(Insolation_med ~ Tmax_med, data = data), col = "black", lwd = 2) 
  plot(data$Tmax_med, data$Force_vent_med, 
       main = "Tmax_med vs Force_vent_med",
       xlab = "Tmax_med (°C)", ylab = "Force_vent_med",
       pch = 16, col = "green")
  abline(lm(Force_vent_med ~ Tmax_med, data = data), col = "black", lwd = 2)  
  
  par(mfrow = c(1, 1))
  
  
  
  
  
  
  data <- read.csv("../Exports/export_meteo.csv", header = TRUE, sep = ",")
  variables <- c("Tmin_med", "Tmax_med", "RR_med", "NBJRR1_med", "NBJRR5_med", 
                 "NBJRR10_med", "Tens_vap_med", "Force_vent_med", 
                 "Insolation_med", "Rayonnement_med")
  data_subset <- data[, variables]
  corr <- cor(data_subset, use = "complete.obs")
  print("Matrice de corrélation :")
  round(corr, 2)
  par(mfrow = c(2, 2))  
  plot(data$Tmin_med, data$Rayonnement_med, 
       main = "Tmin_med vs Rayonnement_med",
       xlab = "Tmin_med (°C)", ylab = "Rayonnement_med",
       pch = 16, col = "red")

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  data <- read.csv("../Exports/export_meteo.csv", header = TRUE, sep = ",")
  variables <- c("Tmin_med", "Tmax_med", "RR_med", "NBJRR1_med", "NBJRR5_med", 
                 "NBJRR10_med", "Tens_vap_med", "Force_vent_med", 
                 "Insolation_med", "Rayonnement_med")
  data_subset <- data[, variables]
  corr <- cor(data_subset, use = "complete.obs")
  print("Matrice de corrélation :")
  round(corr, 2)
  par(mfrow = c(1, 1))  
  plot(data$Tmin_med, data$Rayonnement_med, 
       main = "Tmin_med vs Rayonnement_med",
       xlab = "Tmin_med (°C)", ylab = "Rayonnement_med",
       pch = 16, col = "red")
  abline(lm(Rayonnement_med ~ Tmin_med, data = data), col = "black", lwd = 2)  
  plot(data$Tmax_med, data$Insolation_med, 
       main = "Tmax_med vs Insolation_med",
       xlab = "Tmax_med (°C)", ylab = "Insolation_med",
       pch = 16, col = "blue")
  abline(lm(Insolation_med ~ Tmax_med, data = data), col = "black", lwd = 2) 
  plot(data$Tmax_med, data$Force_vent_med, 
       main = "Tmax_med vs Force_vent_med",
       xlab = "Tmax_med (°C)", ylab = "Force_vent_med",
       pch = 16, col = "green")
  abline(lm(Force_vent_med ~ Tmax_med, data = data), col = "black", lwd = 2)  
  
  par(mfrow = c(1, 1))
  
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




install.packages("lubridate")  # Exécuter une seule fois si le package n'est pas installé

# 📦 Chargement des packages
library(tidyverse)
library(lubridate)

# 📂 Charger les données (adapter le chemin si besoin)
df <- read_csv("../Data/donnees_incendies.csv")

# 🕒 Traitement des plages horaires
df <- df %>%
  mutate(
    heure_num = as.numeric(str_sub(heure, 1, 2)),  # extrait l'heure (ex: "14:30" -> 14)
    tranche_horaire = case_when(
      heure_num >= 0 & heure_num < 3 ~ "00-03h",
      heure_num >= 3 & heure_num < 6 ~ "03-06h",
      heure_num >= 6 & heure_num < 9 ~ "06-09h",
      heure_num >= 9 & heure_num < 12 ~ "09-12h",
      heure_num >= 12 & heure_num < 15 ~ "12-15h",
      heure_num >= 15 & heure_num < 18 ~ "15-18h",
      heure_num >= 18 & heure_num < 21 ~ "18-21h",
      heure_num >= 21 & heure_num <= 23 ~ "21-24h",
      TRUE ~ "Heure inconnue"
    )
  )

df <- read_csv("../Data/donnees_incendies.csv")

# 📊 Comptage des incendies par tranche horaire et type
df_summary <- df %>%
  group_by(tranche_horaire, nature_inc_sec) %>%
  summarise(n = n(), .groups = "drop")

# 🎨 Graphe empilé
ggplot(df_summary, aes(x = tranche_horaire, y = n, fill = nature_inc_sec)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Distribution des incendies par tranche horaire",
    x = "Tranche horaire",
    y = "Nombre d'incendies",
    fill = "Nature secondaire de l'incendie"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_viridis_d()

# Re-niveaute les tranches pour l'ordre logique
df_summary$tranche_horaire <- factor(
  df_summary$tranche_horaire,
  levels = c("00-03h", "03-06h", "06-09h", "09-12h", "12-15h", "15-18h", "18-21h", "21-24h")
)

# 💅 Nouveau graphe stylé
ggplot(df_summary, aes(x = tranche_horaire, y = n, fill = nature_inc_sec)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7, color = "white", linewidth = 0.3) +
  scale_fill_brewer(palette = "YlOrRd") +  # Palette chaude
  labs(
    title = "🔥 Heures critiques des incendies par nature",
    subtitle = "Répartition des incendies secondaires selon les tranches horaires",
    x = "Tranche horaire",
    y = "Nombre d'incendies",
    fill = "Nature secondaire"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", size = 16, color = "#B22222"),
    plot.subtitle = element_text(size = 12, margin = margin(b = 10)),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "right",
    legend.background = element_rect(fill = "transparent"),
    panel.grid.major.y = element_line(color = "#eeeeee"),
    panel.grid.minor = element_blank()
  )


install.packages("geosphere")  # Exécuter une seule fois si le package n'est pas installé


# 📦 Chargement des packages
library(tidyverse)
library(geosphere)

# 🌊 Villes côtières représentatives (tu peux en ajouter plus si tu veux)
villes_cotieres <- tibble(
  ville = c("Brest", "Marseille", "Nice", "Biarritz", "Toulon"),
  lat = c(48.3904, 43.2965, 43.7102, 43.4832, 43.1242),
  lon = c(-4.4861, 5.3698, 7.2620, -1.5586, 5.9281)
)

# 📂 Charger les données d'incendies
df_incendies <- read_csv("../Data/donnees_geo.csv")

# 🧭 Calculer pour chaque incendie la distance minimale à une ville côtière
df_incendies <- df_incendies %>%
  filter(!is.na(longitude), !is.na(latitude)) %>%
  rowwise() %>%
  mutate(
    distance_min = min(
      map2_dbl(
        villes_cotieres$lon, villes_cotieres$lat,
        ~ distVincentySphere(c(longitude, latitude), c(.x, .y))
      ) / 1000  # Convertir en kilomètres
    )
  ) %>%
  ungroup()

# 📊 Catégorisation par distance à la côte
df_incendies <- df_incendies %>%
  mutate(
    categorie_distance_cote = case_when(
      distance_min <= 10 ~ "Proche de la côte (<10 km)",
      distance_min <= 50 ~ "Modéré (10-50 km)",
      distance_min > 50 ~ "Loin de la côte (>50 km)",
      TRUE ~ "Inconnu"
    )
  )

# 📈 Résumé pour le graphe
df_summary <- df_incendies %>%
  count(categorie_distance_cote)

# 🎨 Graphique : Nombre d'incendies selon la distance à la côte
ggplot(df_summary, aes(x = categorie_distance_cote, y = n, fill = categorie_distance_cote)) +
  geom_col(width = 0.6, color = "white") +
  scale_fill_brewer(palette = "YlOrRd") +
  labs(
    title = "🔥 Risque d'incendie et proximité à la côte",
    subtitle = "Analyse par distance minimale à des villes côtières",
    x = "Catégorie de distance à la côte",
    y = "Nombre d'incendies"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", color = "#B22222"),
    axis.text.x = element_text(angle = 30, hjust = 1),
    legend.position = "none"
  )

colnames(df_incendies)


library(tidyverse)
library(geosphere)

# 📂 Charger les données d'incendies avec coordonnées
df_incendies <- read_csv("../Data/donnees_geo.csv")

# 🌊 Coordonnées de villes côtières françaises
villes_cotieres <- tibble(
  ville = c("Brest", "Marseille", "Nice", "Biarritz", "Toulon", "La Rochelle", "Dunkerque", "Ajaccio", "Calais"),
  lat = c(48.3904, 43.2965, 43.7102, 43.4832, 43.1242, 46.1603, 51.0350, 41.9192, 50.9513),
  lon = c(-4.4861, 5.3698, 7.2620, -1.5586, 5.9281, -1.1511, 2.3770, 8.7386, 1.8521)
)

# 🧮 Calculer la distance minimale à une ville côtière
df_incendies <- df_incendies %>%
  filter(!is.na(longitude), !is.na(latitude)) %>%
  rowwise() %>%
  mutate(
    distance_min = min(
      map2_dbl(
        villes_cotieres$lon, villes_cotieres$lat,
        ~ distVincentySphere(c(longitude, latitude), c(.x, .y))
      ) / 1000  # en kilomètres
    )
  ) %>%
  ungroup()

# 🏷️ Créer des catégories de distance
df_incendies <- df_incendies %>%
  mutate(
    categorie_distance_cote = case_when(
      distance_min <= 10 ~ "Proche de la côte (<10 km)",
      distance_min <= 50 ~ "Modéré (10-50 km)",
      distance_min > 50 ~ "Loin de la côte (>50 km)",
      TRUE ~ "Inconnu"
    )
  )

# 📊 Compter les incendies dans chaque catégorie
frequences_observees <- df_incendies %>%
  count(categorie_distance_cote) %>%
  filter(categorie_distance_cote != "Inconnu")

# 🧪 Test du chi² avec données réelles
total <- sum(frequences_observees$n)
expected <- rep(total / nrow(frequences_observees), nrow(frequences_observees))

# Exécution du test
test_chi2 <- chisq.test(frequences_observees$n, p = rep(1 / nrow(frequences_observees), nrow(frequences_observees)))

# 🖨️ Afficher résultats
print(frequences_observees)
print(test_chi2)






library(tidyverse)
library(geosphere)

df_incendies <- read_csv("../Data/donnees_geo.csv")

villes_cotieres <- tibble(
  ville = c("Brest", "Marseille", "Nice", "Biarritz", "Toulon"),
  lat = c(48.3904, 43.2965, 43.7102, 43.4832, 43.1242),
  lon = c(-4.4861, 5.3698, 7.2620, -1.5586, 5.9281)
)

df_incendies <- df_incendies %>%
  filter(!is.na(longitude), !is.na(latitude)) %>%
  rowwise() %>%
  mutate(
    distance_min = min(
      map2_dbl(
        villes_cotieres$lon, villes_cotieres$lat,
        ~ distVincentySphere(c(longitude, latitude), c(.x, .y))
      ) / 1000  # en kilomètres
    )
  ) %>%
  ungroup()

df_incendies <- df_incendies %>%
  mutate(
    categorie_distance_cote = case_when(
      distance_min <= 10 ~ "Proche de la côte (<10 km)",
      distance_min <= 50 ~ "Modéré (10-50 km)",
      distance_min > 50 ~ "Loin de la côte (>50 km)",
      TRUE ~ "Inconnu"
    )
  )

frequences_observees <- df_incendies %>%
  count(categorie_distance_cote) %>%
  filter(categorie_distance_cote != "Inconnu")

total <- sum(frequences_observees$n)
expected <- rep(total / nrow(frequences_observees), nrow(frequences_observees))

test_chi2 <- chisq.test(frequences_observees$n, p = rep(1 / nrow(frequences_observees), nrow(frequences_observees)))

print(frequences_observees)
print(test_chi2)






library(tidyverse)
library(lubridate)

# 1️⃣ Charger les données
df <- read_csv("../Data/donnees_incendies.csv")

# 2️⃣ Filtrer les incendies de type malveillance
df_malveillance <- df %>%
  filter(str_detect(tolower(nature_inc_prim), "malveillance"))

# 3️⃣ Extraction de l'heure et création de tranches horaires
df_malveillance <- df_malveillance %>%
  mutate(
    heure_num = as.numeric(str_sub(heure, 1, 2)),
    tranche_horaire = case_when(
      heure_num >= 0 & heure_num < 6 ~ "Nuit (00h-06h)",
      heure_num >= 6 & heure_num < 12 ~ "Matin (06h-12h)",
      heure_num >= 12 & heure_num < 18 ~ "Après-midi (12h-18h)",
      heure_num >= 18 & heure_num < 24 ~ "Soir (18h-00h)",
      TRUE ~ "Heure inconnue"
    )
  )

# 4️⃣ Graphe : distribution par tranche horaire
ggplot(df_malveillance, aes(x = tranche_horaire, fill = tranche_horaire)) +
  geom_bar(width = 0.7, color = "white") +
  labs(
    title = "⏰ Profil horaire des incendies criminels",
    x = "Tranche horaire",
    y = "Nombre d'incendies"
  ) +
  scale_fill_brewer(palette = "Reds") +
  theme_minimal() +
  theme(legend.position = "none")

library(tidyverse)

# Charger les données
df <- read_csv("../Data/donnees_incendies.csv")

# Filtrer les incendies criminels
df_criminels <- df %>%
  filter(nature_inc_prim == "Criminel")

# Vérifier les mois disponibles
unique(df_criminels$mois)

# Graphe du nombre d'incendies criminels par mois
df_criminels %>%
  count(mois) %>%
  ggplot(aes(x = factor(mois, levels = month.abb), y = n, fill = mois)) +
  geom_col(width = 0.6, color = "white") +
  scale_fill_brewer(palette = "Reds") +
  labs(
    title = "🔥 Incendies criminels par mois",
    x = "Mois",
    y = "Nombre d'incendies"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", color = "#B22222"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none"
  )

colnames(df)
unique(df$mois)



library(tidyverse)

# 🔥 Filtrer les incendies criminels uniquement
df_criminels <- df %>%
  filter(nature_inc_prim == "Criminel") %>%
  filter(!is.na(mois)) %>%
  mutate(
    mois = factor(mois, levels = month.abb)  # Pour trier les mois dans l'ordre
  )

# 📊 Graphe du nombre d'incendies criminels par mois
ggplot(df_criminels %>% count(mois), aes(x = mois, y = n, fill = mois)) +
  geom_col(width = 0.7, color = "white") +
  scale_fill_brewer(palette = "Reds") +
  labs(
    title = "🔥 Incendies criminels par mois",
    subtitle = "Analyse temporelle des actes de malveillance",
    x = "Mois",
    y = "Nombre d'incendies"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", color = "#B22222"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none"
  )



df_malveillance <- df_malveillance %>%
  mutate(
    heure_num = as.numeric(str_sub(heure, 1, 2)),
    tranche_horaire = case_when(
      heure_num >= 0 & heure_num < 6 ~ "Nuit (00h-06h)",
      heure_num >= 6 & heure_num < 12 ~ "Matin (06h-12h)",
      heure_num >= 12 & heure_num < 18 ~ "Après-midi (12h-18h)",
      heure_num >= 18 & heure_num < 24 ~ "Soir (18h-00h)",
      TRUE ~ "Heure inconnue"
    )
  )
# Travailler le facteur pour l'ordre des mois
df_malveillance <- df_malveillance %>%
  mutate(mois = factor(mois, levels = month.abb))  # Jan, Feb, ..., Dec

# Graphe par mois
ggplot(df_malveillance, aes(x = mois, fill = mois)) +
  geom_bar(width = 0.7, color = "white") +
  labs(
    title = "📆 Répartition mensuelle des incendies malveillants",
    x = "Mois",
    y = "Nombre d'incendies"
  ) +
  scale_fill_brewer(palette = "Reds") +
  theme_minimal() +
  theme(legend.position = "none")



# Charger les bibliothèques nécessaires
library(tidyverse)

# 1️⃣ Charger les données
df <- read_csv("../Data/donnees_incendies.csv")

# 2️⃣ Filtrer les incendies de type malveillance
df_malveillance <- df %>%
  filter(str_detect(tolower(nature_inc_prim), "malveillance"))

# 3️⃣ Extraction de l'heure et création de tranches horaires
df_malveillance <- df_malveillance %>%
  mutate(
    heure_num = as.numeric(str_sub(heure, 1, 2)),
    tranche_horaire = case_when(
      heure_num >= 0 & heure_num < 6 ~ "Nuit (00h-06h)",
      heure_num >= 6 & heure_num < 12 ~ "Matin (06h-12h)",
      heure_num >= 12 & heure_num < 18 ~ "Après-midi (12h-18h)",
      heure_num >= 18 & heure_num < 24 ~ "Soir (18h-00h)",
      TRUE ~ "Heure inconnue"
    )
  )

# 4️⃣ Compter les incendies par tranche horaire
freq_observees <- df_malveillance %>%
  count(tranche_horaire)

# 5️⃣ Calcul des fréquences attendues sous l'hypothèse d'une répartition uniforme
total_incendies <- sum(freq_observees$n)
freq_attendues <- rep(total_incendies / nrow(freq_observees), nrow(freq_observees))

# 6️⃣ Test du chi-deux
test_chi2 <- chisq.test(freq_observees$n, p = rep(1/nrow(freq_observees), nrow(freq_observees)), rescale.p = TRUE)

# Afficher les résultats du test
test_chi2



# Load required libraries
library(tidyverse)

# Read your data
df <- read_csv("../Data/donnees_incendies.csv")

# Filter for malicious fires (if needed)
df_malveillance <- df %>%
  filter(str_detect(tolower(nature_inc_prim), "malveillance"))

# Summarize the number of incidents by month
df_monthly_summary <- df_malveillance %>%
  group_by(mois) %>%
  summarise(n_incendies = n())

# View the summary by month
print(df_monthly_summary)

# Optional: Ensure the months are in correct order for visualization
df_monthly_summary <- df_monthly_summary %>%
  mutate(mois = factor(mois, levels = month.abb))  # Jan, Feb, ..., Dec

# View the final count by month for confirmation
print(df_monthly_summary)




# Charger les bibliothèques nécessaires
library(tidyverse)
library(lubridate)

# Charger les données
df <- read_csv("../Data/donnees_incendies.csv")

# Filtrer les incendies de type malveillance (si nécessaire)
df_malveillance <- df %>%
  filter(str_detect(tolower(nature_inc_prim), "malveillance"))

# Extraction de l'heure et création de tranches horaires
df_malveillance <- df_malveillance %>%
  mutate(
    heure_num = as.numeric(str_sub(heure, 1, 2)),
    tranche_horaire = case_when(
      heure_num >= 0 & heure_num < 6 ~ "Nuit (00h-06h)",
      heure_num >= 6 & heure_num < 12 ~ "Matin (06h-12h)",
      heure_num >= 12 & heure_num < 18 ~ "Après-midi (12h-18h)",
      heure_num >= 18 & heure_num < 24 ~ "Soir (18h-00h)",
      TRUE ~ "Heure inconnue"
    )
  )

# Agrégation du nombre d'incendies par tranche horaire
df_tranches_horaires <- df_malveillance %>%
  group_by(tranche_horaire) %>%
  summarise(n_incendies = n())

# Afficher les résultats
print(df_tranches_horaires)


















library(tidyverse)

# 1️⃣ Charger les données
df_incendies <- read_csv("../Data/donnees_incendies.csv")
df_geo <- read_csv("../Data/donnees_geo.csv")

# 2️⃣ Harmoniser les codes INSEE
df_incendies <- df_incendies %>%
  mutate(code_INSEE = str_pad(code_INSEE, 5, pad = "0"))

df_geo <- df_geo %>%
  mutate(code_INSEE = str_pad(code_INSEE, 5, pad = "0"))

# 3️⃣ Fusionner les deux jeux de données
df_merged <- df_incendies %>%
  left_join(df_geo, by = "code_INSEE")

# 4️⃣ Catégoriser l'altitude (par exemple en 3 classes)
df_merged <- df_merged %>%
  mutate(categorie_altitude = case_when(
    altitude_med < 200 ~ "Plaine (<200m)",
    altitude_med >= 200 & altitude_med < 500 ~ "Collines (200-500m)",
    altitude_med >= 500 ~ "Montagne (>500m)",
    TRUE ~ "Inconnu"
  ))

# 5️⃣ Compter les incendies par catégorie d'altitude
freq_altitude <- df_merged %>%
  count(categorie_altitude, name = "n_incendies") %>%
  filter(!is.na(categorie_altitude))

print(freq_altitude)

# 6️⃣ Visualiser
ggplot(freq_altitude, aes(x = categorie_altitude, y = n_incendies, fill = categorie_altitude)) +
  geom_col(width = 0.6, color = "white") +
  labs(
    title = "🔥 Répartition des incendies selon l'altitude moyenne des communes",
    x = "Catégorie d'altitude",
    y = "Nombre d'incendies"
  ) +
  scale_fill_brewer(palette = "Oranges") +
  theme_minimal() +
  theme(legend.position = "none")

# 7️⃣ Test du chi² pour voir si la répartition est significativement différente
if (nrow(freq_altitude) > 1) {
  test_chi2 <- chisq.test(freq_altitude$n_incendies)
  print(test_chi2)
}



# Charger les bibliothèques nécessaires
library(dplyr)
library(ggplot2)
library(tidyr)

# Charger vos données (remplacez 'data.csv' par le chemin réel de votre fichier)
data <- read.csv("../Exports/export_incendies.csv")

# Analyser les causes principales des incendies
cause_principale <- data %>%
  count(nature_inc_prim) %>%
  arrange(desc(n))

# Analyser les causes secondaires des incendies
cause_secondaire <- data %>%
  count(nature_inc_sec) %>%
  arrange(desc(n))

# Répartition des causes principales des incendies avec diagramme circulaire
ggplot(cause_principale, aes(x = "", y = n, fill = nature_inc_prim)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Répartition des Causes Principales des Incendies") +
  theme_minimal() +
  theme(axis.text = element_blank(), 
        axis.title = element_blank(),
        panel.grid = element_blank()) +
  scale_fill_brewer(palette = "Set3") # Choisir une palette de couleurs

# Répartition des causes secondaires des incendies avec diagramme circulaire
ggplot(cause_secondaire, aes(x = "", y = n, fill = nature_inc_sec)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Répartition des Causes Secondaires des Incendies") +
  theme_minimal() +
  theme(axis.text = element_blank(),
        axis.title = element_blank(),
        panel.grid = element_blank()) +
  scale_fill_brewer(palette = "Set2") # Choisir une autre palette de couleurs

# Analyser les causes combinées (principal + secondaire)
cause_combinee <- data %>%
  gather(key = "type_cause", value = "cause", nature_inc_prim, nature_inc_sec) %>%
  count(cause) %>%
  arrange(desc(n))

# Répartition des causes combinées avec diagramme circulaire
ggplot(cause_combinee, aes(x = "", y = n, fill = cause)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Répartition des Causes Combinées des Incendies") +
  theme_minimal() +
  theme(axis.text = element_blank(),
        axis.title = element_blank(),
        panel.grid = element_blank()) +
  scale_fill_brewer(palette = "Set1") # Choisir une palette de couleurs




# Nombre d'incendies par type de cause primaire
incendies_par_type_primaire <- data %>%
  count(nature_inc_prim) %>%
  arrange(desc(n))

# Afficher le résultat
incendies_par_type_primaire

# Nombre d'incendies par type de cause secondaire
incendies_par_type_secondaire <- data %>%
  count(nature_inc_sec) %>%
  arrange(desc(n))

# Afficher le résultat
incendies_par_type_secondaire



library(tidyr)
library(dplyr)

# Fusionner les deux colonnes de causes
cause_combinee <- data %>%
  pivot_longer(cols = c(nature_inc_prim, nature_inc_sec),
               names_to = "type_cause",
               values_to = "cause") %>%
  filter(!is.na(cause)) %>% # Exclure les NA
  count(cause) %>%
  arrange(desc(n))

# Afficher les causes combinées avec leur fréquence
cause_combinee

# Ajouter la colonne de pourcentages
cause_combinee_pct <- cause_combinee %>%
  mutate(pourcentage = n / sum(n) * 100)

# Afficher le résultat
cause_combinee_pct




# Chargement du fichier CSV combiné contenant les données incendie + météo
data <- read.csv("../Exports/export_incendies_meteo.csv", sep = ",", stringsAsFactors = FALSE)
library(ggplot2)
library(dplyr)

# Température max vs Surface brûlée
ggplot(data, aes(x = Tmax_med, y = surface_parcourue_m2)) +
  geom_point(alpha = 0.5, color = "firebrick") +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(title = "Température maximale vs Surface brûlée",
       x = "Température maximale moyenne (°C)",
       y = "Surface parcourue (m²)") +
  theme_minimal()

# Force du vent vs Surface brûlée
ggplot(data, aes(x = Force_vent_med, y = surface_parcourue_m2)) +
  geom_point(alpha = 0.5, color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(title = "Force du vent moyenne vs Surface brûlée",
       x = "Force du vent moyenne (km/h)",
       y = "Surface parcourue (m²)") +
  theme_minimal()

# Tension de vapeur (humidité) vs Surface brûlée
ggplot(data, aes(x = Tens_vap_med, y = surface_parcourue_m2)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(title = "Tension de vapeur moyenne vs Surface brûlée",
       x = "Tension de vapeur moyenne (hPa)",
       y = "Surface parcourue (m²)") +
  theme_minimal()


# Calcul de la corrélation entre température et surface brûlée
cor.test(data$Tmax_med, data$surface_parcourue_m2, method = "pearson")

cor.test(data$Force_vent_med, data$surface_parcourue_m2, method = "pearson")

cor.test(data$Tens_vap_med, data$surface_parcourue_m2, method = "pearson")


install.packages("GGally")

library(GGally)

# Sélection des variables météo + surface
df_meteo <- data %>%
  select(Force_vent_med, Tmax_med, Tens_vap_med, surface_parcourue_m2)

# Matrice de corrélation visuelle
ggpairs(df_meteo,
        title = "Corrélations entre variables météo et surface brûlée")



data <- data %>%
  mutate(temp_elevee = ifelse(Tmax_med > quantile(Tmax_med, 0.75, na.rm = TRUE), "Élevée", "Normale"))

ggplot(data, aes(x = temp_elevee, y = surface_parcourue_m2, fill = temp_elevee)) +
  geom_boxplot() +
  scale_y_log10() +  # si les surfaces sont très dispersées
  labs(title = "Impact de la température élevée sur la surface brûlée",
       x = "Température maximale (catégorisée)",
       y = "Surface parcourue (m²)") +
  theme_minimal() +
  scale_fill_manual(values = c("Élevée" = "red", "Normale" = "lightblue"))



library(ggplot2)

# Scatterplot avec couleur = température
ggplot(data, aes(x = Force_vent_med, y = Tens_vap_med, color = Tmax_med, size = surface_parcourue_m2)) +
  geom_point(alpha = 0.7) +
  scale_color_gradient(low = "blue", high = "red") +
  labs(title = "Surface brûlée selon conditions météo",
       x = "Force du vent moyenne",
       y = "Tension de vapeur moyenne",
       color = "Température max",
       size = "Surface brûlée (m²)") +
  theme_minimal()


data <- read.csv("../Exports/export_incendies_meteo.csv")
# Charger les bibliothèques nécessaires
library(ggplot2)

# Supposons que votre dataframe s'appelle 'incendies_data'
# et contient les colonnes Rayonnement_med et surface_parcourue_m2

# Exemple de graphique
ggplot(data, aes(x = Rayonnement_med, y = surface_parcourue_m2)) +
  geom_point(color = "darkorange", alpha = 0.7) +  # Nuage de points
  geom_smooth(method = "lm", color = "steelblue", se = TRUE) +  # Régression linéaire
  labs(
    title = "Impact du rayonnement solaire sur les surfaces brûlées",
    x = "Rayonnement solaire moyen (W/m²)",
    y = "Surface parcourue par les incendies (m²)"
  ) +
  theme_minimal()



cor.test(data$Rayonnement_med, data$surface_parcourue_m2)


install.packages("survminer")  # Exécuter une seule fois si le package n'est pas installé

# Charger les bibliothèques
library(survival)
library(survminer)
library(dplyr)

# Charger les données
data <- read.csv("../Exports/export_incendies_geo.csv")

# Regrouper les données par commune et année
# Créer un indicateur binaire : y a-t-il eu un incendie cette année ?
data_clean <- data %>%
  group_by(Code_INSEE, Année) %>%
  summarise(incendie = ifelse(n() > 0, 1, 0)) %>%
  ungroup()

# Créer une table de suivi pour chaque commune : durée entre deux incendies
# On prépare les périodes d'observation
data_survie <- data_clean %>%
  group_by(code_INSEE) %>%
  arrange(annee) %>%
  mutate(
    time = cumsum(incendie == 0),   # Nombre d'années sans incendie
    event = incendie                # 1 si incendie, 0 sinon
  ) %>%
  filter(event == 1)  # On ne garde que les périodes où l'événement a été observé

# Modèle Kaplan-Meier
surv_obj <- Surv(data_survie$time, data_survie$event)
fit_km <- survfit(surv_obj ~ 1)

# Graphique de la courbe de survie
ggsurvplot(
  fit_km,
  conf.int = TRUE,
  title = "Analyse de survie des communes face aux incendies",
  xlab = "Années sans incendie",
  ylab = "Probabilité de survie (pas d'incendie)",
  palette = "Dark2"
)





# Charger les bibliothèques
library(survival)   # Pour les modèles de survie
library(survminer)  # Pour les graphiques de survie
library(dplyr)      # Pour la manipulation des données

# Charger les données
data <- read.csv("../Exports/export_incendies_geo.csv")

# Nettoyage des données : créer une colonne pour identifier la présence d'incendie
# (On suppose que la colonne nature_inc_prim contient des valeurs non nulles quand il y a un incendie)
data_clean <- data %>%
  mutate(incendie = ifelse(!is.na(nature_inc_prim), 1, 0))  # 1 si incendie, 0 sinon

# Regrouper les données par Code_INSEE et Année
data_clean <- data_clean %>%
  group_by(code_INSEE, annee) %>%
  summarise(incendie = max(incendie)) %>%
  ungroup()  # Résumé des incendies par commune et année

# Créer une table de suivi pour chaque commune
# On calcule le nombre d'années sans incendie et l'événement (1 = incendie, 0 = pas d'incendie)
data_survie <- data_clean %>%
  group_by(code_INSEE) %>%
  arrange(annee) %>%
  mutate(
    time = cumsum(incendie == 0),   # Calcul du nombre d'années sans incendie
    event = incendie                # 1 si incendie, 0 sinon
  ) %>%
  filter(event == 1)  # Ne garder que les périodes où l'événement (incendie) se produit

# Modèle Kaplan-Meier pour la survie
surv_obj <- Surv(data_survie$time, data_survie$event)
fit_km <- survfit(surv_obj ~ 1)

# Visualisation de la courbe de survie
ggsurvplot(
  fit_km,
  data = data_survie,  # On précise ici l'argument data
  conf.int = TRUE,
  title = "Analyse de survie des communes face aux incendies",
  xlab = "Années sans incendie",
  ylab = "Probabilité de survie (pas d'incendie)",
  palette = "Dark2"
)


# Calculer la durée entre chaque incendie pour chaque commune
data_survie <- data_clean %>%
  group_by(code_INSEE) %>%
  arrange(annee) %>%
  mutate(
    # Calculer la durée entre les années d'incendie
    time = ifelse(incendie == 1, 0, lag(annee) - annee),   # Calcul de l'écart d'années entre deux incendies successifs
    time = ifelse(is.na(time), 0, time)  # Remplacer NA par 0 pour les premières années
  ) %>%
  mutate(
    event = incendie  # 1 si incendie, 0 sinon
  ) %>%
  filter(event == 1)  # Garder uniquement les lignes avec des incendies (event == 1)

# Vérifier les résultats
head(data_survie)

# Vérification de la somme des événements
table(data_survie$event)

# Vérification des résumés de `time`
summary(data_survie$time)





# Calculer la durée sans incendie (accumuler les années sans incendie)
data_survie <- data_clean %>%
  group_by(code_INSEE) %>%
  arrange(annee) %>%
  mutate(
    time = ifelse(incendie == 1, 0, NA)  # initialiser time à 0 quand il y a un incendie
  ) %>%
  mutate(
    # Calculer la durée entre chaque incendie successif
    time = ifelse(is.na(time), lag(time, default = 0) + 1, time)
  ) %>%
  mutate(
    event = incendie  # Garder 1 si incendie, 0 sinon
  ) %>%
  filter(event == 1)  # Garder uniquement les années où un incendie se produit

# Vérifier les résultats après modification
head(data_survie)

# Vérification des résumés de `time`
summary(data_survie$time)

# Vérification de la somme des événements
table(data_survie$event)




# Calculer la durée entre les incendies pour chaque commune
data_survie <- data_clean %>%
  group_by(code_INSEE) %>%
  arrange(code_INSEE, annee) %>%
  mutate(
    # Calculer la durée sans incendie entre deux événements
    time = ifelse(incendie == 1, 0, NA)  # Initialisation à 0 pour les incendies
  ) %>%
  mutate(
    # Utilisation de cumsum pour accumuler les années sans incendie
    time = ifelse(is.na(time), cumsum(incendie == 0), time)
  ) %>%
  mutate(
    event = incendie  # Garder 1 si incendie, 0 sinon
  )

# Vérifier les résultats après modification
head(data_survie)

# Vérification des résumés de `time`
summary(data_survie$time)

# Vérification de la somme des événements
table(data_survie$event)





library(dplyr)

# Calculer l'intervalle entre les incendies pour chaque commune
data_survie <- data_clean %>%
  group_by(code_INSEE) %>%
  arrange(code_INSEE, annee) %>%
  mutate(
    # Calculer la différence entre l'année courante et l'année précédente
    time = annee - lag(annee, default = first(annee)),
    event = incendie  # Garder 1 si incendie, 0 sinon
  ) %>%
  filter(event == 1)  # Garder uniquement les années où un incendie a eu lieu

# Vérification des résultats après modification
head(data_survie)

# Vérification des résumés de `time`
summary(data_survie$time)

# Vérification de la somme des événements
table(data_survie$event)



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

# Vérification des résultats après modification
head(data_survie)

# Vérification des résumés de `time`
summary(data_survie$time)

# Vérification de la somme des événements
table(data_survie$event)

library(survival)

# Créer un objet de survie
surv_obj <- Surv(time = data_survie$time, event = data_survie$event)

# Ajuster un modèle de survie
surv_fit <- survfit(surv_obj ~ 1)

# Visualiser la courbe de survie
plot(surv_fit, main = "Courbe de survie des incendies", xlab = "Temps (années)", ylab = "Probabilité de survie")



library(survival)
library(ggplot2)

# Créer un objet de survie
surv_obj <- Surv(time = data_survie$time, event = data_survie$event)

# Ajuster un modèle de survie
surv_fit <- survfit(surv_obj ~ 1)

# Convertir les résultats du modèle survfit en un dataframe pour ggplot
surv_data <- as.data.frame(surv_fit)

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





# 1. Charger les bibliothèques nécessaires
library(dplyr)
library(ggplot2)
library(readr)

# 2. Importer le fichier CSV
data_incendies <- read_csv("../Exports/export_incendies_geo.csv")

# 3. Vérifier les données
glimpse(data_incendies)

# 4. Nettoyer les données : enlever les valeurs manquantes (si nécessaire)
data_incendies <- data_incendies %>%
  filter(!is.na(code_INSEE), !is.na(commune))

# 5. Ajouter une variable simulée de taux d'urbanisation (si tu ne l'as pas dans le fichier)
# 👉 Tu peux remplacer ce simulateur par une vraie variable de ton dataset si tu l'as
set.seed(42)
taux_urbanisation_par_commune <- data_incendies %>%
  distinct(code_INSEE, commune) %>%
  mutate(taux_urbanisation = runif(n(), min = 0.1, max = 1))  # Valeur entre 10% et 100%

# 6. Nombre d’incendies par commune
nb_incendies_commune <- data_incendies %>%
  group_by(code_INSEE, commune) %>%
  summarise(nb_incendies = n(), .groups = "drop")

# 7. Fusion des données avec le taux d'urbanisation
data_finale <- nb_incendies_commune %>%
  left_join(taux_urbanisation_par_commune, by = c("code_INSEE", "commune"))

# 8. Analyse de corrélation
cor_result <- cor.test(data_finale$nb_incendies, data_finale$taux_urbanisation, method = "spearman")
print(cor_result)

# 9. Visualisation avec ggplot2
ggplot(data_finale, aes(x = taux_urbanisation, y = nb_incendies)) +
  geom_point(alpha = 0.6, color = "darkred") +
  geom_smooth(method = "lm", color = "blue", se = TRUE) +
  labs(
    title = "Corrélation entre urbanisation et fréquence d'incendies",
    subtitle = paste("Coefficient Spearman:", round(cor_result$estimate, 2)),
    x = "Taux d'urbanisation (simulé)",
    y = "Nombre d'incendies par commune"
  ) +
  theme_minimal()




data <- read.csv("../Exports/export_incendies_geo.csv", stringsAsFactors = FALSE)

data$travaux <- grepl("travaux", data$nature_inc_sec, ignore.case = TRUE)

data$classe_altitude <- ifelse(data$altitude_med <= 500, "0-500",
                               ifelse(data$altitude_med <= 1000, "500-1000",
                                      ifelse(data$altitude_med <= 1500, "1000-1500",
                                             ifelse(data$altitude_med <= 2000, "1500-2000", "2000+"))))

tab <- table(data$classe_altitude, data$travaux)

barplot(t(tab),
        beside = TRUE,
        col = c("lightblue", "tomato"),
        legend = c("Non-Travaux", "Travaux"),
        main = "Incendies liés aux travaux par altitude",
        xlab = "Classe d'altitude (m)",
        ylab = "Nombre d'incendies")


tab