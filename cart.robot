# 1. Kosár funkcionalitás
#    Több termék hozzáadása
#    Termék eltávolítása a kosárból
#    Kosár tartalmának ellenőrzése
#    ---------------------------------------
# 1. Shopping cart functionality
#    Add multiple products
#    Remove products from the shopping cart
#    Check the contents of the shopping cart

*** Settings ***
Library    Selenium2Library

*** Keywords ***
Login to Saucedemo mainpage
    Open Browser    https://www.saucedemo.com/    firefox
    Input Text    id:user-name    standard_user
    Input Password    id:password    secret_sauce
    Click Button    id:login-button

Verify Cart Item Count
    [Arguments]    ${expected_count}
    ${item_count}=    Get Element Count    class:cart_item
    Should Be Equal As Integers    ${item_count}    ${expected_count}

Add items to Cart
    Click Element    id:add-to-cart-sauce-labs-backpack
    Click Element    id:add-to-cart-sauce-labs-bike-light
    Click Element    id:add-to-cart-sauce-labs-bolt-t-shirt

Verify Cart Item Price
    [Arguments]    ${expected_cost}
    ${item_cost}=    Get Text    class=inventory_item_price
    Should Be Equal As Strings    ${item_cost}    ${expected_cost}

*** Test Cases ***
Több termék hozzáadása
    Login to Saucedemo mainpage
    Add items to Cart
    Element Should Contain    class:shopping_cart_badge    3
    Click Element    class:shopping_cart_badge
    Verify Cart Item Count    3
    Page Should Contain    Sauce Labs Backpack
    Page Should Contain    Sauce Labs Bike Light
    Page Should Contain    Sauce Labs Bolt T-Shirt
    Sleep    2s
    Close Browser

Remove product from shopping cart
    Login to Saucedemo mainpage
    Add items to Cart
    Click Element    class:shopping_cart_badge
    Click Element    id=remove-sauce-labs-backpack
    Sleep    1s
    Element Text Should Be    class:shopping_cart_badge    1

Check the price in Cart
    Login to Saucedemo mainpage
    Click Element    id:add-to-cart-sauce-labs-backpack
    Click Element    class:shopping_cart_badge
    Verify Cart Item Price    $29.99
    