package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class NoticeHandler extends TextWebSocketHandler{

	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//Noticesock에 접속
		clientList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//NoticeSock에 메세지 전송
		for(WebSocketSession client: clientList) {
			if(!client.getId().equals(session.getId())) {
				client.sendMessage(new TextMessage("newBoard"));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//NoticeSock에 접속 해제
		clientList.remove(session);

	}
	
}
