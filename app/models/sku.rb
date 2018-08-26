class Sku < ApplicationRecord
	require 'csv'
	belongs_to :user
	validates_presence_of :sku_denominations, :sku_combinations

  def self.to_csv(fields = ["sku_denominations","sku_combinations"], options={})
	   CSV.generate(options) do |csv|
	   csv << fields
	   all.each do |sku|
	     csv << sku.attributes.values_at(*fields)
	   end
	  end
	 end

end
