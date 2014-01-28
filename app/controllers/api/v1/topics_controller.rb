module Api
  module V1
    class TopicsController < ApplicationController

      respond_to :json
      before_action :set_topic, only: [:show, :edit, :update, :destroy]
      before_filter :validate_access_token

      before_filter :check_per_page_is_an_integer, only: [:index]
      before_filter :check_per_page_is_in_range, only: [:index]

      def index
        @topics = @user.topics.order("#{sort_field} #{sort_dir}").paginate(:page => params[:page], :per_page => params[:per_page])
        render 'topics/index'
      end

      def show
        render 'topics/show'
      end

      def create
        @topic = Topic.new(topic_params)
        @topic.user_id = @user.id
        @topic.save
        render 'topics/show', status: :created, location: @topic
      end

      def update
        @topic.update(topic_params)
        render 'topics/show', status: :ok, location: @topic
      end

      def destroy
        @topic.destroy
        render nothing: true, status: :no_content
      end

      private

      def sort_field
        %w{id title created_at}.include?(params[:sort_field]) ? params[:sort_field] : 'created_at'
      end

      def sort_dir
        %w{asc desc}.include?(params[:sort_dir]) ? params[:sort_dir] : 'desc'
      end

      def validate_access_token
        if request.headers["X-API-Key"]
          @user = User.find_by_access_token(request.headers["X-API-Key"])
        end

        unless @user
          render nothing: true, status: :unauthorized
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_topic
        @topic = Topic.find_by_secret(params[:id])
        unless @topic
          render nothing: true, status: :not_found
        end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def topic_params
        params.require(:topic).permit(:title, :description, :locked)
      end

      def check_per_page_is_an_integer
        unless params["per_page"].nil?
          unless params["per_page"].is_i?
            render text: "Parameter per_page is not an integer", status: :bad_request
          end
        end
      end

      def check_per_page_is_in_range
        per_page = params["per_page"] || 20
        per_page = per_page.to_i

        Rails.logger.debug "per_page = #{per_page}"
        Rails.logger.debug "per_page in range = #{per_page.between?(1, 10000)}"

        unless per_page.between?(1, 10000)
          Rails.logger.debug "Throw a 400"
          render text: "Parameter per_page is out of range", status: :bad_request
        end
      end

    end
  end
end
