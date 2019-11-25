package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.BoardDTO;
import poly.persistance.mapper.BoardMapper;
import poly.service.IBoardService;

@Service("BoardService")
public class BoardService implements IBoardService {

	@Resource(name="BoardMapper")
	private BoardMapper boardMapper;

	@Override
	public int boardAddproc(BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.boardAddproc(bDTO);
	}

	@Override
	public List<BoardDTO> getBoardList(HashMap<String, Integer> hMap) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getBoardList(hMap);
	}

	@Override
	public BoardDTO boardDetail(BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.boardDetail(bDTO);
	}

	@Override
	public int boardDelete(BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.boardDelete(bDTO);
	}

	@Override
	public int boardMod(BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.boardMod(bDTO);
	}

	@Override
	public int count(BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.count(bDTO);
	}

	@Override
	public List<BoardDTO> userBoard(HashMap<String, Integer> hMap) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.userBoard(hMap);
	}

	@Override
	public int TotalCount() throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.TotalCount();
	}

	@Override
	public int myTotalCount(String userSeq) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.myTotalCount(userSeq);
	}
	
}
