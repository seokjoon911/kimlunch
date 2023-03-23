package dao;

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
import dao.mapper.UserMapper;
import logic.Board;
import logic.User;
@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	private Class<UserMapper> cls = UserMapper.class;
	
	public String search(User user, String url) {
		param.clear();
		param.put("email", user.getEmail());
		param.put("name", user.getName());
		param.put("col", "userid");
		if(url.equals("pw")) {
			param.put("userid", user.getUserid());
			param.put("col", "password");
		}
		return template.getMapper(cls).search(param);
	}
	public void insert(User user) {
	    template.getMapper(cls).insert(user);	
	}
	public User selectOne(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.getMapper(cls).selectOne(param);
	}
	public User selectNick(String nickname) {
		param.clear();
		param.put("nickname", nickname);
		return template.getMapper(cls).selectNick(param);
	}

	public List<User> list() {
		return template.getMapper(cls).list();
	}
	public int count(String userid) {
		return template.getMapper(cls).count(userid);
	}
	
	public List<Board> myboardlist(Integer pageNum, int limit, String userid) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1; 
		int endrow = startrow + limit - 1; //startrow에서 limit만큼
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		param.put("userid", userid);
		return template.getMapper(cls).myboardlist(param);
	}
	public void update(User user) {
		template.getMapper(cls).update(user);
	}
	public void delete(String userid) {
		param.clear();
		param.put("userid", userid);
		template.getMapper(cls).delete(param);
	}
	public void chgpass(String userid, String pass) {
		param.clear();
		param.put("userid", userid);
		param.put("password", pass);
		template.getMapper(cls).chgpass(param);
	}
	public User findNickname(String nickname) {
		return template.getMapper(cls).findNickname(nickname);
	}
	public User findEmail(String email) {
		return template.getMapper(cls).findEmail(email);
	}
	public User selectEmail(String email) {
		param.clear();
		param.put("email", email);
		return template.getMapper(cls).selectEmail(param);
	}
}
