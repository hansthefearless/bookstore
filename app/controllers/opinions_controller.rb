class OpinionsController < ApplicationController
   def create
     @opinion = Opinion.new(opinion_params)
   end
end
