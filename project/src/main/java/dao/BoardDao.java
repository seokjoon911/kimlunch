package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import logic.Board;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<BoardMapper> cls = BoardMapper.class;
	public int count(String boardid) {
		return template.getMapper(cls).count(boardid);
	}
	public int allcount() {
		return template.getMapper(cls).allcount();
	}
	public int bestcount() {
		return template.getMapper(cls).bestcount();
	}
	public int searchCount(String find, String column) {
		return template.getMapper(cls).searchCount(find, column);
	}
	public List<Board> list
	       (Integer pageNum,int limit, String boardid) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1; 
		int endrow = startrow + limit - 1; //startrow에서 limit만큼
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		param.put("boardid", boardid);
		return template.getMapper(cls).list(param);
	}
	public List<Board> allList
	(Integer pageNum,int limit) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1; 
		int endrow = startrow + limit - 1; //startrow에서 limit만큼
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		return template.getMapper(cls).allList(param);
	}
	public List<Board> bestList
	(Integer pageNum,int limit) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1; 
		int endrow = startrow + limit - 1; //startrow에서 limit만큼
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		return template.getMapper(cls).bestList(param);
	}
	public List<Board> listSearch(String find, String column,
			Integer pageNum,int limit) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1; 
		int endrow = startrow + limit - 1; //startrow에서 limit만큼
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		param.put("find", find);
		param.put("column", column);
		return template.getMapper(cls).listSearch(param);
	}
	private int maxNum() {
		return template.getMapper(cls).maxNum();
	}
	public void insert(Board board) {
		int num = maxNum() + 1;
		board.setBno(num); 
		template.getMapper(cls).insert(board); 
	}
	public Board selectOne(Integer num) {
		return template.getMapper(cls).selectOne(num);
	}
	public void readcntadd(Integer num) {
		template.getMapper(cls).readcntadd(num);		
	}
	public void readcntminus(Integer num) {
		template.getMapper(cls).readcntminus(num);		
	}
	public void update(Board board) {
		template.getMapper(cls).update(board);
	}
	public void delete(Integer bno) {
		template.getMapper(cls).delete(bno);
	}
	public void undoHeart(int num) {
		template.getMapper(cls).undoHeart(num);
	}
	public void doHeart(int num) {
		template.getMapper(cls).doHeart(num);
	}
	public List<Board> mapList() {
		return template.getMapper(cls).mapList(param);
	}
}
