package com.lcomputer.example.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lcomputer.example.domain.Answer;
import com.lcomputer.example.domain.Question;
import com.lcomputer.example.domain.Survey;
import com.lcomputer.example.mapper.SurveyMapper;

@Service("SurveyServiceImpl")
public class SurveyServiceImpl implements SurveyService {
	
	@Autowired SurveyMapper surveymapper; 
	
	@Override
	public void surveyInsert(Survey survey) {
		surveymapper.surveyInsert(survey);
		
		for (int i=0; i<survey.getQuestionList().size(); i++) {
			Map<String, Object> questionMap = new HashMap<String, Object>();
			List<Map<String, Object>> qList = new ArrayList<Map<String, Object>>();
			Map<String, Object> qMap;
			questionMap.put("sIdx", survey.getsIdx());
			
			qMap = new HashMap<String, Object>();
			qMap.put("title", survey.getQuestionList().get(i).getTitle());
			qMap.put("type", survey.getQuestionList().get(i).getSurveyType());
			
			qList.add(qMap);
			questionMap.put("qList", qList);
			questionMap.put("qIdx", 0);
			surveymapper.questionInsert(questionMap);
			
			if( survey.getQuestionList().get(i).getItemList() != null) {
				Map<String, Object> itemMap = new HashMap<String, Object>();
				itemMap.put("qIdx", questionMap.get("qIdx"));
				
				Map<String, Object> iMap;
				List<Map<String, Object>> iList = new ArrayList<Map<String, Object>>();
				for (int j=0; j<survey.getQuestionList().get(i).getItemList().size(); j++) {
					iMap = new HashMap<String, Object>();
					iMap.put("value", survey.getQuestionList().get(i).getItemList().get(j).getValue());
					
					iList.add(iMap);
				}
				itemMap.put("iList", iList);
				surveymapper.itemInsert(itemMap);
			}
		}
	}
	
	@Override
	public Survey surveyInfo(Survey survey) {
		return surveymapper.surveyInfo(survey);
	}
	
	@Override
	public Survey surveyTool(Survey survey) {
		return surveymapper.surveyTool(survey);
	}
	
	@Override
	public void answerInsert(Question question) {
		Map<String, Object> answerMap = new HashMap<String, Object>();
		List<Map<String, Object>> aList = new ArrayList<Map<String, Object>>();
		for (int i=0; i<question.getAnswerList().size(); i++) {
			Map<String, Object> aMap;
			
			aMap = new HashMap<String, Object>();
			aMap.put("value", question.getAnswerList().get(i).getValue());
			aMap.put("qIdx", question.getAnswerList().get(i).getqIdx());
			aMap.put("uIdx", question.getAnswerList().get(i).getuIdx());
			
			aList.add(aMap);
		}
		answerMap.put("aList", aList);
		surveymapper.answerInsert(answerMap);
	}
	
	@Override
	public List<Survey> surveyList() {
		return surveymapper.surveyList();
	}
	
	@Override
	public Survey answerTool(Survey survey) {
		return surveymapper.answerTool(survey);
	}
	
	@Override
	public Survey detailTool(Survey survey) {
		return surveymapper.detailTool(survey);
	}
	
	@Override
	public Question questionTool(Question question) {
		return surveymapper.questionTool(question);
	}
	
	@Override
	public int answerCount(Answer answer) {
		return surveymapper.answerCount(answer);
	}
	
}
