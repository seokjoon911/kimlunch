package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import logic.Board;
import logic.Comment;
import logic.ShopService;
import logic.User;

@RestController
@RequestMapping("ajax")
public class AjaxController {
	@Autowired
	ShopService service;
	
	@PostMapping("detailLike")
	public String detailLike(@RequestParam("userid") String userid,
			@RequestParam("num") int num) {
		int findLikes = service.findLikes(userid, num);
		if(findLikes == 1) {
			service.undoLikes(userid, num);
			service.undoHeart(num);
			service.readcntminus(num);
		} else if (findLikes == 0) {
			service.doLikes(userid, num);
			service.doHeart(num);
			service.readcntminus(num);
		} else {
			return "success";
		}
		return "success";
	}
	
	@PostMapping("addComment")
	public String addComment(@RequestParam("bno") int bno, 
			@RequestParam("userid") String userid, 
			@RequestParam("content") String content) {

		Comment cmt = new Comment(content,userid,bno);
		service.commentWrite(cmt, null);
		return "success";
	}
	@PostMapping("updateComment")
	public String updatecmt(
			@RequestParam("cno") int cno, 
			@RequestParam("content") String content,
			@RequestParam("bno") int bno, 
			@RequestParam("userid") String userid
			) {
		Comment cmt = new Comment(content,userid,bno,cno);
		service.commentUpdate(cmt);
		return "success";
	}
	
	@PostMapping("deleteComment")
	 public  String deleteComment(@RequestParam("cno") int cno) {
		Comment cmt = new Comment(cno);
		service.commentDelete(cmt);
		return "success";
	}
}
