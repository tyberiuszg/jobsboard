class JobsStructuresController < ApplicationController

respond_to :html, :js

  def input
  end

  def output
  	
  	@input = params[:input]
  	
  	jobs_structure = JobSequence.new(@input)
    
    if jobs_structure.self_dependency_exists?
      @output = '<i class="material-icons" id="error">warning</i>  Job cannot depend upon themselves'.html_safe 
    elsif jobs_structure.circular_dependency_exists?    	
      @output = '<i class="material-icons" id="error">warning</i> Job sequence contains a circular dependency'.html_safe 
    else
      @output = jobs_structure.result
    end

  	respond_with(@output)
  end

end
