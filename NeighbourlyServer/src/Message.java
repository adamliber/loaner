import java.io.IOException;

import javax.websocket.Session;

public class Message {
	String message;
	int id;
	
	public String getMessage() {
		return message;
	}
	public void setMesage(String message) {
		this.message = message;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public void sendMessage(Session s) {
		try {
			s.getBasicRemote().sendText(message);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
