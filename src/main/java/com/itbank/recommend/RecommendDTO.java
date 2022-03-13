package com.itbank.recommend;

public class RecommendDTO {
	
	private String nick;
	private int r_reply_idx,reply_idx,board_idx;
	
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
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
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}

}
