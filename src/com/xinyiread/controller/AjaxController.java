package com.xinyiread.controller;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.xinyiread.model.User;
import com.xinyiread.service.UserService;
import com.xinyiread.service.WriterService;

@Controller
@RequestMapping("ajax")
public class AjaxController {

	@Autowired
	private UserService uService;
	@Autowired
	private WriterService wService;
	
	@ResponseBody
	@RequestMapping("greeting")
	public Map<String, Object> greeting(String data) {
		Map<String, Object> result = new HashMap<String, Object>();
		Logger androidLog = Logger.getLogger("managerLogger");
		androidLog.info("HelloAndroind - " + data);
		result.put("msg", "Ajax Greeting!");
		return result;
	}
	
	@ResponseBody
	@RequestMapping("checkUsername")
	public Map<String, Object> isUsernameExisted(String username) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (uService.getUserByName(username) != null)
			result.put("isExisted", true);
		else
			result.put("isExisted", false);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("checkEmail")
	public Map<String, Object> isEmailExisted(String email) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (uService.getUserByEmail(email) != null)
			result.put("isExisted", true);
		else
			result.put("isExisted", false);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("checkPenName")
	public Map<String, Object> isPenNameExisted(String penName) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (wService.getWriterByPenName(penName) != null)
			result.put("isExisted", true);
		else
			result.put("isExisted", false);
		return result;
	}
	
	@RequestMapping(value = "ajaxFormSubmit", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxFormSubmit(HttpSession session,
											  HttpServletRequest request,
			  								  @RequestParam(value="uploadFile") MultipartFile uploadFile, 
											  String type,
											  String fileType) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (type != null && !type.equals("")) {
			if (type.equals("userPortrait")) {
				User currentUser = (User) session.getAttribute("USER_SESSION");
				if (currentUser != null) {
					String saveName = "images/portrait/" + currentUser.getId() + "_" + Calendar.getInstance().getTimeInMillis() + fileType;
					String savePath = request.getServletContext().getRealPath("") + "/" + saveName;
					System.out.println(savePath);
					// can't delete default portrait
					if (!currentUser.getPortrait().equals("images/portrait/default.png")) {
						// delete the old portrait
						// WARNING: if the portrait file name can't match with the real portrait file in the directory, leads to uploading new portrait failure, //
						//          thus requires to update the portrait file name according to the one stored in database                                       //
						if (!new File(request.getServletContext().getRealPath("")+ "/" +currentUser.getPortrait()).delete()) {
							// failed
							System.out.println("failed here");
							result.put("code", 0);
							return result;
						}
					}
					try {
						// upload and update
						uploadFile.transferTo(new File(savePath));
						currentUser.setPortrait(saveName);
						uService.updateUser(currentUser);
						result.put("newPhoto", currentUser.getPortrait());
						result.put("code", 1);
					} catch (IOException e) {
						System.out.println("upload new portrait failed");
						result.put("code", 0);
						e.printStackTrace();
					}
				}
				else {
					// user login required
					result.put("code", -1);
				}
			}
		}
		return result;
	}
	
}
