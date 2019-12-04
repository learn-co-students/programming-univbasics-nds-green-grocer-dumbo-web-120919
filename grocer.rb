def find_item_by_name_in_collection(name, collection)
# if name ("WINE") is in the AoH (collection), return that hash.
# if not, return nil
# So I'm gonna have to use an if/else statement. Get into Array, then into the hash, then into the key, then into the value
# p name = "WINE"

# p collection  = [{:item=>"DOG FOOD"}, {:item=>"WINE"}, {:item=>"STRYCHNINE"}] <---- ARRAY
# p collection[0] = {:item=>"DOG FOOD"} <-------------- HASH 
# p collection[1] = {:item => "WINE"} <-------------- HASH
# p collection[2] = {:item => "STRYCHNINE"} <-------------- HASH

# p collection[0][:item] = "DOG FOOD" <---------- STRING
# p collection[1][:item] = "WINE" <---------- STRING
# p collection[2][:item] = "STRYCHNINE" <---------- STRING 

food_counter = 0 
  
 while food_counter < collection.count do 
  hash = collection[food_counter]
   if hash[:item] == name
    return hash
   end 
  food_counter += 1 
 end 

end

def consolidate_cart(cart)
new_cart = []
counter = 0 

 while counter < cart.length  
   new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
   if new_cart_item != nil
    new_cart_item[:count] += 1 
   else 
     new_cart_item = {
      :item => cart[counter][:item],
      :price => cart[counter][:price],
      :clearance => cart[counter][:clearance],
      :count => 1 
     }
     new_cart << new_cart_item
   end 
  counter += 1  
 end 

new_cart
end

def apply_coupons(cart, coupons)
counter = 0 

  while counter < coupons.length do 
  cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
  coupon_item_name = "#{coupons[counter][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
  if cart_item && cart_item[:count] >= coupons[counter][:num]
   if cart_item_with_coupon
    cart_item_with_coupon[:count] += coupons[:counter][:num]
    cart_item[:count] -= coupons[counter][:num]
   else 
    cart_item_with_coupon = {
      :item => coupon_item_name,
      :price => coupons[counter][:cost] / coupons[counter][:num],
      :count => coupons[counter][:num],
      :clearance => cart_item[:clearance]
    }
    cart << cart_item_with_coupon
    cart_item[:count] -= coupons[counter][:num]
   end   
  end 
  counter += 1 
  end 
cart 
end

def apply_clearance(cart)
counter = 0 

  while counter < cart.length do 
   if cart[counter][:clearance]
    cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2) 
   end 
  counter += 1 
  end 
cart   
end

def checkout(cart, coupons)
 consolidated_cart = consolidate_cart(cart)
 couponed_cart = apply_coupons(consolidated_cart, coupons)
 final_cart = apply_clearance(couponed_cart)
 
 total = 0 
 counter = 0 
  while counter < final_cart.length do 
   total += final_cart[counter][:price] * final_cart[counter][:count]
   counter += 1 
  end 
 if total > 100
  total -= (total * 0.10)
 end
total  
end
