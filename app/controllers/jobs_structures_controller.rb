class JobsStructuresController < ApplicationController

respond_to :html, :js

  def input
  end

  def output
  	
  	@input = params[:input]
  	
  	jobs_structure = JobSequence.new(@input)
    
    if jobs_structure.self_dependency_exists?
      @output = "Job cannot depend upon themselves" 
    elsif jobs_structure.circular_dependency_exists?    	
      @output = "Job sequence contains a circular dependency"
    else
      @output = jobs_structure.result
    end

  	respond_with(@output)
  end

end
