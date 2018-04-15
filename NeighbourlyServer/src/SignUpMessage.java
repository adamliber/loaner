
public class SignUpMessage extends Message {
	String name;
	String email;
	String password;
	
	SignUpMessage(String name, String email, String password)
	{
		this.name = name;
		this.email = email;
		this.password = password;
	}

}
