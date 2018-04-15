import java.io.IOException;
import javax.websocket.Session;

public class Message {
	String message;
	
	Message()
	{
		this.message = "";
	}
	
	Message(String message)
	{
		this.message = message;
	}
	
	public String getMessage() {
		return message;
	}
	public void setMesage(String message) {
		this.message = message;
	}
	
}
