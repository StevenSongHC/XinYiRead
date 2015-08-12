package com.xinyiread.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;
import com.xinyiread.service.WriterService;

@Controller
@RequestMapping("writer")
public class WriterController {
	
	@Autowired
	WriterService wService;
	
	@RequestMapping
	public String index(HttpSession session,
						ModelMap model) {
		Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
		
		if (currentWriter == null)
			return "redirect:/login";
		
		model.put("writer", currentWriter);
		return "WRITER/index";
	}
	
	@RequestMapping("i/{penName}")
	public String homepage(ModelMap model,
						   @PathVariable String penName) {
		Writer writer = wService.getWriterByPenName(penName);
		
		if (writer == null)
			return "STATIC/404";
		
		model.put("writer", writer);
		return "WRITER/homepage";
	}
	
	@RequestMapping("commend_writer")
	@ResponseBody
	public Map<String, Object> commendWriter(HttpSession session,
			 								 long wid) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User currentUser = (User) session.getAttribute("USER_SESSION");
		
		if (currentUser == null) {
			result.put("status", -1);		// login user required
			return result;
		}
		
		Writer writer = wService.getWriterById(wid);
		
		if (writer == null) {
			result.put("status", 0);		// writer does not existed
			return result;
		}
		
		if (!wService.getUserCommendWriterHistory(currentUser.getId(), wid).isEmpty()) {
			result.put("status", 2);		// user already commended
			return result;
		}
		
		// commend
		wService.commendWriter(currentUser.getId(), wid);

		result.put("status", 1);			// rating succeed
		return result;
	}
	
	@RequestMapping("setting")
	public String setting(ModelMap model,
						  HttpSession session) {
		Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
		if (currentWriter == null)
			return "redirect:../404";
		model.put("writer", currentWriter);
		return "WRITER/setting";
	}

}
