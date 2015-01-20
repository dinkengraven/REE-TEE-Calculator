require "sinatra"

def calculate_ree(weight, height, age, sex)
	ree = (10.0*weight) + (6.25*height) - (5.0*age)
	if sex == "male"
		return ree + 5
	else
		return ree - 161
	end
end

def calculate_tee(ree, activity_factor, weight_loss = "1") #this will default weight_loss to 1 unless otherwise specified	
	tee = ree * activity_factor
	if weight_loss == "0"
		return tee
	elsif weight_loss == "1"
		return tee - 500
	elsif weight_loss == "1.5"
		return tee - 750
	else weight_loss == "2"
		return tee - 1000
	end
end

get '/' do
	weight = params[:weight].to_f / 2.2
	height = params[:height].to_f * 2.54
	age = params[:age].to_f
	sex = params[:sex].to_s
	weight_loss = params[:weight_loss]
	activity_factor = params[:activity_factor].to_f

	ree = calculate_ree(weight, height, age, sex)

	tee = calculate_tee(ree, activity_factor, weight_loss)

	@ree = ree.to_i.to_s
	@tee = tee.to_i.to_s
	@weight_loss = weight_loss.to_s

	@kcal_trends = []

	21.times do 
		ree = calculate_ree(weight, height, age, sex)

		tee = calculate_tee(ree, activity_factor)
		@kcal_trends.push tee.to_i

		weight = weight - 1
	end

	erb :index
end	