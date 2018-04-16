import java.util.ArrayList;

public class Testing {
	public static void main(String[] args) {
		Database myDB = new Database();
		//myDB.signUp("djnakuda@gmail.com", "Daniyal", "password");
		//myDB.signUp("djnakuda@gmail.com", "Daniyal", "password");
		//myDB.signUp("dshafi@gmail.com", "Daniyal Shafi", "password1");
		myDB.signUp("Avni.barman@gmail.com", "Avni", "avni");
		myDB.addItemToDatabase(1, "Pokemon", "", "This is a really fun game", 34.8765, -118.876757);
		myDB.addItemToDatabase(1, "Camera", "", "This is a really camera", 34.8765, -118.876757);
		myDB.addItemToDatabase(2, "Football", "", "This is a really good ball", 34.8765, -118.876757);
		myDB.addItemToDatabase(2, "Camera Recorder", "", "This is a really good camera", 34.8765, -118.876757);
		//ArrayList<Item> myItems = myDB.searchItems(2, "camera", -150, 150, -150, 150);
		
		//for(int i = 0; i < myItems.size();i++)
		//{
		//	myItems.get(i).printItem();
		//}
		
		//myDB.signUp("adam", "liber", "liber");
		
		//myDB.searchItemsByDistance("cat", 1, 1, 5);
		//myDB.putUserImage();
		//myDB.getUserImage();
	}

}
