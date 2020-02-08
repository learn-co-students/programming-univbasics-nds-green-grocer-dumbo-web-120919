require 'pry'
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0 
  while i < collection.length do 
   if collection[i][:item] == name 
     return collection[i]
   end
   i += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  grocerCart = []
  i = 0 
  while i < cart.length do 
    grocerItem = find_item_by_name_in_collection(cart[i][:item], grocerCart)
    if grocerItem
      grocerItem[:count] += 1 
    else 
      grocerItem = { 
      :item => cart[i][:item], 
      :price => cart[i][:price], 
      :clearance => cart[i][:clearance], 
      :count => 1
      }
      grocerCart << grocerItem
  end
  i += 1 
end
grocerCart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  i = 0 
  while i < coupons.length do 
    grocerItem = find_item_by_name_in_collection(coupons[i][:item], cart)
    couponItem = "#{coupons[i][:item]} W/COUPON"
    cartCoupon = find_item_by_name_in_collection(couponItem, cart)
    if grocerItem && grocerItem[:count] >= coupons[i][:num]
      if cartCoupon
        cartCoupon[:count] += coupons[i][:num]
        grocerItem[:count] -= coupons[i][:num]
      else 
        cartCoupon = {
  :item => couponItem,
  :price => coupons[i][:cost] / coupons[i][:num],
  :count => coupons[i][:num],
  :clearance => grocerItem[:clearance]
        }
      cart << cartCoupon
      grocerItem[:count] -= coupons[i][:num]
      end
    end
    i += 1
end
cart 
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] - (cart[i][:price] * 0.20)).round(2)
end
i += 1 
end
cart 
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  gatheredCart = consolidate_cart(cart)
  couponCart = apply_coupons(gatheredCart, coupons)
  clearanceCart = apply_clearance(couponCart)
  total = 0 
  i = 0 
  while i < clearanceCart.length do 
    total += clearanceCart[i][:price] * clearanceCart[i][:count]
    i += 1 
  end 
  if total > 100 
    total -= (total * 0.10)
  end
  total
end 
