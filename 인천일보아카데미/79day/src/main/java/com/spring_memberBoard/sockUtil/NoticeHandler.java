package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class NoticeHandler extends TextWebSocketHandler{
	
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 클라이언트가 웹소켓에 접속을 했을 때 실행
		clientList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 클라이언트가 웹소켓에 메세지를 전송했을 때 실행
		System.out.println("message : " + message.getPayload());
		// {"noticeType":"reply","bno":10,"bwriter":"작성자 테스트"}
		
		JsonObject noticeObj = JsonParser.parseString(message.getPayload()).getAsJsonObject();
		
		String noticeType = noticeObj.get("noticeType").getAsString();
		
		// message >> 공지 종류, 댓글이 작성된 글번호, 댓글이 작성된 원본 게시글의 작성자
		// 공지종류 : 새 글 등록 알림(전체), 댓글 등록 알림(개별)
		
		// 새 글 등록 알림 : "새 글이 등록 되었습니다".
		
		// 댓글 등록 알림 : "??번글에 댓글이 등록 되었습니다".
		// 글번호, 알림을 받을 대상
		
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", noticeType);
		
		switch(noticeType) {
			case "reply" : // 개별 전송 - bwriter에게 전송 ( bwriter == 회원아이디 )
				
				String bno = noticeObj.get("noticeMsg").getAsString();
				String bwriter = noticeObj.get("receiveId").getAsString();
				msgInfo.put("msgcomm", bno);
				
				for(WebSocketSession client : clientList) {
					Map<String, Object> clientAttr = client.getAttributes();
					String clientMemberId = (String)clientAttr.get("loginMemberId");
					if(clientMemberId.equals(bwriter)) {
						client.sendMessage(new TextMessage(new Gson().toJson(msgInfo)));
					}
				}
				break;
			case "board" : // 전체 전송
				// 서버가 접속 중인 클라이언트들에게 메세지 전송
				msgInfo.put("msgcomm", "새 글이 등록되었습니다.");
				for(WebSocketSession client : clientList) {
					client.sendMessage(new TextMessage(new Gson().toJson(msgInfo)));
				}
				break;
		}
		
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 클라이언트가 웹소켓에 접속을 해제 했을 때 실행
		clientList.remove(session);
	}
	
}
