
public class LoginMessage extends Message {
	
	String email;
	String password;
	
	LoginMessage(String email, String password)
	{
		this.email = email;
		this.password = password;
	}
}
