import java.io.IOException;
import javax.websocket.Session;

public class Message {
	private String messageID;
	private String message;
	
	Message(String message)
	{
		this.message = message;
	}
	public String getMessageID() {
		return messageID;
	}
	public void setMessageID(String messageID) {
		this.messageID = messageID;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
