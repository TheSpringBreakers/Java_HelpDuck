package com.codingdojo.com.helpduck.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.com.helpduck.models.LoginUser;
import com.codingdojo.com.helpduck.models.Ticket;
import com.codingdojo.com.helpduck.models.User;
import com.codingdojo.com.helpduck.services.TicketServ;
import com.codingdojo.com.helpduck.services.UserServ;

@Controller
public class HomeController {

	@Autowired
	private UserServ userServ;
	
	@Autowired
	private TicketServ ticketServ;
	
	
    // ==========================
    //      MAIN FUNCTIONS
    // ==========================
	@GetMapping("/")
	public String index(HttpSession session, Model model) {
		if(session.getAttribute("user_id") != null) {
			return "redirect:/home";
		} else {
			model.addAttribute("newUser", new User());
	        model.addAttribute("newLogin", new LoginUser());
	        	return "index.jsp";
		}
	}
	
	@GetMapping("/home")
	public String home(HttpSession session, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/";
		} else {
			model.addAttribute("theUser", userServ.getUser((Long)session.getAttribute("user_id")));
	        return "home.jsp";
		}
	}
	
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, @ModelAttribute("ticket") Ticket ticket, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/";
		} else {
			model.addAttribute("theUser", userServ.getUser((Long)session.getAttribute("user_id")));
			model.addAttribute("allTickets",ticketServ.getAll());
	        return "dashboard.jsp";
		}
	}
	
    // ==========================
    //      LOGREG FUNCTIONS
    // ==========================
	
   // Create User Process
   @PostMapping("/register")
   public String registerUser(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {
   	userServ.register(newUser, result);
       if(result.hasErrors()) {
           model.addAttribute("newLogin", new LoginUser());
           return "index.jsp";
       }
       session.setAttribute("user_id", newUser.getId());
       return "redirect:/home";
   }
   
   // Login User Process
   @PostMapping("/login")
   public String loginUser(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {
       User user = userServ.login(newLogin, result);
       if(result.hasErrors()) {
           model.addAttribute("newUser", new User());
           return "index.jsp";
       }
       session.setAttribute("user_id", user.getId());
       return "redirect:/home";
   }
   
   // Logout User
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

    // ==========================
    //      TICKET FUNCTIONS
    // ==========================
	
	@GetMapping("ticket/add")
	public String addTicket(HttpSession session, @ModelAttribute("saveTicketForm") Ticket ticket, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/";
		} else {
		return "addTicket.jsp";
		}
	}
	
	@PostMapping("ticket/save")
	public String saveTicket(@Valid @ModelAttribute("saveTicketForm") Ticket ticket, BindingResult result, Model model) {
		if(result.hasErrors()) {
			return "addTicket.jsp";
		} else {
			ticketServ.saveOne(ticket);
			return "redirect:/dashboard";
		}
	}
	
	@GetMapping("ticket/{id}/view")
	public String viewTicket(HttpSession session, @PathVariable("id") Long id, @ModelAttribute("ticket") Ticket ticket, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/";
		} else {
		model.addAttribute("theTicket", ticketServ.getOne(id));
		List<User> allUsers = userServ.getAllUsers();
		model.addAttribute("allUsers", allUsers);
		return "viewTicket.jsp";
		}
	}
	
	@GetMapping("ticket/{id}/edit")
	public String editTicket(HttpSession session, @PathVariable("id") Long id, @ModelAttribute("editTicketForm") Ticket ticket, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/";
		} else {
		model.addAttribute("theTicket", ticketServ.getOne(id));
		return "editTicket.jsp";
		}
	}
	@PutMapping("ticket/{id}/update")
	public String updateTicket(@PathVariable("id") Long id, @Valid @ModelAttribute("editTicketForm") Ticket editTicket, BindingResult result, Model model) {
		if(result.hasErrors()) {
			model.addAttribute("theTicket", ticketServ.getOne(id));
			return "editTicket.jsp";
		} else {
			ticketServ.updateOne(editTicket);
			return "redirect:/ticket/{id}/view";
		}
	}
	
	@GetMapping("ticket/{id}/delete")
	public String deleteTicket(@PathVariable("id") Long id) {
		ticketServ.deleteOne(id);
		return "redirect:/dashboard";
	}
	
	@PostMapping("/ticket/bookmark/{id}")
	public String bookmarkTicket(@PathVariable("id") Long ticketId, @RequestParam("userId") Long userId) {
		
		System.out.println(ticketId);
		System.out.println(userId);
//		retrieve a ticket obj using the ticket id
		Ticket ticket = ticketServ.getOne(ticketId);
		
//		retrieve the user obj using the user id
		User user = userServ.getUser(userId);
		
//		printing to see the liked users of the ticket currently
		List<User> currentLikedUsers = ticket.getLikedUsers();
		System.out.println(currentLikedUsers);
		
//		add current signed in user to list of liked users of ticket
		currentLikedUsers.add(user);
		System.out.println(currentLikedUsers);
		
//		set the ticket liked users to be the new list
		ticket.setLikedUsers(currentLikedUsers);
		
//		send to service and update database
		ticketServ.updateOne(ticket);
		
		return "redirect:/dashboard";
	}
	
}
