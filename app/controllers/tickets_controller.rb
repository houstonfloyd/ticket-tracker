class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  
  def index
    if params[:project].present?
      @tickets = Project.find(params[:project]).tickets
    else
      @tickets = Ticket.all
    end

    if params[:status].present?
      @tickets = @tickets.where(status: params[:status])
    end

    if params[:tag].present?
      @tickets = @tickets.joins(:tags).where("tags.id": params[:tag])
    end
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params.merge(creator: current_user))

    if @ticket.save
      redirect_to tickets_url, notice: 'Your ticket was added.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to ticket_url(@ticket), notice: 'Your ticket was updated.'
    else
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Your ticket was deleted.'
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :body, :status, :assignee_id, :project_id, tag_ids: [])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
