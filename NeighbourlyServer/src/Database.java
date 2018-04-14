import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;

import javax.imageio.ImageIO;

public class Database {
	private Connection conn;
	private PreparedStatement ps; 
	static String loginQuery = "SELECT * FROM Users WHERE email=? && password=?";
	static String ownedItemsQuery = "SELECT * FROM Items WHERE ownerID=?"; //need to install SQL may need to come back and change names later
	static String borrowerQuery = "SELECT * FROM Users WHERE name=?";
	static String singleItemQuery = "SELECT * FROM Items WHERE itemID=?";
	static String signUpInsert = "INSERT INTO Users (email, name, password)\r\n" + " VALUES(? , ?, ?);";
	static String addItemInsert = "INSERT INTO Items(itemName, ownerID, imageURL, description, latitude, longitude,availibility)" +
								" VALUES(? , ?, ?, ? , ?, ?,?)";	
	static String preppingforSearch = "ALTER TABLE Items" +
									" ADD FULLTEXT(itemName,description);";
	static String searchForItems = " SELECT * FROM Items " +
									"WHERE MATCH(itemName,description) AGAINST (?)  AND NOT ownerID=? AND latitude BETWEEN ? AND ? AND longitude BETWEEN ? AND ?;"; 
	static String updateSQL = "UPDATE Users "
            				+ "SET image = ? "
            				+ "WHERE userID=?";
	Database()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/Neighborly?user=root&password=root&useSSL=false"); 
			System.out.println("Database connected");
			
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println("Class not found exception in Database constructor");
		} 
		catch (SQLException e) 
		{
			System.out.println("SQL exception in Database Constructor");
		}
		
	}

	//performs login and if successful returns userID from the database
	//otherwise returns -1
	public int login(String email, String password)
	{
		ResultSet rs;
		try 
		{
			ps = conn.prepareStatement(loginQuery);
			ps.setString(1, email); 
			ps.setString(2, password);
			rs = ps.executeQuery();
			if(rs.next())
			{
				return rs.getInt("userID");
			}
			else //validation was not successful
			{
				return -1;
			}
		} 
		catch (SQLException e) {
			
			System.out.println("SQL exception in Database Login");
			System.out.println(e.getMessage());
			return -1;
		}
	}

	public boolean signUp(String email, String name, String password) {
		try 
		{
			ps = conn.prepareStatement(signUpInsert);
			ps.setString(1, email); 
			ps.setString(2, name);
			ps.setString(3, password); 
			int x = ps.executeUpdate();
			if(x > 0) return true; //signup was succesfull
			else return false; //email address has been already used
		} 
		catch (SQLException e) {
			System.out.println("SQL exception in Database SignUp");
			System.out.println(e.getMessage());
			return false;
		}
	}

	public ArrayList<Item> getUsersItems(int userID)
	{
		ResultSet rs;
		ArrayList<Item> toReturn = new ArrayList<Item>();
		try 
		{
			ps = conn.prepareStatement(ownedItemsQuery);
			ps.setInt(1, userID);
			rs = ps.executeQuery();
			while(rs.next())
			{
				int itemID = rs.getInt("itemID");
				toReturn.add(getItembyID(itemID));
			}
		}
		catch (SQLException e) 
		{
			System.out.println("SQL exception in Database getUsersItems");
			System.out.println(e.getMessage());
		}
		
		return toReturn;
	}

	public void addItemToDatabase(int ownerID, String itemName, String imageURL, String description,double latitude, double longitude) {
		
		try 
		{
			ps = conn.prepareStatement(addItemInsert);
			ps.setString(1, itemName); 
			ps.setInt(2, ownerID);
			ps.setString(3, imageURL);
			ps.setString(4, description); 
			ps.setDouble(5, latitude);
			ps.setDouble(6, longitude);
			ps.setInt(7, 1);
			ps.executeUpdate();
		} 
		catch (SQLException e) {
			System.out.println("SQL exception in Database addItem");
			System.out.println(e.getMessage());
		} 
		
	}

	/*public void borrowItem(int itemID, int borrowerID)
	{
		ResultSet rs;
		try 
		{
			
			ps = conn.prepareStatement(singleItemQuery);
			ps.setInt(1,itemID);
			rs = ps.executeQuery();
			
		} 
		catch (SQLException e) 
		{
			System.out.println("SQL exception in Database borrowItem");
			System.out.println(e.getMessage());
		}
	}*/

	private Item getItembyID(int itemID) {
		ResultSet rs;
		try 
		{
			ps = conn.prepareStatement(singleItemQuery);
			ps.setInt(1, itemID);
			rs = ps.executeQuery();
			rs.next();
			String itemName = rs.getString("itemName");
			String description = rs.getString("description");
			String imageURL = rs.getString("imageURL");
			int ownerID = rs.getInt("ownerID");
			int borrowerID = rs.getInt("borrowerID");
			int availibility = rs.getInt("availibility");
			double latitude = rs.getDouble("latitude");
			double longitude = rs.getDouble("longitude");
			return new Item(itemID,itemName,description,availibility,imageURL,ownerID,borrowerID,latitude,longitude);
		} 
		catch (SQLException e) {
			System.out.println("SQL exception in Database getItemsbyID");
			System.out.println(e.getMessage());
		}
		
		return null;
	}

	public ArrayList<Item> searchItems(int userID, String searchTerm,double minLatitude,double maxLatitude,double minLongitude, double maxLongitude)
	{
		ArrayList<Item> toReturn = new ArrayList<Item>();
		ResultSet rs;
		try 
		{
			ps = conn.prepareStatement(preppingforSearch);
			ps.executeUpdate();
			ps = conn.prepareStatement(searchForItems);
			ps.setString(1,searchTerm);
			ps.setInt(2,userID);
			ps.setDouble(3,minLatitude);
			ps.setDouble(4,maxLatitude);
			ps.setDouble(5,minLongitude);
			ps.setDouble(6,maxLongitude);
			rs = ps.executeQuery();
			while(rs.next())
			{
				int itemID = rs.getInt("itemID");
				toReturn.add(getItembyID(itemID));
			}
		}
		catch (SQLException e) {
			System.out.println("SQL exception in Database searchItems");
			System.out.println(e.getMessage());
		}
		
		
		return toReturn;
	}

	public void putUserImage() {
		//String fileName = userID + "_profile_pic.jpeg";
		File file = new File("images/flowers.jpeg");
		try {
			PreparedStatement pstmt = conn.prepareStatement(updateSQL);
			FileInputStream input = new FileInputStream(file);
			pstmt.setBinaryStream(1, input);
			pstmt.setInt(2, 1);
			pstmt.executeUpdate();
		} catch (FileNotFoundException e) {
			System.out.println("File not found exception in getItemImage");
		} catch (SQLException e) {
			System.out.println("SQL exception in getItemImage");
			System.out.println(e.getMessage());
		}
	}

	public void getUserImage() {
		String selectSQL = "SELECT image FROM Users WHERE userID=?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(selectSQL);
			pstmt.setInt(1, 1);
			ResultSet rs = pstmt.executeQuery();
			File file = new File("output.jpeg");
			FileOutputStream output = new FileOutputStream(file);
			 
			System.out.println("Writing to file " + file.getAbsolutePath());
			while (rs.next()) {
			    InputStream input = rs.getBinaryStream("image");
			    byte[] buffer = new byte[1024];
			    while (input.read(buffer) > 0) {
			        output.write(buffer);
			    }
			}
		} catch (SQLException e) {
			System.out.println("SQL exception in Database searchItems");
			System.out.println(e.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
