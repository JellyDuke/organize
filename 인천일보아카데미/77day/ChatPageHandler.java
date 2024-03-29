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
		
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String) sessionAttrs.get("loginId");
		
		Gson gson = new Gson();
		Map<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "c"); //"c": 접속, "d":접속해제, "m":채팅 ,이렇게 정할 수 있음.
		msgInfo.put("msgid", loginId);
		msgInfo.put("msgcomm", "접속 했습니다.");
		//{"msgtype" : "c" , "msgid" : loginId , "msgcomm" : "접속 했습니다."} msgInfo 
		for(WebSocketSession client : clientList) {
			//새 참여자 접속 안내 메세지 전송
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
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
		
		msgInfo.put("msgtype", "m");
		msgInfo.put("msgid", loginId);
		msgInfo.put("msgcomm", message.getPayload());
		
		for(WebSocketSession client : clientList) {
			if(!client.getId().equals(session.getId())) {
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
									//{ msgid:yyyy, msgcomm:1234}
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅페이지 접속 해제");
		clientList.remove(session);//클라이언트 목록에서 제거

		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String) sessionAttrs.get("loginId");
		
		Gson gson = new Gson();
		Map<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "d"); //"c": 접속, "d":접속해제, "m":채팅 ,이렇게 정할 수 있음.
		msgInfo.put("msgid", loginId);
		msgInfo.put("msgcomm", "접속을 해제했습니다.");
		for(WebSocketSession client : clientList) {
			//새 참여자 접속 해제 안내 메세지 전송
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
	}
	
}
