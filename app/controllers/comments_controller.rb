class CommentsController < ApplicationController
   before_action :set_ticket, only: [:create, :edit, :update, :destroy]
   before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @ticket.comments.new(comment_params.merge(creator: current_user))
          
    if @comment.save
      if params[:ticket_status].present?
        @ticket.update_attribute(:status, params[:ticket_status])
      end
        redirect_to ticket_path(@ticket), notice: 'Comment added.'
    else 
      redirect_to ticket_path(@ticket), alert: 'Issue with comment.'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to ticket_path(@ticket), notice: 'Comment updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to ticket_path(@ticket), notice: 'Comment was deleted.'   
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :ticket_id)
  end
end