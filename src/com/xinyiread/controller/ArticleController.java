package com.xinyiread.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xinyiread.service.ArticleService;

@Controller
@RequestMapping("article")
public class ArticleController {

	@Autowired
	private ArticleService aService;
	
}
