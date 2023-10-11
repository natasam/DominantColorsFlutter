# dominant_colors 
### (soon on the pub.dev)
A  Flutter project that extracts dominant colors from images using the K-means algorithm. 
Here is the article explaining this specific algorithm used for this case: 

[Medium Article - Extracting Dominant Image Colors in Flutter with the K-means++ Algorithm](https://medium.com/@natasa.misic10/extracting-dominant-image-colors-in-flutter-with-the-k-means-algorithm-bdf2b829bde5)

Because the goal is to find the most dominant colors in a photo, clustering algorithms are the best solution. K-means is the most widely used centroid-based clustering algorithm. K-means++ is an improved version of the K-means algorithm. It's main advantage is a smarter initialization of the centroids, which tends to lead to faster convergence and better final clustering results.

## Screenshot examples

  <img src="screenshots/1.png" alt="Flutter screenshot 1" width="200"> <img src="screenshots/2.png" alt="Flutter screenshot 2" width="200"> <img src="screenshots/3.png" alt="Flutter screenshot 3" width="200"> <img src="screenshots/0.png" alt="Flutter screenshot 0" width="200">
