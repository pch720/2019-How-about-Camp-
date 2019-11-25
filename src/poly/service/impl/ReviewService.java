package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.ReviewDTO;
import poly.persistance.mapper.ReviewMapper;
import poly.service.IReviewService;

@Service("ReviewService")
public class ReviewService implements IReviewService{
	
	@Resource(name="ReviewMapper")
	private ReviewMapper reviewMapper;

	@Override
	public int reviewAdd(ReviewDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		return reviewMapper.reviewAdd(rDTO);
	}

	@Override
	public List<ReviewDTO> getReviewList(HashMap<String, String> rMap) throws Exception {
		// TODO Auto-generated method stub
		return reviewMapper.getReviewList(rMap);
	}

	@Override
	public int reviewDel(ReviewDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		return reviewMapper.reviewDel(rDTO);
	}

	@Override
	public int reviewMod(ReviewDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		return reviewMapper.reviewMod(rDTO);
	}

}
