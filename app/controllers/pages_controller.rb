class PagesController < ApplicationController
  def home
  	if params[:city].present? && params[:activity].present?

	  	if params[:city] == "all" && params[:activity] == "all"
	  		@stores = Store.all
	  	elsif params[:city] == "all" && params[:activity] != "all"
	  		@stores = Store.all.where('activity LIKE ?', '%'+params[:activity]+'%')
	  	elsif params[:city] != "all" && params[:activity] == "all"
	  		@stores = Store.all.where('town LIKE ?', '%'+params[:city]+'%')
	  	else
	  		@stores = Store.all.where('town LIKE ? AND activity LIKE ?', 
	  				'%'+params[:city]+'%', '%'+params[:activity]+'%')
	  	end
	else
		@stores = Store.all
	end
  end

  def about
  end

  def listgeojson
  	if params[:city].present? && params[:activity].present?

	  	if params[:city] == "all" && params[:activity] == "all"
	  		@stores = Store.all
	  	elsif params[:city] == "all" && params[:activity] != "all"
	  		@stores = Store.all.where('activity LIKE ?', '%'+params[:activity]+'%')
	  	elsif params[:city] != "all" && params[:activity] == "all"
	  		@stores = Store.all.where('town LIKE ?', '%'+params[:city]+'%')
	  	else
	  		@stores = Store.all.where('town LIKE ? AND activity LIKE ?', 
	  				'%'+params[:city]+'%', '%'+params[:activity]+'%')
	  	end
	else
		@stores = Store.all
	end
  	
  	@featureCollection = { 
		"type" => "FeatureCollection", 
		"features" => []
	}

  	@stores.each do |store|
  		@featureCollection["features"].push({
	    	"type" => "Feature",
	    	"geometry" => {
	      		"type" => "Point",
	      		"coordinates" => Geocoder.coordinates(store.address+" "+store.postcode+" "+store.town+" Réunion")
	    	},
	    	"properties" => {
	      		"title" => store.name,
	      		"description" => store.address+" "+store.postcode+" "+store.town,
	      		"marker-color" => "#e74c3c",
	      		"marker-size" => "large"
	    	}
		})
  	end

  	respond_to do |format|
	  format.html
	  format.xml  { render :xml => @featureCollection }
	  format.json { render :json => @featureCollection }
	end
  end

end
