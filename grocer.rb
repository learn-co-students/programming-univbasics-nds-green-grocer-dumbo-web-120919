def find_item_by_name_in_collection(name, collection)
  index = 0 
  while index < collection.length do 
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1 
  end
  nil
end

def consolidate_cart(cart)
  new_cart = []
  index = 0 
  while index < cart.length do 
    item_name = cart[index][:item]
    found_item = find_item_by_name_in_collection(item_name, new_cart)
    if found_item
      found_item[:count] += 1 
    else
      cart[index][:count] = 1 
      new_cart << cart[index]
    end
    index += 1 
  end
  new_cart
end

def mk_coupon_hash(c)
  rounded_unit_price = (c[:cost].to_f * 1.0 / c[:num]).round(2)
  {
    :item => "#{c[:item]} W/COUPON",
    :price => rounded_unit_price,
    :count => c[:num]
  }
end

def apply_coupon_to_cart(matching_item, coupon, cart)
  matching_item[:count] -= coupon[:num]
  item_with_coupon = mk_coupon_hash(coupon)
  item_with_coupon[:clearance] = matching_item[:clearance]
  cart << item_with_coupon
end 

def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.count do
    coupon = coupons[i]
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_is_in_basket = !!item_with_coupon
    count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]

    if item_is_in_basket and count_is_big_enough_to_apply
      apply_coupon_to_cart(item_with_coupon, coupon, cart)
    end
    i += 1
  end
  cart
end

def apply_clearance(cart)
  index = 0 
  while index < cart.length
    item = cart[index]
    if item[:clearance]
      discounted_price = (item[:price] * 0.8).round(2)
      item[:price] = discounted_price
    end
    index += 1 
  end
  cart
end

def checkout(cart, coupons)
  
  cons_cart = consolidate_cart(cart)
  apply_coupons(cons_cart, coupons)
  apply_clearance(cons_cart)
  
  total = 0 
  index = 0
  
  while index < cons_cart.length do
    total += (cons_cart[index][:count] * cons_cart[index][:price])
    index += 1 
  end
  
  if total > 100
    new_total = (total * 0.9)
    new_total
  else
    total
  end
  
end
