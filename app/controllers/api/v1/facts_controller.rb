class Api::V1::FactsController < ApplicationController
    before_action :find_fact, only: [ :show, :update, :destroy ]

    #GET / facts
    def index
        user = User.find(params[:user_id])
        @facts = user.facts
        render json: @facts
    end

    #GET /facts/:id
    def show
        render json: @fact
    end

    #POST /facts
    def create
        user = User.find(params[:user_id])
        @fact = user.facts.create(fact_params)
        if @fact.save
            render json: @fact
        else
            render error: { error: "Unable to create fact." }, status: 400
        end
    end
    
    #PUT /facts/:id
    def update
        if @fact
            @fact.update(fact_params)
            render json: { message: "fact successfully updated." }, status: 200
        else
            render json: { error: "Unable to update fact." }, status: 400
        end
    end

    #DELETE /facts/:id
    def destroy
        if @fact
            @fact.destroy
            render json: { message: "fact successfully deleted." }, status: 200
        else
            render json: { error: "Unable to delete fact." }, status: 400
        end
    end
    
    private

    def fact_params
        params.require(:fact).permit(:fact, :likes, :user_id)
    end

    def find_fact
        @fact = Fact.find(params[:id])
    end
    
    
end
