package com.codingdojo.com.helpduck.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.com.helpduck.models.Ticket;
import com.codingdojo.com.helpduck.models.User;
import com.codingdojo.com.helpduck.repositories.TicketRepo;

@Service
public class TicketServ {

	@Autowired
	private TicketRepo ticketRepo;
	
	@Autowired
	private UserServ userServ;
	
//	======
//	CREATE
//	======
	public Ticket saveOne(Ticket ticket) {
		return ticketRepo.save(ticket);
	}
	
//	====
//	READ
//	====
	public List<Ticket> getAll() {
		return ticketRepo.findAll();
	}
	public Ticket getOne(Long id) {
		return ticketRepo.findById(id).orElse(null);
	}
	
//	======
//	UPDATE
//	======
	public Ticket updateOne(Ticket editTicket) {
		return ticketRepo.save(editTicket);
	}
	
//	======
//	DELETE
//	======
	public void deleteOne(Long id) {
		ticketRepo.deleteById(id);
	}
	
//	======
//	LIKE
//	======
//	PUTMAP
	 public Ticket likeTicket(Long ticketId, Long userId) {
		 User user = userServ.getUser(userId);
		 
		 Ticket ticket=this.getOne(ticketId);
		 System.out.println(user.getName());
		 System.out.println(ticket.getTitle());
		 if(!ticket.getLikedUsers().contains(user)) {
			 ticket.getLikedUsers().add(user);	
			 System.out.println("SUCCESS");
			 return ticketRepo.save(ticket);
		 } else {
			 System.out.println("ticket service: return null");
			 return null;
		 }
	 }
	 
//	 POSTMAP	 
	 public Ticket bookmark(Long ticketId, Long userId) {
		 Ticket thisTicket = getOne(ticketId);
		 User thisUser = userServ.getUser(userId);
		 thisTicket.getLikedUsers().add(thisUser);
		  return ticketRepo.save(thisTicket);
	 }

//	======
//	UNLIKE
//	======
	 public void unlikeTicket(long ticketId, Long userId) {
		 
		 User user =userServ.getUser(userId);
		 
		 Ticket ticket=this.getOne(ticketId);
		 
		 ticket.getLikedUsers().remove(user);
		 
		 ticketRepo.save(ticket);
	 }
	 
	
}
