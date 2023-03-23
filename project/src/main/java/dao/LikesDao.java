package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;
import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import dao.mapper.LikesMapper;
import dao.mapper.UserMapper;
import logic.Board;
import logic.Likes;
import logic.User;

@Repository
public class LikesDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<LikesMapper> cls = LikesMapper.class;

	private Connection conn;	
	private ResultSet rs;

	public List<Board> getList(int pageNum, int limit, String userid){
		param.clear();
		int startrow = (pageNum - 1) * limit + 1; 
		int endrow = startrow + limit - 1; //startrow에서 limit만큼
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		param.put("userid", userid);
		return template.getMapper(cls).getList(param); 
	}
	
	public ArrayList<Likes> getLikes(String userid, int bno) {
		ArrayList<Likes> list = new ArrayList<>();
		return template.getMapper(cls).getLikes(userid,bno);
	}
	public int doLikes(String userid, int num) {
		return template.getMapper(cls).write(userid, num); 
	}
	
	public int undoLikes(String userid,int num) {
		return template.getMapper(cls).deleteLikes(userid,num); 
	}

	public int count(String userid) {
		return template.getMapper(cls).count(userid);
	}
	public int findLikes(String userid, int num) {
		return template.getMapper(cls).findLikes(userid, num);
	}
	public List<Board> getLikelist(int pageNum, int limit) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1; 
		int endrow = startrow + limit - 1; //startrow에서 limit만큼
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		return template.getMapper(cls).getLikelist(param);
	}
}