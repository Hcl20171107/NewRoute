package com.picture.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import com.picture.util.DBUtil;

public class MapDAO {
	public void save(String latitude, String longtitude) {
		String sql = "insert into coordinate(latitude,longtitude) values(?,?)";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, latitude);
			pstmt.setString(2, longtitude);
		
			pstmt.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBUtil.closeJDBC(null, pstmt, conn);
		}
		
	}
}
