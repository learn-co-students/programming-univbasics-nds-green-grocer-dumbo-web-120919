def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    return collection[i] if name === collection[i][:item]
    i -= -1 
  end 
  nil
  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  i = 0 
  result = []
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  while i < cart.length do
    item_name = find_item_by_name_in_collection(cart[i][:item],result)
    if item_name
      item_name[:count] -= -1
    else 
      item_name = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1 
      }
      result << item_name 
    end 
    i -= -1 
  end 
  result
end

def apply_coupons(cart, coupons)

  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupon_counter = 0 
  while coupon_counter < coupons.length
  cart_index = 0 #goes through items inside the cart ie; items inside the cart 
  while cart_index < cart.length do 
    if coupons[coupon_counter][:item] == cart[cart_index][:item] && coupons[coupon_counter][:num] <= cart[cart_index][:count]
      cart[cart_index][:count] -= coupons[coupon_counter][:num]
   #create a new coupon if it doesn't exist
      new_coupon = {
        :item => "#{cart[cart_index][:item]} W/COUPON",
        :price => coupons[coupon_counter][:cost] / coupons[coupon_counter][:num],
        :clearance => cart[cart_index][:clearance],
        :count => coupons[coupon_counter][:num]
      }
        cart << new_coupon
      end 
      cart_index -= -1 
    end 
    coupon_counter -= -1
  end 
 cart 
 
end

def apply_clearance(cart)
  new_cart = []
  cart_index = 0 
  while cart_index < cart.length do 
    if cart[cart_index][:clearance]
      cart[cart_index][:price] = (cart[cart_index][:price] * 0.8).round (2)
    end 
    new_cart << cart[cart_index]
    cart_index -= -1
  end 
  new_cart 
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  result = 0 
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  new_cart_index = 0 
  while new_cart_index < new_cart.length do 
    result += new_cart[new_cart_index][:price] * new_cart[new_cart_index][:count]
    new_cart_index += 1
end
  if result > 100
    result = (result * 0.9).round(2)
  end 
  result
end 
