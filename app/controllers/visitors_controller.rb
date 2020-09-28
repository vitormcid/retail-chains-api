class VisitorsController < ApplicationController
  before_action :authorize_request
  before_action :authorize_visitor, except: %i[register_incidence]
  before_action :find_visitor, except: %i[create index show]
  before_action :find_visitor_es, only: %i[show]

  # GET /visitors
  def index
    @visitors = Visitor.all
    render json: @visitors, status: :ok
  end

  # GET /visitors/{visitorname}
  def show
    render json: @visitor.map{|v| v._source}, status: :ok
  end

  # POST /visitors
  def create
    @visitor = Visitor.new(visitor_params)
    if @visitor.save
      render json: @visitor, status: :created
    else
      render json: { errors: @visitor.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /visitors/{visitorname}
  def update
    unless @visitor.update(visitor_params)
      render json: { errors: @visitor.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # POST /visitors/{visitorname}/register_incidence
  def register_incidence
    incidence = Incidence.new(incidence_params)
    incidence.visitor_id = @visitor.id
    if incidence.save
      render json: incidence, status: :created
    else
      render json: { errors: @visitor.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /visitors/{visitorname}
  def destroy
    @visitor.destroy
  end

  private

  def find_visitor  	
    @visitor = Visitor.find_by_name!(params[:_name])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Visitor not found' }, status: :not_found
  end

  def find_visitor_es
    @visitor = Visitor.search_by_name(params[:_name])
    unless @visitor.present?
      render json: { errors: 'Visitor not found' }, status: :not_found
    end
  end

  def authorize_visitor
    authorize :visitor
  end

  def visitor_params
    params.permit(
    	:name, :chain_id, :featured_image
    )
  end

  def incidence_params
    params.permit(
      :kind, :datetime
    )
  end
  
end