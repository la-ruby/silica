class CommentsController < ApplicationController
  before_action :set_area_backend # to silence warning
  after_action :verify_authorized

  # POST /comments or /comments.json
  def create
    authorize nil, policy_class: CommentPolicy
    project = Project.find(comment_params[:record_id])
    @comment = Comment.new(
      comment_params.merge(
        { inventor_id: current_user.id }
      )
    )
    result = @comment.save
    Event.create(
      category: 'project_comment',
      timestamp: @comment.created_at,
      record_id: project.id,
      record_type: 'Project',
      secondary_record_id: @comment.id,
      secondary_record_type: 'Comment',
      inventor_id: @comment.inventor_id
    ) if result

    head :no_content
  end

  private
    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :record_id, :record_type)
    end
end
