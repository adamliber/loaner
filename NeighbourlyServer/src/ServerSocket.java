import java.io.IOException;
import java.util.Vector;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


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
	public void onMessage(String message, Session sesion) {
		System.out.println(message);
		try {
			for(Session s: sessionVector)
			{
				s.getBasicRemote().sendText(message);
			}
		}catch(IOException ioe)
		{
			System.out.println("ioe:"+ ioe.getMessage());
		}
	}
	
	@OnClose
	public void close(Session session)
	{
		System.out.println("Client Disconnected");
		sessionVector.remove(session);
	}

}
