package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;

public interface BoardMapper {

	@Select("select count(*) from b_board where boardid=#{value}")
	int count(String boardid);

	@Select("select count(*) from b_board")
	int allcount();
	
	@Select("select count(*) from b_board where heart>=1")
	int bestcount();
	
	@Select({"<script>",
        "select count(*) from b_board ",
        "<if test='column != null'> where ${column} like '%${find}%'</if>",
     "</script>"})
	int searchCount(@Param("find")String find, @Param("column")String column);

	String sql = "select * from "
			+"( select rownum rnum,bno,article,subsistence,img imgurl,boardid,regdate,"
			+ "	ip,readcnt,grade,heart,price,map_a,map_b,menu,userid,pname,paddress,phone from "
			+" (select * from b_board where boardid=#{boardid} "
			+" order by bno desc, subsistence asc))"
			+" where rnum between #{startrow} and #{endrow}";
	@Select(sql)
	List<Board> list(Map<String, Object> param);
	
	String sql2 = "select * from "
			+"( select rownum rnum,bno,article,subsistence,img imgurl,boardid,regdate,"
			+ "	ip,readcnt,grade,heart,price,map_a,map_b,menu,userid,pname,paddress,phone from "
			+" (select * from b_board "
			+" order by bno desc, subsistence asc))"
			+" where rnum between #{startrow} and #{endrow}";
	@Select(sql2)
	List<Board> allList(Map<String, Object> param);
	
	String sql3 = "select * from "
			+ " (select rownum rnum,bno,article,subsistence,img imgurl,boardid,regdate, "
			+ " ip,readcnt,grade,heart,price,map_a,map_b,menu,userid,pname,paddress,phone from "
			+ " (select * from b_board where heart >=1 order by heart desc, bno desc)) "
			+ " where rnum between #{startrow} and #{endrow}";
	@Select(sql3)
	List<Board> bestList(Map<String, Object> param);

	@Select("select nvl(max(bno),0) from b_board")
	int maxNum();
	
	@Insert("insert into b_board "
			+"(bno,article,subsistence,img,boardid,ip,regdate,readcnt,"
			+" grade,heart,price,menu,map_a,map_b,userid,pname,paddress,phone)"
			+" values (#{bno},#{article},#{subsistence},#{imgurl},"
			+ " #{boardid},#{ip},sysdate,0,#{grade},#{heart},#{price},#{menu},#{map_a},#{map_b},"
			+ " #{userid},#{pname},#{paddress},#{phone})")
	void insert(Board board);
	
		//pname, paddress, phone 추가
	String cols = "bno,article,subsistence,img imgurl,boardid,ip,regdate,readcnt,"
			+ " grade,heart,price,menu,map_a,map_b,userid,pname,paddress,phone";
	
	@Select("select "+cols+" from b_board where bno=#{num}")
	Board selectOne(Integer num);
	
    @Update
    ("update b_board set readcnt = readcnt+1 where bno=#{num}")
	void readcntadd(Integer num);
    
    @Update
    ("update b_board set readcnt = readcnt-1 where bno=#{num}")
    void readcntminus(Integer num);

    @Update
    ("update b_board set article=#{article}, subsistence=#{subsistence}, img=#{imgurl},"
    		+ "regdate=#{regdate},grade=#{grade},price=#{price},menu=#{menu},boardid=#{boardid},"
    		+ "map_a=#{map_a},map_b=#{map_b},pname=#{pname},paddress=#{paddress},phone=#{phone} where bno=#{bno}")
	void update(Board board);

    @Delete("delete from b_board where bno=#{bno}")
	void delete(Integer bno);

    @Update("update b_board set heart = heart-1 where bno=#{num}")
	void undoHeart(int num);

    @Update("update b_board set heart = heart+1 where bno=#{num}")
	void doHeart(int num);

    @Select({"<script>",
        "select bno,article,subsistence,img imgurl,boardid,regdate,"
        + "	ip,readcnt,grade,heart,price,map_a,map_b,menu,userid,pname,paddress,phone from b_board",
        "<if test='column != null'> where ${column} like '%${find}%'</if>",
     "</script>"})
	List<Board> listSearch(Map<String, Object> param);

    @Select("select bno, map_a, map_b, pname, phone from b_board")
	List<Board> mapList(Map<String, Object> param);
   
}
