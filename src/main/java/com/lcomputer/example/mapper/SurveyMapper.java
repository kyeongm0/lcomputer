package com.lcomputer.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.lcomputer.example.domain.Answer;
import com.lcomputer.example.domain.Question;
import com.lcomputer.example.domain.Survey;

@Mapper
public interface SurveyMapper {
	
	public void questionInsert(Map<String, Object> questionMap);
	
	public void itemInsert(Map<String, Object> itemMap);
	
	public void surveyInsert(Survey survey);
	
	public Survey surveyInfo(Survey survey);
	
	public Survey surveyTool(Survey survey);
	
	public void answerInsert(Map<String, Object> answerMap);
	
	public List<Survey> surveyList();
	
	public Survey answerTool(Survey survey);
	
	public Survey detailTool(Survey survey);
	
	public Question questionTool(Question question);
	
	public int answerCount(Answer answer);
}
