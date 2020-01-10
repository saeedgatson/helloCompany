Feature: User order validation

	# a ‘new’ user is requested to avoid the max order limit.
	# assuming the order would still be validated for super users even though they can’t checkout, but  the order wouldn’t be placed.
	Scenario Outline: User types have order validated in v1
		Given a new <userType> user has a <productName> in a cart
		When the user attempts to checkout
		Then the order is validated
	
	Examples:
    | userType 	|	productName 		|
    | BASIC			|	CompanyA Widget	|
    | SUPER			|	CompanyA Widget	|


	# assuming basic user validation in v2 because its a requirement for that type.
	Scenario: Basic User order validated in v2
	  Given a new basic user has an order in a cart in v2
    When the user attempts to checkout
    Then the order is validated

	Scenario Outline: Special User order not validated
		Given a new special user has a "<product>" in a cart in "<version>"
    When user attempts a valid checkout
    Then order is placed without validation

 	Examples:
		| 	CompanyA Widget	|	v1	|
		| 	CompanyB Gadget	|	v1	|
		| 	CompanyA Widget	|	v2	|
		| 	CompanyB Gadget	|	v2	|

	Scenario Outline: Super User can not checkout
		Given a new super user has an order in a cart in "<version>"
    When User attempts to checkout
    Then an error message is shown
		And the user is not able to checkout
	
	Examples:
    |	v1	|
    | v2	|

	# super user cases here for coverage if the users type can change now or in the future
	Scenario Outline: Users can place a maximum  of 3 orders 
		Given a "<user>" has successfully completed 3 orders in "<version>"
		When the user attempts to place another valid order
		Then an error message is shown
		And the order is not placed
		
 	Examples:
    |  basic	 user	|	v1	|
    |  special user	|	v1	|
    |  super user		|	v1	|
    |  basic	 user	|	v2	|
    |  special user	|	v2	|
    |  super user		|	v2	|

	Scenario: CompanyA products are not listed on the CompanyB products page in v2
  	Given v2 is being used
		When a user navigates to the product listing page for CompanyA
		Then products from CompanyB are not shown

	Scenario: Products are restricted by company in v2
  	Given a new user has a cart for CompanyA
		When the user attempts to add a product from CompanyB
		Then an error message is shown
		And the product from CompanyB is not added to the cart

	# assuming the order can be placed because special users avoid ‘order validation’. Doesn’t pass a smell check though.
	Scenario: Special User can avoid company restriction in v2
		Given a new special user has a CompanyA product in a CompanyB cart in v2
    When the user attempts to checkout
    Then the order is placed		
