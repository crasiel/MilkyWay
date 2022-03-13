package com.itbank.recommend;

import org.apache.ibatis.annotations.Select;

public interface RecommendDAO {

	RecommendDTO selectOne(RecommendDTO dto);

	int insert(RecommendDTO dto);

	int count(RecommendDTO dto);

	int delete(RecommendDTO dto);

	@Select("select count(*) from recommend where reply_idx = #{reply_idx}")
	int count1(int reply_idx);

}
