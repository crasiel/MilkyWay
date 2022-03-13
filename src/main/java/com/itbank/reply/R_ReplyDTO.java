package com.itbank.reply;

public class R_ReplyDTO {
//	`r_reply_idx` int NOT NULL AUTO_INCREMENT,
//	  `reply_idx` int NOT NULL,
//	  `r_reply_nick` varchar(20) not NULL,
//	  `r_reply_content` varchar(100) not NULL,
//	  `r_reply_date`
	
	private int r_reply_idx, reply_idx;
	private String r_reply_nick, r_reply_content, r_reply_date;
	public int getR_reply_idx() {
		return r_reply_idx;
	}
	public void setR_reply_idx(int r_reply_idx) {
		this.r_reply_idx = r_reply_idx;
	}
	public int getReply_idx() {
		return reply_idx;
	}
	public void setReply_idx(int reply_idx) {
		this.reply_idx = reply_idx;
	}
	public String getR_reply_nick() {
		return r_reply_nick;
	}
	public void setR_reply_nick(String r_reply_nick) {
		this.r_reply_nick = r_reply_nick;
	}
	public String getR_reply_content() {
		return r_reply_content;
	}
	public void setR_reply_content(String r_reply_content) {
		this.r_reply_content = r_reply_content;
	}
	public String getR_reply_date() {
		return r_reply_date;
	}
	public void setR_reply_date(String r_reply_date) {
		this.r_reply_date = r_reply_date;
	}
	
}
