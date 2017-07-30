class JobsStructuresController < ApplicationController

respond_to :html, :js

  def input
    
  end

  def output
  	@input = params[:input]

  	@output = @input
  	respond_with(@output)
  end

end
