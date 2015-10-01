package com.xinyiread.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
		List<Map<String, Object>> briefArticleList = wService.getWriterArticleBriefList(currentWriter.getId());
		List<Map<String, Object>> incompletedList = new ArrayList<Map<String, Object>>();		// 未完成列表
		List<Map<String, Object>> uncheckedList = new ArrayList<Map<String, Object>>();			// 待审核列表
		List<Map<String, Object>> checkedList = new ArrayList<Map<String, Object>>();			// 已通过列表
		List<Map<String, Object>> failedList = new ArrayList<Map<String, Object>>();			// 未通过列表
		// sort the list
		for (Map<String, Object> briefArticle : briefArticleList) {
			// incompleted article list
			if (briefArticle.get("is_complete").toString().equals("0")) {
				incompletedList.add(briefArticle);
			}
			else {
				switch (Integer.parseInt(briefArticle.get("is_censored").toString())) {
					// article failed to pass
					case -1:
						failedList.add(briefArticle);
						break;
					// article not yet reviewed
					case 0:
						uncheckedList.add(briefArticle);
						break;
					// article has been reviewed
					case 1:
						checkedList.add(briefArticle);
						break;
					default:
				}
			}
		}
		model.put("incompletedList", incompletedList);
		model.put("uncheckedList", uncheckedList);
		model.put("checkedList", checkedList);
		model.put("failedList", failedList);
		
		// add statistics of every list
		model.put("incompletedCount", incompletedList.size());
		model.put("uncheckedCount", uncheckedList.size());
		model.put("checkedCount", checkedList.size());
		model.put("failedCount", failedList.size());
		
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
	
	@RequestMapping(value = "commend_writer", method = RequestMethod.POST)
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
	
	@ResponseBody
	@RequestMapping(value = "setting/update", method = RequestMethod.POST)
	public Map<String, Object> update(HttpSession session,
									  String contact) {
		Map<String, Object> result = new HashMap<String, Object>();
		Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
		if (currentWriter == null) {
			result.put("status", -1);
			return result;
		}
		currentWriter.setContact(contact);
		wService.update(currentWriter);
		result.put("status", 1);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "reset_current_project", method = RequestMethod.POST)
	public Map<String, Object> reset(HttpSession session,
									 String contact) {
		Map<String, Object> result = new HashMap<String, Object>();
		Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
		if (currentWriter == null) {
			result.put("status", 0);
			return result;
		}
		currentWriter.setCurrentProject(0);
		wService.update(currentWriter);
		result.put("status", 1);
		return result;
	}

}
