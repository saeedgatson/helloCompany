package hellocompany;

import java.util.List;

public class Order {
	private static final int MAX_ITEM_LIMIT = 5;
	
	private String id;
	private String userid;
	private List<String> products;
	private String version;
	
	public boolean isOrderValid;
	
	public boolean addProduct(String productName) {
		if(products.size() < 5) {
			this.products.add(productName);
			System.out.println("Added: " + productName);
			return true;
		} else {
			System.out.println("Warning: Item not added, max item limit for order reached");
			return false;
		}
	}
	
	//validate the order and return true if successful
	public boolean checkout() {
		this.isOrderValid = true;
		
		return true;
	}
}