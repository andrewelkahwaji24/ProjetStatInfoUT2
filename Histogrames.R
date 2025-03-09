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



