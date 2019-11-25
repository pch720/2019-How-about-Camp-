package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.BoardDTO;

@Mapper("BoardMapper")
public interface BoardMapper {

	int boardAddproc(BoardDTO bDTO)throws Exception;

	List<BoardDTO> getBoardList(HashMap<String, Integer> hMap)throws Exception;

	BoardDTO boardDetail(BoardDTO bDTO)throws Exception;

	int boardDelete(BoardDTO bDTO)throws Exception;

	int boardMod(BoardDTO bDTO)throws Exception;

	int count(BoardDTO bDTO)throws Exception;

	List<BoardDTO> userBoard(HashMap<String, Integer> hMap)throws Exception;

	int TotalCount()throws Exception;

	int myTotalCount(String userSeq)throws Exception;

}
