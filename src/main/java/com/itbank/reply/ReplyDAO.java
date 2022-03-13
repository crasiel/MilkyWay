package com.itbank.reply;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface ReplyDAO {

	@Insert("insert into reply values(0, #{reply_nick}, #{reply_content}, now(), #{board_idx})")
	int insertReply(ReplyDTO dto);

	@Select("select * from reply where board_idx=#{idx} order by reply_date desc")
	List<ReplyDTO> selectReplyAll(int idx);

	@Delete("delete from reply where reply_idx=#{reply_idx}")
	int delete(int reply_idx);

	@Insert("insert into r_reply values(0, #{reply_idx}, #{r_reply_nick}, #{r_reply_content}, now())")
	int insertR_Reply(R_ReplyDTO r_dto);

	@Select("select * from r_reply where reply_idx in (select reply_idx from reply where board_idx=#{idx}) order by reply_idx desc, r_reply_date desc")
	List<R_ReplyDTO> selectR_ReplyAll(int idx);

	@Delete("delete from r_reply where r_reply_idx = #{r_reply_idx}")
	int deleteR_Reply_idx(int r_reply_idx);

	@Select("select * from reply order by reply_idx desc, reply_date desc")
	List<ReplyDTO> selectAll();
	

}
