package com.codingdojo.com.helpduck.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.com.helpduck.models.Ticket;

@Repository
public interface TicketRepo extends CrudRepository<Ticket, Long>{

	List<Ticket> findAll();
}
