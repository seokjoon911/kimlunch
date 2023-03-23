package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

import logic.Board;
import logic.User;

public interface UserMapper {
	@Select("select * from u_user")
	List<User> list();

	@Select({"<script>",
		"select ${col} from u_user "
		+ " where email=#{email} and name=#{name}",
		"<if test='userid != null'> and userid=#{userid}</if>",
		"</script>"})
	String search(Map<String, Object> param);

	@Select("select * from u_user where userid=#{userid}")
	User selectOne(Map<String, Object> param);
	
	@Select("select * from u_user where nickname=#{nickname}")
	User selectNick(Map<String, Object> param);
	
	@Insert("insert into u_user "
		     + " (userid, password,name,nickname,phoneno,"
		     + " email,gender,address)"
		+ " values(#{userid}, #{password},#{name},#{nickname},#{phoneno},"
		     + "#{email},#{gender},#{address})")
			void insert(User user);
	
	@Select("select count(*) from b_board where userid=#{value}")
	int count(String userid);

	 String sql = "select * from "
+"( select rownum rnum,bno,article,subsistence,img imgurl,boardid,regdate,"
+ "	ip,readcnt,grade,heart,price,map_a,map_b,menu,userid from "
+" (select * from b_board where userid=#{userid} "
+" order by bno desc, subsistence asc))"
+" where rnum between #{startrow} and #{endrow}";
	@Select(sql)
	List<Board> myboardlist(Map<String, Object> param);

	@Update("update u_user set name=#{name},nickname"
			+ "=#{nickname},phoneno=#{phoneno},email=#{email},gender=#{gender},"
			+ "address=#{address} where userid=#{userid}")
	void update(User user);
	
	@Delete("delete from u_user where userid=#{userid}")
	void delete(Map<String, Object> param);
	
	@Update("update u_user set password=#{password} where userid=#{userid}")
	void chgpass(Map<String, Object> param);

	@Select("select * from u_user where nickname=#{nickname}")
	User findNickname(String nickname);

	@Select("select * from u_user where email=#{email}")
	User findEmail(String email);

	@Select("select * from u_user where email=#{email}")
	User selectEmail(Map<String, Object> param);
}