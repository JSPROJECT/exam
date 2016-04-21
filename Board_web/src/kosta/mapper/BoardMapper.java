package kosta.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import kosta.model.Board;
import kosta.model.Reply;
import kosta.model.Search;

//import kosta.model.Board;
//import kosta.model.Search;

public interface BoardMapper {
	public int insertBoard(Board board);
	public List<Board> listBoard(RowBounds row,Search search);
	public Board selectBoard(int b_id);
	public int updatehitBoard(int b_id);
	public int updateBoardcontent(Board board);
	public int updateStep(Map<String, Integer> map);
	public Integer selectB_id();
	public int countBoard(Search search);
//	int inserBoard(Board board);
//	List<Board> listBoard(Search search);
//	Board Board_detail(String seq);
//	int updateBoard(Board board);
	public List<Reply> replyList(int b_id);
	public int insertReply(Reply reply);
}
