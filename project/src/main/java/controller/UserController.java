package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Board;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private ShopService service;
	
	@GetMapping("*") //* : 그외 모든 get방식 요청
	public ModelAndView getUser() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	
	@RequestMapping("main") 
	public ModelAndView main(){
		ModelAndView mav = new ModelAndView();
		int limit = 4; // 한페이지에 출력될 게시물 갯수. 한페이지 8개씩 출력
		// boardlist : 한페이지에 출력될 게시물 목록
		int pageNum = 1;
		List<Board> getLikelist = service.getLikelist(pageNum, limit);
		int bestcount = service.bestcount();
		List<Board> maplist = service.maplist();
		// mypage.jsp 뷰에 전달할 데이터 설정
		mav.addObject("bestcount",bestcount);
		mav.addObject("pageNum",pageNum);
		mav.addObject("getLikelist",getLikelist);
		mav.addObject("maplist",maplist);
		return mav;
	}
	
	@PostMapping("join")
	//BindingResult : 오류발생시 오류보관
	public ModelAndView join(@Valid User user, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) { //입력값 오류 발생.
			mav.getModel().putAll(bresult.getModel()); //데이터의 내용을 오류값들로 담음! 
			
			//전체적인 오류코드 등록(한가지 말고 여러가지 오류를등록할때 사용)
			bresult.reject("error.input.user");
			return mav;
		}
		//오류가없을시 db에 회원정보등록
		try {
			service.userInsert(user); //user객체는 유효성검사를마친 정보를 가짐
			mav.addObject("user",user); //user객체 뷰단으로 전달
			
		//DataIntegrityViolationException : 중복키 오류.
		// 똑같은 아이디가 또 들어왔을때 오류 발생.		같은이름의 userid값이 존재하는경우 발생.
		}catch(DataIntegrityViolationException e) {
			e.printStackTrace();
			bresult.reject("error.duplicate.user"); //error.duplicate.user : message.txt에 나와있음. (오류내용)
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:login");
		return mav;
	}
	
	@PostMapping("login")
	public ModelAndView login(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//1. 유효성 검증
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());//에러가있으면 모델객체에 전부집어넣고
			bresult.reject("error.input.login");
			return mav;
		}
		//userid에 해당하는 User 정보를 db에서 읽어오기
		User dbuser = null;
		 dbuser = service.getUser(user.getUserid());
			if(dbuser == null || user.getUserid() == "") {
		 	bresult.reject("error.login.id");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//정상적인 사용자인경우 세션에 로그인정보 등록
		if(user.getPassword().equals(dbuser.getPassword())) {
			session.setAttribute("loginUser", dbuser);
		//비밀번호 틀린경우 에러메세지 출력
		}else {
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//정상적인경우 DB에등록된후에 마이페이지로 이동
		mav.setViewName("redirect:main?userid="+user.getUserid());
		return mav;
	}
	@RequestMapping("logout")	//loginCheckLogout 핵심메서드: 수행해야될 기본 실행 메서드
	public String LCLogout(HttpSession session) {
		session.invalidate();
		return "redirect:login";
	}

	@PostMapping("{url}search")
	public ModelAndView search(User user, BindingResult bresult,
			@PathVariable String url) {
		ModelAndView mav = new ModelAndView();
		String code = "error.userid.search"; //아이디를 찾을 수 없습니다.
		String title = "아이디";
		if(user.getEmail() == null || user.getEmail().equals("")){
			//rejectValue : 프로퍼티별로 오류 정보 저장.
			// <form:errors path="email" /> 출력됨
			//오류코드 : error.required.email 설정됨
			bresult.rejectValue("email", "error.required"); 
		}
		if(user.getName() == null || 
				                  user.getName().equals("")) {
			// <form:errors path="phoneno" /> 출력됨
			//오류코드 : error.required.phoneno 설정됨
			bresult.rejectValue("name", "error.required");
		}
		if(url.equals("pw")) { 
			title="비밀번호";
			code = "error.password.search"; 
			if(user.getUserid() == null || 
					                user.getUserid().equals("")) {
				//<form:errors path="userid" /> 출력됨
				//오류코드 : error.required.userid 설정됨
				bresult.rejectValue("userid", "error.required");
			}
		}
		if(bresult.hasErrors()) { 
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//정상적인 입력인 경우
		String result = null;
		//result : 사용자id,또는 비밀번호 저장
	    result = service.getSearch(user,url);
	    if(result == null) {
			bresult.reject(code); //global 오류 영역 저장 
			mav.getModel().putAll(bresult.getModel());
			return mav;
	    }
	    //EmptyResultDataAccessException : mybatis에서 발생 안됨. 결과가 없는 경우
		mav.addObject("result",result);
		mav.addObject("title",title);
		// /WEB-INF/view/user/search.jsp
		mav.setViewName("user/search"); 
		return mav;
	}
	@RequestMapping("mypage")
	public ModelAndView ICmypage(String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.getUser(userid);
		mav.addObject("user",user);
		userid = user.getUserid();
		session.setAttribute("userid", userid);
		int limit = 8; // 한페이지에 출력될 게시물 갯수. 한페이지 8개씩 출력
		// 게시판 종류별 등록된 게시글 갯수
		int mylistcount = service.mylistcount(userid);
		// boardlist : 한페이지에 출력될 게시물 목록
		int pageNum = 1;
		List<Board> myboardlist = service.myboardlist(pageNum,limit,userid);
		List<Board> getlist = service.getList(pageNum, limit, userid);
		// mypage.jsp 뷰에 전달할 데이터 설정
		mav.addObject("userid",userid);
		mav.addObject("pageNum",pageNum);
		mav.addObject("mylistcount",mylistcount);
		mav.addObject("myboardlist",myboardlist);
		mav.addObject("getlist",getlist);
		return mav;
	}
	@RequestMapping("bookmark") 
	public ModelAndView LClikes(Integer pageNum, String userid,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		userid = user.getUserid();
		session.setAttribute("userid", userid);
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 8; // 한페이지에 출력될 게시물 갯수. 한페이지 8개씩 출력
		// 게시판 종류별 등록된 게시글 갯수
		int mylikescount = service.mylikescount(userid);
		// boardlist : 한페이지에 출력될 게시물 목록
		List<Board> getlist = service.getList(pageNum,limit,userid);
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
		int maxpage = (int)((double)mylikescount/limit + 0.9);
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
		 * 		11				2			1
		 */
		int boardno = mylikescount - (pageNum-1)*limit;
		// myboard.jsp 뷰에 전달할 데이터 설정
		mav.addObject("userid",userid);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("mylikescount",mylikescount);
		mav.addObject("getlist",getlist);
		mav.addObject("boardno",boardno);
		return mav;
	}
	@RequestMapping("myboard")
	public ModelAndView LClist(Integer pageNum, String userid,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		userid = user.getUserid();
		session.setAttribute("userid", userid);
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 8; // 한페이지에 출력될 게시물 갯수. 한페이지 8개씩 출력
		// 게시판 종류별 등록된 게시글 갯수
		int mylistcount = service.mylistcount(userid);
		// boardlist : 한페이지에 출력될 게시물 목록
		List<Board> myboardlist = service.myboardlist
				(pageNum,limit,userid);
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
		int maxpage = (int)((double)mylistcount/limit + 0.9);
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
		 * 		11				2			1
		 */
		int boardno = mylistcount - (pageNum-1)*limit;
		// myboard.jsp 뷰에 전달할 데이터 설정
		mav.addObject("userid",userid);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("mylistcount",mylistcount);
		mav.addObject("myboardlist",myboardlist);
		mav.addObject("boardno",boardno);
		return mav;
	}
	
	@GetMapping({"update","delete"})
	public ModelAndView ICupdate(String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.getUser(userid);
		mav.addObject("user", user);
		return mav;
	}
	/*
	 * 1. 유효성 검증하기.
	 * 2. 비밀번호 검증  
	 *     - 비밀번호 오류 : error.login.password 코드를 입력하여, update.jsp 페이지로 이동.
	 * 3. userid에 해당하는 고객 정보를 수정하기 : ShopService.userUpdate 함수
	 * 4. 수정 성공 : session의 로그인 정보 수정
	 *              main 페이지 이동
	 *    수정 실패 : 수정실패 메세지 출력. update 페이지 이동하기       
	 */
	@PostMapping("update") // POST 방식으로 user/userEntry url 요청시 
	public ModelAndView ICupdate(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//1. 유효성 검증하기
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//2. 비밀번호 검증 
		//admin 로그인시 비밀번호는 admin 비밀번호로 검증
		//본인 로그인시 비밀번호는 본인 비밀번호로 검증
		User loginUser = (User)session.getAttribute("loginUser");
		if(!loginUser.getPassword().equals(user.getPassword())) {
			bresult.reject("error.login.password");
			return mav;
		}
		//3. userid에 해당하는 고객 정보를 수정하기
		try {
			service.userUpdate(user);
			session.setAttribute("loginUser", user);
			// 4. 수정 성공, 수정 실패
			mav.setViewName("redirect:mypage?userid="+user.getUserid());
		} catch (Exception e) {
			e.printStackTrace(); //수정 실패
			throw new LoginException("고객 정보 수정 실패", "update?userid="+user.getUserid());
		}
		return mav;
	}
	@PostMapping("delete")
	public ModelAndView ICDelete
	(String password, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//관리자인 경우 탈퇴 불가
		if(userid.equals("admin")) 
			throw new LoginException
			("관리자 탈퇴는 불가합니다.", "mypage?userid="+userid);
		//로그인된 비밀번호 검증
		User loginUser = (User)session.getAttribute("loginUser");
		//로그인된 비밀번호 검증 : 불일치
		if(!password.equals(loginUser.getPassword())) {
			throw new LoginException
			("비밀번호를 확인하세요", "delete?userid="+userid);
		}
		//로그인된 비밀번호 검증 : 일치
		try {
			service.userDelete(userid); //db에 해당 사용자정보 삭제
		} catch(Exception e) {
			e.printStackTrace();
			throw new LoginException
			("탈퇴시 오류발생","delete?userid="+userid);
		}
		if(loginUser.getUserid().equals("admin")) {
			mav.setViewName("redirect:../admin/list");
		} else {
			mav.setViewName("redirect:login");
			session.invalidate();
		}
		return mav;
	}
	@PostMapping("password")
	public String ICPasswordRtn
	(@RequestParam Map<String,String>req, HttpSession session) {
		//비밀번호 검증
		User loginUser = (User)session.getAttribute("loginUser");
		//req.get("password") : 입력된 현재 비밀번호
		//loginUser.getPassword() : 등록된 비밀번호
		if(!req.get("password").equals(loginUser.getPassword())) {
			throw new LoginException("비밀번호 오류입니다.", "password");
		}
		//비밀번호 일치
		try {
			//loginUser.getUserid() : 로그인 사용자 아이디
			//req.get("chgpass") : 입력된 변경될 비밀번호
			service.userChgpass
				(loginUser.getUserid(), req.get("chgpass"));
			//로그인 정보 변경
			loginUser.setPassword(req.get("chgpass"));
		} catch(Exception e) {
			throw new LoginException
				("비밀번호 수정 db 오류입니다.", "password");
		}
		return "redirect:mypage?userid="+loginUser.getUserid();
	}
	@PostMapping("idCheckOk")
	 public  ModelAndView idcheck(User user , BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());//에러가있으면 모델객체에 전부집어넣고
			bresult.reject("error.input.login");
			return mav;
		}
		 String userid = user.getUserid();
		 User dbusers = service.getUser(userid);
		 if(dbusers != null) { //DB에없는 아이디를 입력해도 에러메세지가뜨지않고 넘어감..
			 bresult.reject("error.duplicate.user");
			 mav.setViewName("/user/idcheck");
			 return mav;
		 }
		 mav.addObject("userid",userid); 
		return mav;
	}
	@PostMapping("nickCheckOk")
	 public  ModelAndView nickcheck(User user , BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());//에러가있으면 모델객체에 전부집어넣고
			bresult.reject("error.input.login");
			return mav;
		}
		 String nickname = user.getNickname();
		 User dbusers = service.getNick(nickname);
		 if(dbusers != null) { //DB에없는 아이디를 입력해도 에러메세지가뜨지않고 넘어감..
			 bresult.reject("error.duplicate.nickname");
			 mav.setViewName("/user/nickcheck");
			 return mav;
		 }
		 mav.addObject("nickname",nickname); 
		return mav;
	}
	@PostMapping("emailCheckOk")
	 public  ModelAndView emailcheck(User user , BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());//에러가있으면 모델객체에 전부집어넣고
			bresult.reject("error.input.login");
			return mav;
		}
		 String email = user.getEmail();
		 User dbusers = service.getEmail(email);
		 if(dbusers != null) { //DB에없는 아이디를 입력해도 에러메세지가뜨지않고 넘어감..
			 bresult.reject("error.duplicate.email");
			 mav.setViewName("/user/emailcheck");
			 return mav;
		 }
		 mav.addObject("email",email); 
		return mav;
	}
}