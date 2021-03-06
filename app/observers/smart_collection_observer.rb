class SmartCollectionObserver < ActiveRecord::Observer
  observe :product

  def after_save(product)
    shop = product.shop
    shop.smart_collections.each do |smart_collection|
      collection_product = smart_collection.collection_products.where(product_id: product.id).first
      if smart_collection.match? product
        smart_collection.collection_products.create(product_id: product.id, position: 0) unless collection_product
      elsif collection_product
        collection_product.destroy
      end
    end
  end
end
