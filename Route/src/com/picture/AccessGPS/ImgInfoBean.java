package com.picture.AccessGPS;

public class ImgInfoBean {
	private String imgHeight ;
	private String imgWidth ;
	private String dateTime ;
	private String altitude ;
	private String latitude;
	private String longitude ;
	private Long imgSize;
	private String imgName;
	public Long getImgSize() {
	    return imgSize;
	}
	public void setImgSize(Long imgSize) {
	    this.imgSize = imgSize;
	}
	public String getImgName() {
	    return imgName;
	}
	public void setImgName(String imgName) {
	    this.imgName = imgName;
	}
	public String getImgHeight() {
	    return imgHeight;
	}
	public void setImgHeight(String imgHeight) {
	    this.imgHeight = imgHeight;
	}
	public String getImgWidth() {
	    return imgWidth;
	}
	public void setImgWidth(String imgWidth) {
	    this.imgWidth = imgWidth;
	}
	public String getDateTime() {
	    return dateTime;
	}
	public void setDateTime(String dateTime) {
	    this.dateTime = dateTime;
	}
	public String getAltitude() {
	    return altitude;
	}
	public void setAltitude(String altitude) {
	    this.altitude = altitude;
	}
	public String getLatitude() {
	    return latitude;
	}
	public void setLatitude(String latitude) {
	    this.latitude = latitude;
	}
	public String getLongitude() {
	    return longitude;
	}
	public void setLongitude(String longitude) {
	    this.longitude = longitude;
	}
	public float getLongitudeNumber() {
		float longitude=Float.parseFloat(this.longitude);
	    return longitude;
	}
	public float getLatitudeNumber() {
		float latitude=Float.parseFloat(this.latitude);
		return latitude;
	}
	public String toString (){
	    return "图片名字"+ this.imgName+"图片尺寸"+this.imgSize +"图片高度"+this.imgHeight+"图片宽度"+this.imgWidth+"拍摄时间"+this.dateTime+"海拔"+this.altitude+"纬度"+this.latitude+"经度"+this.longitude;
	}
}
