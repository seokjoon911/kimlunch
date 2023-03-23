package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CommentMapper;
import logic.Board;
import logic.Comment;

@Repository
public class CommentDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<CommentMapper> cls = CommentMapper.class;

	//댓글 카운트 부분
	public int count(int cno) {
		return template.getMapper(cls).count(cno);
	}
	//댓글 리스트화 하는 부분
	public List<Comment> list(int bno) {
		param.clear();
		param.put("bno", bno);
		return template.getMapper(cls).list(param);
	}
	//댓글 번호 지정 부분
	private int maxNum() {
		return template.getMapper(cls).maxNum();
	}
	//댓글 생성 부분
	public void commentWrite(Comment comment,HttpServletRequest request) {
		int num = maxNum() + 1;
		comment.setcno(num); 
		template.getMapper(cls).insert(comment);
	}
	//댓글에 저장된 내용 불러오는
	public Board selectOne(Integer num) {
		return template.getMapper(cls).selectOne(num);
		
	}
    //댓글 수정
	public void update(Comment comment) {
		template.getMapper(cls).update(comment);
	}
    //댓글 삭제
	public void delete(Comment comment) {
		template.getMapper(cls).delete(comment);
	}

	

}
