require "pry"

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  bg = 0 
  while bg < collection.length do 
  
    if name == collection[bg][:item]
      return collection[bg]
    end 
    bg += 1 
  end
  
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
 # binding.pry
  hg = 0 
  box1= []
  while hg < cart.length do 
    jack_in = find_item_by_name_in_collection(cart[hg][:item], box1)
    if jack_in != nil 
      jack_in[:count] += 1 
    else 
      jack_in = {:item => cart[hg][:item], 
      :price => cart[hg][:price],
      :clearance => cart[hg][:clearance], 
      :count => 1 } 
      box1 << jack_in
    end
    hg += 1 
  end
  return box1
end

def apply_coupons(cart, coupons)
  grower = 0 
  while grower < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[grower][:item], cart)
    couponed_stuff = "#{coupons[grower][:item]} W/COUPON"
    cart_ting_wit_coup = find_item_by_name_in_collection(couponed_stuff, cart)
    if cart_item && cart_item[:count] >= coupons[grower][:num]
      if cart_ting_wit_coup
        cart_ting_wit_coup[:count] += coupons[grower][:num]
        cart_item[:count] -= coupons[grower][:num]
      else
        cart_ting_wit_coup = {:item => couponed_stuff, :price => coupons[grower][:cost]/coupons[grower][:num], :count => coupons[grower][:num], 
          :clearance => cart_item[:clearance]
        }
        cart << cart_ting_wit_coup
        cart_item[:count] -= coupons[grower][:num]
      end
      
    end
    grower += 1 
  end 
  return cart
end

def apply_clearance(cart)
 counter = 0 
 while counter < cart.length do 
   if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.2)).round(2)
    end
    counter += 1 
  end 
  return cart
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
  return total
end
