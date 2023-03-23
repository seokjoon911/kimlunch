package dao.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import logic.Board;
import logic.Likes;

public interface LikesMapper {
	@Select("select count(*) from b_board where bno in (select bno from likes where userid=#{value})")
	int count(String userid);

	String sql = "select * from "
			+ " (select rownum rnum,bno,article,subsistence,img imgurl,boardid,regdate, "
			+ " ip,readcnt,grade,heart,price,map_a,map_b,menu,userid from "
			+ " (select * from b_board where bno in (select bno from likes where userid = #{userid}) "
			+ " order by bno desc, subsistence asc)) "
			+ " where rnum between #{startrow} and #{endrow}";
	@Select(sql)
	List<Board> getList(Map<String, Object> param);
	
	@Insert("insert into Likes VALUES(#{userid},#{num},'1')")
	int write(@Param("userid")String userid, @Param("num")int num);

	@Select("select * from likes where userid =#{userid} and bno = #{bno}")
	ArrayList<Likes> getLikes(String userid, int bno);

	@Delete("delete from likes where bno =#{num} and userid =#{userid}")
	int deleteLikes(@Param("userid") String userid, @Param("num") int num);
	
	@Select("select count(*) from likes where bno=#{num} and userid =#{userid}")
	int findLikes(@Param("userid")String userid, @Param("num")int num);
	
	String sql1 =  "select * from "
			+ " (select rownum rnum,bno,article,subsistence,img imgurl,boardid,regdate, "
			+ " ip,readcnt,grade,heart,price,map_a,map_b,menu,userid from "
			+ " (select * from b_board where bno in (select bno from likes) order by heart desc)) "
			+ " where rnum between #{startrow} and #{endrow}";
	@Select(sql1)
	List<Board> getLikelist(Map<String, Object> param);
}
