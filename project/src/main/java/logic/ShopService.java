package logic;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.CommentDao;
import dao.LikesDao;
import dao.UserDao;

@Service
public class ShopService {
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private LikesDao likesDao;
	
	@Autowired
	private CommentDao commentDao;
	
	public String getSearch(User user, String url) {
		return userDao.search(user,url);
	}
	public void userInsert(User user) {
		userDao.insert(user);
	}
	public User getUser(String userid) {
		return userDao.selectOne(userid);
	}
	public User getNick(String nickname) {
		return userDao.selectNick(nickname);
	}
	public List<User> userlist() {
		return userDao.list();
	}
	public int boardcount(String boardid) {
		return boardDao.count(boardid);
	}
	public int allboardcount() {
		return boardDao.allcount();
	}
	public int bestcount() {
		return boardDao.bestcount();
	}
	public List<Board> boardlist
    (Integer pageNum, int limit, String boardid) {
		return boardDao.list(pageNum,limit,boardid);
	}
	public List<Board> allboardlist
    (Integer pageNum, int limit) {
		return boardDao.allList(pageNum,limit);
	}
	
	public List<Board> bestboardlist
	(Integer pageNum, int limit) {
		return boardDao.bestList(pageNum,limit);
	}	
	public void boardwrite(Board board, HttpServletRequest request) {
	      //첨부 파일이 존재 : 파일 업로드
		  if(board.getImg() != null && !board.getImg().isEmpty()){
	        String path=request.getServletContext().getRealPath("/") +
	        		  "board/file/";
			uploadFileCreate(board.getImg(),path);
			board.setImgurl(board.getImg().getOriginalFilename());
		  }
		  //1. num 컬럼의 최대값
		  //2. board 테이블에 저장
		  boardDao.insert(board);
		}
	private void uploadFileCreate
    (MultipartFile file, String uploadPath) {
	//uploadPath : 파일이 업로드 되는 폴더
	String orgFile = file.getOriginalFilename(); //파일이름
	File fpath = new File(uploadPath); 
	if(!fpath.exists()) fpath.mkdirs(); //업로드 폴더가 없으면 생성
	try {
	//파일의 내용 => uploadPath + orgFile 로 파일 저장
	file.transferTo
	  (new File(uploadPath + orgFile)); //파일업로드
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public Board getBoard(Integer num) {
		return boardDao.selectOne(num);
	}
	public void readcntadd(Integer num) {
		boardDao.readcntadd(num);		
	}
	public void readcntminus(Integer num) {
		boardDao.readcntminus(num);		
	}
	public void boardUpdate(Board board, HttpServletRequest request) {
		if(board.getImg() != null && !board.getImg().isEmpty()) {
			String path = request.getServletContext().getRealPath("/")+
					"board/file/";
			uploadFileCreate(board.getImg(),path);
			board.setImgurl(board.getImg().getOriginalFilename());
		}
		boardDao.update(board);
	}
	public void boardDelete(int bno) {
		boardDao.delete(bno);		
	}
	public int mylistcount(String userid) {
		return userDao.count(userid);
	}
	public int mylikescount(String userid) {
		return likesDao.count(userid);
	}
	public int searchCount(String find, String column) {
		return boardDao.searchCount(find, column);
	}
	public List<Board> myboardlist(Integer pageNum, int limit, String userid) {
		return userDao.myboardlist(pageNum,limit,userid);
	}
	public List<Board> getList(Integer pageNum, int limit, String userid) {
		return likesDao.getList(pageNum,limit,userid);
	}
	public List<Board> listSearch(String find, String column, Integer pageNum, int limit) {
		return boardDao.listSearch(find, column, pageNum, limit);
	}
	public void userUpdate(User user) {
		userDao.update(user);
	}
	public void userDelete(String userid) {
		userDao.delete(userid);	
	}
	public void userChgpass(String userid, String pass) {
		userDao.chgpass(userid, pass);
	}
	public void doLikes(String userid, Integer num) {
		likesDao.doLikes(userid, num);
	}
	public void undoLikes(String userid, Integer num) {
		likesDao.undoLikes(userid, num);
	}
	public int findLikes(String userid, Integer num) {
		return likesDao.findLikes(userid, num);
	}
	public void undoHeart(int num) {
		boardDao.undoHeart(num);
	}
	public void doHeart(int num) {
		boardDao.doHeart(num);
	}
	   //댓글의 숫자를 세는 부분
	public int commentCount(int cno) {
		return commentDao.count(cno);
	}
	//댓글 리스트 저장?
	public List<Comment> list(int bno) {
		return commentDao.list(bno);
	}
    //댓글 작성
	public void commentWrite(Comment comment,HttpServletRequest request) {
		commentDao.commentWrite(comment,request);
	}
	//댓글 내용 보이게 하는
	public Board getComment(Integer cno) {
		return commentDao.selectOne(cno);
	}
	public User findNickname(String nickname) {
		return userDao.findNickname(nickname);
	}
	public User findEmail(String email) {
		return userDao.findEmail(email);
	}
	public User getEmail(String email) {
		return userDao.selectEmail(email);
	}
	public List<Board> getLikelist(int pageNum, int limit) {
		return likesDao.getLikelist(pageNum,limit);
	}
	public List<Board> maplist() {
		return boardDao.mapList();
	}
	public void commentUpdate(Comment comment) {
		commentDao.update(comment);
	}
	//댓글 삭제
	public void commentDelete(Comment comment) {
		commentDao.delete(comment);
	}
}
