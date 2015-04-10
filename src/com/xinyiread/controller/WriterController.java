package com.xinyiread.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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

}
