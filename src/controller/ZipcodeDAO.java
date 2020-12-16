package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ZipcodeDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;

	public ZipcodeDAO() {
		try {
			Context initCtx = new InitialContext();
			Context ctx = (Context) initCtx.lookup("java:comp/env");
			DataSource source = (DataSource) ctx.lookup("jdbc/myoracle");
			con = source.getConnection();
		} catch (Exception e) {
			System.out.println("DBCP연결실패");
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			// 연결을 해제하는것이 아니고 풀에 다시 반납한다.
			if (rs != null)
				rs.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}

	public ArrayList<String> getSido() {
		ArrayList<String> sidoAddr = new ArrayList<String>();

		String sql = "SELECT sido FROM zipcode " + " WHERE 1=1 " + " GROUP BY sido " + " ORDER BY sido ASC";

		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while (rs.next()) {
				sidoAddr.add(rs.getString(1));
			}
		} catch (Exception e) {
		}
		return sidoAddr;
	}

	public ArrayList<String> getGugun(String sido) {
		ArrayList<String> gugunAddr = new ArrayList<String>();

		String sql = "SELECT sido FROM zipcode " +
				" WHERE sido=? " + 
				" ORDER BY gugun DESC";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, sido);
			rs = psmt.executeQuery();
			while (rs.next()) {
				gugunAddr.add(rs.getString(1));
			}
		} catch (Exception e) {
		}
		return gugunAddr;
	}
}
