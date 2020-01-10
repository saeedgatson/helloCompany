package hellocompany;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.junit.Assert.*;

public class StepDefinitions {
	private boolean isPassCheckout;
	private Order order = new Order();
	
	@Given("a new {string} user has a {string} product in a cart")
	public void new_user_has_a_product_in_a_cart(String userType, String productName) {
		this.order.addProduct(productName);
	}

	@When("the user attempts to checkout")
	public void the_user_attempts_to_checkout() {
		this.isPassCheckout = order.checkout();
	}

	@Then("the order is validated")
	public void the_order_is_validated() {
	    assertTrue(order.isOrderValid);
	}
}
