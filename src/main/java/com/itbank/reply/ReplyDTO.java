package com.itbank.reply;

public class ReplyDTO {
//   `reply_idx` int NOT NULL AUTO_INCREMENT,
//     `reply_nick` varchar(20) not NULL,
//     `reply_content` varchar(200) not NULL,
//     `reply_date` varchar(20) not NULL,
//     `board_idx`
   
   private int board_idx, reply_idx, type,count;
   private boolean recommend=false;
   
   
   public int getCount() {
	return count;
}
public void setCount(int count) {
	this.count = count;
}
public boolean isRecommend() {
	return recommend;
}
   public void setRecommend(boolean recommend) {
	this.recommend = recommend;
}
public int getType() {
      return type;
   }
   public void setType(int type) {
      this.type = type;
   }
   private String reply_nick, reply_content, reply_date;
   public int getBoard_idx() {
      return board_idx;
   }
   public void setBoard_idx(int board_idx) {
      this.board_idx = board_idx;
   }
   public int getReply_idx() {
      return reply_idx;
   }
   public void setReply_idx(int reply_idx) {
      this.reply_idx = reply_idx;
   }
   public String getReply_nick() {
      return reply_nick;
   }
   public void setReply_nick(String reply_nick) {
      this.reply_nick = reply_nick;
   }
   public String getReply_content() {
      return reply_content;
   }
   public void setReply_content(String reply_content) {
      this.reply_content = reply_content;
   }
   public String getReply_date() {
      return reply_date;
   }
   public void setReply_date(String reply_date) {
      this.reply_date = reply_date;
   }
   
   
   
}