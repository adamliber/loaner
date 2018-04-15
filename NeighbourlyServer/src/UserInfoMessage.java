import java.util.ArrayList;

public class UserInfoMessage extends Message {
	int userID;
	String name;
	String email;
	ArrayList<Item> myItems;
	ArrayList<Item> borrowedItems;
	
	UserInfoMessage(int userID,String email, Database database)
	{
		this.userID = userID;
		this.name=database.getNameFromID(userID);
		this.email = email;
		this.myItems = database.getMyItems(userID);
		this.borrowedItems = database.getBorrowedItems(userID);
	}

}
