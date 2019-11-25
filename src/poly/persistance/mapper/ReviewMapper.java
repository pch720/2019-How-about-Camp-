package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.ReviewDTO;

@Mapper("ReviewMapper")
public interface ReviewMapper {

	int reviewAdd(ReviewDTO rDTO) throws Exception;

	List<ReviewDTO> getReviewList(HashMap<String, String> rMap)throws Exception;

	int reviewDel(ReviewDTO rDTO)throws Exception;

	int reviewMod(ReviewDTO rDTO)throws Exception;

}
