# Annexes

## A. Insertion d’images (sans afficher de code)
Placez vos images dans `report/images/`, puis utilisez :

<img src="images/MLD.jpg" width="691" />

## B. Génération du livre
Dans RStudio : **Build → Build Book**.

Ou via R :
```r
bookdown::render_book("report/index.Rmd", "bookdown::gitbook")
```
