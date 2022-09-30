package com.lcomputer.example.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.lcomputer.example.domain.Answer;
import com.lcomputer.example.domain.Board;
import com.lcomputer.example.domain.Item;
import com.lcomputer.example.domain.Pagination;
import com.lcomputer.example.domain.Question;
import com.lcomputer.example.domain.Search;
import com.lcomputer.example.domain.Survey;
import com.lcomputer.example.domain.User;
import com.lcomputer.example.domain.Under;
import com.lcomputer.example.domain.Upload;
import com.lcomputer.example.service.BoardService;
import com.lcomputer.example.service.SurveyService;
import com.lcomputer.example.service.UserService;
import com.lcomputer.example.service.UnderService;
import com.lcomputer.example.service.UploadService;

@org.springframework.stereotype.Controller
public class Controller {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired UserService userservice;
	@Autowired BoardService boardservice;
	@Autowired PasswordEncoder passwordEncoder;
	@Autowired UnderService underservice;
	@Autowired UploadService uploadservice;
	@Autowired SurveyService surveyservice;
	
	@RequestMapping("/")
	public String home(Model model) {
		logger.debug("debug");
		logger.info("info");
		logger.error("error");
		return "/index";
	}
	
	@RequestMapping("/beforeSignUp")
	public String beforeSignUp() {
		return "/signup";
	}
	
