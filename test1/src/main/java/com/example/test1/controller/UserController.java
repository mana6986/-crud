package com.example.test1.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.RedirectView;

import com.example.test1.dao.UserService;
import com.example.test1.model.User;

@Controller
public class UserController {
    
	@Autowired
    private UserService userService;

	@PostMapping("/register")
	@ResponseBody // JSON 형태로 응답을 반환하도록 설정
	public ResponseEntity<?> register(@RequestBody User user) {
	    System.out.println(user.toString());
	    userService.save(user); // 회원 정보 저장
	    // 성공 응답을 JSON 형태로 반환
	    return ResponseEntity.ok().body("{\"message\": \"가입되었습니다.\"}");
	}

	  
	 @GetMapping("/checkName")
	 public ResponseEntity<String> checkName(@RequestParam("name") String name) {
	     if (userService.isNameUnique(name)) {
	         return ResponseEntity.ok().body("unique");
	     } else {
	         return ResponseEntity.ok().body("duplicate");
	     }
	 }
	   
	   
	    @PostMapping("/checkFields")
	    public Map<String, Boolean> checkFields(@RequestBody Map<String, String> requestBody) {
	        String name = requestBody.get("name");
	        String email = requestBody.get("email");
	        String phone = requestBody.get("phone");

	        return userService.checkFields(name, email, phone);
	    }
//	  

	 

		
		
		@RequestMapping("/student.do") 
	    public String main(Model model) throws Exception{

	        return "/student-list";
	    }
		@GetMapping("/profile")
	    public String profile(Model model) throws Exception{
	        
	        return "/profile";
	    }
		
		 @GetMapping("/checkEmail")
		    @ResponseBody
		    public String checkEmail(@RequestParam("email") String email) {
		        int count = userService.countByEmail(email);
		        if (count > 0) {
		            return "duplicate";
		        } else {
		            return "unique";
		        }
		    }
		 @PostMapping("/login")
		 public String login(@RequestParam String email,
		                     @RequestParam String password,
		                     HttpSession session) {
		     int check = userService.getIdPassCheck(email, password);

		     if (check == 1) {
		         session.setMaxInactiveInterval(60 * 60 * 8); // 세션 8시간 저장
		         User user = userService.findByEmail(email);
		         if (user == null) {
		             System.out.println("User not found with email: " + email);
		         } else {
		             session.setAttribute("user", user); 
		             System.out.println("Session Value (user email): " + user.getEmail());
		         }
		         return "redirect:/tables"; // 로그인 성공 시 tables 페이지로 리다이렉트
		     } else {
		         // 로그인 실패 시 알림을 출력하고 다시 로그인 페이지로 이동
		         return "redirect:/login?error=1";
		     }
		 }

		 @GetMapping("/logout")
		    public String logout(HttpSession session) {
		        session.invalidate(); // 세션 종료
		        return "redirect:/login"; // 로그인 페이지로 리다이렉트
		    }



		 @GetMapping("/login")
		    public String loginForm(HttpSession session, Model model) {
		        User user = (User) session.getAttribute("user");
		        if (user == null) { // 사용자가 로그인하지 않은 경우
		            model.addAttribute("loginText", "로그인"); // 로그인 텍스트 추가
		        } else {
		            model.addAttribute("loginText", "로그아웃"); // 로그아웃 텍스트 추가
		        }
		        return "login"; // 로그인 폼 페이지로 이동
		    }


		 
		 @GetMapping("/checkLoginStatus")
		 public Map<String, Boolean> checkLoginStatus(HttpSession session) {
		     boolean loggedIn = session.getAttribute("user") != null;
		     Map<String, Boolean> response = new HashMap<>();
		     response.put("loggedIn", loggedIn);
		     return response;
		 }
		

		@GetMapping("/membership")
	    public String membership(Model model) throws Exception{
	        
	        return "/membership";
	    }
		@GetMapping("/write")
	    public String write(Model model) throws Exception{
	        
	        return "/write";
	    }
		@GetMapping("/profileModify")
	    public String profileModify(Model model) throws Exception{
	        
	        return "/profileModify";
	    }
		
		@GetMapping("/sidebar")
	    public String header(Model model) throws Exception{
	        
	        return "/sidebar";
	    }
		  @GetMapping("/test")
		    public String test(Model model) {
		        return "/test";
		    }
	
		
		   @RequestMapping("/detail") 
		    public String detail(Model model) throws Exception{

		        return "/detail";
		    }
	}

	
