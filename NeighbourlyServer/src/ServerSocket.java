import java.io.IOException;
import java.util.ArrayList;
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
	
	
	@OnOpen
	public void open(Session session) {
		System.out.println("Client Connected!");
		sessionVector.add(session);
	}
	
	@OnMessage

	public void onMessage(String message, Session session) {

		System.out.println(message);
		ArrayList<Item> myItems = database.searchItems(2, "camera", -150, 150, -150, 150);
		System.out.println("made it to line 29 ");
		Gson gson = new Gson();
		String toSend = gson.toJson(myItems);
		System.out.println("made it to line 31 ");
		
		try {

			session.getBasicRemote().sendText(toSend);
		} catch (IOException e) {
			System.out.println("IOException in sending the gson");
			System.out.println(e.getMessage());

		}
		
	}
	
	@OnClose
	public void close(Session session)
	{
		System.out.println("Client Disconnected");
		sessionVector.remove(session);
	}

}
