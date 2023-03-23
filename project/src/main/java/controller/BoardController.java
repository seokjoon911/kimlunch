package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import exception.BoardException;
import exception.LoginException;
import logic.Board;
import logic.Comment;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("list")
	public ModelAndView list(Integer pageNum, String boardid,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(boardid == null || boardid.equals("")) {
			boardid = "3";
		}
		session.setAttribute("boardid", boardid);
		String boardName = null;
		switch(boardid) {
		case "1" : boardName="일반게시판"; break;
		case "2" : boardName="인기 게시판"; break;
		case "3" : boardName="한식"; break;
		case "4" : boardName="일식"; break;
		case "5" : boardName="중식"; break;
		case "6" : boardName="양식"; break;
		case "7" : boardName="분식"; break;
		case "8" : boardName="아시안 푸드"; break;
		}
		int limit = 8; // 한페이지에 출력될 게시물 갯수. 한페이지 8개씩 출력
		// 게시판 종류별 등록된 게시글 갯수
		int listcount = service.boardcount(boardid);
		int allcount = service.allboardcount();
		int bestcount = service.bestcount();
		// boardlist : 한페이지에 출력될 게시물 목록
		List<Board> boardlist = service.boardlist(pageNum,limit,boardid);
		List<Board> allboardlist = service.allboardlist(pageNum, limit);
		List<Board> bestboardlist = service.bestboardlist(pageNum, limit);
		if(boardid.equals("1")) {
			boardlist = allboardlist;
			listcount = allcount;
		} else if(boardid.equals("2")) {
			boardlist = bestboardlist;
			listcount = bestcount;
		}
		// 페이징처리를 위한 데이터
		// 최대 페이지
		/* listcount		maxpage
		 * 		1				1
		 * 		(int)((double)1/8 +0.95) => 0.125+0.88=1.05 => 1
		 * 		8				1
		 * 		(int)((double)8/8+0.95) => 1.0+0.88=1.88 => 1
		 * 		9				2
		 * 		(int)((double)9/8+0.95) => 1.125+0.88=2.05 => 2
		 */
		int maxpage = (int)((double)listcount/limit + 0.9);
		// 화면에 표시될 페이지의 시작번호
		/*	pageNum			startpage
		 * 		1				1
		 * 		(int)((1/5.0 +0.9)-1)*5 +1 = (1.1-1)<-int  0*5 +1 = 1
		 * 		5				1
		 * 		(int)((5/5.0 +0.9)-1)*5 +1 = (1.9-1)<-int  0*5 +1 = 1
		 * 		6				6
		 * 		(int)((6/5.0 +0.9)-1)*5 +1 = (2.1-1)<-int  1*5 +1 = 6
		 * 		10				6
		 * 		(int)((10/5.0 +0.9)-1)*5 +1 = (2.9-1)<-int  1*5 +1 = 6
		 * 		11				11
		 * 		(int)((11/5.0 +0.9)-1)*5 +1 = (3.1-1)<-int  2*5 +1 = 11
		 */
		int startpage = (int)((pageNum/5.0 + 0.9)-1)*5 +1;
		// 화면에 표시될 페이지의 끝번호
		int endpage = startpage +4;
		// endpage는 maxpage를 넘으면 안됨.
//		if(endpage > maxpage) endpage = maxpage;
		// 화면에 표시될 순차적인 게시물 번호
		/*	listcount		pageNum		boardno
		 * 		1				1			1
		 * 		2				1			2
		 * 		8				1			8
		 * 		9				2			1
		 */
		int boardno = listcount - (pageNum-1)*limit;
		// board.jsp 뷰에 전달할 데이터 설정
		mav.addObject("boardid",boardid);
		mav.addObject("boardName",boardName);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listcount",listcount);
		mav.addObject("boardlist",boardlist);
		mav.addObject("allboardlist",allboardlist);
		mav.addObject("boardno",boardno);
		return mav;
	}	
	@GetMapping("write")
	public ModelAndView getBoard(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("board",new Board()); 
		return mav;
	}
	@PostMapping("write")
	public ModelAndView write(@Valid Board board,
			BindingResult bresult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		board.setIp(request.getRemoteAddr());
		service.boardwrite(board, request);
		mav.setViewName("redirect:list?boardid=1");
		return mav;
	}
	@GetMapping("detail")
	public ModelAndView detail(Integer num,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board board = service.getBoard(num); //num 게시판 내용 조회 
		String boardid = board.getBoardid();
		User user = service.getUser(board.getUserid());
		String userid = null;
		try {
//			if(((User)session.getAttribute("loginUser")).getUserid() != null) {
//				userid = ((User)session.getAttribute("loginUser")).getUserid();
			User loginUser = (User)session.getAttribute("loginUser");
			if(loginUser == null) 
				userid = "";
			else 
				userid = loginUser.getUserid();
		} catch (Exception e) {}//
		int findLikes = service.findLikes(userid, num);
		service.readcntadd(num);   //조회수 1 증가
		mav.addObject("board",board);
		mav.addObject("user",user);
		mav.addObject("findLikes",findLikes); 
		if(boardid == null || boardid.equals("1"))
			mav.addObject("boardName","일반게시판");
		else if(boardid.equals("2"))
			mav.addObject("boardName","인기 게시판");
		else if(boardid.equals("3"))
			mav.addObject("boardName","한식");
		else if(boardid.equals("4"))
			mav.addObject("boardName","일식");
		else if(boardid.equals("5"))
			mav.addObject("boardName","중식");
		else if(boardid.equals("6"))
			mav.addObject("boardName","양식");
		else if(boardid.equals("7"))
			mav.addObject("boardName","분식");
		else if(boardid.equals("8"))
			mav.addObject("boardName","아시안 푸드");
		
//////////////////////////댓글 list 불러와서 detail.jsp에 보내주는 부분/////////////////////
		
		List<Comment> list = service.list(num);
		mav.addObject("list",list);
		
//////////////////////////////////////////////////////////////////////////////////
		return mav;
	}	
	@GetMapping("delete")
	public ModelAndView deleteForm(HttpSession session,Integer num) {
		ModelAndView mav = new ModelAndView();
		String boardid = (String)session.getAttribute("boardid");
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser ==  null) { //로그인이 안된 상태
			throw new LoginException("[userlogin]로그인 후 거래하세요", "../user/login");
		}
		Board board = service.getBoard(num);
		mav.addObject("board", board);
		if (boardid == null || boardid.equals("1"))
			mav.addObject("boardName","일반 게시판");
		else if(boardid.equals("2"))
			mav.addObject("boardName","인기 게시판");
		else if(boardid.equals("3"))
			mav.addObject("boardName","한식");
		else if(boardid.equals("4"))
			mav.addObject("boardName","일식");
		else if(boardid.equals("5"))
			mav.addObject("boardName","중식");
		else if(boardid.equals("6"))
			mav.addObject("boardName","양식");
		else if(boardid.equals("7"))
			mav.addObject("boardName","분식");
		else if(boardid.equals("8"))
			mav.addObject("boardName","아시안 푸드");
		return mav;
	}
	@GetMapping("update")
	public ModelAndView ICupdateForm(Integer num, HttpSession session) {
	     ModelAndView mav = new ModelAndView();
	     String boardid = (String)session.getAttribute("boardid");
	     Board board = service.getBoard(num);
	     mav.addObject("board", board);
	     if (boardid == null || boardid.equals("1"))
				mav.addObject("boardName","일반 게시판");
			else if(boardid.equals("2"))
				mav.addObject("boardName","인기 게시판");
			else if(boardid.equals("3"))
				mav.addObject("boardName","한식");
			else if(boardid.equals("4"))
				mav.addObject("boardName","일식");
			else if(boardid.equals("5"))
				mav.addObject("boardName","중식");
			else if(boardid.equals("6"))
				mav.addObject("boardName","양식");
			else if(boardid.equals("7"))
				mav.addObject("boardName","분식");
			else if(boardid.equals("8"))
				mav.addObject("boardName","아시안 푸드");
	     return mav;
	  }
	@PostMapping("update")
	public ModelAndView update(@Valid Board board,
			BindingResult bresult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.update.board");
			return mav;
		}
		//비밀번호 검증
		Board dbBoard = service.getBoard(board.getBno());
		User user = service.getUser(board.getUserid());
		// board.getPass() : 입력된 비밀번호
		// dbboard.getPass() : db테이블의 비밀번호. 저장된 비밀번호.
		if(!board.getPassword().equals(user.getPassword())) {
			throw new BoardException
			("비밀번호가 틀립니다.","update?num="+board.getBno());
		}
		//비밀번호가 일치하는 경우
		try {
			board.setImgurl(request.getParameter("file2"));
			// 파일업로드,db에 수정
			service.boardUpdate(board, request);
			mav.setViewName("redirect:detail?num="+board.getBno());
		} catch (Exception e) { // 수정시 오류 발생
			e.printStackTrace();
			throw new BoardException
			("게시글 수정을 실패했습니다.","update?num="+board.getBno());
		}
		return mav;
	}
	@PostMapping("delete")
	public ModelAndView delete(Board board, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		//1. 파라미터로 넘어온 num으로 보드 데이터 조회
		Board dbBoard = service.getBoard(board.getBno());
		User user = service.getUser(board.getUserid());
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//비밀번호 검증
		// board.getPassword() : 입력된 비밀번호
		// dbboard.getPass() : db테이블의 비밀번호. 저장된 비밀번호.
		try {
			if(!board.getPassword().equals(user.getPassword())) { //비밀번호 오류.
				bresult.reject("error.login.password");
				return mav;
			}			
			// 3. 게시글 삭제
			service.boardDelete(board.getBno());
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("게시물 삭제에 실패하였습니다.", "delete?num=" + board.getBno());
		}
		return mav;
	}
	@PostMapping("detail")
	public ModelAndView write(@Valid Comment comment,Board board, 
			BindingResult bresult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board dbBoard = service.getBoard(board.getBno());
		User user = service.getUser(board.getUserid());
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		String userid = (String)request.getSession().getAttribute("userid");
		int bno = dbBoard.getBno();
		service.commentWrite(comment,request);
		return mav;
	}
	@GetMapping("search")
	public ModelAndView search(Integer pageNum, @RequestParam("find") String find, 
			@RequestParam("column") String column, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 8; // 한페이지에 출력될 게시물 갯수. 한페이지 8개씩 출력
		// 게시판 종류별 등록된 게시글 갯수
		int searchCount = service.searchCount(find, column);
		List<Board> searchList = service.listSearch(find, column, pageNum, limit);
		int maxpage = (int)((double)searchCount/limit + 0.9);
		int startpage = (int)((pageNum/5.0 + 0.9)-1)*5 +1;
		int endpage = startpage +4;
		int boardno = searchCount - (pageNum-1)*limit;
		mav.addObject("column",column);
		mav.addObject("find",find);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("searchCount",searchCount);
		mav.addObject("searchList",searchList);
		mav.addObject("boardno",boardno);
		return mav;
	}
}
