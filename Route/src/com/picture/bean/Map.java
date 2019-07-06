package com.picture.bean;

public class Map {
	private int pictureId;
	private float latitude;
	private float longtitude;
	
	public Map() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Map(int pictureId, float latitude, float longtitude) {
		super();
		this.pictureId = pictureId;
		this.latitude = latitude;
		this.longtitude = longtitude;
	}

	public int getPictureId() {
		return pictureId;
	}

	public void setPictureId(int pictureId) {
		this.pictureId = pictureId;
	}

	public float getLatitude() {
		return latitude;
	}

	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}

	public float getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(float longtitude) {
		this.longtitude = longtitude;
	}
	
	
}
