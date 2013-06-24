function cleaned = preprocess(image)

greyScale = rgb2gray(image);
cleaned = greyScale < 65;

end