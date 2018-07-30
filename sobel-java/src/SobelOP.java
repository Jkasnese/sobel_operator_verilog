import java.awt.Color;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

/***
 * Implementa o operador de Sobel em uma imagem em escala de cinza 
 *
 */

public class SobelOP {

	
	private static int sobelX[][] = {{-1, -2, -1}, {0, 0, 0},{1, 2, 1}}; 
	private static int sobelY[][] = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
	private static int width =525, height = 350, threshold = 16; // Dimensões da imagem e limiar 
	private static BufferedImage img = null, imgOut = new BufferedImage(width-2, height-2, BufferedImage.TYPE_INT_RGB);
	private static int[][] sumX = new int[width][height];
	private static int[][] sumY = new int[width][height], sumT = new int[width][height];
	private static String fileName = "flower"; // Nome do arquivo da imagem a ser processada
	private static File output = new File(fileName + "-sobel" + threshold + ".jpg");
	
	
	public static void main(String[] args) {
	

		try {
			img = ImageIO.read(new File(fileName + ".jpg"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		

		for(int i = 1; i < width-1; i++)
		{
			for(int j = 1; j < height-1; j++) {
			    
				
				sumX[i][j] =  (sobelX[0][0]*(new Color(img.getRGB(i-1, j-1)).getBlue())) +(sobelX[0][1]*(new Color(img.getRGB(i-1, j)).getBlue())) + (sobelX[0][2]*(new Color(img.getRGB(i-1, j+1)).getBlue())) + (sobelX[1][0]*(new Color(img.getRGB(i, j-1)).getBlue())) + (sobelX[1][1]*(new Color(img.getRGB(i, j)).getBlue())) + (sobelX[1][2]*(new Color(img.getRGB(i, j+1)).getBlue())) + (sobelX[2][0]*(new Color(img.getRGB(i+1, j-1)).getBlue())) + (sobelX[2][1]*(new Color(img.getRGB(i+1, j)).getBlue())) + (sobelX[2][2]*(new Color(img.getRGB(i+1, j+1)).getBlue()));
				
				if(sumX[i][j] < 0)
					sumX[i][j] *= (-1);
				
				sumY[i][j] =  (sobelY[0][0]*(new Color(img.getRGB(i-1, j-1)).getBlue())) +(sobelY[0][1]*(new Color(img.getRGB(i-1, j)).getBlue())) + (sobelY[0][2]*(new Color(img.getRGB(i-1, j+1)).getBlue())) + (sobelY[1][0]*(new Color(img.getRGB(i, j-1))).getBlue()) + (sobelY[1][1]*(new Color(img.getRGB(i, j)).getBlue())) + (sobelY[1][2]*(new Color(img.getRGB(i, j+1)).getBlue())) + (sobelY[2][0]*(new Color(img.getRGB(i+1, j-1)).getBlue())) + (sobelY[2][1]*(new Color(img.getRGB(i+1, j)).getBlue())) + (sobelY[2][2]*(new Color(img.getRGB(i+1, j+1)).getBlue()));
				
				if(sumY[i][j] < 0)
					sumY[i][j] *= (-1); 
				
				sumT[i][j] = sumX[i][j] + sumY[i][j]; 
				
				
				
			if(sumT[i][j] > 255)
				{	
					int r = 255, g = 255, b = 255;
					int rgb = (r<<16) + (g<<8) + b;
					sumT[i][j] = rgb;
				}
				
				if (sumT[i][j] < threshold) {
					int r = 0, g = 0, b = 0;
					int rgb = (r<<16) + (g<<8) + b;
					sumT[i][j] = rgb;
				}

				else {
					int r = sumT[i][j], g = sumT[i][j], b = sumT[i][j];
					int rgb = (r<<16) + (g<<8) + b;
					sumT[i][j] = rgb;
				}
				
				// binarizando imagem: 
				
				/*if(sumT[i][j] > threshold) {
					int r = 255, g = 255, b = 255;
					int rgb = (r<<16) + (g<<8) + b;
					sumT[i][j] = rgb;
				}
				else {
					int r = 0, g = 0, b = 0;
					int rgb = (r<<16) + (g<<8) + b;
					sumT[i][j] = rgb;
				}
				*/
				
								
				imgOut.setRGB(i-1, j-1, sumT[i][j]); // -1 porque inicialmente ele pega o pixel 1 da imagem original, na imagem resultante este será o pixel 0  
				
				// Printando valor do pixel
				if (sumT[i][j] > threshold) {
					System.out.print(new Color(imgOut.getRGB(i-1, j-1)).getBlue() + " ");					
				}

			}
			System.out.println("\n");
		}
		
		
		try {
			ImageIO.write(imgOut, "jpg", output);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
