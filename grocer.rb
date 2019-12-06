def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    return collection[i] if name === collection[i][:item]
    i += 1
  end
  nil
end

def consolidate_cart(cart)
  i = 0
  result = []
  while i < cart.count do
    item_name = cart[i][:item]
    looking_for = find_item_by_name_in_collection(item_name, result)
    if looking_for
      looking_for[:count] += 1
    else
      cart[i][:count] = 1
      result << cart[i]
  end
  i += 1
end
 result
end

def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.count do
    oupon = coupons[i]
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

end

def apply_clearance(cart)
  i = 0
  while i < cart.length do
    item = cart[i]
    if item[:clearance]
      discounted_price = ((1 - CLEARANCE_ITEM_DISCOUNT_RATE) * item[:price]).round(2)
        item[:price] = discounted_price
    end
    i += 1
  end

  cart
end

def checkout(cart, coupons)
  total = 0
  i = 0

  ccart = consolidate_cart(cart)
  apply_coupons(ccart, coupons)
  apply_clearance(ccart)

  while i < ccart.length do
    total += items_total_cost(ccart[i])
    i += 1
  end

  total >= 100 ? total * (1.0 - BIG_PURCHASE_DISCOUNT_RATE) : total
end
