package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;
import logic.Comment;

public interface CommentMapper {

	@Select("select count(*) from c_comment where bno=#{bno}")
	int count(int bno);
	
	@Select("select co.cno, co.bno, co.userid, co.content, co.wdate, us.nickname"
			+ " from c_comment co, u_user us where bno=#{bno} and co.userid = us.userid order by co.wdate")
	List<Comment> list(Map<String, Object> param); //여기서 문제 날듯

	@Insert("insert into c_comment (cno, content, wdate, bno, userid) "
			+ "values (#{cno},#{content},sysdate,#{bno},#{userid})")
	void insert(Comment comment);

	@Select("select nvl(max(cno),0) from c_comment")
	int maxNum();

	@Select("select cno, content, wdate, grp , grps , grpl ,userid, bno"
+" values (#{cno},#{content},#{wdate},#{grp},"
+ "#{grps},#{grpl},#{userid},#{bno})")
	Board selectOne(Integer num);
	
	@Delete("delete from c_comment where cno=#{cno}")
	void delete(Comment comment);

	@Update
	("update c_comment set content=#{content} where cno=#{cno}")
	void update(Comment comment);


	

	

	




	
}
