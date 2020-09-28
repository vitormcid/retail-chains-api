class ChainsController < ApplicationController
  before_action :authorize_request, except: %i[total] 
  before_action :authorize_chain, except: %i[total]
  before_action :find_chain, except:  %i[create index show total]
  before_action :find_chain_es, only: %i[show]

  # GET /chains
  def index
    @chains= Chain.all  
    render json: @chains, status: :ok
  end

  # GET /chains/{name}
  def show  
    render json: @chain.map{|c| c._source}, status: :ok
  end

  # POST /chains
  def create    
    @chain = Chain.new(chain_params)   
    if @chain.save
      render json: @chain, status: :created
    else
      render json: { errors: @chain.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /chains/{name}
  def update
    unless @chain.update(chain_params)
      render json: { errors: @chain.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /chains/{name}
  def destroy   
    @chain.destroy
  end

  # GET /chains/total
  def total
    render json: {
      total_chains: Chain.all.count,
      total_visitors: Visitor.all.count},
      status: :ok
  end

  private

  def find_chain
    @chain = Chain.find_by_name!(params[:_name])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Chain not found' }, status: :not_found
  end

  #elastic search
  def find_chain_es
    @chain = Chain.search_by_name(params[:_name])
    unless @chain.present?
      render json: { errors: 'Chain not found' }, status: :not_found
    end
  end

  def authorize_chain
    authorize :chain
  end

  def chain_params
    params.permit(
    	:cnpj, :name
    )
  end
end