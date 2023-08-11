package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class ChatHandler extends TextWebSocketHandler{
	
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 접속했을 때
		
		Map<String, Object> sessionAttr = session.getAttributes();
		String loginId = (String)sessionAttr.get("loginMemberId");
		
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		
		msgInfo.put("msgType", "c"); // c, d, m
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", " 님이 접속하였습니다.");
		
		Gson gson = new Gson();
		
		for(WebSocketSession client : clientList) {
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
		
		clientList.add(session); // 클라이언트 목록에 저장
		
		for(WebSocketSession client : clientList) {
			Map<String, Object> sessionAttrs = client.getAttributes();
			String clientMemberId = (String)sessionAttrs.get("loginMemberId");
			
			HashMap<String, String> clientInfo = new HashMap<String, String>();
			
			clientInfo.put("msgType", "c"); // c, d, m
			clientInfo.put("msgId", clientMemberId);
			clientInfo.put("msgComm", " 님이 접속하였습니다.");
			
			session.sendMessage(new TextMessage(gson.toJson(clientInfo)));
		}
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 메세지를 받았을 때
		
		Map<String, Object> sessionAttr = session.getAttributes();
		String loginId = (String)sessionAttr.get("loginMemberId");
		
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		
		msgInfo.put("msgType", "m"); // c, d, m
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", message.getPayload());
		
		Gson gson = new Gson();
		
		for(WebSocketSession client : clientList) {
			if(!session.getId().equals(client.getId())) {
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 접속 종료했을 때
		
		clientList.remove(session);
		
		Map<String, Object> sessionAttr = session.getAttributes();
		String loginId = (String)sessionAttr.get("loginMemberId");
		
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		
		msgInfo.put("msgType", "d"); // c, d, m
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", " 님이 접속을 종료했습니다.");
		
		Gson gson = new Gson();
		
		for(WebSocketSession client : clientList) {
			if(!session.getId().equals(client.getId())) {
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
			}
		}
	}
	
}