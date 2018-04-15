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
		try {
			m = gson.fromJson(message,Message.class);
		}
		catch(EOFException eofe)
		{
			System.out.println(eofe.getMessage());
		}
		String messageID = m.getMessageID();
		
		if(messageID.equals("signUp"))
		{
			m = gson.fromJson(message,SignUpMessage.class);
			String name = ((SignUpMessage) m).getName();
			String email = ((SignUpMessage) m).getEmail();
			String password = ((SignUpMessage) m).getPassword();
			
			int userID = database.signUp(email, name, password);
			
			if(userID != -1)
			{
				String toWrite = gson.toJson(new UserInfoMessage(userID,email,database));
				session.getBasicRemote().sendText(toWrite);
			}
			else //sign up was unsuccessful
			{
				session.getBasicRemote().sendText();
			}
			
		}
		else if(m.equals("login"))
		{
			String email = ((LoginMessage) m).getEmail();
			String password = ((LoginMessage) m).getPassword();
			
			int userID =  database.login(email, password);
			if(userID == -1) //means login was unsuccessfull
			{
				session.getBasicRemote().sendText();
			}
			else //means login was successful
			{	
				String toWrite = gson.toJson(new UserInfoMessage(userID,email,database));
				session.getBasicRemote.sendText(toWrite);
				//session.getUserProperties()
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
