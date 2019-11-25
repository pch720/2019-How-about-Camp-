package poly.service;

import java.util.HashMap;
import java.util.List;

import poly.dto.ReviewDTO;

public interface IReviewService {

	int reviewAdd(ReviewDTO rDTO) throws Exception;

	List<ReviewDTO> getReviewList(HashMap<String, String> rMap)throws Exception;

	int reviewDel(ReviewDTO rDTO)throws Exception;

	int reviewMod(ReviewDTO rDTO)throws Exception;

}
