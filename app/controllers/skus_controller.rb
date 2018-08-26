class SkusController < ApplicationController

	def new
		@sku = Sku.new
	end

	def create
		@user = current_user
		@sku_denominations = params[:sku_denominations].to_i
		if params[:csv].present?
			@option1_sku = []
			@option2_sku = []
			@option3_sku = []
			sku_hash_arr = []
			file =  params[:csv]
			csv_arr = CSV.read(file.path)
			if csv_arr.include? ["option1_sku", "option2_sku", "option3_sku"]
				csv_arr.each_with_index do |csv, i|
					if i > 0
						@option1_sku << csv[0] if csv.first.present?
						@option2_sku << csv[1] if csv.second.present?
	          @option3_sku <<  csv[2] if csv.third.present?
	        end
				end

				@option1_sku.compact.each do |option1|
          @option2_sku.compact.each do |option2|
          	@option3_sku.compact.each do |option3|
          		@combination = option1 + "," + option2 + "," + option3
              sku_hash = {sku_combinations: @combination,sku_denominations: @sku_denominations,user_id: current_user.id}
          		sku_hash_arr << sku_hash
          		@sku_denominations += 1

          	end
          end
				end
				@skus = Sku.create(sku_hash_arr)	
        @ids = @skus.map(&:id)
			else
				flash[:error] = "File format is not correct"
			end
		end
	end

	def new_csv
		@skus = Sku.where(id: params[:ids])
		# @skus = Sku.all
		data = @skus
		respond_to do |format|
      format.html
      format.csv { send_data @skus.to_csv, :type => 'text/csv', filename: "skus-#{Date.today}.csv" }
    end
	end

end
