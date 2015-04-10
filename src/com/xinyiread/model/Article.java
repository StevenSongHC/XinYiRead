package com.xinyiread.model;

import java.sql.Date;

public class Article {

	private long id;
	private long wid;
	private int catid;
	private String title;
	private String intro;
	private String content;
	private String recommand;
	private int readCount;
	private int likeCount;
	private int dislikeCount;
	private Date publishDate;
	private int isComplete;
	private int isWriterShow;
	private int isCensored;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getWid() {
		return wid;
	}
	public void setWid(long wid) {
		this.wid = wid;
	}
	public int getCatid() {
		return catid;
	}
	public void setCatid(int catid) {
		this.catid = catid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRecommand() {
		return recommand;
	}
	public void setRecommand(String recommand) {
		this.recommand = recommand;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public int getDislikeCount() {
		return dislikeCount;
	}
	public void setDislikeCount(int dislikeCount) {
		this.dislikeCount = dislikeCount;
	}
	public Date getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
	public int getIsComplete() {
		return isComplete;
	}
	public void setIsComplete(int isComplete) {
		this.isComplete = isComplete;
	}
	public int getIsWriterShow() {
		return isWriterShow;
	}
	public void setIsWriterShow(int isWriterShow) {
		this.isWriterShow = isWriterShow;
	}
	public int getIsCensored() {
		return isCensored;
	}
	public void setIsCensored(int isCensored) {
		this.isCensored = isCensored;
	}
	
}
