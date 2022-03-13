package com.itbank.board;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


public interface BoardDAO {

	@Insert("insert into board (originalFileName, storedFileName, content, hashtag,writer) values (#{originalFileName}, #{storedFileName}, #{content}, #{hashtag} , #{writer})")
	int insert(BoardDTO dto);

	@Select("select * from board order by idx desc")
	List<BoardDTO> selectBoardList();

	@Select("select * from board where hashtag like '%${hashtag}%' order by idx desc")
	List<BoardDTO> getSearchList(String hashtag);

	@Insert("insert into hashtag(hashtag) values (#{hashtag})")
	int hashInsert(String hashtag);

	@Select("select hashtag from hashtag")
	List<Hashtag> getHash();

	@Update("update hashtag set hashCnt = hashCnt + 1 where hashtag = #{hashtag} ")
	int plusCnt(String hasgtag);

	@Select("select * from board where idx=#{idx}")
	BoardDTO selectOne(int idx);

	@Select("select * from hashtag order by hashCnt desc limit 5;")
	List<Hashtag> selectHashList();

}