	@RequestMapping("/signup")
	public String signup(User user) {
		String encodedPassword= passwordEncoder.encode(user.getPassword());
		
		user.setPassword(encodedPassword);
		user.setAccountNonExpired(true);
		user.setEnabled(true);
		user.setAccountNonLocked(true);
		user.setCredentialsNonExpired(true);
		user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));
		
		userservice.createUser(user);
		userservice.createAuthorities(user);
		
		
		return "/login";
	}
	
	@RequestMapping(value="/login")
	public String beforeLogin(Model model) {
		return "/login";
	}
	
	@Secured({"ROLE_ADMIN"})
		@RequestMapping(value="/admin")
		public String admin(Model model) {
			return "/admin";
		}
	
		@RequestMapping(value="/admin/level/{userIdx}")
		public String userLevel(User user, @PathVariable Optional<String> userIdx, Model model) {
			user.setuIdx(userIdx.get());
			user = userservice.userInfo(user);
			userservice.userLevel(user);
			model.addAttribute("user", user);
			
			return "/user_level_result";
		}
	
	@Secured({"ROLE_USER"})
		@RequestMapping(value="/user/info")
		public String userInfo(Model model) {
			return "/user_info";
		}
	
		@RequestMapping(value="/denied")
		public String denied(Model model) {
			return "/denied";
		}
		
		@RequestMapping(value={"/user/list", "/user/list/{pageNum}"})
		public String userList(User user, Model model, Pagination pagination, @PathVariable Optional<Integer> pageNum) {
			int page = pageNum.isPresent() ? pageNum.get() : 1;
			int count = userservice.userCount();
			pagination.setPage(page);
			pagination.setCount(count);
			pagination.page();
			user.setPagination(pagination);
			List<User> list= userservice.userList(user);
			model.addAttribute("list", list);
			model.addAttribute("pagination", pagination);
						
			return "/user_list";
		}
		
		@RequestMapping(value="/user/detail/{userIdx}")
		public String userDetail(User user, Model model, @PathVariable Optional<String> userIdx, Authentication authentication) {
			User principal = (User) authentication.getPrincipal();
			principal=userservice.userInfo(principal);
			user.setuIdx(userIdx.get());
			user= userservice.userDetail(user);
			model.addAttribute("user", user);
			model.addAttribute("principal", principal);
			
			return "/user_detail";
		}
		
		@RequestMapping(value="/user/edit/{userIdx}")
		public String userEdit(User user, @PathVariable Optional<String> userIdx, Model model, Authentication authentication) {
			User principal = (User) authentication.getPrincipal();
			if(principal.getuIdx() == userIdx.get()) {
				user.setuIdx(userIdx.get());
				user = userservice.userEdit(user);
				model.addAttribute("user", user);
			}
			
			return "/user_edit";
		}
		
		@RequestMapping(value="/user/edit/process")
		public String userEditProcess(User user) {
			userservice.userEditProcess(user);
			
			return "/user_edit_result";
		}
		
		@RequestMapping(value="/user/delete/{userIdx}")
		public String userDelete(User user, @PathVariable Optional<String> userIdx, Authentication authentication) {
			User principal = (User) authentication.getPrincipal();
			principal=userservice.userInfo(principal);
			if(principal.getuIdx() == userIdx.get() || Integer.parseInt(principal.getuIdx()) == 2) {
				user.setuIdx(userIdx.get());
				userservice.userDelete(user);
			}
			
			return "/user_delete_result";
		}
		
		@RequestMapping(value={"/board/list", "/board/list/{pageNum}"})
		public String boardList(Board board, Pagination pagination, Model model, @PathVariable Optional<Integer> pageNum, Search search) {	
			int page = pageNum.isPresent() ? pageNum.get() : 1;
			String nullcheck=search.getbKeyword();
			
			String keyword = search.getbKeyword()==null ? "" : "%"+search.getbKeyword()+"%";
			//String keyword = search.getbKeyword()==null ? "" : search.getbKeyword();
			search.setbKeyword(keyword);
			int count = (nullcheck==null || nullcheck=="") ? boardservice.boardCount() : boardservice.searchCount(search);
			pagination.setPage(page);
			pagination.setCount(count);
			pagination.page();
			pagination.setSearch(search);
			board.setPagination(pagination);
			List<Board> list=null;
			
			if(nullcheck==null || nullcheck=="") {
				list= boardservice.boardList(board);
			}
			else {
				list= boardservice.boardSearch(board);
			}
			
			keyword = keyword.replaceAll("%", "");
			search.setbKeyword(keyword);
			model.addAttribute("list", list);
			model.addAttribute("pagination", pagination);	
			return "/board_list";
		}
		
		@RequestMapping(value="/board/insert")
		public String beforeInsert(Board board, Authentication authentication) {
			User principal = (User) authentication.getPrincipal();
			board.setuIdx(Integer.parseInt(principal.getuIdx()));
			return "/board_insert";
		}
		
		@RequestMapping(value="/board/insert/process")
		public String boardInsert(Board board, Upload upload, @RequestParam MultipartFile[] uploadFile, Model model) throws IllegalStateException, IOException {
			String uploadPath="/Users/l6-morning/Documents/work13/lcomputer/src/main/resources/static";
			boardservice.boardInsert(board);
			upload.setbIdx(board.getbIdx());
			
			for(MultipartFile file : uploadFile) {
				if(!file.isEmpty()) {
					String originalName=file.getOriginalFilename();
					String fileExtension=originalName.substring(originalName.lastIndexOf("."));
					String uuid = UUID.randomUUID().toString();
					String uploadName = uuid +  fileExtension;
					String savefileName= uploadPath + File.separator + uuid + fileExtension;
					upload.settUpload(uploadName);
					upload.settFileName(originalName);
					uploadservice.uploadInsert(upload);
					
					Path savePath= Paths.get(savefileName);
					try {
						file.transferTo(savePath);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

			return "/board_insert_result";
		}
		
		@RequestMapping(value= { "/board/detail/{boardIdx}", "/board/detail/{boardIdx}/{pageNum}"})
		public String boardDetail(Board board, @PathVariable Optional<Integer> boardIdx, @PathVariable Optional<Integer> pageNum, Pagination pagination, Under under, Upload upload, Model model, Authentication authentication) {
			User principal = (User) authentication.getPrincipal();
			principal=userservice.userInfo(principal);
			
			int page= pageNum.isPresent() ? pageNum.get() : 1;
			under.setbIdx(boardIdx.get());
			int count= underservice.underCount(under);
			
			pagination.setPage(page);
			pagination.setCount(count);
			pagination.page();
			under.setPagination(pagination);
			
			board.setbIdx(boardIdx.get());
			upload.setbIdx(board.getbIdx());
			board = boardservice.boardDetail(board);
			List<Under> list = underservice.underList(under);
			
			model.addAttribute("board", board);
			model.addAttribute("list", list);
			model.addAttribute("pagination", pagination);
			model.addAttribute("principal", principal);
			
			return "/board_detail";
		}
		
		@RequestMapping(value="/board/edit/{boardIdx}")
		public String boardEdit(Board board, @PathVariable Optional<Integer> boardIdx, Model model, Authentication authentication) {
			User principal = (User) authentication.getPrincipal();
			board.setbIdx(boardIdx.get());
			board=boardservice.boardInfo(board);
			if(Integer.parseInt(principal.getuIdx()) == board.getuIdx()) {
				board = boardservice.boardEdit(board);
				model.addAttribute("board", board);
			}
			
			return "/board_edit";
		}
		
		@RequestMapping(value="/board/edit/process")
		public String boardEditProcess(Board board) {
			boardservice.boardEditProcess(board);
			
			return "/board_edit_result";
		}
		
		@RequestMapping(value="/board/delete/{boardIdx}")
		public String boardDelete(Board board, Upload upload, @PathVariable Optional<Integer> boardIdx, Authentication authentication) {
			User principal = (User) authentication.getPrincipal();
			board.setbIdx(boardIdx.get());
			board=boardservice.boardInfo(board);
			if(Integer.parseInt(principal.getuIdx()) == board.getuIdx() || Integer.parseInt(principal.getuIdx()) == 2) {
				boardservice.boardDelete(board);
				upload.setbIdx(boardIdx.get());
				List<Upload> list = uploadservice.uploadRead(upload);
				
				String uploadPath="/Users/l6-morning/Documents/work13/lcomputer/src/main/resources/static";
				String fileName1=list.get(0).gettUpload();
				String fileName2=list.get(1).gettUpload();
				String filePath1= uploadPath+ "/" + fileName1;
				String filePath2= uploadPath+ "/" + fileName2;
				
				File f1= new File(filePath1);
				if(f1.exists())
					f1.delete();
				
				File f2= new File(filePath2);
				if(f2.exists())
					f2.delete();
				
				uploadservice.uploadDelete(upload);
			}
			
			return "/board_delete_result";
		}
		
		@RequestMapping(value="/board/reply/{boardIdx}")
		public String boardReply(Board board, @PathVariable Optional<Integer> boardIdx, Model model) {
			board.setbIdx(boardIdx.get());
			board=boardservice.boardReply(board);
			board.setbOrigin(board.getbIdx());
			model.addAttribute("board", board);
			return "/board_reply";
		}
		
		@RequestMapping(value="/board/reply/process")
		public String boardReplyProcess(Board board) {
			boardservice.boardReplyProcess(board);
			return "/board_reply_result";
		}
		
		@RequestMapping(value="/under/insert")
		public String underInsert(Under under, Authentication authentication, Model model) {
			User principal = (User) authentication.getPrincipal();
			under.setuIdx(Integer.parseInt(principal.getuIdx()));
			underservice.underInsert(under);
			model.addAttribute("under", under);
			return "/under_insert_result";
		}
		
		@RequestMapping(value="/under/comment")
		public String underComment(Under under, Model model, Pagination pagination) {
			under.setdOrder(under.getdOrder()+1);
			underservice.underComment(under);
			int count= underservice.underCount(under);
			
			pagination.setCount(count);
			pagination.page();
			under.setPagination(pagination);
			
			List<Under> list = underservice.underList(under);
			
			model.addAttribute("under", under);
			model.addAttribute("list", list);
			model.addAttribute("pagination", pagination);
			return "/under_comment_result";
		}
		
		@RequestMapping(value="/under/comment/edit")
		public String commentEdit(Under under, Pagination pagination, Model model) {
			underservice.underEdit(under);
			int count= underservice.underCount(under);
			
			pagination.setCount(count);
			pagination.page();
			under.setPagination(pagination);
			
			List<Under> list = underservice.underList(under);
			
			model.addAttribute("under", under);
			model.addAttribute("list", list);
			model.addAttribute("pagination", pagination);
			return "/under_comment_result";
		}
		
		@RequestMapping(value="/under/comment/delete")
		public String commentDelete(Under under, Pagination pagination, Model model) {
			underservice.underDelete(under);
			int count= underservice.underCount(under);
			
			pagination.setCount(count);
			pagination.page();
			under.setPagination(pagination);
			
			List<Under> list = underservice.underList(under);
			
			model.addAttribute("under", under);
			model.addAttribute("list", list);
			model.addAttribute("pagination", pagination);
			return "/under_comment_result";
		}
		
		@RequestMapping(value="/survey")
		public String survey(Authentication authentication, User user, Model model) {
			User principal = (User) authentication.getPrincipal();
			user.setuIdx(principal.getuIdx());
			model.addAttribute("user", user);
			return "/survey";
		}
		
		@RequestMapping(value="/survey/insert")
		public String surveyInsert(@RequestBody Survey survey) {
			surveyservice.surveyInsert(survey);
			return "/survey_result";
		}
		
		@RequestMapping(value="/survey/tool/{surveyIdx}")
		public String surveyTool(Survey survey, Model model, @PathVariable Optional<Integer> surveyIdx, User user, Authentication authentication) {
			User principal = (User) authentication.getPrincipal();
			user.setuIdx(principal.getuIdx());
			
			survey.setsIdx(surveyIdx.get());
			survey = surveyservice.surveyTool(survey);
			model.addAttribute("survey", survey);
			model.addAttribute("user", user);
			
			return "/survey_tool";
		}
		
		@RequestMapping(value="/survey/answer")
		public String surveyAnswer(@RequestBody Question question) {
			for (int i=0; i<question.getAnswerList().size(); i++) {
				if ( question.getAnswerList().get(i).getValue() == null || question.getAnswerList().get(i).getValue() == "" ) {
					return "/denied";
				}
			}
			surveyservice.answerInsert(question);
			return "survey_result";
		}
		
		@RequestMapping(value="/survey/list")
		public String surveyList(Model model) {
			List<Survey> list = surveyservice.surveyList();
			model.addAttribute("list", list);
			return "/survey_list";
		}
		
		@RequestMapping(value="/survey/admin/{surveyIdx}")
		public String surveyAdmin(@PathVariable Optional<Integer> surveyIdx, Survey survey, Model model) {
			survey.setsIdx(surveyIdx.get());
			survey = surveyservice.answerTool(survey);
			List<Map<Object, String>> list = new ArrayList<Map<Object, String>>();
			for (int i=0; i<survey.getQuestionList().size(); i++) {
				if(survey.getQuestionList().get(i).getSurveyType() != 4) {
					int count = survey.getQuestionList().get(i).getAnswerList().size();
					survey.setCount(count);
					
					for (int j=0; j<survey.getQuestionList().get(i).getAnswerList().size(); j++) {
						String name = survey.getQuestionList().get(i).getAnswerList().get(j).getUser().getuName();
						String uidx = survey.getQuestionList().get(i).getAnswerList().get(j).getUser().getuIdx();
						
						Map<Object, String> map = new HashMap<Object, String>();
						map.put("name", name);
						map.put("uidx", uidx);
						list.add(map);
					}
					break;
				}
			}
			
			model.addAttribute("survey", survey);
			model.addAttribute("list", list);
			return "/survey_admin_list";
		}
		
		@RequestMapping(value="/survey/detail/{surveyIdx}/{userIdx}")
		public String surveyDetail(@PathVariable Optional<Integer> surveyIdx, @PathVariable Optional<Integer> userIdx, Survey survey, Model model) {
			survey.setsIdx(surveyIdx.get());
			survey.setuIdx(userIdx.get());
			survey = surveyservice.detailTool(survey);
			
			model.addAttribute("survey", survey);
			return "/survey_detail";
		}
		
		@ResponseBody
		@RequestMapping(value="survey/chart")
		public List<Map<String, Object>> answerChart(@RequestBody Question question, Model model) {
			question = surveyservice.questionTool(question);
			
			
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
			for ( int i=0; i<question.getItemList().size(); i++ ) {
				Map<String, Object> itemMap = new HashMap<String, Object>();
				
				String item = question.getItemList().get(i).getValue();
				Answer answer = new Answer();
				answer.setValue(item);
				int itemCount = surveyservice.answerCount(answer);
				
				itemMap.put("item", item);
				itemMap.put("itemCount", itemCount);
				dataList.add(itemMap);
			}
			
			model.addAttribute("dataList", dataList);

			return dataList;
		}
}
