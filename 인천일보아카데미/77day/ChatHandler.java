package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class ChatHandler extends TextWebSocketHandler{
	
	
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	@Override	
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("채팅페이지 접속");
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginMemberId = (String)sessionAttrs.get("loginMemberId");
		System.out.println(loginMemberId);
		
		Gson gson = new Gson();
		Map<String,String> msgInfo = new HashMap<String,String>();
		
		msgInfo.put("msgtype", "c");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", "접속 했습니다.");
		
		for(WebSocketSession client: clientList) {
			//새 참여자 접속 안내 메세지 전송
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
		clientList.add(session); //클라이언트 목록에 저장
	}

	@Override

	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("채팅 메세지 전송");
		System.out.println("전송한 메세지: " + message.getPayload());
		
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginMemberId = (String) sessionAttrs.get("loginMemberId");
		System.out.println(loginMemberId);
		
		Gson gson = new Gson();
		Map<String,String> msgInfo = new HashMap<String,String>();
		
		msgInfo.put("msgtype", "m");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", message.getPayload());
		
		for(WebSocketSession client : clientList) {
			if(!client.getId().equals(session.getId())) {
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅페이지 접속 해제");
		clientList.remove(session);

		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginMemberId = (String) sessionAttrs.get("loginMemberId");
		
		System.out.println(loginMemberId);
		
		Gson gson = new Gson();
		Map<String,String> msgInfo = new HashMap<String,String>();
		
		msgInfo.put("msgtype", "d");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", "접속을 해제했습니다.");
		
		for(WebSocketSession client : clientList) {
			//참여자 접속 해제 안내 메세지 전송
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
			}
		
	}
}
