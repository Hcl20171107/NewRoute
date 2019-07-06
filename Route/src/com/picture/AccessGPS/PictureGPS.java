package com.picture.AccessGPS;

import java.io.File;
import java.io.IOException;
import java.math.*;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;



public class PictureGPS {
	public static void main(String[] args) throws Exception, Exception{  
        File file1 = new File("C:\\Users\\hp\\Desktop\\images\\理工楼.jpg"); 
        File file2 = new File("C:\\Users\\hp\\Desktop\\images\\宿舍楼.jpg");  
        File file3 = new File("C:\\Users\\hp\\Desktop\\images\\行知楼.jpg");  
        File file4 = new File("C:\\Users\\hp\\Desktop\\images\\海量广场.jpg");  
        File file5 = new File("C:\\Users\\hp\\Desktop\\images\\赤峰市.jpg");  
        printImageTags(file1);
        printImageTags(file2);
        printImageTags(file3);
        printImageTags(file4);
        printImageTags(file5);
        
    } 
	

	private static void printImageTags(File file) throws ImageProcessingException, Exception{  
    	Metadata metadata = ImageMetadataReader.readMetadata(file);  
        for (Directory directory : metadata.getDirectories()) {  
            for (Tag tag : directory.getTags()) {  
                String tagName = tag.getTagName();  
                String desc = tag.getDescription(); 
                if (tagName.equals("Image Height")) {  
                	System.out.println("图片高度: "+desc);
                } else if (tagName.equals("Image Width")) {  
                	System.out.println("图片宽度: "+desc);
                } else if (tagName.equals("Date/Time Original")) {  
                	System.out.println("拍摄时间: "+desc);
                }else if (tagName.equals("GPS Latitude")) {  
                	System.err.println("纬度 : "+desc);
                } else if (tagName.equals("GPS Longitude")) {  
                	System.err.println("经度: "+desc);
                }
            }  
        }  
    }  
   
    public static String pointToLatlong (String point ) {  
        Double du = Double.parseDouble(point.substring(0, point.indexOf("°")).trim());  
        Double fen = Double.parseDouble(point.substring(point.indexOf("°")+1, point.indexOf("'")).trim());  
        Double miao = Double.parseDouble(point.substring(point.indexOf("'")+1, point.indexOf("\"")).trim());  
        Double duStr = du + fen / 60 + miao / 60 / 60 ;  
        return duStr.toString();  
    } 
}