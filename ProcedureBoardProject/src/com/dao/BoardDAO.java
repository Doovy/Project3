package com.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import oracle.jdbc.OracleTypes;

public class BoardDAO {
	private Connection conn;
	private CallableStatement cs;
	// 주소 얻기
	public void getConnection(){
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:/comp/env/jdbc/oracle");
			conn = ds.getConnection();
		} catch (NamingException | SQLException e) {
			e.printStackTrace();
		}
	}
	// 반환
	public void disConnection(){
		if(cs!= null){
			try {cs.close();} catch (SQLException e) {e.printStackTrace();}	
		}
		if(conn!=null){
			try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
	}
	// 기능
	public List<BoardDTO> boardListData(int page){
		List<BoardDTO> list = new ArrayList<>();
		getConnection();
		int rowSize = 10;
		int start = rowSize * (page-1) + 1;
		int end = page*rowSize;
		String sql = "{CALL boardListData(?, ?, ?)}";
		try {
			cs = conn.prepareCall(sql);
			cs.registerOutParameter(1, OracleTypes.CURSOR);
			cs.setInt(2, start);
			cs.setInt(3, end);
			cs.executeUpdate();
			ResultSet rs = (ResultSet)cs.getObject(1);
			while(rs.next()){
				BoardDTO d = new BoardDTO();
				d.setNo(rs.getInt(1));
				d.setSubject(rs.getString(2));
				d.setName(rs.getString(3));
				d.setRegdate(rs.getDate(4));
				d.setHit(rs.getInt(5));
				d.setGroup_tab(rs.getInt(6));
				d.setRowNum(rs.getInt(7));
				list.add(d);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
	
	public void boardInsert(BoardDTO d){
		getConnection();
		String sql = "{CALL boardInsert(?,?,?,?,?)}";
		try {
			cs = conn.prepareCall(sql);
			cs.setString(1, d.getName());
			cs.setString(2, d.getEmail());
			cs.setString(3, d.getSubject());
			cs.setString(4, d.getContent());
			cs.setString(5, d.getPwd());
			cs.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	
	public BoardDTO boardContentData(int no){
		BoardDTO d = new BoardDTO();
		getConnection();
		String sql = "{CALL boardContentData(?, ?)}";
		try {
			cs = conn.prepareCall(sql);
			cs.setInt(1, no);
			cs.registerOutParameter(2, OracleTypes.CURSOR);
			cs.executeUpdate();
			ResultSet rs = (ResultSet)cs.getObject(2);
			rs.next();
			d.setNo(rs.getInt(1));
			d.setName(rs.getString(2));
			d.setEmail(rs.getString(3));
			d.setSubject(rs.getString(4));
			d.setContent(rs.getString(5));
			d.setRegdate(rs.getDate(6));
			d.setHit(rs.getInt(7));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		return d;
	}
	
	public int boardTotalPage(){
		int total = 0;
		getConnection();
		String sql = "{CALL boardRowCount(?)}";
		try {
			cs = conn.prepareCall(sql);
			cs.registerOutParameter(1, OracleTypes.INTEGER);
			cs.executeUpdate();
			int count = cs.getInt(1);
			total = (int)(Math.ceil((count/10.0)));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
		return total;
	}
	
	public int boardRowCount(){
		int total = 0;
		getConnection();
		String sql = "{CALL boardRowCount(?)}";
		try {
			cs = conn.prepareCall(sql);
			cs.registerOutParameter(1, OracleTypes.INTEGER);
			cs.executeUpdate();
			total = cs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
		return total;
	}
	
}
