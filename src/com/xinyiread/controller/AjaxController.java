package com.xinyiread.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("ajax")
public class AjaxController {
	
	@ResponseBody
	@RequestMapping("greeting")
	public Map<String, Object> greeting(String data) {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(data);
		result.put("msg", "Ajax Greeting!");
		return result;
	}
	
}
