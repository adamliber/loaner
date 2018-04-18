
public class Item {

	private String itemName;
	private int itemID;
	private String imageID;
	private String itemDescription;
	private double latitude;
	private double longitude;
	private int ownerID;
	private int borrowerID;
	private int available;
	private int request;
	private int requestorID;
	private int returnRequest;

	Item(int itemID, String itemName, String description, String imageID, int ownerID,
			int borrowerID, double latitude, double longitude, int available, int request, int requestorID,
			int returnRequest) {
		this.itemID = itemID;
		this.imageID = imageID;
		this.itemDescription = description;
		this.ownerID = ownerID;
		this.borrowerID = borrowerID;
		this.itemName = itemName;
		this.latitude = latitude;
		this.longitude = longitude;
		this.available = available;
		this.request = request;
		this.requestorID = requestorID;
		this.setReturnRequest(returnRequest);

	}

	public int getAvailable() {
		return available;
	}

	public void setAvailable(int available) {
		this.available = available;
	}

	public int getRequest() {
		return request;
	}

	public void setRequest(int request) {
		this.request = request;
	}

	public int getRequestorID() {
		return requestorID;
	}

	public void setRequestorID(int requestorID) {
		this.requestorID = requestorID;
	}

	
	public int getItemID() {
		return itemID;
	}

	public void setItemID(int itemID) {
		this.itemID = itemID;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}


	public String getImageID() {
		return imageID;
	}

	public void setImageID(String imageID) {
		this.imageID = imageID;
	}

	public String getDescription() {
		return itemDescription;
	}

	public void setDescription(String description) {
		this.itemDescription = description;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public int getOwnerID() {
		return ownerID;
	}

	public void setOwnerID(int ownerID) {
		this.ownerID = ownerID;
	}

	public int getBorrowerID() {
		return borrowerID;
	}

	public void setBorrowerID(int borrowerID) {
		this.borrowerID = borrowerID;
	}

	public void printItem() {

		System.out.println("----------------------------------------");
		System.out.println("ItemName: " + itemName);
		System.out.println("ItemID: " + itemID);
		System.out.println("Avaliliblity: " + available);
		System.out.println("description: " + itemDescription);
		System.out.println("ownerID: " + ownerID);
		System.out.println("Latitude: " + latitude);
		System.out.println("Longitude: " + longitude);

	}

	public int getReturnRequest() {
		return returnRequest;
	}

	public void setReturnRequest(int returnRequest) {
		this.returnRequest = returnRequest;
	}

}
