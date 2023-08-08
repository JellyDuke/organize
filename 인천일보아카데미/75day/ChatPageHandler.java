package com.WebSockChat.SockController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class ChatPageHandler extends TextWebSocketHandler {
	
	//채팅 페이지에 접속한 클라이언트 목록
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("채팅페이지 접속");
		clientList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("채팅 메세지 전송");
		System.out.println("전송한 메세지: " + message.getPayload());
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String) sessionAttrs.get("loginId");
		System.out.println("보내는 사람: " + loginId);
		
		Gson gson = new Gson();
		Map<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("sendid", loginId);
		msgInfo.put("message", message.getPayload());
		
		for(WebSocketSession client : clientList) {
			if(!client.getId().equals(session.getId())) {
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
									//{ sendid:yyyy, message:1234}
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅페이지 접속 해제");
		clientList.remove(session);
		

	}
	
}
