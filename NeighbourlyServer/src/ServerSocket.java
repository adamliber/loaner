import java.io.IOException;
import java.util.Vector;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;


@ServerEndpoint(value ="/ws")
public class ServerSocket {
	
	private static Vector<Session> sessionVector = new Vector<Session>();
	private static Database database = new Database();
	private static Gson gson = new Gson();
	
	
	@OnOpen
	public void open(Session session) {
		System.out.println("Client Connected!");
		sessionVector.add(session);
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {	
		System.out.println(message);
		Message m = null;
		m = gson.fromJson(message,Message.class);
		String messageID = m.getMessageID();
		System.out.println("messageID: " + messageID);
		
		if(messageID.trim().equals("signUp"))
		{
			m = gson.fromJson(message,SignUpMessage.class);
			String name = ((SignUpMessage) m).getName();
			String email = ((SignUpMessage) m).getEmail();
			String password = ((SignUpMessage) m).getPassword();
			String toWrite = "";
			
			int userID = database.signUp(email, name, password);
			
			if(userID != -1)
			{
				toWrite = gson.toJson(new UserInfoMessage(userID,email,database));
			}
			else //sign up was unsuccessful
			{
				toWrite = gson.toJson(new Message("invalid"));
			}
			
			try {
				session.getBasicRemote().sendText(toWrite);
			} catch (IOException e) {
				System.out.println("IOException in signup");
			}
			
		}
		else if(messageID.trim().equals("login"))
		{
			m = gson.fromJson(message,LoginMessage.class);
			String email = ((LoginMessage) m).getEmail();
			String password = ((LoginMessage) m).getPassword();
			String toWrite = "";
			
			int userID =  database.login(email, password);
			if(userID == -1) //means login was unsuccessfull
			{
				toWrite = gson.toJson(new Message("invalid"));
				
			}
			else //means login was successful
			{	
				toWrite = gson.toJson(new UserInfoMessage(userID,email,database));
				//session.getUserProperties()
			}
			
			try {
				session.getBasicRemote().sendText(toWrite);
			} catch (IOException e) {
				System.out.println("IOException in signup");
			}
		}
		else if(messageID.trim().equals("searchItems"))
		{
			
		}
		else if(messageID.trim().equals("postItem"))
		{
			m = gson.fromJson(message,PostItemMessage.class);
			
			
		}
		else if(messageID.trim().equals("userPhotoUpload"))
		{
			m = gson.fromJson(message,PhotoUploadMessage.class);
			String str = ((PhotoUploadMessage) m).getImageAsString();
			
			
			  try {
                byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(str); 
			  }
			  catch(ArrayIndexOutOfBoundsException aioe){ 
				System.out.println("Array Index Out of Bounds Exception in userPhotoUpload");
			  }
		}
		
	}
	
	@OnClose
	public void close(Session session)
	{
		System.out.println("Client Disconnected");
		sessionVector.remove(session);
	}

}
