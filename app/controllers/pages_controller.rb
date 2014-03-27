class PagesController < ApplicationController
  def home
  	if params[:city].present? && params[:activity].present?

	  	if params[:city] == "all" && params[:activity] == "all"
	  		@stores = Store.all.order('created_at DESC')
	  	elsif params[:city] == "all" && params[:activity] != "all"
	  		@stores = Store.all.order('created_at DESC').where('activity ILIKE ?', '%'+params[:activity]+'%')
	  	elsif params[:city] != "all" && params[:activity] == "all"
	  		@stores = Store.all.order('created_at DESC').where('town ILIKE ?', '%'+params[:city]+'%')
	  	else
	  		@stores = Store.all.order('created_at DESC').where('town ILIKE ? AND activity ILIKE ?', 
	  				'%'+params[:city]+'%', '%'+params[:activity]+'%')
	  	end
	else
		@stores = Store.all.order('created_at DESC')
	end
  end

  def about
  end

  def listgeojson
  	if params[:city].present? && params[:activity].present?

	  	if params[:city] == "all" && params[:activity] == "all"
	  		@stores = Store.all.order('created_at DESC')
	  	elsif params[:city] == "all" && params[:activity] != "all"
	  		@stores = Store.all.order('created_at DESC').where('activity ILIKE ?', '%'+params[:activity]+'%')
	  	elsif params[:city] != "all" && params[:activity] == "all"
	  		@stores = Store.all.order('created_at DESC').where('town ILIKE ?', '%'+params[:city]+'%')
	  	else
	  		@stores = Store.all.order('created_at DESC').where('town ILIKE ? AND activity ILIKE ?', 
	  				'%'+params[:city]+'%', '%'+params[:activity]+'%')
	  	end
	else
		@stores = Store.all.order('created_at DESC')
	end
  	
  	@featureCollection = { 
		"type" => "FeatureCollection", 
		"features" => []
	}

  	@stores.each do |store|
  		@featureCollection["features"].push({
	    	"type" => "Feature",
	    	"debug" => store.address+" "+store.postcode+" "+store.town+" Réunion",
	    	"geometry" => {
	      		"type" => "Point",
	      		"coordinates" => Geocoder.coordinates(store.address+" "+store.postcode+" "+store.town+" Réunion")
	    	},
	    	"properties" => {
	      		"title" => store.name,
	      		"description" => "<p>"+store.address+" "+store.postcode+" "+store.town+"</p><p>"+store.activity+"</p>",
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
