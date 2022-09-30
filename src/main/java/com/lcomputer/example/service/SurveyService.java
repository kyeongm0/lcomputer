package com.lcomputer.example.service;

import java.util.List;

import com.lcomputer.example.domain.Answer;
import com.lcomputer.example.domain.Question;
import com.lcomputer.example.domain.Survey;

public interface SurveyService {
	public void surveyInsert(Survey survey);
	
	public Survey surveyInfo(Survey survey);

	public Survey surveyTool(Survey survey);
	
	public void answerInsert(Question question);
	
	public List<Survey> surveyList();
	
	public Survey answerTool(Survey survey);
	
	public Survey detailTool(Survey survey);
	
	public Question questionTool(Question question);
	
	public int answerCount(Answer answer);
}
