module Api
  module V1
    class IdeasController < ApplicationController

      respond_to :json
      
      before_filter :set_topic
      before_action :set_idea, only: [:show, :edit, :update, :destroy]

      before_filter :validate_access_token

      def index
        @ideas = @topic.ideas.order("#{sort_field} #{sort_dir}")
        render 'ideas/index'
      end

      def show
        render 'ideas/show'
      end

      def create
        @idea = Idea.new(idea_params)
        @idea.user_id = @user.id
        @idea.topic_id = @topic.secret
        @idea.save
        render 'ideas/show', status: :created, location: [@topic, @idea]
      end

      def update
        @idea.update(idea_params)
        render 'ideas/show', status: :ok, location: [@topic, @idea]
      end

      def destroy
        @idea.destroy
        render nothing: true, :status => :no_content
      end

      private

      def sort_field
        %w{id title created_at}.include?(params[:sort_field]) ? params[:sort_field] : 'created_at'
      end

      def sort_dir
        %w{asc desc}.include?(params[:sort_dir]) ? params[:sort_dir] : 'desc'
      end

      def validate_access_token
        @user = User.find_by_access_token(request.headers["X-API-Key"])
        unless @user
          render nothing: true, :status => :unauthorized
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_topic
        @topic = Topic.find_by_secret(params[:topic_id])
        unless @topic
          render nothing: true, :status => :not_found
        end
      end

      def set_idea
        begin
        @idea = @topic.ideas.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render nothing: true, :status => :not_found
        end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def idea_params
        params.require(:idea).permit(:title, :description)
      end
    end
  end
end
