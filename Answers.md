## Exercice 2

1) LazyVGrid permet d’afficher des éléments sous forme de grille verticale. Il ne charge que les éléments visibles à l'écran et charge dynamiquement les autres lorsque l'utilisateur fait défiler la grille.
    On l'utlise pour optimiser les performances avec un comportement paresseux, ce qui est pratique pour les grandes listes.
2) Les différents types de colonnes sont :

- GridItem(.fixed(size)) : Une colonne d’une largeur fixe.
- GridItem(.adaptive(minimum: size)) : Une colonne dont la largeur s’adapte dynamiquement pour occuper tout l'espace disponible.
- GridItem(.flexible(minimum: size, maximum: size)) : Une colonne flexible, où la largeur peut s’ajuster entre une valeur minimum et maximum.

Les colonnes sont flexibles pour s’ajuster à l’espace disponible tout en maintenant une largeur minimum de 150 px, c'est ce qui nous permet aussi d'avoir une grille responsive.

3) Le problème vient du fait que les images sont redimensionnées pour remplir complètement les colonnes flexibles. Cela est dû au fait que les colonnes définies avec .flexible permettent de s’étendre autant que l’espace disponible.

## Exercice 4

3) 
- Async/Await fournit une syntaxe plus lisible et naturelle en utilisant des mots-clés comme async et await, le débogage est plus simple.
- Combine est Conçu pour la programmation réactive en manipulant des flux de données (Publishers/Subscribers). Il permet de chaîner et de combiner plusieurs opérations asynchrones grâce à des opérateurs fonctionnels comme map, flatMap, etc.
- Completion Handler / GCD est une méthode bien supportée mais moins intuitive. Il peut devenir difficile à lire et maintenir lorsque plusieurs appels sont chaînés.
GCD offre un contrôle direct sur les files d'attente, ce qui est utile pour des cas complexes ou précis.
